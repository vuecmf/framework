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

use tauthz\facade\Enforcer;
use think\Model;

/**
 * 角色模型
 * Class Roles
 * @package app\vuecmf\model
 */
class Roles extends Base
{

    /**
     * 新增加或更新前
     * @param Model $model
     * @return mixed|void
     */
    public static function onBeforeWrite(Model $model)
    {
        empty($model->pid) && $model->pid = 0;
        $id_path = (string)$model->pid;
        getTreeIdPath($id_path, $model, intval($model->pid));
        $model->id_path = $id_path;
    }


    /**
     * 更新角色前
     * @param Model $model
     * @return mixed|void
     */
    public static function onBeforeUpdate(Model $model)
    {
        //清除角色相关权限
        $old_role_name = self::where('id', $model->id)->value('role_name');
        //更新权限项中的角色名称
        Rules::where('ptype', 'p')->where('v0', $old_role_name)->update(['v0' => $model->role_name]);
        Rules::where('ptype', 'g')->where('v1', $old_role_name)->update(['v1' => $model->role_name]);

    }

    /**
     * 删除角色后
     * @param Model $model
     */
    public static function onAfterDelete(Model $model)
    {
        //清除角色相关权限
        Enforcer::deleteRole($model->role_name);
    }

}
