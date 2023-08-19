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
 * 模型动作模型
 * Class ModelAction
 * @package app\vuecmf\model\facade
 * @method static array getAllApiMap($api_id_arr) 获取所有指定的API映射列表
 * @method static array getModelIdListById($action_id_arr) 根据动作ID获取所属模型ID
 */
class ModelAction extends Facade
{
    /**
     * @return string
     */
    protected static function getFacadeClass(): string
    {
        return 'app\vuecmf\model\ModelAction';
    }

}