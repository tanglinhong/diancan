-- MySQL dump 10.15  Distrib 10.0.26-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: diancan_db
-- ------------------------------------------------------
-- Server version	10.0.26-MariaDB-3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Address`
--

DROP TABLE IF EXISTS `Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `province` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `county` varchar(30) NOT NULL,
  `street` varchar(400) NOT NULL,
  `consignee` varchar(30) NOT NULL,
  `consignee_tel` varchar(30) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `postcode` varchar(6) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Address_user_id_id_1b3a96fa_fk_User_id` (`user_id_id`),
  CONSTRAINT `Address_user_id_id_1b3a96fa_fk_User_id` FOREIGN KEY (`user_id_id`) REFERENCES `User` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
INSERT INTO `Address` VALUES (1,'福建省','宁德','蕉城区','霞飞路200号 南京理工大学','王子扬','13270728660',1,'210094',1),(2,'福建省','宁德','霞浦县','孝陵卫200号 宁德职业技术学院','汤林鸿','15312345678',1,'223001',2),(3,'福建省','宁德','古田县','幸福大道200号 古田大学','郑铜亚','15312345678',1,'210035',3),(4,'福建省','宁德','寿宁县','阳光东路200号 宁德理工大学','林博','13312345678',1,'210033',4),(5,'福建省','宁德','周宁县','莲花乡赤水沟子5组2号','田智存','13212345678',1,'210030',5),(6,'福建省','宁德','寿宁县','新泰大道200号 寿宁职业技术学院','何树伟','18912345678',1,'230021',6);
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Merchandise`
--

DROP TABLE IF EXISTS `Merchandise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Merchandise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `price` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `shop_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Merchandise_5a722918` (`shop_id_id`),
  CONSTRAINT `Merchandise_shop_id_id_4ad8d9ab_fk_Shop_id` FOREIGN KEY (`shop_id_id`) REFERENCES `Shop` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Merchandise`
--

