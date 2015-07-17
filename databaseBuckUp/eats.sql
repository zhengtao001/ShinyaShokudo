-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: EATS
-- ------------------------------------------------------
-- Server version	5.5.40-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `EatsIndex_relationship`
--

DROP TABLE IF EXISTS `EatsIndex_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EatsIndex_relationship` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itself_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `itself_id` (`itself_id`),
  CONSTRAINT `itself_id_refs_id_8c450030` FOREIGN KEY (`itself_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EatsIndex_relationship`
--

LOCK TABLES `EatsIndex_relationship` WRITE;
/*!40000 ALTER TABLE `EatsIndex_relationship` DISABLE KEYS */;
INSERT INTO `EatsIndex_relationship` VALUES (1,1),(2,2),(3,3),(4,4);
/*!40000 ALTER TABLE `EatsIndex_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EatsIndex_relationship_relation`
--

DROP TABLE IF EXISTS `EatsIndex_relationship_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EatsIndex_relationship_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relationship_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `relationship_id` (`relationship_id`,`user_id`),
  KEY `EatsIndex_relationship_relation_6f9399d2` (`relationship_id`),
  KEY `EatsIndex_relationship_relation_6340c63c` (`user_id`),
  CONSTRAINT `relationship_id_refs_id_f69aedeb` FOREIGN KEY (`relationship_id`) REFERENCES `EatsIndex_relationship` (`id`),
  CONSTRAINT `user_id_refs_id_f197f12d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EatsIndex_relationship_relation`
--

LOCK TABLES `EatsIndex_relationship_relation` WRITE;
/*!40000 ALTER TABLE `EatsIndex_relationship_relation` DISABLE KEYS */;
INSERT INTO `EatsIndex_relationship_relation` VALUES (1,1,2),(10,1,3),(4,2,1),(5,2,3),(9,3,1),(3,3,2);
/*!40000 ALTER TABLE `EatsIndex_relationship_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Message_group`
--

DROP TABLE IF EXISTS `Message_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Message_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Message_group`
--

LOCK TABLES `Message_group` WRITE;
/*!40000 ALTER TABLE `Message_group` DISABLE KEYS */;
INSERT INTO `Message_group` VALUES (1,'room215'),(2,'123');
/*!40000 ALTER TABLE `Message_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Message_group_user`
--

DROP TABLE IF EXISTS `Message_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Message_group_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`user_id`),
  KEY `Message_group_user_5f412f9a` (`group_id`),
  KEY `Message_group_user_6340c63c` (`user_id`),
  CONSTRAINT `group_id_refs_id_1580be4d` FOREIGN KEY (`group_id`) REFERENCES `Message_group` (`id`),
  CONSTRAINT `user_id_refs_id_0b78d637` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Message_group_user`
--

LOCK TABLES `Message_group_user` WRITE;
/*!40000 ALTER TABLE `Message_group_user` DISABLE KEYS */;
INSERT INTO `Message_group_user` VALUES (1,1,1),(3,1,2),(2,1,3),(4,1,4),(7,2,2),(5,2,3);
/*!40000 ALTER TABLE `Message_group_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Message_groupmessage`
--

DROP TABLE IF EXISTS `Message_groupmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Message_groupmessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `pub_date` datetime NOT NULL,
  `text` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Message_groupmessage_5f412f9a` (`group_id`),
  KEY `Message_groupmessage_0a681a64` (`sender_id`),
  CONSTRAINT `group_id_refs_id_fa5d7e5c` FOREIGN KEY (`group_id`) REFERENCES `Message_group` (`id`),
  CONSTRAINT `sender_id_refs_id_b3e0536b` FOREIGN KEY (`sender_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Message_groupmessage`
--

LOCK TABLES `Message_groupmessage` WRITE;
/*!40000 ALTER TABLE `Message_groupmessage` DISABLE KEYS */;
INSERT INTO `Message_groupmessage` VALUES (1,1,1,'2014-12-18 08:52:43','只要能在这里说话，就大功告成了！！'),(2,1,1,'2014-12-18 08:59:16','修改了点bug，现在不会出现重复消息了！！'),(3,1,1,'2014-12-18 16:35:00','搞完收工～'),(4,1,3,'2014-12-18 17:28:21','lalal'),(5,1,1,'2014-12-18 17:28:32','啦啦啦'),(6,1,2,'2014-12-18 17:29:31','我是小明！'),(7,1,2,'2014-12-18 17:30:50','我是小葱！'),(8,1,1,'2014-12-18 17:31:07','用错账号了QAQ'),(9,1,3,'2015-01-02 21:59:00','1234'),(10,1,3,'2015-01-02 21:59:45','终于写完这个项目啦'),(11,1,3,'2015-01-02 22:07:15','终于写完这个项目啦'),(12,1,1,'2015-01-02 22:07:21','Hey, there!'),(13,1,1,'2015-01-02 22:08:08','困死了，赶紧整理好资料睡觉吧'),(14,1,3,'2015-01-02 22:08:55','好的 小明呢'),(15,1,2,'2015-01-02 22:09:01','好的QAQ');
/*!40000 ALTER TABLE `Message_groupmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Message_receivestatus`
--

DROP TABLE IF EXISTS `Message_receivestatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Message_receivestatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `last_recv` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Message_receivestatus_6340c63c` (`user_id`),
  CONSTRAINT `user_id_refs_id_76a6c350` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Message_receivestatus`
--

LOCK TABLES `Message_receivestatus` WRITE;
/*!40000 ALTER TABLE `Message_receivestatus` DISABLE KEYS */;
INSERT INTO `Message_receivestatus` VALUES (1,3,'2015-01-02 22:09:01'),(2,1,'2015-01-02 22:09:05'),(3,2,'2015-01-02 22:08:58'),(4,4,'2014-12-18 19:59:16');
/*!40000 ALTER TABLE `Message_receivestatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Message_usermessage`
--

DROP TABLE IF EXISTS `Message_usermessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Message_usermessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` int(11) NOT NULL,
  `recver_id` int(11) NOT NULL,
  `pub_date` datetime NOT NULL,
  `text` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Message_usermessage_0a681a64` (`sender_id`),
  KEY `Message_usermessage_07f09556` (`recver_id`),
  CONSTRAINT `recver_id_refs_id_df642618` FOREIGN KEY (`recver_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `sender_id_refs_id_df642618` FOREIGN KEY (`sender_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Message_usermessage`
--

LOCK TABLES `Message_usermessage` WRITE;
/*!40000 ALTER TABLE `Message_usermessage` DISABLE KEYS */;
INSERT INTO `Message_usermessage` VALUES (1,1,3,'2014-12-17 03:20:39','ok，现在来试一下时间问题'),(2,1,3,'2014-12-17 03:23:02','这次总行了吧！'),(3,1,3,'2014-12-17 03:23:40','为什么你会收到两条。。'),(4,1,3,'2014-12-17 03:25:02','ok，现在没问题了！'),(5,1,3,'2014-12-17 03:42:53','=-='),(6,1,3,'2014-12-17 03:53:37','说你妹夫啊'),(7,1,3,'2014-12-17 04:50:48','留言测试～'),(8,2,1,'2014-12-17 04:55:51','留言测试～'),(9,2,1,'2014-12-17 04:56:17','测试反馈～'),(10,1,2,'2014-12-17 04:57:16','再次测试'),(11,2,1,'2014-12-17 04:57:25','再次反馈'),(12,1,3,'2014-12-17 05:00:02','刚刚加多了一张表进去，用来支持留言的功能=-=虽然好累但是好爽。明天再把群组讨论搞定。睡觉啦啦啦'),(13,2,1,'2014-12-17 17:48:39','我测试一下'),(14,1,3,'2014-12-18 05:58:17','开发进入了一个新阶段，有点困'),(15,1,3,'2014-12-18 08:51:57','估计快完成了！！！好激动！！'),(16,1,3,'2014-12-18 17:21:39','啦啦啦'),(17,3,2,'2014-12-18 17:29:13','lalal');
/*!40000 ALTER TABLE `Message_usermessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add relation ship',7,'add_relationship'),(20,'Can change relation ship',7,'change_relationship'),(21,'Can delete relation ship',7,'delete_relationship'),(22,'Can add user comment',8,'add_usercomment'),(23,'Can change user comment',8,'change_usercomment'),(24,'Can delete user comment',8,'delete_usercomment'),(25,'Can add user comment v2',9,'add_usercommentv2'),(26,'Can change user comment v2',9,'change_usercommentv2'),(27,'Can delete user comment v2',9,'delete_usercommentv2'),(28,'Can add user comment v3',10,'add_usercommentv3'),(29,'Can change user comment v3',10,'change_usercommentv3'),(30,'Can delete user comment v3',10,'delete_usercommentv3'),(34,'Can add user message',12,'add_usermessage'),(35,'Can change user message',12,'change_usermessage'),(36,'Can delete user message',12,'delete_usermessage'),(37,'Can add group',13,'add_group'),(38,'Can change group',13,'change_group'),(39,'Can delete group',13,'delete_group'),(40,'Can add user group',14,'add_usergroup'),(41,'Can change user group',14,'change_usergroup'),(42,'Can delete user group',14,'delete_usergroup'),(43,'Can add group message',15,'add_groupmessage'),(44,'Can change group message',15,'change_groupmessage'),(45,'Can delete group message',15,'delete_groupmessage');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$ZhYugPvGXTSF$MlHhFfdssjYQxJjVmMOUi6/x4pWHqk+iYp+0z0w0Pdk=','2015-01-02 13:59:53',1,'ycc','','','609918436@qq.com',1,1,'2014-12-10 16:51:23'),(2,'pbkdf2_sha256$12000$38xwhaNizOqe$VfqtEZiyQKGJ1eI71W2ZhIKJhzijRgjs0Fr0Fo5G8so=','2015-01-02 14:08:27',0,'xiaoming','','','xiaoming@qq.com',0,1,'2014-12-10 16:53:17'),(3,'pbkdf2_sha256$12000$ODvU9oYjek3d$vZSktpxwgnZzPjfw64p1Ec8wYVcIVsjLt/s8Rw3L95g=','2015-01-02 13:44:46',0,'cyc','','','cyc@qq.com',0,1,'2014-12-10 21:52:50'),(4,'pbkdf2_sha256$12000$A4N94bJSH6ZN$tfOFkI0RBZcl+Ps25bvldyeKsGq3KlBz9SjxHRLYDzA=','2014-12-18 11:58:52',0,'igg','','','gg@qq.com',0,1,'2014-12-15 18:54:14');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_usercomment`
--

DROP TABLE IF EXISTS `comment_usercomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment_usercomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `pub_date` datetime NOT NULL,
  `text` longtext COLLATE utf8_unicode_ci NOT NULL,
  `plus_one` int(11) NOT NULL,
  `image` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_usercomment_e969df21` (`author_id`),
  CONSTRAINT `author_id_refs_id_b42d16d0` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_usercomment`
--

LOCK TABLES `comment_usercomment` WRITE;
/*!40000 ALTER TABLE `comment_usercomment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_usercomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_usercommentv2`
--

DROP TABLE IF EXISTS `comment_usercommentv2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment_usercommentv2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `pub_date` datetime NOT NULL,
  `text` longtext COLLATE utf8_unicode_ci NOT NULL,
  `plus_one` int(11) NOT NULL,
  `foodname` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `address` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `model_pic` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_usercommentv2_e969df21` (`author_id`),
  CONSTRAINT `author_id_refs_id_f7e20337` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_usercommentv2`
--

LOCK TABLES `comment_usercommentv2` WRITE;
/*!40000 ALTER TABLE `comment_usercommentv2` DISABLE KEYS */;
INSERT INTO `comment_usercommentv2` VALUES (1,2,'2014-12-10 16:55:53','太棒了！',0,'辉记关东煮',9,'至二','pic_folder/xiaoming.jpg'),(2,3,'2014-12-10 21:53:51','这才是真正的关东煮啊！',1,'关东煮',11,'新天地','pic_folder/cyc.jpeg');
/*!40000 ALTER TABLE `comment_usercommentv2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_usercommentv3`
--

DROP TABLE IF EXISTS `comment_usercommentv3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment_usercommentv3` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_pic` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_usercommentv3`
--

LOCK TABLES `comment_usercommentv3` WRITE;
/*!40000 ALTER TABLE `comment_usercommentv3` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_usercommentv3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext COLLATE utf8_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `app_label` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'relation ship','EatsIndex','relationship'),(8,'user comment','comment','usercomment'),(9,'user comment v2','comment','usercommentv2'),(10,'user comment v3','comment','usercommentv3'),(12,'user message','Message','usermessage'),(13,'group','Message','group'),(14,'user group','Message','usergroup'),(15,'group message','Message','groupmessage');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('40qlkth0sz0osso88hur84v9pz1urplh','ZWMwNTRlMzRhODRmMjJlZDdlNWZhNmZhN2NhZWE4ZWQ4MTdmY2U3YTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-12-30 19:36:16'),('5bdz00ofn8il0zkbdtnuuhlxa0xb5o0a','MmNkNTZmMjRlMTkwZmM4MDBiZDQ3ZGZjNTdiY2NmYjM4ZWQ3NDkxZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6M30=','2014-12-30 18:25:37'),('5dokfwdllxqes4fk2jkrkdbj49uug41n','ZWMwNTRlMzRhODRmMjJlZDdlNWZhNmZhN2NhZWE4ZWQ4MTdmY2U3YTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-12-29 23:18:46'),('60xgx9r8f4t1nmh2hvclx89smz0jon1l','MmNkNTZmMjRlMTkwZmM4MDBiZDQ3ZGZjNTdiY2NmYjM4ZWQ3NDkxZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6M30=','2015-01-16 13:42:22'),('7p463adnp2zzkdkvnn7gxhf2j1jd8s1n','MmNkNTZmMjRlMTkwZmM4MDBiZDQ3ZGZjNTdiY2NmYjM4ZWQ3NDkxZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6M30=','2014-12-30 20:51:06'),('b0ddhaqqrirgoykmubrivw5m4oejxj6x','ZWMwNTRlMzRhODRmMjJlZDdlNWZhNmZhN2NhZWE4ZWQ4MTdmY2U3YTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-12-30 19:57:55'),('e9q1xh8kdksszxb3r87ks5s1iphw3p26','MDAyNGE4YTY3ZWE5Yjg2MzBlYmM2NTFjZTRkMGY3YmEwNDJmNjVmMDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-12-24 16:53:17'),('ebe8k3c4dtfw2eusbqjpbu3fsr4ye7v6','OWIwMWNlODJhMTlmMDAxOTI2YzY1MzExNTBmMGMxZjhjYTMwMjhlZDp7fQ==','2014-12-30 19:51:59'),('gx4kotscsv2s7b27yto8uf2bk3wxp1sp','OWIwMWNlODJhMTlmMDAxOTI2YzY1MzExNTBmMGMxZjhjYTMwMjhlZDp7fQ==','2015-01-01 09:31:13'),('htuo1mu35vhue0e621jdgzs7euwthui2','OWIwMWNlODJhMTlmMDAxOTI2YzY1MzExNTBmMGMxZjhjYTMwMjhlZDp7fQ==','2015-01-01 09:31:19'),('i76udbfrjdiq19x27q63dryrjxrachx2','OWIwMWNlODJhMTlmMDAxOTI2YzY1MzExNTBmMGMxZjhjYTMwMjhlZDp7fQ==','2014-12-30 17:56:08'),('imp8adh8x06iewjzzfo1a8l6mrvaqha2','MDAyNGE4YTY3ZWE5Yjg2MzBlYmM2NTFjZTRkMGY3YmEwNDJmNjVmMDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2015-01-16 14:08:27'),('n919yrwmbnqe8eyuuelwb3w21tb0h0j3','MmNkNTZmMjRlMTkwZmM4MDBiZDQ3ZGZjNTdiY2NmYjM4ZWQ3NDkxZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6M30=','2015-01-01 09:27:43'),('qe2ncyvtkbjzb5upw8hfnsehhhyxyngl','MmNkNTZmMjRlMTkwZmM4MDBiZDQ3ZGZjNTdiY2NmYjM4ZWQ3NDkxZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6M30=','2015-01-16 13:44:46'),('rb6kszafw1sh8fr7utgozccofl4yqd4k','ZTcxNjk2OThkYTA0ZDdhMGZlNzM5MWI4NDA4MmRlODA1NzI5OGJkZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NH0=','2015-01-01 11:58:52'),('un9tkeab0f9w71dnlv4ttqizflk0chv6','ZWMwNTRlMzRhODRmMjJlZDdlNWZhNmZhN2NhZWE4ZWQ4MTdmY2U3YTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2015-01-16 13:59:54'),('v9pmnx4tq705gnilfc7mue6eiwo90xw7','OWIwMWNlODJhMTlmMDAxOTI2YzY1MzExNTBmMGMxZjhjYTMwMjhlZDp7fQ==','2014-12-30 19:36:00'),('x3zq40sy3tapbj65vwso3l480q8sx03z','MmNkNTZmMjRlMTkwZmM4MDBiZDQ3ZGZjNTdiY2NmYjM4ZWQ3NDkxZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6M30=','2014-12-24 21:52:51');
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

-- Dump completed on 2015-01-02 22:59:55
