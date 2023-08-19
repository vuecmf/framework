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
 * 模型动作管理
 * Class ModelAction
 * @package app\vuecmf\controller
 */
class ModelAction extends Base
{
    /**
     * 获取Api映射列表
     * @return Json
     */
    public function get_api_map(): Json
    {
        return self::common('GetApiMap', '拉取Api映射列表成功！');
    }

    /**
     * 获取动作列表，根据模型分组
     * @return Json
     */
    public function get_action_list(): Json
    {
        return self::common('GetActionList', '拉取所有动作列表成功！');
    }

}
