# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.24)
# Database: advanced_yii2
# Generation Time: 2015-06-25 15:04:43 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table auth_assignment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_assignment`;

CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `auth_assignment` WRITE;
/*!40000 ALTER TABLE `auth_assignment` DISABLE KEYS */;

INSERT INTO `auth_assignment` (`item_name`, `user_id`, `created_at`)
VALUES
	('admin',1,NULL),
	('admin',2,NULL),
	('create-branch',9,NULL),
	('create-company',9,NULL);

/*!40000 ALTER TABLE `auth_assignment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_item`;

CREATE TABLE `auth_item` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `rule_name` varchar(64) DEFAULT NULL,
  `data` text,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `type` (`type`),
  CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `auth_item` WRITE;
/*!40000 ALTER TABLE `auth_item` DISABLE KEYS */;

INSERT INTO `auth_item` (`name`, `type`, `description`, `rule_name`, `data`, `created_at`, `updated_at`)
VALUES
	('admin',1,'admin can create branches and create companies',NULL,NULL,NULL,NULL),
	('create-branch',2,'allow a user to add a branch',NULL,NULL,NULL,NULL),
	('create-company',2,'allows user to create a company',NULL,NULL,NULL,NULL),
	('updateOwnPost',2,'update your own post ','isAuthor',NULL,NULL,NULL);

/*!40000 ALTER TABLE `auth_item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_item_child
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_item_child`;

CREATE TABLE `auth_item_child` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `auth_item_child` WRITE;
/*!40000 ALTER TABLE `auth_item_child` DISABLE KEYS */;

INSERT INTO `auth_item_child` (`parent`, `child`)
VALUES
	('admin','create-branch'),
	('admin','create-company'),
	('admin','updateOwnPost');

/*!40000 ALTER TABLE `auth_item_child` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_rule`;

CREATE TABLE `auth_rule` (
  `name` varchar(64) NOT NULL,
  `data` text,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `auth_rule` WRITE;
/*!40000 ALTER TABLE `auth_rule` DISABLE KEYS */;

INSERT INTO `auth_rule` (`name`, `data`, `created_at`, `updated_at`)
VALUES
	('isAuthor',NULL,NULL,NULL);

