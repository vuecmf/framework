<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2022 http://www.vuecmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( https://github.com/vuecmf/framework/blob/main/LICENSE )
// +----------------------------------------------------------------------
// | Author: vuecmf <tulihua2004@126.com>
// +----------------------------------------------------------------------
declare (strict_types = 1);

namespace app\vuecmf\middleware;

use app\vuecmf\model\facade\ModelFormRules as ModelFormRulesService;
use app\vuecmf\model\facade\ModelIndex as ModelIndexService;
use app\vuecmf\model\facade\ModelConfig as ModelConfigService;
use think\Exception;
use Closure;
use think\exception\ValidateException;
use think\Request;
use think\Response;

/**
 * 数据校验中间件
 * Class DataCheck
 * @package app\vuecmf\middleware
 */
class DataCheck
{
    /**
     * 处理请求: 表单数据校验
     *
     * @param Request $request
     * @param Closure       $next
     * @return Response
     */
    public function handle(Request $request, Closure $next): Response
    {
        try{
            if(!$request->isPost()) throw new Exception('请求方式错误!');

            $rule = []; //校验规则
            $message = []; //错误提示信息

            //根据模型从model_form_rules表中取出数据校验规则
            $rule_list = ModelFormRulesService::getRuleListByModel($request->model_id);
            foreach ($rule_list as $val){
                $rule_value = $val->rule_type . (!empty($val->rule_value) ? ':' . $val->rule_value : '');
                $rule[$val->field_name] = isset($rule[$val->field_name]) ? $rule[$val->field_name] . '|' . $rule_value : $rule_value;
                $message[$val->field_name . '.' . $val->rule_type] = $val->error_tips;
            }

            //字段唯一索引校验, 根据模型从model_index表取出唯一索引字段
            $unique_fields = ModelIndexService::getUniqueFields($request->model_id);
            $table_name = ModelConfigService::getTableNameByModelId($request->model_id);
            foreach ($unique_fields as $field_list){
                $field_name = $field_list[0]['field_name'];
                $other_field_name = [];
                $field_label = [];
                foreach ($field_list as $field){
                    array_push($field_label, $field['label']);
                    array_push($other_field_name, $field['field_name']);
                }
                $rule_value = 'unique:' . $table_name;
                !empty($other_field_name) && $rule_value .= ',' . implode('^', $other_field_name);

                $rule[$field_name] = isset($rule[$field_name]) ? $rule[$field_name] . '|' . $rule_value : $rule_value;
                $message[$field_name . '.unique'] = implode(',', $field_label) . '必须唯一！现已重复。';
            }

            //开始校验表单数据
            $data = $request->post('data','{}');
            is_string($data) && $data = json_decode($data, true);

            if(!empty($data)){
                $is_batch = false;
                foreach ($data as $key => $item){
                    if(is_array($item)){
                        foreach ($item as &$item2){
                            is_array($item2) && $item2 = implode(',', $item2);
                        }
                    }

                    !is_string($key) && $is_batch = true;
                    $is_batch && validate($rule, $message, true)->check($item);//批量导入验证
                }
                !$is_batch && validate($rule, $message, true)->check($data);  //单个表单保存验证
            }

            return $next($request);

        }catch (ValidateException $e){
            return ajaxFail($e, 1001);
        }catch (\Exception $e){
            return ajaxFail($e, 1002);
        }

    }
}
