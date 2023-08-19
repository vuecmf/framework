<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2023 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\model\facade;


use think\Facade;

/**
 * 管理员模型
 * Class Admin
 * @package app\vuecmf\model\facade
 * @method static array getAppInfo(string $app_name) 获取应用信息
 * @method static array getAuthAppList() 获取需要授权的应用列表
 */
class AppConfig extends Facade
{

    /**
     * @return string
     */
    protected static function getFacadeClass(): string
    {
        return 'app\vuecmf\model\AppConfig';
    }

}
