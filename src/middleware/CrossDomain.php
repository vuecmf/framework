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

use Closure;


class CrossDomain {

    public function handle($request, Closure $next)
    {
        if(!env('cross_domain.enable', false)){
            return $next($request);
        }

        $origin = isset($_SERVER['HTTP_ORIGIN']) ? $_SERVER['HTTP_ORIGIN'] : '';
        $allowed_origin = trim(env('cross_domain.allowed_origin', ''));

        if($allowed_origin == '' || $allowed_origin == '*' || $origin == ''){
            $origin = '*';
        }else if(strpos($allowed_origin, $origin) === false){
            return $next($request);
        }
        
        $header = [
            'Access-Control-Allow-Origin' => $origin,
            'Access-Control-Allow-Credentials' => 'true',
            'Access-Control-Max-Age'           => 3600,
            'Access-Control-Allow-Methods'     => 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
            'Access-Control-Allow-Headers'     => 'Authorization, token, Content-Type, If-Match, If-Modified-Since, If-None-Match, If-Unmodified-Since, X-CSRF-TOKEN, X-Requested-With',
        ];
        return $next($request)->header($header);
    }

}