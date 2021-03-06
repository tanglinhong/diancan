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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
INSERT INTO `Address` VALUES (1,'福建省','宁德','寿宁县','孝陵卫200号 宁德理工大学','王子扬','13270728660',1,'210094',1),(2,'福建省','宁德','古田县','马坑乡200号 南京理工大学','王子扬','13312345678',1,'210094',2);
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
  `image` varchar(50) NOT NULL,
  `shop_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Merchandise_5a722918` (`shop_id_id`),
  CONSTRAINT `Merchandise_shop_id_id_4ad8d9ab_fk_Shop_id` FOREIGN KEY (`shop_id_id`) REFERENCES `Shop` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Merchandise`
--

LOCK TABLES `Merchandise` WRITE;
/*!40000 ALTER TABLE `Merchandise` DISABLE KEYS */;
INSERT INTO `Merchandise` VALUES (1,'小份黄焖鸡',15,'',1),(2,'大份黄焖鸡',20,'',1),(3,'米饭',1,'',1),(4,'金针菇',4,'',1),(5,'土豆',2,'',1);
/*!40000 ALTER TABLE `Merchandise` ENABLE KEYS */;
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
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Orders_user_id_id_1fd11d1c_fk_User_id` (`user_id_id`),
  CONSTRAINT `Orders_user_id_id_1fd11d1c_fk_User_id` FOREIGN KEY (`user_id_id`) REFERENCES `User` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
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
  `shop_img` varchar(50) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Shop_user_id_id_2b2e4b88_fk_User_id` (`user_id_id`),
  CONSTRAINT `Shop_user_id_id_2b2e4b88_fk_User_id` FOREIGN KEY (`user_id_id`) REFERENCES `User` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shop`
--

LOCK TABLES `Shop` WRITE;
/*!40000 ALTER TABLE `Shop` DISABLE KEYS */;
INSERT INTO `Shop` VALUES (1,'黄焖鸡米饭',20,5,4.1,'',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'pbkdf2_sha256$30000$509fNPlBr8tX$M8XeQnLgEjFi9Jf2PlVQMFBJQpvmEXKE4UAK3va7+GU=','2016-10-11 04:35:55.964308','Grinch','majorgrinch@gmail.com','13270728660',1,0),(2,'pbkdf2_sha256$30000$mJdzyQqnHyv7$n7hD/zvyBUTFJjdnG7xYapPuuoKMC5QmS4AxxASL314=','2016-10-12 00:55:45.437774','Linda','linda@gmail.com','13312345678',1,0);
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
INSERT INTO `auth_permission` VALUES (1,'Can add user',1,'add_user'),(2,'Can change user',1,'change_user'),(3,'Can delete user',1,'delete_user'),(4,'Can add address',2,'add_address'),(5,'Can change address',2,'change_address'),(6,'Can delete address',2,'delete_address'),(7,'Can add orders',3,'add_orders'),(8,'Can change orders',3,'change_orders'),(9,'Can delete orders',3,'delete_orders'),(10,'Can add order detail',4,'add_orderdetail'),(11,'Can change order detail',4,'change_orderdetail'),(12,'Can delete order detail',4,'delete_orderdetail'),(13,'Can add shop',5,'add_shop'),(14,'Can change shop',5,'change_shop'),(15,'Can delete shop',5,'delete_shop'),(16,'Can add merchandise',6,'add_merchandise'),(17,'Can change merchandise',6,'change_merchandise'),(18,'Can delete merchandise',6,'delete_merchandise'),(19,'Can add sales num',7,'add_salesnum'),(20,'Can change sales num',7,'change_salesnum'),(21,'Can delete sales num',7,'delete_salesnum'),(22,'Can add log entry',8,'add_logentry'),(23,'Can change log entry',8,'change_logentry'),(24,'Can delete log entry',8,'delete_logentry'),(25,'Can add permission',9,'add_permission'),(26,'Can change permission',9,'change_permission'),(27,'Can delete permission',9,'delete_permission'),(28,'Can add group',10,'add_group'),(29,'Can change group',10,'change_group'),(30,'Can delete group',10,'delete_group'),(31,'Can add content type',11,'add_contenttype'),(32,'Can change content type',11,'change_contenttype'),(33,'Can delete content type',11,'delete_contenttype'),(34,'Can add session',12,'add_session'),(35,'Can change session',12,'change_session'),(36,'Can delete session',12,'delete_session');
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
INSERT INTO `django_content_type` VALUES (8,'admin','logentry'),(10,'auth','group'),(9,'auth','permission'),(11,'contenttypes','contenttype'),(1,'login','user'),(2,'mainpage','address'),(6,'mainpage','merchandise'),(4,'mainpage','orderdetail'),(3,'mainpage','orders'),(7,'mainpage','salesnum'),(5,'mainpage','shop'),(12,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'login','0001_initial','2016-10-10 06:20:35.496568'),(2,'contenttypes','0001_initial','2016-10-10 06:20:35.529118'),(3,'admin','0001_initial','2016-10-10 06:20:35.620073'),(4,'admin','0002_logentry_remove_auto_add','2016-10-10 06:20:35.627656'),(5,'contenttypes','0002_remove_content_type_name','2016-10-10 06:20:35.673056'),(6,'auth','0001_initial','2016-10-10 06:20:35.858376'),(7,'auth','0002_alter_permission_name_max_length','2016-10-10 06:20:35.903189'),(8,'auth','0003_alter_user_email_max_length','2016-10-10 06:20:35.932652'),(9,'auth','0004_alter_user_username_opts','2016-10-10 06:20:35.959455'),(10,'auth','0005_alter_user_last_login_null','2016-10-10 06:20:35.986367'),(11,'auth','0006_require_contenttypes_0002','2016-10-10 06:20:35.990910'),(12,'auth','0007_alter_validators_add_error_messages','2016-10-10 06:20:36.043394'),(13,'auth','0008_alter_user_username_max_length','2016-10-10 06:20:36.072897'),(14,'mainpage','0001_initial','2016-10-10 06:20:36.592164'),(15,'sessions','0001_initial','2016-10-10 06:20:36.620233');
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
INSERT INTO `django_session` VALUES ('yxldhgkpyv54sc4iztzwe4f3y92fzqeo','M2U1N2MyNThjMTI3NjQ4NWZjNGY1ZGI5MzhkMDM3MDg2ZWY0N2M2NDp7Il9hdXRoX3VzZXJfaGFzaCI6IjE2ZGE4YmRjNmZlYjE4NmQ3NDIwMzU5ODZjOTkwZjE0Njc1MGUzOTAiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2016-10-26 00:55:45.441782');
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

-- Dump completed on 2016-10-12  9:09:08
