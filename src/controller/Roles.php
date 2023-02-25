<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2022 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\controller;

use think\response\Json;

/**
 * 角色管理
 * Class Roles
 * @package app\vuecmf\controller
 */
class Roles extends Base
{

    /**
     * 批量分配用户
     * @return Json
     */
    public function add_users(): Json
    {
        return self::common('AddUsers', '分配用户成功！', '分配用户失败！');
    }

    /**
     * 批量删除用户
     * @return Json
     */
    public function del_users(): Json
    {
        return self::common('DelUsers', '删除用户成功！', '删除用户失败！');
    }

    /**
     * 添加角色权限
     * @return Json
     */
    public function add_permission(): Json
    {
        return self::common('AddPermission', '添加角色权限成功！', '添加角色权限失败！');
    }

    /**
     * 删除角色权限
     * @return Json
     */
    public function del_permission(): Json
    {
        return self::common('DelPermission', '删除角色权限成功！', '删除角色权限失败！');
    }

    /**
     * 获取角色下所有用户
     * @return Json
     */
    public function get_users(): Json
    {
        return self::common('GetUsers', '拉取角色用户成功！');
    }

    /**
     * 获取角色下所有权限
     * @return Json
     */
    public function get_permission(): Json
    {
        return self::common('GetPermission', '拉取角色权限成功！');
    }

    /**
     * 获取所有用户
     * @return Json
     */
    public function get_all_users(): Json
    {
        return self::common('GetAllUsers', '拉取所有用户成功！');
    }


}