LOCK TABLES `Merchandise` WRITE;
/*!40000 ALTER TABLE `Merchandise` DISABLE KEYS */;
INSERT INTO `Merchandise` VALUES (1,'小份黄焖鸡',15,'',1),(2,'大份黄焖鸡',20,'',1),(3,'土豆',2,'',1),(4,'金针菇',4,'',1),(5,'雪碧',3,'',1),(6,'黑胶猪排饭',3,'',2),(7,'咖喱鸡腿饭',16,'',2),(8,'牛肉炒饭',15,'',2),(9,'西红柿鸡蛋盖浇饭',11,'',2),(10,'猪排饭',14,'',2),(11,'照烧鸡腿饭',18,'',2),(12,'回锅肉盖浇饭',17,'',2);
/*!40000 ALTER TABLE `Merchandise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrderDetail`
--

DROP TABLE IF EXISTS `OrderDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OrderDetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchan_num` int(11) NOT NULL,
  `merchan_id_id` int(11) NOT NULL,
  `order_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `OrderDetail_merchan_id_id_2f56445b_fk_Merchandise_id` (`merchan_id_id`),
  KEY `OrderDetail_564fd3cf` (`order_id_id`),
  CONSTRAINT `OrderDetail_merchan_id_id_2f56445b_fk_Merchandise_id` FOREIGN KEY (`merchan_id_id`) REFERENCES `Merchandise` (`id`),
  CONSTRAINT `OrderDetail_order_id_id_f85b1493_fk_Orders_id` FOREIGN KEY (`order_id_id`) REFERENCES `Orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderDetail`
--

LOCK TABLES `OrderDetail` WRITE;
/*!40000 ALTER TABLE `OrderDetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `OrderDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_num` varchar(20) NOT NULL,
  `order_time` datetime(6) NOT NULL,
  `total_price` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `shop_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  `address_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Orders_shop_id_id_3241a5ca_fk_Shop_id` (`shop_id_id`),
  KEY `Orders_18624dd3` (`user_id_id`),
  KEY `Orders_8f7bed04` (`address_id_id`),
  CONSTRAINT `Orders_address_id_id_da764055_fk_Address_id` FOREIGN KEY (`address_id_id`) REFERENCES `Address` (`id`),
  CONSTRAINT `Orders_shop_id_id_3241a5ca_fk_Shop_id` FOREIGN KEY (`shop_id_id`) REFERENCES `Shop` (`id`),
  CONSTRAINT `Orders_user_id_id_1fd11d1c_fk_User_id` FOREIGN KEY (`user_id_id`) REFERENCES `User` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` VALUES (1,'201610120756054','2016-10-12 07:56:05.855238',20,0,2,4,4),(2,'201610120756054','2016-10-12 07:56:05.864353',24,0,1,4,4),(3,'201610120756055','2016-10-12 07:56:05.873187',24,0,1,5,5),(4,'201610120757262','2016-10-12 07:57:26.696314',22,0,1,2,2),(5,'201610121248255','2016-10-12 12:48:25.894836',24,2,1,5,5),(6,'201610121349255','2016-10-12 13:49:25.004693',24,2,1,5,5),(7,'201610121449415','2016-10-12 14:49:41.463303',24,2,1,5,5),(8,'201610121549415','2016-10-12 15:49:41.471321',24,2,1,5,5),(9,'201610121657405','2016-10-12 16:57:40.442331',24,1,1,5,5),(10,'201610121658402','2016-10-12 16:58:40.454401',24,1,1,2,2),(11,'201610121659404','2016-10-12 16:59:40.464355',24,1,1,4,4),(12,'201610121714072','2016-10-12 17:14:07.790719',24,1,1,2,2),(13,'201610121715075','2016-10-12 17:15:07.802222',24,1,1,5,5);
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SalesNum`
--

DROP TABLE IF EXISTS `SalesNum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SalesNum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `month` int(11) NOT NULL,
  `sales_num` int(11) NOT NULL,
  `merchan_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `SalesNum_merchan_id_id_66352ac3_fk_Merchandise_id` (`merchan_id_id`),
  CONSTRAINT `SalesNum_merchan_id_id_66352ac3_fk_Merchandise_id` FOREIGN KEY (`merchan_id_id`) REFERENCES `Merchandise` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SalesNum`
--

LOCK TABLES `SalesNum` WRITE;
/*!40000 ALTER TABLE `SalesNum` DISABLE KEYS */;
/*!40000 ALTER TABLE `SalesNum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Shop`
--

DROP TABLE IF EXISTS `Shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shopname` varchar(30) NOT NULL,
  `least_price` int(11) NOT NULL,
  `deliver_fee` int(11) NOT NULL,
  `review_score` decimal(2,1) NOT NULL,
  `shop_img` varchar(100) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Shop_user_id_id_2b2e4b88_fk_User_id` (`user_id_id`),
  CONSTRAINT `Shop_user_id_id_2b2e4b88_fk_User_id` FOREIGN KEY (`user_id_id`) REFERENCES `User` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shop`
--

LOCK TABLES `Shop` WRITE;
/*!40000 ALTER TABLE `Shop` DISABLE KEYS */;
INSERT INTO `Shop` VALUES (1,'杨铭宇黄焖鸡',30,10,4.5,'uploads/goods_1376638321_7423.jpg',1),(2,'湖畔人家',15,3,4.1,'',3);
/*!40000 ALTER TABLE `Shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `email` varchar(40) NOT NULL,
  `cellphone` varchar(15) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_shop` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'pbkdf2_sha256$30000$XO3JfO3IpcAU$06rVGvpUHlnlNA9IDFkNa+5CIwXjm7DYZaM2GsNy2mg=','2016-10-12 07:57:58.725003','Grinch','majorgrinch@gmail.com','13270728660',1,1),(2,'pbkdf2_sha256$30000$VWxl8cpzvAKP$C9LygpRdae5pFpHJHwBrs7sn5IbtLiauIy8Ow348xq8=','2016-10-12 07:44:53.862588','LInda','linda@163.com','15312345678',1,0),(3,'pbkdf2_sha256$30000$Zp4mW6lQ2M5g$Cn3+qG9mT6a7wTAgjdKAcxLTK6R0uaJ4uB7KweWdHYo=','2016-10-12 07:46:01.796673','Doujiang','doujiangdj@163.com','15212345678',1,1),(4,'pbkdf2_sha256$30000$M1CNpqNPoG3L$kl66bJYqwZFmZ2svj8IAZrgm7L3F7IZvcCgkFRUFEmM=','2016-10-12 07:47:25.387992','Linbo','linbo@gmail.com','13312345678',1,0),(5,'pbkdf2_sha256$30000$jcvnIBzvWLMo$1ltNVOCWDtMynEsBik2Tc+ersIOhvP5KQBWvW7JeDPw=','2016-10-12 07:48:30.287889','TZC','zhicunxia@126.com','13212345678',1,0),(6,'pbkdf2_sha256$30000$0a70f4TWMzCS$aNOmCM6oPMzr6Rh4sTbWekPb3UbTcsVU8RU0BD6QzXY=','2016-10-13 04:30:02.758610','HeShuwei','datasource@gmail.com','18912345678',1,0);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add user',1,'add_user'),(2,'Can change user',1,'change_user'),(3,'Can delete user',1,'delete_user'),(4,'Can add shop',2,'add_shop'),(5,'Can change shop',2,'change_shop'),(6,'Can delete shop',2,'delete_shop'),(7,'Can add order detail',3,'add_orderdetail'),(8,'Can change order detail',3,'change_orderdetail'),(9,'Can delete order detail',3,'delete_orderdetail'),(10,'Can add merchandise',4,'add_merchandise'),(11,'Can change merchandise',4,'change_merchandise'),(12,'Can delete merchandise',4,'delete_merchandise'),(13,'Can add address',5,'add_address'),(14,'Can change address',5,'change_address'),(15,'Can delete address',5,'delete_address'),(16,'Can add sales num',6,'add_salesnum'),(17,'Can change sales num',6,'change_salesnum'),(18,'Can delete sales num',6,'delete_salesnum'),(19,'Can add orders',7,'add_orders'),(20,'Can change orders',7,'change_orders'),(21,'Can delete orders',7,'delete_orders'),(22,'Can add log entry',8,'add_logentry'),(23,'Can change log entry',8,'change_logentry'),(24,'Can delete log entry',8,'delete_logentry'),(25,'Can add group',9,'add_group'),(26,'Can change group',9,'change_group'),(27,'Can delete group',9,'delete_group'),(28,'Can add permission',10,'add_permission'),(29,'Can change permission',10,'change_permission'),(30,'Can delete permission',10,'delete_permission'),(31,'Can add content type',11,'add_contenttype'),(32,'Can change content type',11,'change_contenttype'),(33,'Can delete content type',11,'delete_contenttype'),(34,'Can add session',12,'add_session'),(35,'Can change session',12,'change_session'),(36,'Can delete session',12,'delete_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_User_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_User_id` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (8,'admin','logentry'),(9,'auth','group'),(10,'auth','permission'),(11,'contenttypes','contenttype'),(1,'login','user'),(5,'mainpage','address'),(4,'mainpage','merchandise'),(3,'mainpage','orderdetail'),(7,'mainpage','orders'),(6,'mainpage','salesnum'),(2,'mainpage','shop'),(12,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'login','0001_initial','2016-10-12 07:42:19.359841'),(2,'contenttypes','0001_initial','2016-10-12 07:42:19.386629'),(3,'admin','0001_initial','2016-10-12 07:42:19.465861'),(4,'admin','0002_logentry_remove_auto_add','2016-10-12 07:42:19.473577'),(5,'contenttypes','0002_remove_content_type_name','2016-10-12 07:42:19.518733'),(6,'auth','0001_initial','2016-10-12 07:42:19.685362'),(7,'auth','0002_alter_permission_name_max_length','2016-10-12 07:42:19.716681'),(8,'auth','0003_alter_user_email_max_length','2016-10-12 07:42:19.727419'),(9,'auth','0004_alter_user_username_opts','2016-10-12 07:42:19.737294'),(10,'auth','0005_alter_user_last_login_null','2016-10-12 07:42:19.749951'),(11,'auth','0006_require_contenttypes_0002','2016-10-12 07:42:19.753374'),(12,'auth','0007_alter_validators_add_error_messages','2016-10-12 07:42:19.779729'),(13,'auth','0008_alter_user_username_max_length','2016-10-12 07:42:19.790871'),(14,'mainpage','0001_initial','2016-10-12 07:42:20.193032'),(15,'mainpage','0002_auto_20161012_0204','2016-10-12 07:42:20.238112'),(16,'mainpage','0003_auto_20161012_0213','2016-10-12 07:42:20.357058'),(17,'mainpage','0004_auto_20161012_0737','2016-10-12 07:42:20.469990'),(18,'sessions','0001_initial','2016-10-12 07:42:20.500574'),(19,'mainpage','0005_auto_20161012_1622','2016-10-12 08:23:13.572190'),(20,'mainpage','0006_auto_20161012_1914','2016-10-12 19:14:50.608208'),(21,'mainpage','0007_auto_20161012_1916','2016-10-12 19:16:12.061468');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('43fap21roqw37sx6t7rpnvcauh61pl5x','OGI3ODI1MDhmOWRkY2Q2NGI4ZmQ2NTAxODZhYWQ4MmQ4ZGUzNWQ0ZTp7Il9hdXRoX3VzZXJfaGFzaCI6IjA4ZGVkMWZiNTgyN2JkOWY0ZDNlZWM0ZmIzYTBjNDlkMTUyZjkwM2UiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2016-10-27 04:30:02.762255');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-13 12:37:41
