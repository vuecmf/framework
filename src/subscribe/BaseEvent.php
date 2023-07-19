<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2022 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\subscribe;

use app\vuecmf\model\facade\GrantAuth;
use app\vuecmf\model\facade\ModelField as ModelFieldService;
use app\vuecmf\model\facade\ModelConfig as ModelConfigService;
use app\vuecmf\model\ModelConfig;
use app\vuecmf\model\ModelField;
use app\vuecmf\model\ModelRelation;
use think\Exception;
use think\Request;

/**
 * 基础事件抽象类
 * Class BaseEvent
 * @package app\vuecmf\subscribe
 */
abstract class BaseEvent
{

    public $eventPrefix = ''; //事件前缀

    public function __construct()
    {
        $this->eventPrefix = app()->request->controller();
    }

    /**
     * 列表
     * @param Request $request
     * @return mixed
     */
    public function onIndex(Request $request)
    {
        $data = $request->post('data', []); //接收提交的数据
        $model = app($request->model_name);
        $model_conf = ModelConfigService::getModelConfig($request->model_id);
        if(empty($model_conf)) throw new Exception('模型配置信息缺失');
        if(empty($model_conf['label_field_name'])) throw new Exception('模型还没有设置标题字段');

        if(isset($data['action']) && $data['action'] == 'getField'){
            //列表字段及表单相关
            $order_field = $model_conf['table_name'] == 'roles' ? '' : 'sort_num';
            return $model->getTableInfo(
                $request->model_id,
                $data['filter'],
                $model_conf['is_tree'],
                $model_conf['label_field_name'],
                $order_field,
                0,
                'pid',
                $model_conf['table_name'],
                $request->login_user_info['is_super'] == 10
            );
        }else if($model_conf['is_tree']){
            //列表数据（目录树形式）
            $order_field = $model_conf['table_name'] == 'roles' ? '' : 'sort_num';
            return getTreeList($model, 0, $data['keywords'], 'pid', $model_conf['label_field_name'],$order_field);
        }else{
            //列表数据（常规形式）
            if(!empty($data['keywords'])){
                //模糊搜索
                //先取出需模糊搜索的字段
                $filter_field_list = ModelFieldService::getFilterFields($request->model_id);
                $model = $model::where(implode('|', $filter_field_list), 'like', '%'. $data['keywords'] .'%');
            }else if(!empty($data['filter'])){
                //高级搜索
                foreach ($data['filter'] as $field => $val){
                    if($val == null || $val == '') continue;
                    if(is_string($val)){
                        $model = $model->where($field, $val);
                    }else{
                        $fieldType = ModelFieldService::getTypeByFieldName($field, $request->model_id);
                        if(in_array($fieldType, ['timestamp', 'date', 'datetime'])){
                            $model = $model->whereBetween($field, $val);
                        }else{
                            $model = $model->whereIn($field, $val);
                        }
                    }
                }
            }

            //若是非超级管理员登录时，进入管理员列表，不显示超级管理员资料
            if($model_conf['table_name'] == 'admin' && $request->login_user_info['is_super'] != 10){
                $model = $model->where('is_super', 20);
                $model = $model->whereRaw('id = ' . $request->login_user_info['id'] . ' or pid = ' . $request->login_user_info['id']);
            }

            //排序
            $order_field = !empty($data['order_field']) ? $data['order_field'] : 'id';
            $order_sort = !empty($data['order_sort']) ? $data['order_sort'] : 'desc';

            return $model->order($order_field, $order_sort)->paginate([
                'list_rows'=> $data['page_size'],
                'page' => $data['page']
            ])->jsonSerialize();
        }
    }

    /**
     * 保存
     * @param Request $request
     * @return mixed
     */
    public function onSave(Request $request)
    {
        $model = app($request->model_name);
        $data = $request->post('data',[]);
        if(!empty($data['id'])){
            if(isset($data['password']) && empty($data['password'])) unset($data['password']);
            $res = $model::update($data);
        }else{
            $res = $model::create($data);
        }
        return $res;
    }

    /**
     * 批量保存
     * @param Request $request
     * @return mixed
     */
    public function onSaveAll(Request $request)
    {
        $model = app($request->model_name);
        $data = $request->post('data','{}');
        is_string($data) && $data = json_decode($data, true);
        return $model->saveAll($data);
    }

    /**
     * 获取详情
     * @param Request $request
     * @return mixed
     * @throws Exception
     */
    public function onDetail(Request $request){
        $data = $request->post('data',[]);
        if(empty($data['id'])) throw new Exception('参数ID不能为空');
        $model = app($request->model_name);
        return $model::where('id', $data['id'])->find();
    }

