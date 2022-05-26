<?php

use think\migration\Migrator;
use think\migration\db\Column;

class UpdateModelField extends Migrator
{

    public function up()
    {

        //更新表数据
        $this->execute('update '.config('database.connections.mysql.prefix').'model_field set type = "varchar",length = 24,default_value = "" where id in(74,76);');

    }

    public function down()
    {
        //还原表数据
        $this->execute('update '.config('database.connections.mysql.prefix').'model_field set type = "bigint",length = 20,default_value = 0 where id in(74,76);');

    }
}
