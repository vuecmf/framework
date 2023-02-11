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


/**
 * 应用管理
 * Class AppConfig
 * @package app\vuecmf\controller
 */
class AppConfig extends Base
{

    public function test(){

        $result =  root_path();
        


        return ajaxSuccess('ok', $result);
    }
}
