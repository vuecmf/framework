<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2022 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\model;


use app\vuecmf\model\facade\FieldOption as FieldOptionService;
use app\vuecmf\model\facade\ModelField as ModelFieldService;
use app\vuecmf\model\facade\ModelForm as ModelFormService;
use app\vuecmf\model\facade\ModelFormRules as ModelFormRulesService;
use app\vuecmf\model\facade\ModelRelation as ModelRelationService;
use think\Model;

/**
 * 基础模型
 * Class Base
 * @package app\vuecmf\model
 */
class Base extends Model
{

    /**
     * 新增加或更新前
     * @param Model $model
     * @return mixed|void
     */
    public static function onBeforeWrite(Model $model)
    {
        //若表单传入的值是空的，则使用字段设置中的默认值
        $table_name = toUnderline($model->getName());
        $model_id = ModelConfig::where('status',10)->where('table_name', $table_name)->value('id');
        $data = $model->getData();
        foreach ($data as $field_name => $val){
            $fieldInfo = ModelField::field('id,default_value')
                ->where('status', 10)
                ->where('model_id', $model_id)
                ->where('field_name', $field_name)
                ->find();

            $formInfo = ModelForm::field('type, default_value')
                ->where('model_id', $model_id)
                ->where('model_field_id', $fieldInfo['id'])
                ->where('status', 10)
                ->find();

            if(!empty($formInfo)){
                empty($val) && $val = $formInfo['default_value'];
                if(in_array($formInfo['type'], ['datetime','date']) && !empty($val)){
                    $val = str_replace('T',' ',$val);
                    $val = str_replace('.000Z','',$val);
                }
            }

            if(empty($val)){
                $val = $fieldInfo['default_value'];
            }else if(is_array($val)){
                $val = implode(',', $val);
            }


            $model->setAttr($field_name, $val);
        }

    }

    /**
     * 获取模型字段及表单相关信息
     * @param int $model_id         模型ID
     * @param array|null $filter    过滤表单数据
     * @param bool $is_tree         是否为树形列表
     * @param string $label_field   标题字段名
     * @param string $order_field   排序字段名
     * @param int $pid              父级ID
     * @param string $pid_field     父级字段名
     * @return array
     */
    public function getTableInfo(int $model_id, ?array $filter, bool $is_tree = false, string $label_field = 'title', string $order_field = 'sort_num', int $pid = 0, string $pid_field = 'pid'): array
    {
        //列表字段及表单相关
        $fieldInfo = ModelFieldService::getFieldInfo($model_id);
        $formInfo = ModelFormService::getFormInfo($model_id);
        $fieldOption = FieldOptionService::getFieldOptions($model_id);
        $relationInfo = ModelRelationService::getRelationInfo($model_id, $filter);
        $formRulesInfo = ModelFormRulesService::getRuleListForForm($model_id);

        //目录树列表中 父级字段处理
        if($is_tree){
            $pid_field_id = ModelField::where('field_name', $pid_field)
                ->where('model_id', $model_id)
                ->value('id');

            $tree = []; formatTree($tree, $this, $pid, $label_field,$pid_field, $order_field);
            $fieldOption[$pid_field_id] = $tree;
        }

        return [
            'field_info' => $fieldInfo,
            'form_info' => $formInfo,
            'field_option' => $fieldOption,
            'relation_info' => $relationInfo,
            'form_rules' => $formRulesInfo,
            'model_id' => $model_id,
        ];
    }

}