/*!40000 ALTER TABLE `auth_rule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table branches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `branches`;

CREATE TABLE `branches` (
  `branch_id` int(11) NOT NULL AUTO_INCREMENT,
  `companies_company_id` int(11) NOT NULL,
  `branch_name` varchar(100) NOT NULL,
  `branch_address` varchar(255) NOT NULL,
  `branch_created_date` datetime NOT NULL,
  `branch_status` enum('active','inactive') NOT NULL,
  PRIMARY KEY (`branch_id`),
  KEY `fk_branches_companies_idx` (`companies_company_id`),
  CONSTRAINT `fk_branches_companies` FOREIGN KEY (`companies_company_id`) REFERENCES `companies` (`company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;

INSERT INTO `branches` (`branch_id`, `companies_company_id`, `branch_name`, `branch_address`, `branch_created_date`, `branch_status`)
VALUES
	(2,2,'main branch','some branch address','2014-12-05 06:12:27','inactive'),
	(3,2,'another branch','another branch address','2014-12-05 07:12:16','active'),
	(4,3,'Sri Lanka','sdfdfsdf','2014-12-15 01:12:24','active'),
	(5,3,'sdfsdf','sdfsdfsdf','2015-02-02 06:02:58','active'),
	(6,9,'Colombo','some where in colombo ','2015-03-15 08:03:19','active'),
	(7,3,'Galle','address','2015-05-09 08:05:41','inactive'),
	(8,3,'ampara','address','2015-05-09 08:05:59','active'),
	(10,8,'testing ajax submit','some where in colombo ','2015-05-09 08:05:25','active');

/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table companies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `companies`;

CREATE TABLE `companies` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) NOT NULL,
  `company_email` varchar(100) NOT NULL,
  `company_address` varchar(255) NOT NULL,
  `logo` varchar(200) NOT NULL,
  `company_start_date` date NOT NULL,
  `company_created_date` datetime NOT NULL,
  `company_status` enum('active','inactive') NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;

INSERT INTO `companies` (`company_id`, `company_name`, `company_email`, `company_address`, `logo`, `company_start_date`, `company_created_date`, `company_status`)
VALUES
	(2,'ABC','abc@gmail.com','some address','','0000-00-00','2014-12-05 06:12:19','active'),
	(3,'DoingITeasy','do@sdf.com','sodfksdfsdf','','0000-00-00','2014-12-15 01:12:47','active'),
	(8,'DoingITeasyChannel','doi@doing.gi','some address','uploads/DoingITeasyChannel.png','0000-00-00','2015-01-10 08:01:30','active'),
	(9,'ABCD','abc@gmail.com','some address ','','0000-00-00','2015-03-15 08:03:19','active');

/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table customers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `zip_code` varchar(20) NOT NULL,
  `city` varchar(100) NOT NULL,
  `province` varchar(100) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table departments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `departments`;

CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `branches_branch_id` int(11) NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `companies_company_id` int(11) NOT NULL,
  `department_created_date` datetime NOT NULL,
  `department_status` enum('active','inactive') NOT NULL,
  PRIMARY KEY (`department_id`),
  KEY `fk_departments_branches1_idx` (`branches_branch_id`),
  KEY `fk_departments_companies1_idx` (`companies_company_id`),
  CONSTRAINT `fk_departments_branches1` FOREIGN KEY (`branches_branch_id`) REFERENCES `branches` (`branch_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_departments_companies1` FOREIGN KEY (`companies_company_id`) REFERENCES `companies` (`company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;

INSERT INTO `departments` (`department_id`, `branches_branch_id`, `department_name`, `companies_company_id`, `department_created_date`, `department_status`)
VALUES
	(2,2,'IT Department',2,'2014-12-05 06:12:09','active');

/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table emails
# ------------------------------------------------------------

DROP TABLE IF EXISTS `emails`;

CREATE TABLE `emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver_name` varchar(50) NOT NULL,
  `receiver_email` varchar(200) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `attachment` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;

INSERT INTO `emails` (`id`, `receiver_name`, `receiver_email`, `subject`, `content`, `attachment`)
VALUES
	(1,'Uthpala','uiheenatigala@gmail.com','Testing the email ','Some content ','attachments/1421906659.png');

/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `created_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;

INSERT INTO `event` (`id`, `title`, `description`, `created_date`)
VALUES
	(1,'test event','some test description','2015-06-12'),
	(2,'another task','some descriptinons','2015-06-12'),
	(3,'do this on the 17th','here is how to do it ','2015-06-17'),
	(4,'8th event','have some fun','2015-06-08');

/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table locations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `zip_code` varchar(20) NOT NULL,
  `city` varchar(100) NOT NULL,
  `province` varchar(100) NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;

INSERT INTO `locations` (`location_id`, `zip_code`, `city`, `province`)
VALUES
	(1,'1111','Colombo','Western'),
	(2,'2222','Galle','Southern ');

/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migration`;

CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;

INSERT INTO `migration` (`version`, `apply_time`)
VALUES
	('m000000_000000_base',1416813354),
	('m130524_201442_init',1416813368);

/*!40000 ALTER TABLE `migration` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table po
# ------------------------------------------------------------

DROP TABLE IF EXISTS `po`;

CREATE TABLE `po` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `po_no` varchar(10) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `po` WRITE;
/*!40000 ALTER TABLE `po` DISABLE KEYS */;

INSERT INTO `po` (`id`, `po_no`, `description`)
VALUES
	(2,'po-1','some description'),
	(3,'po-2','purchasing order number 2');

