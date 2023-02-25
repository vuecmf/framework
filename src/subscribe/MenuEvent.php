<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2022 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\subscribe;

use app\vuecmf\ConstConf;
use think\Request;
use app\vuecmf\model\facade\GrantAuth;
use app\vuecmf\model\facade\Menu;
use app\vuecmf\model\facade\ModelAction;
use think\Exception;
use think\facade\Cache;

/**
 * 菜单事件
 * Class MenuEvent
 * @package app\vuecmf\subscribe
 */
class MenuEvent extends BaseEvent
{
    /**
     * 获取导航菜单列表
     * @return array
     */
    public function onNav(Request $request)
    {
        $data = $request->post('data',[]);
        if(empty($data['username'])) throw new Exception('参数username(用户名)不能为空！');

        $cache_key = 'vuecmf:nav_menu:' . $data['username'];
        $res = Cache::get($cache_key);
        if(empty($res)){
            $api_id_res = GrantAuth::getPermission($data['username'], $request->login_user_info);
            $api_id_arr = [];
            foreach ($api_id_res as $id_arr){
                $api_id_arr = array_unique(array_merge($api_id_arr, $id_arr));
            }

            $res['api_maps'] = ModelAction::getAllApiMap($api_id_arr);

            $model_id_arr = ModelAction::getModelIdListById($api_id_arr);
            $model_id_arr[] = 0;
            $res['nav_menu'] = Menu::nav($model_id_arr, $api_id_arr, 0);

            Cache::tag(ConstConf::C_TAG_USER)->set($cache_key, $res);
        }
        return $res;
    }

}
