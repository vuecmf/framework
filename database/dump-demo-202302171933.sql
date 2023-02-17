-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: demo
-- ------------------------------------------------------
-- Server version	5.7.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `vuecmf_admin`
--

DROP TABLE IF EXISTS `vuecmf_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `username` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `is_super` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '超级管理员：10=是，20=否',
  `reg_time` datetime(3) NOT NULL COMMENT '注册时间',
  `reg_ip` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '注册IP',
  `last_login_time` datetime(3) NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `update_time` datetime(3) NOT NULL COMMENT '更新时间',
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'api访问token',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`username`,`email`,`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_admin`
--

LOCK TABLES `vuecmf_admin` WRITE;
/*!40000 ALTER TABLE `vuecmf_admin` DISABLE KEYS */;
INSERT INTO `vuecmf_admin` VALUES (1,'vuecmf','$2a$10$/OGrqqU4vJomU475crwBM.wi3380HsDY3RWnq1OyZaM7RRQvzZMeG','2278667823@qq.com','18988888888',10,'2022-11-07 09:20:58.032','','2023-02-17 19:17:04.000','127.0.0.1','2023-02-15 10:32:37.914','',10),(2,'test','$2a$10$Yewdyx9djNGAc3gsPiuwL.mtFh3uKE2eICppONXlwUyBmSY./5RNO','test@test.com','18090908989',20,'2022-11-09 20:55:34.479','','2023-02-17 19:29:20.000','127.0.0.1','2022-11-09 20:55:34.479','1e09f3c60e41c7d2ad80ced4cfbdbdad',10),(3,'test111','','test@test111.com','18090908900',20,'2022-11-09 20:55:34.479','127.0.0.1','2022-11-09 20:55:34.479','','2022-11-09 20:55:34.479','',10),(4,'test223','','test@test222.com','18090908911',20,'2022-11-09 20:55:34.479','127.0.0.1','2023-02-16 20:28:31.000','127.0.0.1','2023-02-16 20:28:31.000','',10);
/*!40000 ALTER TABLE `vuecmf_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_app_config`
--

DROP TABLE IF EXISTS `vuecmf_app_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_app_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `app_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '应用名称',
  `login_enable` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '是否开启登录验证, 10=是，20=否',
  `auth_enable` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '是否开启权限验证, 10=是，20=否',
  `exclusion_url` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '排除验证的URL,多个用英文逗号分隔',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '类型：10=内置，20=扩展',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`app_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--应用配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_app_config`
--

LOCK TABLES `vuecmf_app_config` WRITE;
/*!40000 ALTER TABLE `vuecmf_app_config` DISABLE KEYS */;
INSERT INTO `vuecmf_app_config` VALUES (1,'vuecmf',10,10,'/vuecmf/admin/login, /vuecmf/admin/logout, /vuecmf/model_action/get_api_map',10,10),(2,'demo',20,20,'',20,10);
/*!40000 ALTER TABLE `vuecmf_app_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_field_option`
--

DROP TABLE IF EXISTS `vuecmf_field_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_field_option` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属模型ID',
  `model_field_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型字段ID',
  `option_value` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '选项值',
  `option_label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '选项标签',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '类型：10=内置，20=扩展',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`model_field_id`,`option_value`)
) ENGINE=InnoDB AUTO_INCREMENT=319 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--字段的选项列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_field_option`
--

