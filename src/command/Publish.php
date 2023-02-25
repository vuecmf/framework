<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2022 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\command;

use think\console\Command;
use think\console\Input;
use think\console\Output;

/**
 * 发布配置文件、迁移文件指令
 */
class Publish extends Command
{
    /**
     * 配置指令
     */
    protected function configure()
    {
        $this->setName('vuecmf:publish')->setDescription('Publish Vuecmf');
    }

    /**
     * 执行指令
     * @param Input  $input
     * @param Output $output
     * @return null|int
     * @throws LogicException
     * @see setCode()
     */
    protected function execute(Input $input, Output $output)
    {
        $destination = $this->app->getRootPath() . '/database/migrations/';
        if(!is_dir($destination)){
            mkdir($destination, 0755, true);
        }
        $source = __DIR__.'/../../database/migrations/';
        $handle = dir($source);

        while($entry=$handle->read()) {
            if(($entry!=".")&&($entry!="..")){
                if(is_file($source.$entry)){
                    copy($source.$entry, $destination.$entry);
                }
            }
        }

        if (!file_exists(config_path().'tauthz-rbac-model.conf')) {
            copy(__DIR__.'/../../config/tauthz-rbac-model.conf', config_path().'tauthz-rbac-model.conf');
        }

        if (!file_exists(config_path().'tauthz.php')) {
            copy(__DIR__.'/../../config/tauthz.php', config_path().'tauthz.php');
        }

        $destination = app_path() . '/vuecmf/';
        if(!is_dir($destination)){
            mkdir($destination, 0755, true);
        }

        if (!file_exists($destination.'common.php')) {
            copy(__DIR__.'/../common.php', app_path().'/common.php');
        }

        if (!file_exists($destination.'event.php')) {
            copy(__DIR__.'/../event.php', $destination.'event.php');
        }

        if (!file_exists($destination.'middleware.php')) {
            copy(__DIR__.'/../middleware.php', $destination.'middleware.php');
        }


        $controller_dir = $destination . 'controller/';
        if(!is_dir($controller_dir)){
            mkdir($controller_dir, 0755, true);
        }

        if (!file_exists($controller_dir.'Index.php')) {
            file_put_contents($controller_dir.'Index.php', '<?php
declare (strict_types = 1);

namespace app\vuecmf\controller;


class Index
{
    public function index(): string
    {
        return \'<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} a{color:#2E5CD5;cursor: pointer;text-decoration: none} a:hover{text-decoration:underline; } body{ background: #fff; font-family: "Century Gothic","Microsoft yahei"; color: #333;font-size:18px;} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.6em; font-size: 42px }</style><div style="padding: 24px 48px;"> <h1>:) </h1><p>Welcome to VueCMF V2.1<br/></p><span style="font-size:25px;">[ Powered by <a href="http://www.vuecmf.com/" target="_blank">vuecmf</a> ]</span><script src="https://hm.baidu.com/hm.js?74079f71bcec1421dd89f7c08ed21d68"></script></div>\';
    }
}
        ');
        }

    }
}

