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
use think\Exception;
use think\facade\Cache;
use think\Model;

/**
 * 应用管理模型
 * Class AppConfig
 * @package app\vuecmf\model
 */
class AppConfig extends Base
{

    /**
     * 创建应用前
     * @param Model $model
     * @return mixed|void
     */
    public static function onBeforeInsert(Model $model)
    {
        $app_dir = root_path($model->app_name);
        //创建应用目录
        mkdir($app_dir,0666, true);
        //创建控制器目录
        mkdir($app_dir . 'controller',0666, true);
        //创建模型层目录
        mkdir($app_dir . 'model',0666, true);
        //创建事件层目录
        mkdir($app_dir . 'subscribe',0666, true);

    }

    /**
     * 更新应用前
     * @param Model $model
     * @return mixed|void
     */
    public static function onBeforeUpdate(Model $model)
    {
        //更新应用目录, 先查询原应用名称，若现应用名称与原应用名称不一致，则进行应用目录更新
        $old_app_name = self::where('id', $model->id)->value('app_name');
        if($old_app_name != $model->app_name){
            rename($old_app_name, root_path($model->app_name));
        }
    }




    /**
     * 删除应用前
     * @param Model $model
     * @return mixed|void
     */
    public static function onBeforeDelete(Model $model)
    {
        //先检查应用下是否存在模型，若存在则不允许删除
        $model_num = ModelConfig::where('app_id', $model->id)->count();
        if($model_num > 0) {
            throw new Exception('不允许删除有分配模型的应用！');
        }
    }

    public static function onAfterWrite(Model $model): void
    {
        //数据更新后，清除历史缓存
        Cache::tag(ConstConf::C_TAG_APP)->clear();
    }

    public static function onAfterDelete(Model $model): void
    {
        //数据更新后，清除历史缓存
        Cache::tag(ConstConf::C_TAG_APP)->clear();
    }


    /**
     * 获取应用信息
     * @param string $app_name
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getAppInfo(string $app_name):array
    {
        if(empty($app_name)) return [];

        $cache_key = 'vuecmf:app_info:' . $app_name;
        $appInfo = Cache::get($cache_key);

        if(empty($appInfo)){
            $appInfo = self::where('app_name', $app_name)
                ->where('status', 10)
                ->find()->getData();

            if(!empty($appInfo['exclusion_url'])){
                $arr = explode(',', $appInfo['exclusion_url']);
                foreach ($arr as &$v){
                    $v = trim($v);
                }
                $appInfo['exclusion_url'] = $arr;
            }else{
                $appInfo['exclusion_url'] = [];
            }

            Cache::tag(ConstConf::C_TAG_APP)->set($cache_key, $appInfo);
        }

        return $appInfo;
    }


}
