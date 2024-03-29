<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2023 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\controller;

use tauthz\facade\Enforcer;
use think\App;
use think\response\Json;


/**
 * 管理员操作相关控制器
 * Class Admin
 * @package app\vuecmf\controller
 */
class Admin extends Base
{
    /**
     * 列表
     * @return Json
     */
    public function index(): Json
    {
        return self::common('Index', '拉取成功','拉取失败', function ($data){
            if(!empty($data['data'])){
                foreach ($data['data'] as &$val){
                    $val['roles'] = Enforcer::getImplicitRolesForUser($val['username'], $this->request->app_name);
                }
            }
            return $data;
        });
    }


    /**
     * 登录系统
     * @return Json
     */
    public function login(): Json
    {
        return self::common('Login', '登录成功！', '登录失败！');
    }

    /**
     * 退出系统
     * @return Json
     */
    public function logout(): Json
    {
        return self::common('Logout', '登录已退出！', '退出出现异常！');
    }

    /**
     * 添加用户角色
     * @return Json
     */
    public function add_role(): Json
    {
        return self::common('AddRole', '添加用户角色成功！', '添加用户角色失败！');
    }

    /**
     * 删除用户角色
     * @return Json
     */
    public function del_role(): Json
    {
        return self::common('DelRole', '删除用户角色成功！', '删除用户角色失败！');
    }

    /**
     * 添加用户权限
     * @return Json
     */
    public function add_permission(): Json
    {
        return self::common('AddPermission', '添加用户权限成功！', '添加用户权限失败！');
    }

    /**
     * 删除用户权限
     * @return Json
     */
    public function del_permission(): Json
    {
        return self::common('DelPermission', '删除用户权限成功！', '删除用户权限失败！');
    }

    /**
     * 获取用户的所有权限
     * @return Json
     */
    public function get_permission(): Json
    {
        return self::common('GetPermission', '拉取用户权限成功！');
    }

    /**
     * 获取所有角色
     * @return Json
     */
    public function get_all_roles(): Json
    {
        return self::common('GetAllRoles', '拉取所有角色成功！');
    }

    /**
     * 获取用户下所有角色
     * @return Json
     */
    public function get_roles(): Json
    {
        return self::common('GetRoles', '拉取角色成功！');
    }

    /**
     * 添加用户权限
     * @return Json
     */
    public function set_user_permission(): Json
    {
        return self::common('SetUserPermission', '设置用户权限成功！');
    }

    /**
     * 获取用户权限列表
     * @return Json
     */
    public function get_user_permission(): Json
    {
        return self::common('GetUserPermission', '拉取用户权限成功！');
    }


}
