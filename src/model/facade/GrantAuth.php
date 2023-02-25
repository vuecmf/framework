<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2022 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\model\facade;


use think\Facade;

/**
 * 权限管理模型
 * Class GrantAuth
 * @package app\vuecmf\model\facade
 * @method static bool roles(string $method, string $username, $role_name_list) 添加/删除用户角色
 * @method static bool permission(string $method, string $user_or_role, string $action_id) 添加/删除(用户或角色)权限
 * @method static bool users(string $method, $username_list, string $role_name) 为角色分配/清除用户
 * @method static array getPermission(string $user_or_role, $login_user_info = null) 获取(用户或角色)所有权限ID列表
 * @method static array getUsers(string $role_name) 获取角色下所有用户名称
 * @method static array getRoles(string $username) 获取用户下所有角色名称
 */
class GrantAuth extends Facade
{

    /**
     * @return string
     */
    protected static function getFacadeClass(): string
    {
        return 'app\vuecmf\model\GrantAuth';
    }

}
