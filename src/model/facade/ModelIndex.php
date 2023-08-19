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
 * 字段索引模型
 * Class ModelIndex
 * @package app\vuecmf\model\facade
 * @method static array getUniqueFields($model_id) 获取模型的唯一索引字段
 */
class ModelIndex extends Facade
{

    /**
     * @return string
     */
    protected static function getFacadeClass(): string
    {
        return 'app\vuecmf\model\ModelIndex';
    }

}