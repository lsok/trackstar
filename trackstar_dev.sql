-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 30, 2015 at 10:54 ����
-- Server version: 5.5.8
-- PHP Version: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `trackstar_dev`
--

-- --------------------------------------------------------

--
-- Table structure for table `authassignment`
--

CREATE TABLE IF NOT EXISTS `authassignment` (
  `itemname` varchar(64) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`itemname`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `authassignment`
--

INSERT INTO `authassignment` (`itemname`, `userid`, `bizrule`, `data`) VALUES
('admin', '1', NULL, 'N;');

-- --------------------------------------------------------

--
-- Table structure for table `authitem`
--

CREATE TABLE IF NOT EXISTS `authitem` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `authitem`
--

INSERT INTO `authitem` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
('admin', 2, '', NULL, 'N;'),
('adminManagement', 1, 'access to the application administration functionality', NULL, 'N;'),
('createIssue', 0, 'create a new issue', NULL, 'N;'),
('createProject', 0, 'create a new project', NULL, 'N;'),
('createUser', 0, 'create a new user', NULL, 'N;'),
('deleteIssue', 0, 'delete an issue from a project', NULL, 'N;'),
('deleteProject', 0, 'delete a project', NULL, 'N;'),
('deleteUser', 0, 'remove a user from a project', NULL, 'N;'),
('member', 2, '', NULL, 'N;'),
('owner', 2, '', NULL, 'N;'),
('reader', 2, '', NULL, 'N;'),
('readIssue', 0, 'read issue information', NULL, 'N;'),
('readProject', 0, 'read project information', NULL, 'N;'),
('readUser', 0, 'read user profile information', NULL, 'N;'),
('updateIssue', 0, 'update issue information', NULL, 'N;'),
('updateProject', 0, 'update project information', NULL, 'N;'),
('updateUser', 0, 'update a users information', NULL, 'N;');

-- --------------------------------------------------------

--
-- Table structure for table `authitemchild`
--

CREATE TABLE IF NOT EXISTS `authitemchild` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `authitemchild`
--

INSERT INTO `authitemchild` (`parent`, `child`) VALUES
('admin', 'adminManagement'),
('member', 'createIssue'),
('owner', 'createProject'),
('owner', 'createUser'),
('member', 'deleteIssue'),
('owner', 'deleteProject'),
('owner', 'deleteUser'),
('admin', 'member'),
('owner', 'member'),
('admin', 'owner'),
('admin', 'reader'),
('member', 'reader'),
('owner', 'reader'),
('reader', 'readIssue'),
('reader', 'readProject'),
('reader', 'readUser'),
('member', 'updateIssue'),
('owner', 'updateProject'),
('owner', 'updateUser');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_comment`
--

CREATE TABLE IF NOT EXISTS `tbl_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `issue_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_user_id` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_comment_issue` (`issue_id`),
  KEY `FK_comment_author` (`create_user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `tbl_comment`
--

INSERT INTO `tbl_comment` (`id`, `content`, `issue_id`, `create_time`, `create_user_id`, `update_time`, `update_user_id`) VALUES
(1, '这是第一条评论。', 1, '2014-12-18 15:54:19', 1, '2014-12-18 15:54:19', 1),
(2, '这是第２条评论。', 1, '2014-12-18 15:55:33', 1, '2014-12-18 15:55:33', 1),
(3, '又一条评论。', 25, '2014-12-18 15:56:47', 1, '2014-12-18 15:56:47', 1),
(4, '再写一条评论。', 25, '2014-12-18 15:59:05', 1, '2014-12-18 15:59:05', 1),
(5, '再来一条。', 25, '2014-12-18 15:59:30', 1, '2014-12-18 15:59:30', 1),
(14, '再发一条评论。', 25, '2014-12-18 16:14:02', 1, '2014-12-18 16:14:02', 1),
(15, '始终显示输入表单。', 25, '2014-12-19 15:56:15', 1, '2014-12-19 15:56:15', 1),
(16, '地士大夫', 25, '2014-12-19 15:57:09', 1, '2014-12-19 15:57:09', 1),
(17, '模压', 1, '2014-12-19 15:58:54', 1, '2014-12-19 15:58:54', 1),
(18, 'test', 25, '2014-12-19 15:59:56', 6, '2014-12-19 15:59:56', 6),
(19, '震夺', 25, '2014-12-19 16:01:50', 1, '2014-12-19 16:01:50', 1),
(20, '你城', 25, '2014-12-19 16:02:14', 1, '2014-12-19 16:02:14', 1),
(21, 'sdsdf', 25, '2014-12-19 16:03:43', 1, '2014-12-19 16:03:43', 1),
(22, '始终显示表单。', 25, '2014-12-19 16:05:24', 1, '2014-12-19 16:05:24', 1),
(23, '士大夫', 25, '2014-12-19 16:05:40', 1, '2014-12-19 16:05:40', 1),
(24, '水豆腐', 25, '2014-12-19 16:05:48', 1, '2014-12-19 16:05:48', 1),
(25, '枯大师傅', 25, '2014-12-19 16:06:05', 1, '2014-12-19 16:06:05', 1),
(26, '今天的测试。', 25, '2014-12-22 16:29:35', 1, '2014-12-22 16:29:35', 1),
(27, '昨天的测试。', 1, '2014-12-22 16:30:05', 1, '2014-12-22 16:30:05', 1),
(28, '一个新评论。', 24, '2014-12-24 17:01:01', 1, '2014-12-24 17:01:01', 1),
(29, '测试rss链接的新评论。', 24, '2014-12-29 15:28:50', 1, '2014-12-29 15:28:50', 1),
(30, '戴尔笔记本', 1, '2007-04-07 05:45:28', 6, '2007-04-07 05:45:28', 6);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_issue`
--

CREATE TABLE IF NOT EXISTS `tbl_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `requester_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_user_id` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `FK_issue_owner` (`owner_id`),
  KEY `FK_issue_requester` (`requester_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=26 ;

--
-- Dumping data for table `tbl_issue`
--

INSERT INTO `tbl_issue` (`id`, `name`, `description`, `project_id`, `type_id`, `status_id`, `owner_id`, `requester_id`, `create_time`, `create_user_id`, `update_time`, `update_user_id`) VALUES
(1, 'issue 1', 'this is issue 13', 1, 1, 0, 1, 2, NULL, NULL, NULL, NULL),
(24, '新问题', '项目2的问题', 2, 0, 0, 1, 1, NULL, NULL, NULL, NULL),
(25, '新问题', 'this is issue', 1, 0, 0, 1, 1, '2014-09-16 16:10:57', 0, '2014-09-16 16:10:57', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project`
--

CREATE TABLE IF NOT EXISTS `tbl_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `name_cn` varchar(128) DEFAULT NULL,
  `description` text,
  `create_time` datetime DEFAULT NULL,
  `create_user_id` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `tbl_project`
--

INSERT INTO `tbl_project` (`id`, `name`, `name_cn`, `description`, `create_time`, `create_user_id`, `update_time`, `update_user_id`) VALUES
(1, 'test project 1', NULL, 'this is a test project.', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(2, 'test project 2', NULL, 'This is a test project 2.', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(3, '测试公共字段自动赋值', NULL, '注意此项目的创建用户和更新用户都是0，在下面的学习中注意此处的变化，这可能不是应该显示的Yii::app()->user->id的值。', '2014-09-16 15:58:20', 0, '2014-09-16 16:03:03', 0),
(4, '新项目', NULL, '这是一个新项目', '2014-10-04 17:26:17', 4, '2014-10-04 17:26:17', 4),
(7, 'new test project', '中文项目名称', '枯', '2015-01-16 05:18:04', 6, '2015-01-16 05:18:04', 6);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project_user_assignment`
--

CREATE TABLE IF NOT EXISTS `tbl_project_user_assignment` (
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_user_id` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`project_id`,`user_id`),
  KEY `FK_user_project` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_project_user_assignment`
--


-- --------------------------------------------------------

--
-- Table structure for table `tbl_project_user_role`
--

CREATE TABLE IF NOT EXISTS `tbl_project_user_role` (
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` varchar(64) NOT NULL,
  PRIMARY KEY (`project_id`,`user_id`,`role`),
  KEY `user_id` (`user_id`),
  KEY `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_project_user_role`
--


-- --------------------------------------------------------

--
-- Table structure for table `tbl_sys_message`
--

CREATE TABLE IF NOT EXISTS `tbl_sys_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_user_id` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tbl_sys_message`
--


-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE IF NOT EXISTS `tbl_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(256) NOT NULL,
  `username` varchar(256) DEFAULT NULL,
  `password` varchar(256) DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_user_id` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`id`, `email`, `username`, `password`, `last_login_time`, `create_time`, `create_user_id`, `update_time`, `update_user_id`) VALUES
(1, 'test1@notanaddress.com', 'Test_User_One', 'a688a47ac73fb58ce3828bcb184cb157', '2015-01-31 05:31:52', NULL, NULL, NULL, NULL),
(2, 'test2@notanaddress.com', 'Test_User_Two', 'ad0234829205b9033196ba818f7a872b', NULL, NULL, NULL, NULL, NULL),
(4, 'help@lsok.net', 'lsokweb', 'a688a47ac73fb58ce3828bcb184cb157', '2014-12-12 15:41:11', '2014-09-17 19:27:00', 0, '2014-09-22 16:45:21', 4),
(5, '615912549@qq.com', 'qaz8555', 'f5d8636de189eba67f39ae19ce76ccb2', '2014-12-12 15:40:20', '2014-09-22 16:44:01', 4, '2014-09-22 16:44:01', 4),
(6, '953195854@qq.com', 'lsok', 'a688a47ac73fb58ce3828bcb184cb157', '2015-01-26 03:36:48', '2014-10-02 18:16:30', 4, '2014-10-02 18:16:30', 4);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authassignment`
--
ALTER TABLE `authassignment`
  ADD CONSTRAINT `authassignment_ibfk_1` FOREIGN KEY (`itemname`) REFERENCES `authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_comment`
--
ALTER TABLE `tbl_comment`
  ADD CONSTRAINT `FK_comment_author` FOREIGN KEY (`create_user_id`) REFERENCES `tbl_user` (`id`),
  ADD CONSTRAINT `FK_comment_issue` FOREIGN KEY (`issue_id`) REFERENCES `tbl_issue` (`id`);

--
-- Constraints for table `tbl_issue`
--
ALTER TABLE `tbl_issue`
  ADD CONSTRAINT `FK_issue_owner` FOREIGN KEY (`owner_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_issue_project` FOREIGN KEY (`project_id`) REFERENCES `tbl_project` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_issue_requester` FOREIGN KEY (`requester_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_project_user_assignment`
--
ALTER TABLE `tbl_project_user_assignment`
  ADD CONSTRAINT `FK_project_user` FOREIGN KEY (`project_id`) REFERENCES `tbl_project` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_user_project` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_project_user_role`
--
ALTER TABLE `tbl_project_user_role`
  ADD CONSTRAINT `tbl_project_user_role_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `tbl_project` (`id`),
  ADD CONSTRAINT `tbl_project_user_role_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`id`),
  ADD CONSTRAINT `tbl_project_user_role_ibfk_3` FOREIGN KEY (`role`) REFERENCES `authitem` (`name`);
