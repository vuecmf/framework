<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2023 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\subscribe;


use app\vuecmf\model\Admin;
use app\vuecmf\model\facade\GrantAuth;
use think\Exception;
use think\Request;

/**
 * 角色事件
 * Class RolesEvent
 * @package app\vuecmf\subscribe
 */
class RolesEvent extends BaseEvent
{

    /**
     * 为角色分配用户
     * @param Request $request
     * @return bool
     * @throws Exception
     */
    public function onAddUsers(Request $request): bool
    {
        $data = $request->post('data',[]);
        if(empty($data['role_name'])) throw new Exception('userid_list(用户ID列表)和role_name(角色名称)不能为空');
        if(empty($data['userid_list'])){
            //若传入的为空，则先查出该角色下原有用户列表，然后全部删除
            $username_list = GrantAuth::getUsers($data['role_name']);
            return GrantAuth::users('del', $username_list, $data['role_name']);
        }else{
            $username_list = Admin::whereIn('id', $data['userid_list'])->column('username');
            return GrantAuth::users('add', $username_list, $data['role_name']);
        }

    }

    /**
     * 清除角色下的用户
     * @param Request $request
     * @return bool
     * @throws Exception
     */
    public function onDelUsers(Request $request): bool
    {
        $data = $request->post('data',[]);
        if(empty($data['username_list']) || empty($data['role_name'])) throw new Exception('username_list(用户名列表)和role_name(角色名称)不能为空');
        return GrantAuth::users('del', $data['username_list'], $data['role_name']);
    }

    /**
     * 添加角色权限
     * @param Request $request
     * @return bool
     * @throws Exception
     */
    public function onAddPermission(Request $request): bool
    {
        $data = $request->post('data',[]);
        if(empty($data['role_name'])) throw new Exception('参数role_name(角色名称)不能为空！');
        if(empty($data['action_id'])) throw new Exception('请选择功能项！');
        return GrantAuth::permission('role_add', $data['role_name'], $data['action_id']);
    }

    /**
     * 删除角色权限
     * @param Request $request
     * @return bool
     * @throws Exception
     */
    public function onDelPermission(Request $request): bool
    {
        $data = $request->post('data',[]);
        if(empty($data['role_name'])) throw new Exception('参数role_name(角色名称)不能为空！');
        if(empty($data['action_id'])) throw new Exception('请选择功能项！');
        return GrantAuth::permission('role_del', $data['role_name'], $data['action_id']);
    }

    /**
     * 获取角色所有权限
     * @param Request $request
     * @return array
     * @throws Exception
     */
    public function onGetPermission(Request $request): array
    {
        $data = $request->post('data',[]);
        if(empty($data['role_name'])) throw new Exception('参数role_name(角色名称)不能为空！');
        return GrantAuth::getPermission($data['role_name']);
    }

    /**
     * 获取角色下所有用户
     * @param Request $request
     * @return array
     * @throws Exception
     */
    public function onGetUsers(Request $request): array
    {
        $data = $request->post('data',[]);
        if(empty($data['role_name'])) throw new Exception('参数role_name(角色名称)不能为空！');

        $username_list = GrantAuth::getUsers($data['role_name']);

        return Admin::whereIn('username', $username_list)
            ->where('status', 10)
            ->column('id');
    }


    /**
     * 获取所有用户
     * @return array
     */
    public function onGetAllUsers(Request $request): array
    {
        $data = $request->post('data',[]);
        $model = Admin::field('id `key`, username label, false disabled')->where('status', 10)
            ->where('is_super','<>', 10);

        if(!empty($data['username'])){
            $user_info = Admin::where('status', 10)
                ->where('username', $data['username'])
                ->find();
            if($user_info['is_super'] != 10){
                $model = $model->where('pid', $user_info['id']);
            }
        }

        return $model->select()->toArray();
    }


}
