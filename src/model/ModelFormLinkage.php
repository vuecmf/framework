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

use app\vuecmf\ConstConf;
use think\facade\Cache;
use think\Model;

/**
 * 表单联动模型
 * Class ModelFormLinkage
 * @package app\vuecmf\model
 */
class ModelFormLinkage extends Base
{

    /**
     * 数据添加或更新后
     * @param Model $model
     * @return void
     */
    public static function onAfterWrite(Model $model): void
    {
        Cache::tag(ConstConf::C_TAG_MODEL)->clear();
    }

    /**
     * 数据删除后
     * @param Model $model
     * @return void
     */
    public static function onAfterDelete(Model $model): void
    {
        Cache::tag(ConstConf::C_TAG_MODEL)->clear();
    }

}
