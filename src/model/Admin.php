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
use tauthz\facade\Enforcer;
use think\Exception;
use think\facade\Cache;
use think\Model;

/**
 * 管理员模型
 * Class Admin
 * @package app\vuecmf\model
 */
class Admin extends Base
{

    /**
     * 数据写入前
     * @param Model $model
     * @return mixed|void
     */
    public static function onBeforeWrite(Model $model)
    {
        $model->reg_ip = request()->ip();
        !empty($model->password) && $model->password = password_hash($model->password,PASSWORD_DEFAULT);
        $model->update_time = date('Y-m-d H:i:s');
        $model->last_login_time = $model->update_time;

        $token = strtolower(trim(request()->header('token',''),'\t\r\n?'));
        $id = self::where('token', $token)
            ->where('status', 10)
            ->value('id');
        $model->pid = $id;
    }


    /**
     * 新增前数据处理
     * @param Model $model
     */
    public static function onBeforeInsert(Model $model)
    {
        $model->reg_time = date('Y-m-d H:i:s');
    }

    /**
     * 更新前数据处理
     * @param Model $model
     */
    public static function onBeforeUpdate(Model $model)
    {
        //如果修改了用户名，则更新权限表中的对应用户名
        $old_user_name = self::where('id', $model->id)->value('username');
        Rules::where('v0', $old_user_name)->update(['v0' => $model->username]);
    }

    /**
     * 删除用户后处理
     * @param Model $model
     */
    public static function onAfterDelete(Model $model)
    {
        //清除用户相关权限
        Enforcer::deleteUser($model->username);
    }


    /**
     * 判断是否已登录
     * @param $token
     * @return array|bool
     * @throws Exception
     */
    public function isLogin($token)
    {
        if(empty($token) || $token == 'null') return false;

        $cache_key = 'vuecmf:login_user_info:' . $token;
        $login_info = Cache::get($cache_key);

        if(empty($login_info)){
            $adminInfo = self::field('id, username, password, is_super, token')
                ->where('token', $token)
                ->where('status', 10)
                ->find();
            if(empty($adminInfo) || $token != makeToken($adminInfo->username, $adminInfo->password, request()->ip())){
                return false;
            }
            $login_info = [
                'id' => $adminInfo->id,
                'username' => $adminInfo->username,
                'is_super' => $adminInfo->is_super,
                'token'    => $adminInfo->token,
            ];
            Cache::tag(ConstConf::C_TAG_USER)->set($cache_key, $login_info, 3600);
        }

        return $login_info;

    }

}
