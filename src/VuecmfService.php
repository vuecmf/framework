<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2023 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf;

use think\Service;
use app\vuecmf\command\Publish;

class VuecmfService extends Service
{

    /**
     * Boot function.
     *
     * @return void
     */
    public function boot()
    {
        $this->commands(['vuecmf:publish' => Publish::class]);
    }
    

}