/*!40000 ALTER TABLE `po` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table po_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `po_item`;

CREATE TABLE `po_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `po_item_no` varchar(10) NOT NULL,
  `quantity` double NOT NULL,
  `po_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `po_id` (`po_id`),
  CONSTRAINT `po_item_ibfk_1` FOREIGN KEY (`po_id`) REFERENCES `po` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `po_item` WRITE;
/*!40000 ALTER TABLE `po_item` DISABLE KEYS */;

INSERT INTO `po_item` (`id`, `po_item_no`, `quantity`, `po_id`)
VALUES
	(1,'po-item-1',10,2),
	(2,'po-item-2',20,2),
	(3,'po-item-3',12,3),
	(4,'po-item-4',20,3);

/*!40000 ALTER TABLE `po_item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `role` smallint(6) NOT NULL DEFAULT '10',
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `role`, `status`, `created_at`, `updated_at`)
VALUES
	(1,'','','doingITeasy','mXoICMvTR_n21FMJaCyA9ft_b4RsF0Vs','$2y$13$bucEc1sMCJyePLhjZYnDxOk0u0p7pyotQJQgd95o20G05RJ4UHoDy',NULL,'uiheenatigala@gmail.com',10,10,1416813431,1416813431),
	(2,'Uthpala','Heenatigala','uthpala','fqWNg-v9cWNLv6duFyJCBHmuAhtiCuNv','$2y$13$Ci4zoXaf.skJ3akK/fBM/.bqUgkIqTJ7si6IJq1tybnYCbNd/FH5S',NULL,'test@gmail.com',10,10,1417756860,1417756860),
	(3,'somename','somename','sam','tf7kuVqmlpZc9aMZZC1_ob7iloEUQCcV','$2y$13$eQeVy6mnPYs/xzXVvG2vmOyaRsN284p5X6DMBw5p4bmc6rg9/ntc.',NULL,'sam@gmail.com',10,10,1423652674,1423652674),
	(4,'John','John','john','vZnsGI8Xbqsw2V8_JRg7LGyMJBA-4-qd','$2y$13$uNBa7td3ICKjq0M7BYzrkOAw9YkmyJk1dI0hefLwnN.ejXQ3COGRC',NULL,'john@gmail.com',10,10,1423652764,1423652764),
	(5,'Uthpala','company','123','ANOsFmFjgoqQbL1SvY2zo-60ZvaAhSlD','$2y$13$gG5yDLZzap.RBQ/nIVMDauYhcvFPOWjnfoinRso2tfB9CYUjXaE1G',NULL,'11@gmail.com',10,10,1423652807,1423652807),
	(6,'Uthpala','company','1234','A1iUOZ1GD2zveVx8zeCU9m9qmqTdF6Rl','$2y$13$ZLHSp/2F4Iak5zcgKcSJkuM5jybZWFe1gQzbIqoa0cp8cm/t2lbNq',NULL,'114@gmail.com',10,10,1423652865,1423652865),
	(7,'4444','4444','444','H_fFlWcjm1BhXmXpJUkFzCVAt4fFDQHr','$2y$13$fEGU8V2s/ikeOX3VGIwdIuTxB2eIFX9Yb9LQoZykfeatfOFuoYh0i',NULL,'john4@gmail.com',10,10,1423652892,1423652892),
	(8,'4444','4444','4445','WQ0u1u-ArxbuhmoVgDiqLPG7HhAZig0I','$2y$13$dRm8m0GBEbkrZGmxL9Zd8OjNIwWiVFJ.8pgdLDOjnGpQuwdwa36Zu',NULL,'john54@gmail.com',10,10,1423652959,1423652959),
	(9,'testin','sdfsdf','test111','JcsG6u8Q1bWbP5n0epSTnlnDs2azNb0U','$2y$13$UtvvtM89GmR7Qp8zdaQ.Oemf/eVkRprgE/fN7iziPD80yrK.foWaW',NULL,'john111@gmail.com',10,10,1423653059,1423653059);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
