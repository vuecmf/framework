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
 * 模型配置模型
 * Class ModelConfig
 * @package app\vuecmf\model\facade
 * @method static string getTableNameByModelId($model_id) 根据模型ID获取对应表名（不含前缀）
 * @method static string getModelNameByModelId($model_id) 根据模型ID获取对应模型名称
 * @method static object getModelInstanceByModelId($model_id) 根据模型ID获取对应模型实例
 * @method static array getModelConfig(int $model_id) 获取指定模型的配置信息
 */
class ModelConfig extends Facade
{
    /**
     * @return string
     */
    protected static function getFacadeClass(): string
    {
        return 'app\vuecmf\model\ModelConfig';
    }
}