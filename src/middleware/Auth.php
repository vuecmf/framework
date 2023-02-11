<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2022 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\middleware;

use app\vuecmf\model\facade\AppConfig;
use app\vuecmf\model\ModelConfig;
use app\vuecmf\model\facade\Admin as AdminService;
use Closure;
use tauthz\facade\Enforcer;
use think\Exception;
use think\Request;
use think\response\Json;

/**
 * 访问权限控制中间件
 * Class Auth
 * @package app\vuecmf\middleware
 */
class Auth
{
    /**
     * 访问权限检测
     * @param Request $request
     * @param Closure $next
     * @return mixed|Json
     */
    public function handle(Request $request, Closure $next)
    {
        try{
            $login_info = null; //当前登录用户信息
            $login_pass = false; //登录是否通过
            $auth_pass = false;  //权限验证是否通过
            $routeInfo = getRouteInfo($request); //获取当前动作路径

            if(empty($routeInfo['app_name'])){
                throw new Exception('没有获取到应用名称！');
            }

            //获取当前应用配置信息
            $appInfo = AppConfig::getAppInfo($routeInfo['app_name']);

            $appInfo['login_enable'] == 20 && $login_pass = true;
            $appInfo['auth_enable'] == 20 && $auth_pass = true;
            $current_url = '/' . $routeInfo['app_name'] . '/' . $routeInfo['controller'] . '/' . $routeInfo['action'];

            if(in_array($current_url, $appInfo['exclusion_url']) || in_array($current_url . '/', $appInfo['exclusion_url'])){
                $login_pass = true;
                $auth_pass = true;
            }

            if(!$login_pass){
                $token = strtolower(trim($request->header('token',''),'\t\r\n?'));
                $login_info = AdminService::isLogin($token);

                if(!$login_info){
                    throw new Exception('您还没有登录或登录已超时!');
                }

                //非超级管理员需要进行权限认证
                if($login_info['is_super'] != 10 && !$auth_pass){
                    $auth_pass = Enforcer::enforce($login_info['username'], $routeInfo['app_name'] , $routeInfo['controller'], $routeInfo['action']);
                }else{
                    $auth_pass = true;
                }
            }

            if(!$auth_pass){
                throw new Exception('您没有访问权限!');
            }

            if($routeInfo['controller'] == 'index' && $routeInfo['action'] == 'index'){
                //后台默认首页
                return $next($request);
            }else{
                //根据当前路由找到当前的模型
                $model_name = '';
                $table_name = $routeInfo['controller'] == 'upload' ? 'upload_file' : $routeInfo['controller'];
                $model_config = ModelConfig::field('id, is_tree, label')->where('table_name', $table_name)->where('status', 10)->find();
                !empty($model_config['id']) && $model_name = $request->controller();
                !empty($model_name) && $model_name = '\\app\\'. $routeInfo['app_name'] .'\\model\\' . $model_name;

                if(empty($model_config)) throw new Exception('模型('.$table_name.')还没有创建任何动作！');

                $request->model_id = $model_config['id'];
                $request->model_name = $model_name;
                $request->model_label = $model_config['label'];
                $request->model_is_tree = $model_config['is_tree'];
                $request->app_name = $routeInfo['app_name'];
                $request->login_user_info = $login_info;

                return $next($request);
            }

        }catch (\Exception $e){
            return ajaxFail($e, 1003);
        }

    }
}
