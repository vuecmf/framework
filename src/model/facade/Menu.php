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
 * 菜单模型
 * Class Menu
 * @package app\vuecmf\model\facade
 * @method static array nav($pid=0) 获取导航菜单
 * @method static dropdown(array &$tree = [], int $pid = 0) 获取下拉菜单列表
 */
class Menu extends Facade
{
    /**
     * @return string
     */
    protected static function getFacadeClass(): string
    {
        return 'app\vuecmf\model\Menu';
    }

}