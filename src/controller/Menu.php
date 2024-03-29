<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2023 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\controller;

use think\response\Json;

/**
 * 菜单管理
 * Class Menu
 * @package app\vuecmf\controller
 */
class Menu extends Base
{

    /**
     * 导航菜单
     */
    public function nav(): Json
    {
        return self::common('Nav', '拉取成功！', '拉取失败！');
    }


}
