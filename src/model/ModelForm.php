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

use app\vuecmf\ConstConf;
use think\facade\Cache;
use think\Model;

/**
 * 模型表单模型
 * Class ModelForm
 * @package app\vuecmf\model
 */
class ModelForm extends Base
{

    /**
     * 数据写入前检测排序号是否重复
     * @param Model $model
     * @return mixed|void
     */
    public static function onBeforeWrite(Model $model)
    {
        //检查排序号是否有重复
        $num = self::where('sort_num', $model->sort_num)->where('model_id', $model->model_id)->count('id');
        if($num > 1) throw new Exception('同一模型下的表单排序号不能重复！');
    }

    /**
     * 数据添加或更新后
     * @param Model $model
     * @return void
     */
    public static function onAfterWrite(Model $model): void
    {
        Cache::tag(ConstConf::C_TAG_MODEL)->clear();
    }

    /**
     * 数据删除后
     * @param Model $model
     * @return void
     */
    public static function onAfterDelete(Model $model): void
    {
        Cache::tag(ConstConf::C_TAG_MODEL)->clear();
    }


    /**
     * 获取模型的表单信息
     * @param $model_id
     * @return mixed
     */
    public function getFormInfo($model_id)
    {
        $cache_key = 'vuecmf:model_form:form_info:' . $model_id;
        $result = Cache::get($cache_key);
        if(empty($result)){
            $result = self::alias('vmf')
                ->join('model_field vmf2', 'vmf.model_field_id = vmf2.id')
                ->where('vmf.model_id', $model_id)
                ->where('vmf.status', 10)
                ->where('vmf2.status', 10)
                ->order('vmf.sort_num')
                ->column('vmf.model_field_id field_id, vmf2.field_name, vmf2.label, vmf.`type`, vmf.default_value, vmf.is_disabled', 'vmf.sort_num');
            Cache::tag(ConstConf::C_TAG_MODEL)->set($cache_key, $result);
        }

        return $result;
    }


}