LOCK TABLES `vuecmf_field_option` WRITE;
/*!40000 ALTER TABLE `vuecmf_field_option` DISABLE KEYS */;
INSERT INTO `vuecmf_field_option` VALUES (1,1,5,'template/content/List','列表组件',10,10),(2,1,8,'10','内置',10,10),(3,1,8,'20','扩展',10,10),(4,1,9,'10','是',10,10),(5,1,9,'20','否',10,10),(6,1,11,'10','开启',10,10),(7,1,11,'20','禁用',10,10),(8,2,16,'action_list','获取动作列表',10,10),(9,2,16,'list','列表',10,10),(10,2,16,'detail','详情',10,10),(11,2,16,'save','保存',10,10),(12,2,16,'save_all','批量保存',10,10),(13,2,16,'delete','删除',10,10),(14,2,16,'delete_batch','批量删除',10,10),(15,2,16,'dropdown','下拉列表',10,10),(16,2,16,'add_permission','设置角色权限',10,10),(17,2,16,'assign_role','分配角色',10,10),(18,2,16,'assign_users','批量分配用户',10,10),(19,2,16,'del_permission','删除角色权限',10,10),(20,2,16,'del_users','批量删除用户',10,10),(21,2,16,'get_all_roles','获取所有角色',10,10),(22,2,16,'get_all_users','获取所有用户',10,10),(23,2,16,'get_permission','获取角色下所有权限',10,10),(24,2,16,'get_roles','获取用户的角色',10,10),(25,2,16,'get_users','获取角色下所有用户',10,10),(26,2,16,'get_user_permission','获取用户权限',10,10),(27,2,16,'set_user_permission','设置用户权限',10,10),(28,2,16,'login','登录后台',10,10),(29,2,16,'logout','退出系统',10,10),(30,2,16,'nav','导航菜单',10,10),(31,2,16,'upload','上传文件',10,10),(32,2,17,'10','开启',10,10),(33,2,17,'20','禁用',10,10),(34,3,22,'char','固定长度字符串',10,10),(35,3,22,'varchar','可变长度字符串',10,10),(36,3,22,'text','多行文本',10,10),(37,3,22,'mediumtext','中型多行文本',10,10),(38,3,22,'longtext','大型多行文本',10,10),(39,3,22,'tinyint','小型数值',10,10),(40,3,22,'smallint','中型数值',10,10),(41,3,22,'int','大型数值',10,10),(42,3,22,'bigint','越大型数值',10,10),(43,3,22,'float','单精度浮点型',10,10),(44,3,22,'double','双精度浮点型',10,10),(45,3,22,'decimal','金额型',10,10),(46,3,22,'date','日期',10,10),(47,3,22,'datetime','日期时间',10,10),(48,3,22,'timestamp','日期时间',10,10),(49,3,25,'10','是',10,10),(50,3,25,'20','否',10,10),(51,3,28,'10','是',10,10),(52,3,28,'20','否',10,10),(53,3,29,'10','是',10,10),(54,3,29,'20','否',10,10),(55,3,30,'10','是',10,10),(56,3,30,'20','否',10,10),(57,3,31,'10','显示',10,10),(58,3,31,'20','不显示',10,10),(59,3,32,'10','固定',10,10),(60,3,32,'20','不固定',10,10),(61,3,34,'10','是',10,10),(62,3,34,'20','否',10,10),(63,3,36,'10','开启',10,10),(64,3,36,'20','禁用',10,10),(65,4,43,'10','开启',10,10),(66,4,43,'20','禁用',10,10),(67,5,47,'NORMAL','常规',10,10),(68,5,47,'UNIQUE','唯一',10,10),(69,5,47,'FULLTEXT','全文',10,10),(70,5,48,'10','开启',10,10),(71,5,48,'20','禁用',10,10),(72,6,55,'10','开启',10,10),(73,6,55,'20','禁用',10,10),(74,7,58,'map-location','定位',10,10),(75,7,58,'coordinate','坐标',10,10),(76,7,58,'alarm-clock','闹钟',10,10),(77,7,58,'clock','时钟',10,10),(78,7,58,'calendar','日历',10,10),(79,7,58,'apple','苹果',10,10),(80,7,58,'pear','梨子',10,10),(81,7,58,'orange','桔子',10,10),(82,7,58,'cherry','樱桃',10,10),(83,7,58,'grape','葡萄',10,10),(84,7,58,'watermelon','西瓜',10,10),(85,7,58,'burger','汉堡包',10,10),(86,7,58,'dessert','甜点',10,10),(87,7,58,'fries','薯条',10,10),(88,7,58,'ice-cream','冰淇淋',10,10),(89,7,58,'milk-tea','奶茶',10,10),(90,7,58,'lollipop','棒棒糖',10,10),(91,7,58,'sugar','糖果',10,10),(92,7,58,'food','食物',10,10),(93,7,58,'fork-spoon','叉勺',10,10),(94,7,58,'coffee-cup','咖啡杯',10,10),(95,7,58,'goblet','高脚杯',10,10),(96,7,58,'mug','杯子',10,10),(97,7,58,'bowl','碗',10,10),(98,7,58,'arrow-left','左箭头',10,10),(99,7,58,'arrow-right','右箭头',10,10),(100,7,58,'avatar','头像',10,10),(101,7,58,'user','用户',10,10),(102,7,58,'male','男',10,10),(103,7,58,'female','女',10,10),(104,7,58,'bell','铃',10,10),(105,7,58,'basketball','篮球',10,10),(106,7,58,'bicycle','自行车',10,10),(107,7,58,'ship','船',10,10),(108,7,58,'van','货车',10,10),(109,7,58,'box','箱子',10,10),(110,7,58,'briefcase','公文包',10,10),(111,7,58,'suitcase','手提箱',10,10),(112,7,58,'brush','刷子',10,10),(113,7,58,'camera','相机',10,10),(114,7,58,'video-camera','摄像机',10,10),(115,7,58,'cellphone','手机',10,10),(116,7,58,'phone','电话',10,10),(117,7,58,'headset','耳机',10,10),(118,7,58,'watch','手表',10,10),(119,7,58,'cpu','CPU',10,10),(120,7,58,'microphone','麦克风',10,10),(121,7,58,'monitor','显示器',10,10),(122,7,58,'mouse','鼠标',10,10),(123,7,58,'printer','打印机',10,10),(124,7,58,'picture','图片',10,10),(125,7,58,'film','电影',10,10),(126,7,58,'video-play','播放',10,10),(127,7,58,'video-pause','暂停',10,10),(128,7,58,'chat-dot-round','聊天',10,10),(129,7,58,'circle-check','打钩',10,10),(130,7,58,'circle-close','打叉',10,10),(131,7,58,'circle-plus','圆形加号',10,10),(132,7,58,'umbrella','雨伞',10,10),(133,7,58,'mostly-cloudy','云朵',10,10),(134,7,58,'wind-power','风力',10,10),(135,7,58,'lightning','闪电',10,10),(136,7,58,'sunny','太阳',10,10),(137,7,58,'moon','月亮',10,10),(138,7,58,'star','星星',10,10),(139,7,58,'money','钞票',10,10),(140,7,58,'coin','硬币',10,10),(141,7,58,'credit-card','信用卡',10,10),(142,7,58,'wallet','钱包',10,10),(143,7,58,'discount','折扣',10,10),(144,7,58,'goods','购物袋',10,10),(145,7,58,'shopping-cart','购物车',10,10),(146,7,58,'price-tag','价格标签',10,10),(147,7,58,'collection-tag','收藏标签',10,10),(148,7,58,'compass','指南针',10,10),(149,7,58,'connection','连接',10,10),(150,7,58,'link','超链接',10,10),(151,7,58,'scissor','剪切',10,10),(152,7,58,'copy-document','复制',10,10),(153,7,58,'delete','删除',10,10),(154,7,58,'rank','移动',10,10),(155,7,58,'crop','裁切',10,10),(156,7,58,'edit','编辑',10,10),(157,7,58,'filter','过滤',10,10),(158,7,58,'upload','上传',10,10),(159,7,58,'download','下载',10,10),(160,7,58,'finished','完成',10,10),(161,7,58,'document','文档',10,10),(162,7,58,'folder','文件夹',10,10),(163,7,58,'data-analysis','数据分析',10,10),(164,7,58,'histogram','直方图',10,10),(165,7,58,'trend-charts','折线图',10,10),(166,7,58,'pie-chart','饼图',10,10),(167,7,58,'flag','旗帜',10,10),(168,7,58,'full-screen','全屏',10,10),(169,7,58,'grid','网格',10,10),(170,7,58,'guide','路标',10,10),(171,7,58,'help','帮助',10,10),(172,7,58,'view','展示',10,10),(173,7,58,'hide','隐藏',10,10),(174,7,58,'list','列表',10,10),(175,7,58,'house','房子',10,10),(176,7,58,'office-building','办公楼',10,10),(177,7,58,'school','学校',10,10),(178,7,58,'shop','商店',10,10),(179,7,58,'key','钥匙',10,10),(180,7,58,'lock','锁',10,10),(181,7,58,'management','管理',10,10),(182,7,58,'magnet','磁铁',10,10),(183,7,58,'medal','奖章',10,10),(184,7,58,'menu','菜单',10,10),(185,7,58,'message-box','消息盒子',10,10),(186,7,58,'message','信封',10,10),(187,7,58,'postcard','明信片',10,10),(188,7,58,'notebook','笔记本',10,10),(189,7,58,'info-filled','信息',10,10),(190,7,58,'warning-filled','警告',10,10),(191,7,58,'notification','通知',10,10),(192,7,58,'question-filled','问号',10,10),(193,7,58,'odometer','里程计',10,10),(194,7,58,'more','更多',10,10),(195,7,58,'operation','操作',10,10),(196,7,58,'opportunity','机会',10,10),(197,7,58,'paperclip','回形针',10,10),(198,7,58,'present','当前',10,10),(199,7,58,'reading','阅读',10,10),(200,7,58,'search','放大镜',10,10),(201,7,58,'zoom-in','放大镜+',10,10),(202,7,58,'zoom-out','放大镜-',10,10),(203,7,58,'setting','齿轮',10,10),(204,7,58,'share','分享',10,10),(205,7,58,'sort','排序',10,10),(206,7,58,'stamp','图章',10,10),(207,7,58,'switch-button','开关',10,10),(208,7,58,'takeaway-box','任务',10,10),(209,7,64,'10','内置',10,10),(210,7,64,'20','扩展',10,10),(211,7,66,'10','开启',10,10),(212,7,66,'20','禁用',10,10),(213,8,72,'10','是',10,10),(214,8,72,'20','否',10,10),(215,8,79,'10','开启',10,10),(216,8,79,'20','禁用',10,10),(217,9,83,'text','文本输入框',10,10),(218,9,83,'textarea','多行文本输入框',10,10),(219,9,83,'radio','单选框',10,10),(220,9,83,'password','密码框',10,10),(221,9,83,'checkbox','多选框',10,10),(222,9,83,'input_number','计数器',10,10),(223,9,83,'select','单选下拉框',10,10),(224,9,83,'select_mul','多选下拉框',10,10),(225,9,83,'switch','开关',10,10),(226,9,83,'date','日期日历',10,10),(227,9,83,'datetime','日期时间日历',10,10),(228,9,83,'upload_image','图片上传',10,10),(229,9,83,'upload_file','文件上传',10,10),(230,9,83,'editor','编辑器',10,10),(231,9,83,'hidden','隐藏域',10,10),(232,9,85,'10','是',10,10),(233,9,85,'20','否',10,10),(234,9,87,'10','开启',10,10),(235,9,87,'20','禁用',10,10),(236,10,91,'require','必填',10,10),(237,10,91,'number','纯数字(不包负数和小数点)',10,10),(238,10,91,'integer','整数',10,10),(239,10,91,'float','浮点数',10,10),(240,10,91,'boolean','布尔值',10,10),(241,10,91,'email','邮箱',10,10),(242,10,91,'array','数组',10,10),(243,10,91,'accepted','是否为(yes,on,或是1)',10,10),(244,10,91,'date','日期',10,10),(245,10,91,'alpha','纯字母',10,10),(246,10,91,'alphaNum','字母和数字',10,10),(247,10,91,'alphaDash','字母和数字，下划线_及破折号-',10,10),(248,10,91,'chs','纯汉字',10,10),(249,10,91,'chsAlpha','汉字、字母',10,10),(250,10,91,'chsAlphaNum','汉字、字母和数字',10,10),(251,10,91,'chsDash','汉字、字母、数字和下划线_及破折号-',10,10),(252,10,91,'cntrl','换行、缩进、空格',10,10),(253,10,91,'graph','可打印字符(空格除外)',10,10),(254,10,91,'print','可打印字符(包括空格)',10,10),(255,10,91,'lower','小写字符',10,10),(256,10,91,'upper','大写字符',10,10),(257,10,91,'space','空白字符(包括缩进，垂直制表符，换行符，回车和换页字符)',10,10),(258,10,91,'xdigit','十六进制字符串',10,10),(259,10,91,'activeUrl','域名或者IP',10,10),(260,10,91,'url','URL地址',10,10),(261,10,91,'ip','IP地址',10,10),(262,10,91,'dateFormat','指定格式的日期',10,10),(263,10,91,'mobile','手机号码',10,10),(264,10,91,'idCard','身份证号码',10,10),(265,10,91,'macAddr','MAC地址',10,10),(266,10,91,'zip','邮政编码',10,10),(267,10,91,'in','在某个范围',10,10),(268,10,91,'notIn','不在某个范围',10,10),(269,10,91,'between','在某个区间',10,10),(270,10,91,'notBetween','不在某个范围',10,10),(271,10,91,'length','长度是否在某个范围',10,10),(272,10,91,'max','最大长度',10,10),(273,10,91,'min','最小长度',10,10),(274,10,91,'after','在某个日期之后',10,10),(275,10,91,'before','在某个日期之前',10,10),(276,10,91,'expire','在某个有效日期之内',10,10),(277,10,91,'allowIp','IP是否在某个范围(多个IP用逗号分隔)',10,10),(278,10,91,'denyIp','IP是否禁止(多个IP用逗号分隔)',10,10),(279,10,91,'confirm','和另外一个字段的值一致',10,10),(280,10,91,'different','和另外一个字段的值不一致',10,10),(281,10,91,'=','等于某个值',10,10),(282,10,91,'>=','大于等于某个值',10,10),(283,10,91,'>','大于某个值',10,10),(284,10,91,'<=','小于等于某个值',10,10),(285,10,91,'<','小于某个值',10,10),(286,10,91,'filter','支持使用filter_var进行验证',10,10),(287,10,91,'regex','正则验证',10,10),(288,10,91,'file','文件',10,10),(289,10,91,'image','图像文件',10,10),(290,10,91,'fileExt','上传文件后缀',10,10),(291,10,91,'fileMime','上传文件类型',10,10),(292,10,91,'fileSize','上传文件大小',10,10),(293,10,91,'token','表单令牌',10,10),(294,10,91,'unique','请求的字段值是否为唯一',10,10),(295,10,91,'requireIf','某个字段的值等于某个值的时候必须',10,10),(296,10,91,'requireWith','某个字段有值的时候必须',10,10),(297,10,91,'requireWithout','某个字段没有值的时候必须',10,10),(298,10,91,'requireCallback','某个callable为真的时候字段必须',10,10),(299,10,94,'10','开启',10,10),(300,10,94,'20','禁用',10,10),(301,11,101,'10','开启',10,10),(302,11,101,'20','禁用',10,10),(303,12,107,'10','开启',10,10),(304,12,107,'20','禁用',10,10),(305,4,38,'10','内置',10,10),(306,4,38,'20','扩展',10,10),(307,14,111,'10','是',10,10),(308,14,111,'20','否',10,10),(309,14,112,'10','是',10,10),(310,14,112,'20','否',10,10),(311,14,114,'10','内置',10,10),(312,14,114,'20','扩展',10,10),(313,14,115,'10','开启',10,10),(314,14,115,'20','禁用',10,10),(315,15,121,'10','开启',10,20),(316,15,121,'20','禁用',10,20),(317,16,123,'10','开启',10,20),(318,16,123,'20','禁用',10,20);
/*!40000 ALTER TABLE `vuecmf_field_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_menu`
--

DROP TABLE IF EXISTS `vuecmf_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单标题',
  `icon` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单图标',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `id_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'ID路径,英文逗号分隔',
  `path_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单路径,英文逗号分隔',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `app_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应用ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '类型：10=内置，20=扩展',
  `sort_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '菜单的排列顺序(小在前)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_menu`
--

LOCK TABLES `vuecmf_menu` WRITE;
/*!40000 ALTER TABLE `vuecmf_menu` DISABLE KEYS */;
INSERT INTO `vuecmf_menu` VALUES (1,'系统管理','setting',0,'','',0,1,10,999999,10),(2,'系统授权','lock',1,'m1','系统管理',0,1,10,2,10),(3,'管理员','user',2,'m1,m2','系统管理,管理员',8,1,10,3,10),(4,'角色','document',2,'m1,m2','系统管理,管理员',11,1,10,4,10),(5,'模型配置','document-copy',1,'m1','系统管理',1,1,10,5,10),(6,'菜单配置','notebook',1,'m1','系统管理',7,1,10,6,10),(7,'应用管理','folder',1,'m1','系统管理',14,1,10,7,10),(8,'图片','calendar',0,'','',0,0,20,1,10),(9,'分类','coordinate',8,'m8','图片',15,2,20,1,10),(10,'图片','pear',8,'m8','图片',16,2,20,2,10);
/*!40000 ALTER TABLE `vuecmf_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_migrations`
--

DROP TABLE IF EXISTS `vuecmf_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_migrations` (
  `version` bigint(20) NOT NULL DEFAULT '0' COMMENT '版本号',
  `migration_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '迁移名称',
  `start_time` datetime(3) NOT NULL COMMENT '开始时间',
  `end_time` datetime(3) NOT NULL COMMENT '结束时间',
  `breakpoint` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '断点'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--数据库升级日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_migrations`
--

LOCK TABLES `vuecmf_migrations` WRITE;
/*!40000 ALTER TABLE `vuecmf_migrations` DISABLE KEYS */;
INSERT INTO `vuecmf_migrations` VALUES (20221107090920,'Init database','2022-11-07 09:20:57.445','2022-11-07 09:20:58.077',0);
/*!40000 ALTER TABLE `vuecmf_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_model_action`
--

DROP TABLE IF EXISTS `vuecmf_model_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_model_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `label` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '动作标签',
  `api_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '后端请求地址',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属模型ID',
  `action_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '动作类型',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`model_id`,`action_type`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--模型动作表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_model_action`
--

LOCK TABLES `vuecmf_model_action` WRITE;
/*!40000 ALTER TABLE `vuecmf_model_action` DISABLE KEYS */;
INSERT INTO `vuecmf_model_action` VALUES (1,'模型管理列表','/vuecmf/model_config',1,'list',10),(2,'保存模型','/vuecmf/model_config/save',1,'save',10),(3,'删除模型','/vuecmf/model_config/delete',1,'delete',10),(4,'批量保存模型','/vuecmf/model_config/save_all',1,'save_all',10),(5,'批量删除模型','/vuecmf/model_config/delete_batch',1,'delete_batch',10),(6,'模型下拉列表','/vuecmf/model_config/dropdown',1,'dropdown',10),(7,'模型动作管理列表','/vuecmf/model_action',2,'list',10),(8,'保存模型动作','/vuecmf/model_action/save',2,'save',10),(9,'删除模型动作','/vuecmf/model_action/delete',2,'delete',10),(10,'动作下拉列表','/vuecmf/model_action/dropdown',2,'dropdown',10),(11,'批量保存模型动作','/vuecmf/model_action/save_all',2,'save_all',10),(12,'批量删除模型动作','/vuecmf/model_action/delete_batch',2,'delete_batch',10),(14,'模型字段管理列表','/vuecmf/model_field',3,'list',10),(15,'保存模型字段','/vuecmf/model_field/save',3,'save',10),(16,'删除模型字段','/vuecmf/model_field/delete',3,'delete',10),(17,'字段下拉列表','/vuecmf/model_field/dropdown',3,'dropdown',10),(18,'批量保存模型字段','/vuecmf/model_field/save_all',3,'save_all',10),(19,'批量删除模型字段','/vuecmf/model_field/delete_batch',3,'delete_batch',10),(20,'字段选项管理列表','/vuecmf/field_option',4,'list',10),(21,'保存字段选项','/vuecmf/field_option/save',4,'save',10),(22,'删除字段选项','/vuecmf/field_option/delete',4,'delete',10),(23,'批量保存字段选项','/vuecmf/field_option/save_all',4,'save_all',10),(24,'批量删除字段选项','/vuecmf/field_option/delete_batch',4,'delete_batch',10),(25,'模型索引管理列表','/vuecmf/model_index',5,'list',10),(26,'保存模型索引','/vuecmf/model_index/save',5,'save',10),(27,'删除模型索引','/vuecmf/model_index/delete',5,'delete',10),(28,'批量保存模型索引','/vuecmf/model_index/save_all',5,'save_all',10),(29,'批量删除模型索引','/vuecmf/model_index/delete_batch',5,'delete_batch',10),(30,'模型关联管理列表','/vuecmf/model_relation',6,'list',10),(31,'保存模型关联','/vuecmf/model_relation/save',6,'save',10),(32,'删除模型关联','/vuecmf/model_relation/delete',6,'delete',10),(33,'批量保存模型关联','/vuecmf/model_relation/save_all',6,'save_all',10),(34,'批量删除模型关联','/vuecmf/model_relation/delete_batch',6,'delete_batch',10),(35,'菜单管理列表','/vuecmf/menu',7,'list',10),(36,'保存菜单','/vuecmf/menu/save',7,'save',10),(37,'删除菜单','/vuecmf/menu/delete',7,'delete',10),(38,'导航菜单','/vuecmf/menu/nav',7,'nav',10),(39,'批量保存菜单','/vuecmf/menu/save_all',7,'save_all',10),(40,'批量删除菜单','/vuecmf/menu/delete_batch',7,'delete_batch',10),(42,'管理员列表','/vuecmf/admin',8,'list',10),(43,'保存管理员','/vuecmf/admin/save',8,'save',10),(44,'删除管理员','/vuecmf/admin/delete',8,'delete',10),(45,'管理员详情','/vuecmf/admin/detail',8,'detail',10),(46,'获取动作列表','/vuecmf/model_action/get_action_list',8,'action_list',10),(47,'分配角色','/vuecmf/admin/add_role',8,'assign_role',10),(48,'登录后台','/vuecmf/admin/login',8,'login',10),(49,'退出系统','/vuecmf/admin/logout',8,'logout',10),(50,'批量保存管理员','/vuecmf/admin/save_all',8,'save_all',10),(51,'批量删除管理员','/vuecmf/admin/delete_batch',8,'delete_batch',10),(52,'获取所有角色','/vuecmf/admin/get_all_roles',8,'get_all_roles',10),(53,'获取用户的角色','/vuecmf/admin/get_roles',8,'get_roles',10),(54,'设置用户权限','/vuecmf/admin/set_user_permission',8,'set_user_permission',10),(55,'获取用户权限','/vuecmf/admin/get_user_permission',8,'get_user_permission',10),(56,'模型表单管理列表','/vuecmf/model_form',9,'list',10),(57,'保存模型表单','/vuecmf/model_form/save',9,'save',10),(58,'删除模型表单','/vuecmf/model_form/delete',9,'delete',10),(59,'表单下拉列表','/vuecmf/model_form/dropdown',9,'dropdown',10),(60,'批量保存模型表单','/vuecmf/model_form/save_all',9,'save_all',10),(61,'批量删除模型表单','/vuecmf/model_form/delete_batch',9,'delete_batch',10),(62,'模型表单验证管理列表','/vuecmf/model_form_rules',10,'list',10),(63,'保存模型表单验证','/vuecmf/model_form_rules/save',10,'save',10),(64,'删除模型表单验证','/vuecmf/model_form_rules/delete',10,'delete',10),(65,'批量保存模型表单验证','/vuecmf/model_form_rules/save_all',10,'save_all',10),(66,'批量删除模型表单验证','/vuecmf/model_form_rules/delete_batch',10,'delete_batch',10),(67,'角色管理列表','/vuecmf/roles',11,'list',10),(68,'保存角色','/vuecmf/roles/save',11,'save',10),(69,'删除角色','/vuecmf/roles/delete',11,'delete',10),(70,'批量保存角色','/vuecmf/roles/save_all',11,'save_all',10),(71,'获取动作列表','/vuecmf/model_action/get_action_list',11,'action_list',10),(72,'批量删除角色','/vuecmf/roles/delete_batch',11,'delete_batch',10),(73,'批量分配用户','/vuecmf/roles/add_users',11,'assign_users',10),(74,'批量删除用户','/vuecmf/roles/del_users',11,'del_users',10),(75,'设置角色权限','/vuecmf/roles/add_permission',11,'add_permission',10),(76,'删除角色权限','/vuecmf/roles/del_permission',11,'del_permission',10),(77,'获取角色下所有用户','/vuecmf/roles/get_users',11,'get_users',10),(78,'获取角色下所有权限','/vuecmf/roles/get_permission',11,'get_permission',10),(79,'获取所有用户','/vuecmf/roles/get_all_users',11,'get_all_users',10),(80,'模型联动设置列表','/vuecmf/model_form_linkage',12,'list',10),(81,'保存模型联动设置','/vuecmf/model_form_linkage/save',12,'save',10),(82,'删除模型联动设置','/vuecmf/model_form_linkage/delete',12,'delete',10),(83,'批量保存模型联动设置','/vuecmf/model_form_linkage/save_all',12,'save_all',10),(84,'批量删除模型联动设置','/vuecmf/model_form_linkage/delete_batch',12,'delete_batch',10),(85,'文件上传','/vuecmf/upload',13,'upload',10),(96,'应用管理列表','/vuecmf/app_config',14,'list',10),(97,'保存应用','/vuecmf/app_config/save',14,'save',10),(98,'删除应用','/vuecmf/app_config/delete',14,'delete',10),(99,'应用下拉列表','/vuecmf/app_config/dropdown',14,'dropdown',10),(100,'批量保存应用','/vuecmf/app_config/save_all',14,'save_all',10),(101,'批量删除应用','/vuecmf/app_config/delete_batch',14,'delete_batch',10),(102,'图片分类管理列表','/demo/photo_cate',15,'list',10),(103,'保存图片分类','/demo/photo_cate/save',15,'save',10),(104,'删除图片分类','/demo/photo_cate/delete',15,'delete',10),(105,'图片分类下拉列表','/demo/photo_cate/dropdown',15,'dropdown',10),(106,'批量保存图片分类','/demo/photo_cate/save_all',15,'save_all',10),(107,'图片管理列表','/demo/photo',16,'list',10),(108,'保存图片','/demo/photo/save',16,'save',10),(109,'删除图片','/demo/photo/delete',16,'delete',10),(110,'图片下拉列表','/demo/photo/dropdown',16,'dropdown',10),(111,'批量保存图片','/demo/photo/save_all',16,'save_all',10);
/*!40000 ALTER TABLE `vuecmf_model_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_model_config`
--

DROP TABLE IF EXISTS `vuecmf_model_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_model_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `app_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属应用ID',
  `table_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '模型对应的表名(不含表前缘)',
  `label` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '模型标签',
  `component_tpl` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件模板',
  `default_action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '默认动作ID',
  `search_field_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '搜索字段ID，多个用逗号分隔',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '类型：10=内置，20=扩展',
  `is_tree` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '是否为目录树：10=是，20=否',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '模型对应表的备注',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`app_id`,`table_name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--模型配置管理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_model_config`
--

LOCK TABLES `vuecmf_model_config` WRITE;
/*!40000 ALTER TABLE `vuecmf_model_config` DISABLE KEYS */;
INSERT INTO `vuecmf_model_config` VALUES (1,1,'model_config','模型配置','template/content/List',1,'3,4,5',10,20,'系统--模型配置管理表',10),(2,1,'model_action','模型动作','template/content/List',7,'13,14,16',10,20,'系统--模型动作表',10),(3,1,'model_field','模型字段','template/content/List',14,'19,20,22',10,20,'系统--模型字段管理表',10),(4,1,'field_option','字段选项','template/content/List',20,'41,42',10,20,'系统--字段的选项列表',10),(5,1,'model_index','模型索引','template/content/List',25,'47',10,20,'系统--模型索引设置表',10),(6,1,'model_relation','模型关联','template/content/List',30,'51,53',10,20,'系统--模型关联设置表',10),(7,1,'menu','菜单','template/content/List',35,'57,58,62',10,10,'系统--菜单表',10),(8,1,'admin','管理员','template/content/List',42,'68,70,71',10,20,'系统--管理员表',10),(9,1,'model_form','模型表单','template/content/List',56,'83,84',10,20,'系统--模型表单设置表',10),(10,1,'model_form_rules','模型表单验证','template/content/List',62,'91,92,93',10,20,'系统--模型表单验证设置表',10),(11,1,'roles','角色','template/content/List',67,'96',10,10,'系统--角色表',10),(12,1,'model_form_linkage','模型表单联动','template/content/List',80,'103,104,105',10,20,'系统--模型表单联动设置表',10),(13,1,'upload_file','文件上传','',0,'',10,20,'系统--文件上传',10),(14,1,'app_config','应用配置','template/content/List',96,'110,113',10,20,'系统--应用配置表',10),(15,2,'photo_cate','图片分类','template/content/List',102,'117',20,10,'图片分类',10),(16,2,'photo','图片','template/content/List',107,'134',20,20,'图片',10);
/*!40000 ALTER TABLE `vuecmf_model_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_model_field`
--

DROP TABLE IF EXISTS `vuecmf_model_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_model_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `field_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表的字段名称',
  `label` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表的字段中文名称',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属模型ID',
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表的字段类型',
  `length` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '表的字段长度',
  `decimal_length` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '表的字段为decimal类型时的小数位数',
  `is_null` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '是否为空：10=是，20=否',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表的字段备注说明',
  `default_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据默认值',
  `is_auto_increment` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '是否自动递增：10=是，20=否',
  `is_label` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '是否为标题字段：10=是，20=否',
  `is_signed` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '是否可为负数：10=是，20=否',
  `is_show` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '默认列表中显示：10=显示，20=不显示',
  `is_fixed` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '默认列表中固定：10=固定，20=不固定',
  `column_width` int(10) unsigned NOT NULL DEFAULT '150' COMMENT '列表中默认显示宽度：0表示不限',
  `is_filter` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表中是否可为筛选条件：10=是，20=否',
  `sort_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '表单/列表中字段的排列顺序(小在前)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`field_name`,`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--模型字段管理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_model_field`
--

LOCK TABLES `vuecmf_model_field` WRITE;
/*!40000 ALTER TABLE `vuecmf_model_field` DISABLE KEYS */;
INSERT INTO `vuecmf_model_field` VALUES (1,'id','ID',1,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,1,10),(2,'app_id','所属应用',1,'int',11,0,20,'所属应用ID','0',20,20,20,10,20,150,10,2,10),(3,'table_name','表名',1,'varchar',64,0,20,'模型对应的表名(不含表前缘)','',20,10,20,10,20,150,10,3,10),(4,'label','模型标签',1,'varchar',64,0,20,'模型标签','',20,10,20,10,20,150,10,4,10),(5,'component_tpl','组件模板',1,'varchar',255,0,20,'组件模板','',20,20,20,10,20,150,10,5,10),(6,'default_action_id','默认动作',1,'int',11,0,20,'默认动作ID','0',20,20,20,10,20,150,10,6,10),(7,'search_field_id','搜索字段',1,'varchar',255,0,20,'搜索字段ID，多个用逗号分隔','',20,20,20,10,20,300,20,7,10),(8,'type','类型',1,'smallint',4,0,20,'类型：10=内置，20=扩展','20',20,20,20,10,20,100,10,8,10),(9,'is_tree','目录树',1,'smallint',4,0,20,'是否为目录树：10=是，20=否','20',20,20,20,10,20,100,10,9,10),(10,'remark','表备注',1,'varchar',255,0,20,'模型对应表的备注','',20,20,20,10,20,100,10,10,10),(11,'status','状态',1,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,11,10),(12,'id','ID',2,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,12,10),(13,'label','动作标签',2,'varchar',64,0,20,'动作标签','',20,10,20,10,20,150,10,13,10),(14,'api_path','后端请求地址',2,'varchar',255,0,20,'后端请求地址','',20,20,20,10,20,150,10,14,10),(15,'model_id','所属模型',2,'int',11,0,20,'所属模型ID','0',20,20,20,10,20,150,20,15,10),(16,'action_type','动作类型',2,'varchar',32,0,20,'动作类型','',20,20,20,10,20,150,10,16,10),(17,'status','状态',2,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,17,10),(18,'id','ID',3,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,18,10),(19,'field_name','字段名称',3,'varchar',64,0,20,'表的字段名称','',20,10,20,10,20,150,10,19,10),(20,'label','字段中文名',3,'varchar',64,0,20,'表的字段中文名称','',20,10,20,10,20,150,10,20,10),(21,'model_id','所属模型',3,'int',11,0,20,'所属模型ID','0',20,20,20,10,20,150,20,21,10),(22,'type','字段类型',3,'varchar',20,0,20,'表的字段类型','',20,20,20,10,20,150,10,22,10),(23,'length','字段长度',3,'int',11,0,20,'表的字段长度','0',20,20,20,10,20,100,10,23,10),(24,'decimal_length','小数位数',3,'smallint',2,0,20,'表的字段为decimal类型时的小数位数','0',20,20,20,10,20,100,10,24,10),(25,'is_null','是否为空',3,'smallint',4,0,20,'是否为空：10=是，20=否','10',20,20,20,10,20,100,10,25,10),(26,'note','字段备注',3,'varchar',255,0,20,'表的字段备注说明','',20,20,20,10,20,150,10,26,10),(27,'default_value','默认值',3,'varchar',255,0,20,'数据默认值','',20,20,20,10,20,150,10,27,10),(28,'is_auto_increment','自动递增',3,'smallint',4,0,20,'是否自动递增：10=是，20=否','20',20,20,20,10,20,100,10,28,10),(29,'is_label','标题字段',3,'smallint',4,0,20,'是否为标题字段：10=是，20=否','20',20,20,20,10,20,100,10,29,10),(30,'is_signed','可为负数',3,'smallint',4,0,20,'是否可为负数：10=是，20=否','10',20,20,20,10,20,100,10,30,10),(31,'is_show','列表可显',3,'smallint',4,0,20,'默认列表中显示：10=显示，20=不显示','10',20,20,20,10,20,100,10,31,10),(32,'is_fixed','固定列',3,'smallint',4,0,20,'默认列表中固定：10=固定，20=不固定','20',20,20,20,10,20,100,10,32,10),(33,'column_width','列宽度',3,'int',11,0,20,'列表中默认显示宽度：0表示不限','150',20,20,20,10,20,100,10,33,10),(34,'is_filter','可筛选',3,'smallint',4,0,20,'列表中是否可为筛选条件：10=是，20=否','10',20,20,20,10,20,100,10,34,10),(35,'sort_num','排序',3,'int',11,0,20,'表单/列表中字段的排列顺序(小在前)','0',20,20,20,10,20,100,10,36,10),(36,'status','状态',3,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,37,10),(37,'id','ID',4,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,37,10),(38,'type','类型',4,'smallint',4,0,20,'类型：10=内置，20=扩展','20',20,20,20,10,20,100,10,38,10),(39,'model_id','所属模型',4,'int',11,0,20,'所属模型ID','0',20,20,20,10,20,150,20,39,10),(40,'model_field_id','模型字段',4,'int',11,0,20,'模型字段ID','0',20,20,20,10,20,150,20,40,10),(41,'option_value','选项值',4,'varchar',64,0,20,'选项值','',20,10,20,10,20,150,10,41,10),(42,'option_label','选项标签',4,'varchar',255,0,20,'选项标签','',20,20,20,10,20,150,10,42,10),(43,'status','状态',4,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,43,10),(44,'id','ID',5,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,44,10),(45,'model_id','所属模型',5,'int',11,0,20,'所属模型ID','0',20,20,20,10,20,150,20,45,10),(46,'model_field_id','模型字段',5,'varchar',100,0,20,'模型字段ID','',20,20,20,10,20,150,10,46,10),(47,'index_type','索引类型',5,'varchar',32,0,20,'索引类型： PRIMARY=主键，NORMAL=常规，UNIQUE=唯一，FULLTEXT=全文','NORMAL',20,10,20,10,20,150,10,47,10),(48,'status','状态',5,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,48,10),(49,'id','ID',6,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,49,10),(50,'model_id','所属模型',6,'int',11,0,20,'所属模型ID','0',20,20,20,10,20,150,20,50,10),(51,'model_field_id','模型字段',6,'int',11,0,20,'模型字段ID','0',20,10,20,10,20,150,20,51,10),(52,'relation_model_id','关联模型',6,'int',11,0,20,'关联模型ID','0',20,20,20,10,20,150,10,52,10),(53,'relation_field_id','关联模型字段',6,'int',11,0,20,'关联模型字段ID','0',20,20,20,10,20,150,10,53,10),(54,'relation_show_field_id','显示字段',6,'varchar',255,0,20,'关联模型显示字段ID,多个逗号分隔，全部用*','',20,20,20,10,20,150,10,54,10),(55,'status','状态',6,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,55,10),(56,'id','ID',7,'int',11,0,20,'自增ID','0',10,20,20,20,20,150,20,56,10),(57,'title','菜单标题',7,'varchar',64,0,20,'菜单标题','',20,10,20,10,20,150,10,57,10),(58,'icon','菜单图标',7,'varchar',32,0,20,'菜单图标','',20,20,20,10,20,150,10,58,10),(59,'pid','父级',7,'int',11,0,20,'父级ID','0',20,20,20,20,20,150,10,59,10),(60,'app_id','应用',7,'int',11,0,20,'应用ID','0',20,20,20,10,20,150,10,60,10),(61,'id_path','ID路径',7,'varchar',255,0,20,'ID路径,英文逗号分隔','',20,20,20,10,20,150,20,61,10),(62,'path_name','菜单路径',7,'varchar',255,0,20,'菜单路径,英文逗号分隔','',20,20,20,10,20,150,20,62,10),(63,'model_id','模型',7,'int',11,0,20,'模型ID','0',20,20,20,10,20,150,10,63,10),(64,'type','类型',7,'smallint',4,0,20,'类型：10=内置，20=扩展','20',20,20,20,10,20,100,10,64,10),(65,'sort_num','排序',7,'int',11,0,20,'菜单的排列顺序(小在前)','0',20,20,20,10,20,150,10,65,10),(66,'status','状态',7,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,150,10,66,10),(67,'id','ID',8,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,67,10),(68,'username','用户名',8,'varchar',32,0,20,'用户名','',20,10,20,10,20,150,10,68,10),(69,'password','密码',8,'varchar',255,0,20,'密码','',20,20,20,20,20,150,20,69,10),(70,'email','邮箱',8,'varchar',64,0,20,'邮箱','',20,20,20,10,20,150,10,70,10),(71,'mobile','手机',8,'varchar',32,0,20,'手机','',20,20,20,10,20,150,10,71,10),(72,'is_super','超级管理员',8,'smallint',4,0,20,'超级管理员：10=是，20=否','20',20,20,20,10,20,150,10,72,10),(73,'reg_time','注册时间',8,'timestamp',0,0,20,'注册时间','CURRENT_TIMESTAMP',20,20,20,10,20,150,10,73,10),(74,'reg_ip','注册IP',8,'varchar',24,0,20,'注册IP','',20,20,20,10,20,150,20,74,10),(75,'last_login_time','最后登录时间',8,'timestamp',0,0,20,'最后登录时间','CURRENT_TIMESTAMP',20,20,20,10,20,150,10,75,10),(76,'last_login_ip','最后登录IP',8,'varchar',24,0,20,'最后登录IP','',20,20,20,10,20,150,20,76,10),(77,'update_time','更新时间',8,'timestamp',0,0,20,'更新时间','CURRENT_TIMESTAMP',20,20,20,10,20,150,10,77,10),(78,'token','访问token',8,'varchar',255,0,20,'api访问token','',20,20,20,10,20,150,10,78,10),(79,'status','状态',8,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,79,10),(80,'id','ID',9,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,80,10),(81,'model_id','所属模型',9,'int',11,0,20,'所属模型ID','0',20,20,20,10,20,150,20,81,10),(82,'model_field_id','模型字段',9,'int',11,0,20,'模型字段ID','0',20,20,20,10,20,150,10,82,10),(83,'type','控件类型',9,'varchar',32,0,20,'表单控件类型','',20,10,20,10,20,150,10,83,10),(84,'default_value','控件默认值',9,'varchar',255,0,20,'表单控件默认值','',20,20,20,10,20,150,10,84,10),(85,'is_disabled','是否禁用',9,'smallint',4,0,20,'添加/编辑表单中是否禁用： 10=是，20=否','20',20,20,20,10,20,100,10,85,10),(86,'sort_num','排序',9,'int',11,0,20,'菜单的排列顺序(小在前)','0',20,20,20,10,20,100,10,86,10),(87,'status','状态',9,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,87,10),(88,'id','ID',10,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,88,10),(89,'model_id','所属模型',10,'int',11,0,20,'所属模型ID','0',20,20,20,10,20,150,20,89,10),(90,'model_form_id','模型表单',10,'int',11,0,20,'模型表单ID','0',20,20,20,10,20,150,20,90,10),(91,'rule_type','验证类型',10,'varchar',32,0,20,'表单验证类型','',20,10,20,10,20,150,10,91,10),(92,'rule_value','验证规则',10,'varchar',255,0,20,'表单验证规则','',20,20,20,10,20,150,10,92,10),(93,'error_tips','错误提示',10,'varchar',255,0,20,'表单验证不通过的错误提示信息','',20,20,20,10,20,150,10,93,10),(94,'status','状态',10,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,94,10),(95,'id','ID',11,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,95,10),(96,'role_name','角色名称',11,'varchar',64,0,20,'用户的角色名称','',20,10,20,10,20,150,10,96,10),(98,'pid','父级',11,'int',11,0,20,'父级ID','0',20,20,20,10,20,150,10,98,10),(99,'id_path','层级路径',11,'varchar',255,0,20,'角色ID层级路径','',20,20,20,10,20,150,10,99,10),(100,'remark','备注',11,'varchar',255,0,20,'角色的备注信息','',20,20,20,10,20,150,10,100,10),(101,'status','状态',11,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,101,10),(102,'id','ID',12,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,102,10),(103,'model_id','所属模型',12,'int',11,0,20,'所属模型ID','0',20,20,20,10,20,150,20,103,10),(104,'model_field_id','模型字段',12,'int',11,0,20,'模型字段ID','0',20,10,20,10,20,150,20,104,10),(105,'linkage_field_id','联动字段',12,'int',11,0,20,'联动表单的字段ID','0',20,20,20,10,20,150,10,105,10),(106,'linkage_action_id','联动动作',12,'int',11,0,20,'获取联动表单数据的动作ID','0',20,20,20,10,20,150,10,106,10),(107,'status','状态',12,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,107,10),(109,'id','ID',14,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,109,10),(110,'app_name','应用名称',14,'varchar',64,0,20,'应用名称','',20,10,20,10,20,150,10,110,10),(111,'login_enable','登录验证',14,'smallint',4,0,20,'是否开启登录验证, 10=是，20=否','10',20,20,20,10,20,150,10,111,10),(112,'auth_enable','权限验证',14,'smallint',4,0,20,'是否开启权限验证, 10=是，20=否','10',20,20,20,10,20,150,10,112,10),(113,'exclusion_url','排除验证URL',14,'varchar',2000,0,20,'排除验证的URL，多个用英文逗号分隔','',20,20,20,10,20,150,10,113,10),(114,'type','类型',14,'smallint',4,0,20,'类型：10=内置，20=扩展','20',20,20,20,10,20,150,10,114,10),(115,'status','状态',14,'smallint',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,115,10),(116,'id','ID',15,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,0,10),(117,'title','标题',15,'varchar',64,0,20,'标题','',20,10,20,10,20,150,10,60,10),(118,'pid','父级',15,'int',11,0,20,'父级ID','0',20,20,20,10,20,150,10,9996,10),(119,'id_path','层级路径',15,'varchar',255,0,20,'ID层级路径','',20,20,20,10,20,150,10,9997,10),(120,'sort_num','排序',15,'int',11,0,20,'排列顺序(小在前)','0',20,20,20,10,20,100,10,9998,10),(121,'status','状态',15,'int',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,9999,10),(122,'id','ID',16,'int',11,0,20,'自增ID','0',10,20,20,10,20,100,20,0,10),(123,'status','状态',16,'int',4,0,20,'状态：10=开启，20=禁用','10',20,20,20,10,20,100,10,9999,10),(133,'cid','分类',16,'int',11,0,20,'分类','0',20,20,20,10,20,150,10,2,10),(134,'title','名称',16,'varchar',64,0,20,'名称','',20,10,10,10,20,150,10,3,10),(135,'pic','图片',16,'varchar',255,0,20,'图片','',20,20,10,10,20,150,10,4,10),(137,'content','图片说明',16,'text',0,0,20,'图片说明','',20,20,10,20,20,150,10,5,10);
/*!40000 ALTER TABLE `vuecmf_model_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_model_form`
--

DROP TABLE IF EXISTS `vuecmf_model_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_model_form` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属模型ID',
  `model_field_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型字段ID',
  `type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表单控件类型',
  `default_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表单控件默认值',
  `is_disabled` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '添加/编辑表单中是否禁用： 10=是，20=否',
  `sort_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '菜单的排列顺序(小在前)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`model_field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--模型表单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_model_form`
--

LOCK TABLES `vuecmf_model_form` WRITE;
/*!40000 ALTER TABLE `vuecmf_model_form` DISABLE KEYS */;
INSERT INTO `vuecmf_model_form` VALUES (1,8,68,'text','',20,1,10),(2,8,69,'password','',20,2,10),(3,8,70,'text','',20,3,10),(4,8,71,'text','',20,4,10),(5,8,72,'radio','20',20,5,10),(6,11,96,'text','',20,6,10),(8,11,98,'select','',20,8,10),(9,11,100,'textarea','',20,9,10),(10,11,101,'radio','10',20,10,10),(11,7,57,'text','',20,11,10),(12,7,58,'select','',20,12,10),(13,7,59,'select','',20,13,10),(14,7,60,'select','',20,14,10),(15,7,63,'select','',20,15,10),(16,7,65,'input_number','0',20,16,10),(17,7,66,'radio','10',20,17,10),(18,1,2,'select','',20,18,10),(19,1,3,'text','',20,19,10),(20,1,4,'text','',20,20,10),(21,1,5,'select','template/content/List',20,21,10),(22,1,6,'select','',20,22,10),(23,1,7,'select_mul','',20,23,10),(24,1,9,'radio','20',20,24,10),(25,1,10,'textarea','',20,25,10),(26,1,11,'radio','10',20,26,10),(27,3,19,'text','',20,27,10),(28,3,20,'text','',20,28,10),(29,3,21,'select','',10,29,10),(30,3,22,'select','',20,30,10),(31,3,23,'input_number','',20,31,10),(32,3,24,'input_number','0',20,32,10),(33,3,25,'radio','10',20,33,10),(34,3,27,'text','',20,34,10),(35,3,26,'textarea','',20,35,10),(36,3,28,'radio','20',20,36,10),(37,3,29,'radio','20',20,37,10),(38,3,30,'radio','10',20,38,10),(39,3,31,'radio','10',20,39,10),(40,3,32,'radio','20',20,40,10),(41,3,33,'input_number','150',20,41,10),(42,3,34,'radio','10',20,42,10),(43,3,35,'input_number','0',20,43,10),(44,3,36,'radio','10',20,44,10),(45,4,39,'select','',10,45,10),(46,4,40,'select','',10,46,10),(47,4,41,'text','',20,47,10),(48,4,42,'text','',20,48,10),(49,4,43,'radio','10',20,49,10),(50,5,45,'select','',10,50,10),(51,5,46,'select_mul','',20,51,10),(52,5,47,'select','NORMAL',20,52,10),(53,5,48,'radio','10',20,53,10),(54,6,50,'select','',10,54,10),(55,6,51,'select','',10,55,10),(56,6,52,'select','',20,56,10),(57,6,53,'select','',20,57,10),(60,6,54,'select_mul','',20,60,10),(61,6,55,'radio','10',20,61,10),(62,2,15,'select','',10,62,10),(63,2,13,'text','',20,63,10),(64,2,14,'text','',20,64,10),(66,2,16,'select','',20,66,10),(67,2,17,'radio','10',20,67,10),(68,9,81,'select','',20,68,10),(69,9,82,'select','',20,69,10),(70,9,83,'select','',20,70,10),(71,9,84,'text','',20,71,10),(72,9,85,'radio','20',20,72,10),(73,9,86,'input_number','0',20,73,10),(74,9,87,'radio','10',20,74,10),(75,10,89,'select','',10,75,10),(76,10,90,'select','',10,76,10),(77,10,91,'select','',20,77,10),(78,10,92,'text','',20,78,10),(79,10,93,'text','',20,79,10),(80,10,94,'radio','10',20,80,10),(81,12,103,'select','',10,81,10),(82,12,104,'select','',10,82,10),(83,12,105,'select','',20,83,10),(84,12,106,'select','',20,84,10),(85,12,107,'radio','10',20,85,10),(86,14,110,'text','',20,86,10),(87,14,111,'radio','10',20,87,10),(88,14,112,'radio','10',20,88,10),(89,14,113,'textarea','',20,89,10),(90,14,114,'radio','20',20,90,10),(94,16,133,'select','0',20,1,10),(95,16,134,'text','',20,2,10),(96,16,135,'upload_image','',20,3,10),(97,16,123,'radio','10',20,4,10),(98,16,137,'editor','',20,5,10),(99,15,118,'select','',20,1,10),(100,15,117,'text','',20,2,10),(101,15,120,'input_number','0',20,3,10),(102,15,121,'radio','10',20,4,10);
/*!40000 ALTER TABLE `vuecmf_model_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_model_form_linkage`
--

DROP TABLE IF EXISTS `vuecmf_model_form_linkage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_model_form_linkage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属模型ID',
  `model_field_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型字段ID',
  `linkage_field_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '联动表单的字段ID',
  `linkage_action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '获取联动表单数据的动作ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`model_field_id`,`linkage_field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--模型表单联动设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_model_form_linkage`
--

LOCK TABLES `vuecmf_model_form_linkage` WRITE;
/*!40000 ALTER TABLE `vuecmf_model_form_linkage` DISABLE KEYS */;
INSERT INTO `vuecmf_model_form_linkage` VALUES (1,1,3,6,10,10),(2,1,3,7,17,10),(3,5,45,46,17,10),(4,6,52,53,17,10),(5,6,52,54,17,10),(6,7,60,63,6,10),(7,9,81,82,17,10),(8,12,105,106,10,10);
/*!40000 ALTER TABLE `vuecmf_model_form_linkage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_model_form_rules`
--

DROP TABLE IF EXISTS `vuecmf_model_form_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_model_form_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属模型ID',
  `model_form_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型表单ID',
  `rule_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表单验证类型',
  `rule_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表单验证规则',
  `error_tips` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表单验证不通过的错误提示信息',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--模型表单验证设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_model_form_rules`
--

LOCK TABLES `vuecmf_model_form_rules` WRITE;
/*!40000 ALTER TABLE `vuecmf_model_form_rules` DISABLE KEYS */;
INSERT INTO `vuecmf_model_form_rules` VALUES (1,8,1,'require','','用户名必填',10),(2,8,1,'length','4,32','用户名长度为4到32个字符',10),(3,8,3,'require','','邮箱必填',10),(4,8,3,'email','','邮箱输入有误',10),(5,8,4,'require','','手机必填',10),(6,8,4,'mobile','','手机输入有误',10),(7,11,6,'require','','角色名称必填',10),(8,7,11,'require','','菜单标题必填',10),(9,1,18,'require','','请选择',10),(10,1,19,'require','','表名必填',10),(11,1,20,'require','','模型标签必填',10),(12,1,21,'require','','请选择',10),(13,3,27,'require','','字段名称必填',10),(14,3,28,'require','','字段中文名必填',10),(15,3,29,'require','','请选择',10),(16,3,30,'require','','请选择',10),(17,3,31,'number','','请输入数字',10),(18,4,45,'require','','请选择',10),(19,4,46,'require','','请选择',10),(20,4,47,'require','','选项值必填',10),(21,4,48,'require','','选项标签必填',10),(22,5,50,'require','','请选择',10),(23,5,51,'require','','请选择',10),(24,5,52,'require','','请选择',10),(25,6,54,'require','','请选择',10),(26,6,55,'require','','请选择',10),(27,6,56,'require','','请选择',10),(28,6,57,'require','','请选择',10),(29,6,60,'require','','请选择',10),(30,2,62,'require','','请选择',10),(31,2,63,'require','','动作标签必填',10),(32,2,64,'require','','后端请求地址必填',10),(33,2,65,'require','','请选择',10),(34,2,66,'require','','请选择',10),(35,2,14,'require','','请选择',10),(36,9,68,'require','','请选择',10),(37,9,69,'require','','请选择',10),(38,9,70,'require','','请选择',10),(39,10,75,'require','','请选择',10),(40,10,76,'require','','请选择',10),(41,10,77,'require','','请选择',10),(42,12,81,'require','','请选择',10),(43,12,82,'require','','请选择',10),(44,12,83,'require','','请选择',10),(45,12,84,'require','','请选择',10),(46,14,86,'require','','应用名称必填',10),(47,15,91,'require','','请选择',10),(49,16,94,'require','','',10),(50,16,95,'require','','',10),(51,16,96,'require','','',10);
/*!40000 ALTER TABLE `vuecmf_model_form_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_model_index`
--

DROP TABLE IF EXISTS `vuecmf_model_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_model_index` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属模型ID',
  `model_field_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '模型字段ID',
  `index_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL' COMMENT '索引类型： PRIMARY=主键，NORMAL=常规，UNIQUE=唯一，FULLTEXT=全文',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--模型索引设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_model_index`
--

LOCK TABLES `vuecmf_model_index` WRITE;
/*!40000 ALTER TABLE `vuecmf_model_index` DISABLE KEYS */;
INSERT INTO `vuecmf_model_index` VALUES (1,1,'3','UNIQUE',10),(2,2,'15,16','UNIQUE',10),(3,3,'19,21','UNIQUE',10),(4,4,'40,41','UNIQUE',10),(5,6,'51,53','UNIQUE',10),(6,8,'68','UNIQUE',10),(7,8,'70','UNIQUE',10),(8,8,'71','UNIQUE',10),(9,9,'82','UNIQUE',10),(10,11,'96','UNIQUE',10),(11,12,'104,105','UNIQUE',10),(12,14,'110','UNIQUE',10),(13,16,'134','NORMAL',10);
/*!40000 ALTER TABLE `vuecmf_model_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_model_relation`
--

DROP TABLE IF EXISTS `vuecmf_model_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_model_relation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属模型ID',
  `model_field_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型字段ID',
  `relation_model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联模型ID',
  `relation_field_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联模型字段ID',
  `relation_show_field_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '关联模型显示字段ID,多个逗号分隔，全部用*',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`model_field_id`,`relation_field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--模型关联设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_model_relation`
--

LOCK TABLES `vuecmf_model_relation` WRITE;
/*!40000 ALTER TABLE `vuecmf_model_relation` DISABLE KEYS */;
INSERT INTO `vuecmf_model_relation` VALUES (1,1,2,14,109,'110',10),(2,1,6,2,12,'13',10),(3,1,7,3,18,'19,20',10),(4,2,15,1,1,'3,4',10),(5,3,21,1,1,'3,4',10),(6,4,39,1,1,'3,4',10),(7,4,40,3,18,'19,20',10),(8,5,45,1,1,'3,4',10),(9,5,46,3,18,'19,20',10),(10,6,50,1,1,'3,4',10),(11,6,51,3,18,'19,20',10),(12,6,52,1,1,'3,4',10),(13,6,53,3,18,'19,20',10),(14,6,54,3,18,'19,20',10),(15,7,63,1,1,'3,4',10),(16,7,60,14,109,'110',10),(17,9,81,1,1,'3,4',10),(18,9,82,3,18,'19,20',10),(19,10,89,1,1,'3,4',10),(20,10,90,9,80,'81,82,83',10),(21,12,103,1,1,'3,4',10),(22,12,104,3,18,'19,20',10),(23,12,105,3,18,'19,20',10),(24,12,106,2,12,'13',10),(25,16,133,15,116,'117',10);
/*!40000 ALTER TABLE `vuecmf_model_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_photo`
--

DROP TABLE IF EXISTS `vuecmf_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_photo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  `cid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分类',
  `title` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
  `pic` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图片',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '图片说明',
  PRIMARY KEY (`id`),
  KEY `idx_title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='图片';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_photo`
--

LOCK TABLES `vuecmf_photo` WRITE;
/*!40000 ALTER TABLE `vuecmf_photo` DISABLE KEYS */;
INSERT INTO `vuecmf_photo` VALUES (1,10,2,'test001','http://localhost:8080/uploads/20221109/92ec19ffde05e15769b1bb3ee05ad745.png','<ul class=\"s-hotsearch-content\" id=\"hotsearch-content-wrapper\" style=\"margin: 0px; padding: 0px; list-style: none; color: rgb(0, 0, 0); font-family: Arial, sans-serif; font-size: 12px;\"><li class=\"hotsearch-item odd\" data-index=\"2\" style=\"margin: 0px 20px 0px 0px; padding: 0px; list-style: none; width: 306px; height: 36px; line-height: 36px; clear: both;\"></li><li class=\"hotsearch-item odd\" data-index=\"0\" style=\"margin: 0px 20px 0px 0px; padding: 0px; list-style: none; width: 306px; float: left; height: 36px; line-height: 36px; clear: both;\"><a class=\"title-content  c-link c-font-medium c-line-clamp1\" href=\"https://www.baidu.com/s?wd=%E4%B9%A0%E8%BF%91%E5%B9%B3%E5%90%91%E4%B8%96%E7%95%8C%E4%BA%92%E8%81%94%E7%BD%91%E5%A4%A7%E4%BC%9A%E8%87%B4%E8%B4%BA%E4%BF%A1&amp;sa=fyb_n_homepage&amp;rsv_dl=fyb_n_homepage&amp;from=super&amp;cl=3&amp;tn=baidutop10&amp;fr=top1000&amp;rsv_idx=2&amp;hisfilter=1\" target=\"_blank\" style=\"text-decoration-line: none; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 14px; line-height: 36px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: rgb(34, 34, 34); float: left; height: 36px; width: 306px;\"><span class=\"c-icon title-content-top-icon c-color-red c-gap-right-small\" style=\"margin-right: 8px; color: rgb(246, 48, 81); -webkit-font-smoothing: antialiased; transform: rotate(180deg); height: 18px; width: 18px; display: inline-block; vertical-align: middle; line-height: 18px; position: relative; top: -2px; left: -3px; font-size: 18px; font-family: cIconfont !important;\"></span><span class=\"title-content-title\" style=\"font-size: 16px;\">习近平向世界互联网大会致贺信</span></a><span class=\"title-content-mark ie-vertical c-text c-gap-left-small \" style=\"margin-left: 6px; display: inline-block; padding: 0px 2px; text-align: center; vertical-align: middle; color: rgb(255, 255, 255); overflow: hidden; line-height: 16px; height: 16px; border-radius: 4px; position: relative; top: -2px;\"></span></li><li class=\"hotsearch-item even\" data-index=\"3\" style=\"margin: 0px 0px 0px 20px; padding: 0px; list-style: none; width: 306px; float: left; height: 36px; line-height: 36px;\"><a class=\"title-content  c-link c-font-medium c-line-clamp1\" href=\"https://www.baidu.com/s?wd=%E4%BC%97%E5%A4%9A%E2%80%9C%E9%BB%91%E7%A7%91%E6%8A%80%E2%80%9D%E9%BD%90%E8%81%9A%E8%BF%9B%E5%8D%9A%E4%BC%9A&amp;sa=fyb_n_homepage&amp;rsv_dl=fyb_n_homepage&amp;from=super&amp;cl=3&amp;tn=baidutop10&amp;fr=top1000&amp;rsv_idx=2&amp;hisfilter=1\" target=\"_blank\" style=\"text-decoration-line: none; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 14px; line-height: 36px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: rgb(34, 34, 34); float: left; height: 36px; width: 306px;\"><span class=\"title-content-index c-index-single c-index-single-hot3\" style=\"display: inline-block; background: 0px 0px; color: rgb(250, 169, 14); width: 22px; font-size: 18px; letter-spacing: -1px; margin-right: 4px; line-height: 18px; position: relative; top: 1px;\">3</span><span class=\"title-content-title\" style=\"font-size: 16px;\">众多“黑科技”齐聚进博会</span></a><span class=\"title-content-mark ie-vertical c-text c-gap-left-small \" style=\"margin-left: 6px; display: inline-block; padding: 0px 2px; text-align: center; vertical-align: middle; color: rgb(255, 255, 255); overflow: hidden; line-height: 16px; height: 16px; border-radius: 4px; position: relative; top: -2px;\"></span></li><li class=\"hotsearch-item odd\" data-index=\"1\" style=\"margin: 0px 20px 0px 0px; padding: 0px; list-style: none; width: 306px; float: left; height: 36px; line-height: 36px; clear: both;\"><a class=\"title-content tag-width c-link c-font-medium c-line-clamp1\" href=\"https://www.baidu.com/s?wd=%E4%B9%8C%E5%85%8B%E5%85%B0%E5%AE%A3%E5%B8%83%E5%9B%BD%E6%9C%89%E5%8C%96%E9%A9%AC%E8%BE%BE%E8%A5%BF%E5%A5%87+%E4%B8%AD%E4%BC%81%E5%9B%9E%E5%BA%94&amp;sa=fyb_n_homepage&amp;rsv_dl=fyb_n_homepage&amp;from=super&amp;cl=3&amp;tn=baidutop10&amp;fr=top1000&amp;rsv_idx=2&amp;hisfilter=1\" target=\"_blank\" style=\"text-decoration-line: none; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 14px; line-height: 36px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: rgb(34, 34, 34); float: left; height: 36px; width: auto; max-width: 284px;\"><span class=\"title-content-index c-index-single c-index-single-hot1\" style=\"display: inline-block; background: 0px 0px; color: rgb(254, 45, 70); width: 22px; font-size: 18px; letter-spacing: -1px; margin-right: 4px; line-height: 18px; position: relative; top: 1px;\">1</span><span class=\"title-content-title\" style=\"font-size: 16px;\">乌克兰宣布国有化马达西奇 中企回应</span></a><span class=\"title-content-mark ie-vertical c-text c-gap-left-small c-text-hot\" style=\"margin-left: 6px; display: inline-block; padding: 0px 2px; text-align: center; vertical-align: middle; color: rgb(255, 255, 255); overflow: hidden; line-height: 16px; height: 16px; border-radius: 4px; background-color: rgb(255, 102, 0); position: relative; top: -2px;\">热</span></li><li class=\"hotsearch-item even\" data-index=\"4\" style=\"margin: 0px 0px 0px 20px; padding: 0px; list-style: none; width: 306px; float: left; height: 36px; line-height: 36px;\"><a class=\"title-content tag-width c-link c-font-medium c-line-clamp1\" href=\"https://www.baidu.com/s?wd=%E5%B9%BF%E5%B7%9E%E5%8C%97%E4%BA%AC%E7%AD%89%E5%9C%B0%E8%88%AA%E7%8F%AD%E7%8E%B0%E5%A4%A7%E9%9D%A2%E7%A7%AF%E5%8F%96%E6%B6%88&amp;sa=fyb_n_homepage&amp;rsv_dl=fyb_n_homepage&amp;from=super&amp;cl=3&amp;tn=baidutop10&amp;fr=top1000&amp;rsv_idx=2&amp;hisfilter=1\" target=\"_blank\" style=\"text-decoration-line: none; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 14px; line-height: 36px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: rgb(34, 34, 34); float: left; height: 36px; width: auto; max-width: 284px;\"><span class=\"title-content-index c-index-single c-index-single-hot4\" style=\"display: inline-block; background: 0px 0px; color: rgb(145, 149, 163); width: 22px; font-size: 18px; letter-spacing: -1px; margin-right: 4px; line-height: 18px; position: relative; top: 1px;\">4</span><span class=\"title-content-title\" style=\"font-size: 16px;\">广州北京等地航班现大面积取消</span></a><span class=\"title-content-mark ie-vertical c-text c-gap-left-small c-text-hot\" style=\"margin-left: 6px; display: inline-block; padding: 0px 2px; text-align: center; vertical-align: middle; color: rgb(255, 255, 255); overflow: hidden; line-height: 16px; height: 16px; border-radius: 4px; background-color: rgb(255, 102, 0); position: relative; top: -2px;\">热</span></li><li class=\"hotsearch-item odd\" data-index=\"2\" style=\"margin: 0px 20px 0px 0px; padding: 0px; list-style: none; width: 306px; float: left; height: 36px; line-height: 36px; clear: both;\"><a class=\"title-content tag-width c-link c-font-medium c-line-clamp1\" href=\"https://www.baidu.com/s?wd=%E5%8C%BB%E7%94%9F%E4%B8%8A%E9%97%A8%E6%8E%8C%E6%8E%B4%E5%B9%BC%E5%84%BF%E6%8E%A8%E5%80%92%E8%80%81%E4%BA%BA%E5%B7%B2%E8%A2%AB%E5%88%91%E6%8B%98&amp;sa=fyb_n_homepage&amp;rsv_dl=fyb_n_homepage&amp;from=super&amp;cl=3&amp;tn=baidutop10&amp;fr=top1000&amp;rsv_idx=2&amp;hisfilter=1\" target=\"_blank\" style=\"text-decoration-line: none; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 14px; line-height: 36px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: rgb(34, 34, 34); float: left; height: 36px; width: auto; max-width: 284px;\"><span class=\"title-content-index c-index-single c-index-single-hot2\" style=\"display: inline-block; background: 0px 0px; color: rgb(255, 102, 0); width: 22px; font-size: 18px; letter-spacing: -1px; margin-right: 4px; line-height: 18px; position: relative; top: 1px;\">2</span><span class=\"title-content-title\" style=\"font-size: 16px;\">医生上门掌掴幼儿推倒老人已被刑拘</span></a><span class=\"title-content-mark ie-vertical c-text c-gap-left-small c-text-hot\" style=\"margin-left: 6px; display: inline-block; padding: 0px 2px; text-align: center; vertical-align: middle; color: rgb(255, 255, 255); overflow: hidden; line-height: 16px; height: 16px; border-radius: 4px; background-color: rgb(255, 102, 0); position: relative; top: -2px;\"></span></li></ul>'),(2,10,2,'test22','http://localhost:8080/uploads/20221110/92ec19ffde05e15769b1bb3ee05ad745.png','sddddd');
/*!40000 ALTER TABLE `vuecmf_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_photo_cate`
--

DROP TABLE IF EXISTS `vuecmf_photo_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_photo_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `id_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'ID层级路径',
  `sort_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '菜单的排列顺序(小在前)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='图片分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_photo_cate`
--

LOCK TABLES `vuecmf_photo_cate` WRITE;
/*!40000 ALTER TABLE `vuecmf_photo_cate` DISABLE KEYS */;
INSERT INTO `vuecmf_photo_cate` VALUES (1,'风景',0,'',1,10),(2,'冬天',1,'1',1,10),(3,'秋天',1,'1',2,10),(4,'建筑',0,'',2,10);
/*!40000 ALTER TABLE `vuecmf_photo_cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_roles`
--

DROP TABLE IF EXISTS `vuecmf_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `role_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户的角色名称',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `id_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色ID层级路径',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色的备注信息',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态：10=开启，20=禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_roles`
--

LOCK TABLES `vuecmf_roles` WRITE;
/*!40000 ALTER TABLE `vuecmf_roles` DISABLE KEYS */;
INSERT INTO `vuecmf_roles` VALUES (1,'系统测试',0,'0','',10);
/*!40000 ALTER TABLE `vuecmf_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuecmf_rules`
--

DROP TABLE IF EXISTS `vuecmf_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuecmf_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `ptype` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '类型：g=组或角色，p=策略',
  `v0` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应定义的sub(用户名或角色名)',
  `v1` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应定义的dom(角色或应用名)',
  `v2` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应定义的obj(应用名或控制器名)',
  `v3` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应定义的act(动作名称)',
  `v4` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '预留，暂用不到',
  `v5` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '预留，暂用不到',
  `v6` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '预留，暂用不到',
  `v7` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '预留，暂用不到',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`ptype`,`v0`,`v1`,`v2`,`v3`,`v4`,`v5`,`v6`,`v7`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统--授权规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuecmf_rules`
--

LOCK TABLES `vuecmf_rules` WRITE;
/*!40000 ALTER TABLE `vuecmf_rules` DISABLE KEYS */;
INSERT INTO `vuecmf_rules` VALUES (1,'g','test','系统测试','vuecmf','','','','',''),(97,'p','系统测试','demo','photo','delete','','','',''),(98,'p','系统测试','demo','photo','dropdown','','','',''),(95,'p','系统测试','demo','photo','index','','','',''),(96,'p','系统测试','demo','photo','save','','','',''),(99,'p','系统测试','demo','photo','save_all','','','',''),(92,'p','系统测试','demo','photo_cate','delete','','','',''),(93,'p','系统测试','demo','photo_cate','dropdown','','','',''),(90,'p','系统测试','demo','photo_cate','index','','','',''),(91,'p','系统测试','demo','photo_cate','save','','','',''),(94,'p','系统测试','demo','photo_cate','save_all','','','',''),(46,'p','系统测试','vuecmf','admin','add_role','','','',''),(43,'p','系统测试','vuecmf','admin','delete','','','',''),(50,'p','系统测试','vuecmf','admin','delete_batch','','','',''),(44,'p','系统测试','vuecmf','admin','detail','','','',''),(51,'p','系统测试','vuecmf','admin','get_all_roles','','','',''),(52,'p','系统测试','vuecmf','admin','get_roles','','','',''),(54,'p','系统测试','vuecmf','admin','get_user_permission','','','',''),(41,'p','系统测试','vuecmf','admin','index','','','',''),(47,'p','系统测试','vuecmf','admin','login','','','',''),(48,'p','系统测试','vuecmf','admin','logout','','','',''),(42,'p','系统测试','vuecmf','admin','save','','','',''),(49,'p','系统测试','vuecmf','admin','save_all','','','',''),(53,'p','系统测试','vuecmf','admin','set_user_permission','','','',''),(86,'p','系统测试','vuecmf','app_config','delete','','','',''),(89,'p','系统测试','vuecmf','app_config','delete_batch','','','',''),(87,'p','系统测试','vuecmf','app_config','dropdown','','','',''),(84,'p','系统测试','vuecmf','app_config','index','','','',''),(85,'p','系统测试','vuecmf','app_config','save','','','',''),(88,'p','系统测试','vuecmf','app_config','save_all','','','',''),(22,'p','系统测试','vuecmf','field_option','delete','','','',''),(24,'p','系统测试','vuecmf','field_option','delete_batch','','','',''),(20,'p','系统测试','vuecmf','field_option','index','','','',''),(21,'p','系统测试','vuecmf','field_option','save','','','',''),(23,'p','系统测试','vuecmf','field_option','save_all','','','',''),(37,'p','系统测试','vuecmf','menu','delete','','','',''),(40,'p','系统测试','vuecmf','menu','delete_batch','','','',''),(35,'p','系统测试','vuecmf','menu','index','','','',''),(38,'p','系统测试','vuecmf','menu','nav','','','',''),(36,'p','系统测试','vuecmf','menu','save','','','',''),(39,'p','系统测试','vuecmf','menu','save_all','','','',''),(10,'p','系统测试','vuecmf','model_action','delete','','','',''),(13,'p','系统测试','vuecmf','model_action','delete_batch','','','',''),(11,'p','系统测试','vuecmf','model_action','dropdown','','','',''),(45,'p','系统测试','vuecmf','model_action','get_action_list','','','',''),(8,'p','系统测试','vuecmf','model_action','index','','','',''),(9,'p','系统测试','vuecmf','model_action','save','','','',''),(12,'p','系统测试','vuecmf','model_action','save_all','','','',''),(4,'p','系统测试','vuecmf','model_config','delete','','','',''),(6,'p','系统测试','vuecmf','model_config','delete_batch','','','',''),(7,'p','系统测试','vuecmf','model_config','dropdown','','','',''),(2,'p','系统测试','vuecmf','model_config','index','','','',''),(3,'p','系统测试','vuecmf','model_config','save','','','',''),(5,'p','系统测试','vuecmf','model_config','save_all','','','',''),(16,'p','系统测试','vuecmf','model_field','delete','','','',''),(19,'p','系统测试','vuecmf','model_field','delete_batch','','','',''),(17,'p','系统测试','vuecmf','model_field','dropdown','','','',''),(14,'p','系统测试','vuecmf','model_field','index','','','',''),(15,'p','系统测试','vuecmf','model_field','save','','','',''),(18,'p','系统测试','vuecmf','model_field','save_all','','','',''),(57,'p','系统测试','vuecmf','model_form','delete','','','',''),(60,'p','系统测试','vuecmf','model_form','delete_batch','','','',''),(58,'p','系统测试','vuecmf','model_form','dropdown','','','',''),(55,'p','系统测试','vuecmf','model_form','index','','','',''),(56,'p','系统测试','vuecmf','model_form','save','','','',''),(59,'p','系统测试','vuecmf','model_form','save_all','','','',''),(80,'p','系统测试','vuecmf','model_form_linkage','delete','','','',''),(82,'p','系统测试','vuecmf','model_form_linkage','delete_batch','','','',''),(78,'p','系统测试','vuecmf','model_form_linkage','index','','','',''),(79,'p','系统测试','vuecmf','model_form_linkage','save','','','',''),(81,'p','系统测试','vuecmf','model_form_linkage','save_all','','','',''),(63,'p','系统测试','vuecmf','model_form_rules','delete','','','',''),(65,'p','系统测试','vuecmf','model_form_rules','delete_batch','','','',''),(61,'p','系统测试','vuecmf','model_form_rules','index','','','',''),(62,'p','系统测试','vuecmf','model_form_rules','save','','','',''),(64,'p','系统测试','vuecmf','model_form_rules','save_all','','','',''),(27,'p','系统测试','vuecmf','model_index','delete','','','',''),(29,'p','系统测试','vuecmf','model_index','delete_batch','','','',''),(25,'p','系统测试','vuecmf','model_index','index','','','',''),(26,'p','系统测试','vuecmf','model_index','save','','','',''),(28,'p','系统测试','vuecmf','model_index','save_all','','','',''),(32,'p','系统测试','vuecmf','model_relation','delete','','','',''),(34,'p','系统测试','vuecmf','model_relation','delete_batch','','','',''),(30,'p','系统测试','vuecmf','model_relation','index','','','',''),(31,'p','系统测试','vuecmf','model_relation','save','','','',''),(33,'p','系统测试','vuecmf','model_relation','save_all','','','',''),(73,'p','系统测试','vuecmf','roles','add_permission','','','',''),(71,'p','系统测试','vuecmf','roles','add_users','','','',''),(74,'p','系统测试','vuecmf','roles','del_permission','','','',''),(72,'p','系统测试','vuecmf','roles','del_users','','','',''),(68,'p','系统测试','vuecmf','roles','delete','','','',''),(70,'p','系统测试','vuecmf','roles','delete_batch','','','',''),(77,'p','系统测试','vuecmf','roles','get_all_users','','','',''),(76,'p','系统测试','vuecmf','roles','get_permission','','','',''),(75,'p','系统测试','vuecmf','roles','get_users','','','',''),(66,'p','系统测试','vuecmf','roles','index','','','',''),(67,'p','系统测试','vuecmf','roles','save','','','',''),(69,'p','系统测试','vuecmf','roles','save_all','','','',''),(83,'p','系统测试','vuecmf','upload','index','','','','');
/*!40000 ALTER TABLE `vuecmf_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'demo'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-17 19:33:03
