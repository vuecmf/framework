<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2023 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\model;


use app\vuecmf\ConstConf;
use app\vuecmf\make\facade\Make;
use think\facade\Cache;
use think\Model;
use app\vuecmf\model\facade\ModelField;

/**
 * 模型配置模型
 * Class ModelConfig
 * @package app\vuecmf\model
 */
class ModelConfig extends Base
{

    /**
     * 数据更新前
     * @param Model $model
     * @return mixed|void
     */
    public static function onBeforeUpdate(Model $model)
    {
        if(is_array($model->search_field_id)){
            if(count($model->search_field_id) > 0){
                $model->search_field_id = implode(',', $model->search_field_id);
            }else{
                $model->search_field_id = '';
            }
        }

        $old_mc = self::alias("mc")->field('mc.table_name, ac.app_name')
            ->join('app_config ac','mc.app_id = ac.id', 'left')
            ->where('mc.id', $model->id)
            ->find()->toArray();

        //若原表名与新表名不一致，则更新表名及相关类文件名
        if($old_mc['table_name'] != $model->table_name){
            Make::renameTable($old_mc['table_name'], $model->table_name);
            Make::removeModelClass($old_mc['table_name'], $old_mc['app_name']);
            Make::buildModelClass($model->table_name, $model->label, $model->is_tree == 10, $old_mc['app_name']);
        }
    }


    /**
     * 数据添加完后
     * @param Model $model
     * @return void
     */
    public static function onAfterInsert(Model $model): void
    {
        $app_name = AppConfig::where('id', $model->app_id)->value('app_name');
        
        //初始化模型相关数据
        Make::buildModelData($model->id, $model->table_name, $model->label, $model->is_tree, $app_name, $model->remark);
        
        //添加一条模型数据后，生成该模型相关的类文件
        Make::buildModelClass($model->table_name, $model->label, $model->is_tree == 10, $app_name);
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
        //如果是扩展的模型，删除时则清除该模型相关的类文件及数据
        $data = $model->getData();

        if(isset($data['type']) && $data['type'] == 20){
            $app_name = AppConfig::where('id', $data['app_id'])->value('app_name');
            Make::removeModelData($data['id'], $data['table_name']);
            Make::removeModelClass($data['table_name'], $app_name);
        }
    }

    /**
     * 获取指定模型的配置信息
     * @param int $model_id 模型ID
     * @return array
     */
    public function getModelConfig(int $model_id): array
    {
        $cache_key = 'vuecmf:model_config';
        $modelConfig = Cache::get($cache_key);
        if(empty($modelConfig) || !isset($modelConfig[$model_id])){
            $modelConfig = ModelConfig::where('status', 10)->column('table_name, is_tree, id model_id, app_id','id');
            foreach ($modelConfig as &$v){
                $v['is_tree'] = $v['is_tree'] == 10;
                $v['label_field_name'] = ModelField::where('status', 10)
                    ->where('model_id', $v['model_id'])
                    ->where('is_label', 10)
                    ->value('field_name');
            }
            Cache::tag(ConstConf::C_TAG_MODEL)->set($cache_key, $modelConfig);
        }

        return $modelConfig[$model_id] ?? [];
    }


    /**
     * 根据模型ID获取对应表名（不含前缀）
     * @param int $model_id
     * @return string
     */
    public function getTableNameByModelId(int $model_id): string
    {
        $modelConfig = $this->getModelConfig($model_id);
        return $modelConfig['table_name'] ?? '';
    }

    /**
     * 根据模型ID获取对应模型名称
     * @param int $model_id
     * @return string
     */
    public function getModelNameByModelId(int $model_id): string
    {
        $table_name = self::getTableNameByModelId($model_id);
        return str_replace(' ','', ucwords(str_replace('_', ' ', $table_name)));
    }

    /**
     * 根据模型ID获取对应模型实例
     * @param int $model_id
     * @param string $app_name
     * @return mixed|object|\think\App
     */
    public function getModelInstanceByModelId(int $model_id, string $app_name = 'vuecmf')
    {
        $model_name = self::getModelNameByModelId($model_id);
        return app('\\app\\'. $app_name .'\\model\\' . $model_name);
    }



}