    /**
     * 删除
     * @param Request $request
     * @return mixed
     * @throws Exception
     */
    public function onDelete(Request $request){
        $data = $request->post('data',[]);
        if(empty($data['id'])) throw new Exception('参数ID不能为空');
        $model = app($request->model_name, [], true);
        $id_arr = explode(',', (string)$data['id']);

        if($request->model_is_tree == 10 && isset($data['children']) && count($data['children']) > 0) {
            throw new Exception('此项下面还有子项，不可删除！若要删除，请先删除其子项');
        }

        if(count($id_arr) == 1){
            $res = $model::where('id', $data['id'])->find();
            if(empty($res)) throw new Exception('没有找到删除的数据');
            return $res->delete();
        }else{
            return $model::whereIn('id', $id_arr)->delete();
        }

    }

    /**
     * 下拉列表
     * @param Request $request
     * @return mixed
     */
    public function onDropdown(Request $request){
        $model = app($request->model_name);
        $data = $request->post('data',[]);

        $relation_show_field_id = '';

        if(isset($data['relation_model_id']) && $data['relation_model_id'] > 0){
            $data['model_id'] = $data['relation_model_id'];
        }else if(isset($data['table_name'])){
            if(empty($data['table_name'])) return [];
            $data['model_id'] = ModelConfig::where('status', 10)
                ->where('table_name', $data['table_name'])->value('id');
        }else if(isset($data['linkage_field_id']) && $data['linkage_field_id'] > 0){
            //联动模型的下拉
            $re = ModelRelation::field('relation_model_id, relation_show_field_id')
                ->where('model_field_id', $data['linkage_field_id'])
                ->where('status', 10)
                ->find();

            if($re->relation_model_id == 0) {
                throw new Exception('联动字段没有设置模型关联');
            }

            $data['model_id'] = $re->relation_model_id;
            $relation_show_field_id = $re->relation_show_field_id;
        }

        if(isset($data['model_id']) && empty($data['model_id'])) return [];

        if(empty($data['linkage_field_id']) && empty($data['model_field_id']) && !empty($data['model_id'])){
            $relation_show_field_id = ModelRelation::where('relation_model_id', $data['model_id'])
                ->where('status', 10)
                ->value('relation_show_field_id');
        }

        $label_field = 'id';
	    $value_field = 'id';
	    $field_type = '';
        $label_field_list = [];
        $tmp_arr = explode("\\", $request->model_name);
        $model_name = $tmp_arr[count($tmp_arr) - 1];

        switch ($model_name) {
            case 'ModelField':
                $label_field_list = ['field_name', 'label'];
                break;
            case 'ModelAction':
                $label_field_list = ['action_type', 'label'];
                break;
            case 'FieldOption':
                $label_field_list = ['option_label'];
                $value_field = 'option_value';
                if(isset($data['model_field_id']) && $data['model_field_id'] > 0){
                    $field_type = ModelField::where('id', $data['model_field_id'])
                        ->where('status', 10)->value('type');
                }
                break;
            default:
                $query = ModelField::field('field_name')->where('status', 10);
                if(!empty($relation_show_field_id)) {
                    //字段有模型关联的，下拉列表中显示的字段 从模型关联中的设置的显示字段
                    $labelFieldIdArr = explode(',', $relation_show_field_id);
                    $query = $query->whereIn('id', $labelFieldIdArr);
                }else{
                    //没有模型模型关联的，下拉列表中直接显示标题字段
                    $table_name = toUnderline($model_name);
                    $model_id = ModelConfig::where('status', 10)
                        ->where('table_name', $table_name)->value('id');
                    $query = $query->where('is_label', 10)
                        ->where('model_id', $model_id);
                }

                $fieldRes = $query->select();
                foreach ($fieldRes as $v){
                    $label_field_list[] = $v->field_name;
                }
        }

        if(count($label_field_list) > 0) {
            $label_field = $label_field_list[0];
            $label_field_list = array_slice($label_field_list, 1);
            if(count($label_field_list) > 0){
                $label_field = 'concat(' . $label_field . ",'('," . implode(",'-',", $label_field_list) . ",')')";
            }
        }

        $query = $model::field($label_field . ' label, ' . $value_field . ' value')
            ->where('status', 10);

        if($model_name == 'ModelConfig'){
            if(!isset($data['app_id'])) return [];
            $query = $query->where('app_id', $data['app_id']);
        }else if(isset($data['model_field_id']) && $data['model_field_id'] > 0){
            $query = $query->where('model_field_id', $data['model_field_id']);
        }else if(isset($data['model_id'])){
            $query = $query->where('model_id', $data['model_id']);
        }else{
            return [];
        }

        return $query->select();

    }



}
