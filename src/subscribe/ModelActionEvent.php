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

use app\vuecmf\model\ModelConfig;
use app\vuecmf\model\Roles;
use think\Request;
use app\vuecmf\model\facade\GrantAuth;
use app\vuecmf\model\ModelAction;
use think\Exception;

/**
 * 模型动作事件
 * Class ModelActionEvent
 * @package app\vuecmf\subscribe
 */
class ModelActionEvent extends BaseEvent
{
    /**
     * 获取API映射
     * @param Request $request
     * @return mixed
     * @throws Exception
     */
    public function onGetApiMap(Request $request)
    {
        $data = $request->post('data',[]);
        if(empty($data['table_name'])) throw new Exception('参数table_name不能为空');
        if(empty($data['action_type'])) throw new Exception('参数action_type不能为空');
        return ModelAction::alias('ma')
            ->join('model_config mc',' ma.model_id = mc.id')
            ->where('mc.table_name', $data['table_name'])
            ->where('ma.action_type', $data['action_type'])
            ->value('api_path');

    }

    /**
     * 获取所有模型的动作列表
     * @param Request $request
     * @return array
     */
    public function onGetActionList(Request $request): array
    {
        $data = $request->post('data',[]);
        $res = [];

        if(!empty($data['role_name'])){
            //若传入角色名称，则只取当前角色的父级角色拥有的权限
            $pid = Roles::where('role_name', $data['role_name'])
                ->where('status', 10)
                ->value('pid');
            if($pid === null) return [];
            if($pid > 0){
                //父级角色
                $pid_role_name = Roles::where('id', $pid)
                    ->where('status', 10)
                    ->value('role_name');
                if(empty($pid_role_name)) return [];
                $rs = GrantAuth::getPermission($pid_role_name);

                foreach ($rs as $model_name => $action_id){
                    $action_list = ModelAction::whereIn('id', $action_id)
                        ->where('status', 10)
                        ->column('label', 'id');
                    $res[$model_name] = $action_list;
                }

                return $res;
            }
        }

        //获取所有权限列表(排除关闭权限验证的应用)
        $actionList = ModelAction::alias('vma')->field('vma.id action_id, vma.label action_label, vmc.label model_name')
            ->join('model_config vmc', 'vmc.id = vma.model_id', 'LEFT')
            ->join('app_config vac', 'vac.id = vmc.app_id', 'LEFT')
            ->where('vac.auth_enable', 10)
            ->where('vma.status', 10)
            ->where('vmc.status', 10)
            ->where('vac.status', 10)
            ->select();

        foreach ($actionList as $val){
            $res[$val->model_name][$val->action_id] = $val->action_label;
        }

        return $res;
    }


}
