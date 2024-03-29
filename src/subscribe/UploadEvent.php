<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2023 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\subscribe;

use app\vuecmf\model\ModelFormRules;
use think\Exception;
use think\facade\Filesystem;
use think\Request;

/**
 * 文件上传事件
 * Class UploadEvent
 * @package app\vuecmf\subscribe
 */
class UploadEvent extends BaseEvent
{

    /**
     * 接收文件并保存到服务器
     * @param Request $request
     * @return array
     */
    public function onIndex(Request $request): array
    {
        $field_name = $request->post('field_name');
        $file = $request->file('file');

        $check_config = [];
        $message = [];

        //若字段有配置上传校验规则
        $rule_config = ModelFormRules::alias('vmfr')
            ->field('rule_type, rule_value, error_tips')
            ->join('model_form vmf', 'vmfr.model_form_id = vmf.id', 'LEFT')
            ->join('model_field vmf2', 'vmf.model_field_id = vmf2.id', 'LEFT')
            ->whereIn('rule_type', ['file','image','fileExt','fileMime','fileSize'])
            ->where('vmfr.status', 10)
            ->where('vmf.status', 10)
            ->where('vmf2.status', 10)
            ->where('vmf2.field_name', $field_name)
            ->select();

        if(!$rule_config->isEmpty()){
            $rules = [];
            foreach ($rule_config as $val){
                $rules[] = !empty($val->rule_value) ? $val->rule_type . ':' . $val->rule_value : $val->rule_type;
                !empty($val->error_tips) && $message['file.'. $val->rule_type] = $val->error_tips;
            }

            $check_config['file'] = implode('|', $rules);
        }else{
            $rules = [];
            !empty(config('filesystem.upload.file_size')) && $rules[] = 'fileSize:' . config('filesystem.upload.file_size');
            !empty(config('filesystem.upload.file_ext')) && $rules[] = 'fileExt:' . config('filesystem.upload.file_ext');

            !empty($rules) && $check_config = ['file' => implode('|', $rules)];
        }

        try{
            !empty($check_config) && validate($check_config, $message)->check(['file'=>$file]);
            $file_url = Filesystem::disk('public')->putFile('file', $file); //保存文件
            $file_url = str_replace('\\','/',$file_url); //针对windows环境下处理分隔符

            return [
                'field_name' => $field_name,
                'url' => $request->domain() . config('filesystem.disks.public.url') . '/' . $file_url
            ];

        }catch (\think\exception\ValidateException $e){
            throw new Exception($field_name . '|' . $e->getMessage());
        }

    }

}
