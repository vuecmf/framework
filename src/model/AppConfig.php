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
        $app_dir = base_path($model->app_name);
        //创建应用目录
        mkdir($app_dir,0666, true);
        //创建控制器目录
        mkdir($app_dir . 'controller',0666, true);
        //创建模型层目录
        mkdir($app_dir . 'model',0666, true);
        //创建事件层目录
        mkdir($app_dir . 'subscribe',0666, true);
        //创建中间件
        Make::buildMiddlewareClass($model->app_name);
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
            rename(root_path('app' . DIRECTORY_SEPARATOR . $old_app_name), root_path('app' . DIRECTORY_SEPARATOR . $model->app_name));
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
        $app_dir = base_path($model->app_name);
        //删除控制器目录
        rmdir($app_dir . 'controller');
        //删除模型层目录
        rmdir($app_dir . 'model');
        //删除事件层目录
        rmdir($app_dir . 'subscribe');
        //删除应用目录
        rmdir($app_dir);
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


    /**
     * 获取需要授权的应用列表
     * @return array
     */
    public function getAuthAppList(): array
    {
        $cache_key = 'vuecmf:app_list';
        $appList = Cache::get($cache_key);

        if(empty($appList)){
            $appList = self::where('auth_enable', 10)
                ->where('status', 10)
                ->column('app_name');

            Cache::tag(ConstConf::C_TAG_APP)->set($cache_key, $appList);
        }

        return $appList;
    }


}
