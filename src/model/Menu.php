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


/**
 * 菜单模型
 * Class Menu
 * @package app\vuecmf\model
 */
class Menu extends Base
{

    /**
     * 获取导航菜单列表
     * @param array $model_id_arr
     * @param array $api_id_arr
     * @param int $pid
     * @param array $menuList
     * @param array $id_path
     * @param array $path_name
     * @return array
     */
    public function nav(array $model_id_arr, array $api_id_arr, int $pid = 0, array &$menuList = [], array $id_path = [], array $path_name = []):array
    {
        $res = self::where('pid', $pid)
            ->where('status', 10)
            ->whereIn('model_id', $model_id_arr)
            ->order('sort_num')
            ->column('concat("m",id) mid, id, pid, title, icon, model_id');

        foreach ($res as &$val){
            $menuList[$val['mid']] = [];

            if(empty($id_path)){
                $val['id_path'] = [$val['mid']];
                $val['path_name'] = [$val['title']];
            }else{
                $val['id_path'] =  $id_path;
                $val['path_name'] = $path_name;
                array_push($val['id_path'], $val['mid']);
                array_push($val['path_name'], $val['title']);
            }

            $child = $this->nav($model_id_arr, $api_id_arr, $val['id'], $menuList[$val['mid']], $val['id_path'], $val['path_name']);

            $child = array_filter($child);

            if(!empty($child)){
                $val['children'] = $child;
            }else{
                $model_cfg = ModelConfig::alias('MC')
                    ->join('model_action MA', 'MC.default_action_id = MA.id','LEFT')
                    ->field('MC.table_name, MA.action_type default_action_type, MC.component_tpl, MC.search_field_id, MC.is_tree')
                    ->where('MC.id', $val['model_id'])
                    ->whereIn('MA.id', $api_id_arr)
                    ->where('MC.status', 10)
                    ->where('MA.status', 10)
                    ->find();

                if(!empty($model_cfg)){
                    $model_cfg = $model_cfg->getData();
                    $val = array_merge($val, $model_cfg);
                }else if($val['model_id'] >= 0){
                    unset($menuList[$val['mid']]);
                    continue;
                }
            }

            $menuList[$val['mid']] = $val;

        }
        return $menuList;
    }


}
