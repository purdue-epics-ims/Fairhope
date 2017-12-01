-- phpMyAdmin SQL Dump
-- version 3.3.10.4
-- http://www.phpmyadmin.net
--
-- Host: mysql.ea.fairhopedanville.org
-- Generation Time: Sep 24, 2015 at 09:43 PM
-- Server version: 5.1.56
-- PHP Version: 5.4.42

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `fairhope`
--

-- --------------------------------------------------------

--
-- Table structure for table `ea_appointments`
--

CREATE TABLE IF NOT EXISTS `ea_appointments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `book_datetime` datetime DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `notes` text,
  `hash` text,
  `is_unavailable` tinyint(4) DEFAULT '0',
  `id_users_provider` bigint(20) unsigned DEFAULT NULL,
  `id_users_customer` bigint(20) unsigned DEFAULT NULL,
  `id_services` bigint(20) unsigned DEFAULT NULL,
  `id_google_calendar` text,
  `referring_agency` text NOT NULL,
  `contact_person` text NOT NULL,
  `layette` varchar(256) NOT NULL,
  `backpack_qty` int(20) NOT NULL,
  `no_show_flag` tinyint(1) NOT NULL,
  `reschedule` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_users_customer` (`id_users_customer`),
  KEY `id_services` (`id_services`),
  KEY `id_users_provider` (`id_users_provider`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=55 ;

--
-- Dumping data for table `ea_appointments`
--

INSERT INTO `ea_appointments` (`id`, `book_datetime`, `start_datetime`, `end_datetime`, `notes`, `hash`, `is_unavailable`, `id_users_provider`, `id_users_customer`, `id_services`, `id_google_calendar`, `referring_agency`, `contact_person`, `layette`, `backpack_qty`, `no_show_flag`, `reschedule`) VALUES
(38, '2015-04-30 08:12:50', '2015-05-04 10:00:00', '2015-05-04 10:30:00', 'clothing, layette g, Pnp', '51aaf8a2d4b87d3324d8681a50ee7752', 0, 85, 95, 1, NULL, '', '', '', 0, 0, 0),
(39, '2015-04-30 08:19:11', '2015-04-20 10:00:00', '2015-04-20 10:30:00', 'clothing layette g pnp', '6604deff78779146e16388aa87ced285', 0, 85, 96, 1, NULL, '', '', '', 0, 0, 0),
(40, '2015-04-30 08:21:06', '2015-04-20 10:30:00', '2015-04-20 11:00:00', 'clothing', 'da7da07a0d6a7844a0bb1b40af2cb8f6', 0, 85, 97, 1, NULL, '', '', '', 0, 0, 0),
(41, '2015-04-30 08:51:06', '2015-04-20 11:00:00', '2015-04-20 11:30:00', '', '67748be8505ebebd5bd61326a49301d3', 0, 85, 98, 1, NULL, '', '', '', 0, 0, 0),
(42, '2015-04-30 08:51:41', '2015-04-20 11:00:00', '2015-04-20 11:30:00', '', 'cbc1318389e41ee569d496dd7955e4b1', 0, 85, 99, 1, NULL, '', '', '', 0, 0, 0),
(43, '2015-04-30 08:51:59', '2015-04-20 11:30:00', '2015-04-20 12:00:00', '', '7e9eb281e70415b143676da3d125134a', 0, 85, 100, 1, NULL, '', '', '', 0, 0, 0),
(44, '2015-04-30 08:52:17', '2015-04-20 12:00:00', '2015-04-20 12:30:00', '', 'e4a73f88a993f07f38668c6a680aff7e', 0, 85, 101, 1, NULL, '', '', '', 0, 0, 0),
(45, '2015-04-30 08:52:58', '2015-04-20 13:00:00', '2015-04-20 13:30:00', '', '851e3b171d02aa2947b5eb01e70a9203', 0, 85, 102, 1, NULL, '', '', '', 0, 0, 0),
(46, '2015-04-30 08:53:19', '2015-04-20 15:00:00', '2015-04-20 15:30:00', '', 'a0578702a1870c283d03baf616f05056', 0, 85, 103, 1, NULL, '', '', '', 0, 0, 0),
(47, '2015-04-30 08:53:57', '2015-04-20 15:30:00', '2015-04-20 16:00:00', '', 'ab79c6285042d63b54cd15c785662497', 0, 85, 104, 1, NULL, '', '', '', 0, 0, 0),
(48, '2015-04-30 08:54:50', '2015-04-23 10:30:00', '2015-04-23 11:00:00', '', '1e594e428b3ab7aaeba9b129ba77d691', 0, 85, 109, 1, NULL, '', '', '', 0, 0, 0),
(49, '2015-04-30 08:55:11', '2015-04-23 11:00:00', '2015-04-23 11:30:00', '', '91937f673c8f8cd2a5451649db0e335c', 0, 85, 105, 1, NULL, '', '', '', 0, 0, 0),
(50, '2015-04-30 08:55:41', '2015-04-27 10:00:00', '2015-04-27 10:30:00', '', '37f92d59061329a7ff304f1464f326a8', 0, 85, 106, 1, NULL, '', '', '', 0, 0, 0),
(51, '2015-04-30 08:56:14', '2015-04-27 11:30:00', '2015-04-27 12:00:00', '', 'a86192b879bfcf2967299184bd0520d1', 0, 85, 107, 1, NULL, '', '', '', 0, 0, 0),
(52, '2015-04-30 08:57:00', '2015-04-30 10:30:00', '2015-04-30 11:00:00', '', '84d746a6460c6552ed4722c355f37476', 0, 85, 108, 1, NULL, '', '', '', 0, 0, 0),
(53, '2015-05-21 14:13:50', '2015-05-21 10:00:00', '2015-05-21 10:30:00', '', '9fe4835ed16533e10ca498a97d8a6821', 0, 85, 95, 1, NULL, '', '', '', 0, 0, 0),
(54, '2015-05-27 18:33:21', '2015-05-28 10:00:00', '2015-05-28 10:30:00', 'Referred by: District 118 - Sandy', 'b5641fc34cdd0b7420d5c7cb620db2e1', 0, 85, 111, 1, NULL, '', '', '1', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ea_roles`
--

CREATE TABLE IF NOT EXISTS `ea_roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `slug` varchar(256) DEFAULT NULL,
  `is_admin` tinyint(4) DEFAULT NULL COMMENT '0',
  `appointments` int(4) DEFAULT NULL COMMENT '0',
  `customers` int(4) DEFAULT NULL COMMENT '0',
  `services` int(4) DEFAULT NULL COMMENT '0',
  `users` int(4) DEFAULT NULL COMMENT '0',
  `system_settings` int(4) DEFAULT NULL COMMENT '0',
  `user_settings` int(11) DEFAULT NULL,
  `report` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `ea_roles`
--

INSERT INTO `ea_roles` (`id`, `name`, `slug`, `is_admin`, `appointments`, `customers`, `services`, `users`, `system_settings`, `user_settings`, `report`) VALUES
(1, 'Administrator', 'admin', 1, 15, 15, 15, 15, 15, 15, 15),
(2, 'Provider', 'provider', 0, 15, 15, 0, 0, 0, 15, 15),
(3, 'Customer', 'customer', 0, 0, 0, 0, 0, 0, 0, 0),
(4, 'Secretary', 'secretary', 0, 15, 15, 0, 0, 0, 15, 15);

-- --------------------------------------------------------

--
-- Table structure for table `ea_secretaries_providers`
--

CREATE TABLE IF NOT EXISTS `ea_secretaries_providers` (
  `id_users_secretary` bigint(20) unsigned NOT NULL,
  `id_users_provider` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id_users_secretary`,`id_users_provider`),
  KEY `fk_ea_secretaries_providers_1` (`id_users_secretary`),
  KEY `fk_ea_secretaries_providers_2` (`id_users_provider`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ea_secretaries_providers`
--


-- --------------------------------------------------------

--
-- Table structure for table `ea_services`
--

CREATE TABLE IF NOT EXISTS `ea_services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `currency` varchar(32) DEFAULT NULL,
  `description` text,
  `id_service_categories` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_service_categories` (`id_service_categories`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ea_services`
--

INSERT INTO `ea_services` (`id`, `name`, `duration`, `price`, `currency`, `description`, `id_service_categories`) VALUES
(1, 'General Appointment', 30, 0.00, '', '', NULL),
(2, 'Special Appointment', 20, 0.00, '', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ea_services_providers`
--

CREATE TABLE IF NOT EXISTS `ea_services_providers` (
  `id_users` bigint(20) unsigned NOT NULL,
  `id_services` bigint(20) unsigned NOT NULL,
  `max_noshow_num` bigint(20) NOT NULL,
  `no_show_count_period` bigint(20) NOT NULL,
  PRIMARY KEY (`id_users`,`id_services`),
  KEY `id_services` (`id_services`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ea_services_providers`
--

INSERT INTO `ea_services_providers` (`id_users`, `id_services`, `max_noshow_num`, `no_show_count_period`) VALUES
(85, 1, 2, 90),
(85, 2, 2, 80);

-- --------------------------------------------------------

--
-- Table structure for table `ea_service_categories`
--

CREATE TABLE IF NOT EXISTS `ea_service_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ea_service_categories`
--


-- --------------------------------------------------------

--
-- Table structure for table `ea_settings`
--

CREATE TABLE IF NOT EXISTS `ea_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(512) DEFAULT NULL,
  `value` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `ea_settings`
--

INSERT INTO `ea_settings` (`id`, `name`, `value`) VALUES
(16, 'company_working_plan', '{"monday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"tuesday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"wednesday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"thursday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"friday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"saturday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"sunday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]}}'),
(17, 'book_advance_timeout', '30'),
(18, 'company_name', 'Fair Hope Children''s Ministry'),
(19, 'company_email', 'fairhope@aharonhannan.com'),
(20, 'company_link', 'http://google.com');

-- --------------------------------------------------------

--
-- Table structure for table `ea_users`
--

CREATE TABLE IF NOT EXISTS `ea_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(256) DEFAULT NULL,
  `last_name` varchar(512) DEFAULT NULL,
  `dob` varchar(64) DEFAULT NULL,
  `email` varchar(512) DEFAULT NULL,
  `mobile_number` varchar(128) DEFAULT NULL,
  `phone_number` varchar(128) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `city` varchar(256) DEFAULT NULL,
  `state` varchar(128) DEFAULT NULL,
  `zip_code` varchar(64) DEFAULT NULL,
  `notes` text,
  `id_roles` bigint(20) unsigned NOT NULL,
  `num_of_children` bigint(20) NOT NULL,
  `num_noshow` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_roles` (`id_roles`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=114 ;

--
-- Dumping data for table `ea_users`
--

INSERT INTO `ea_users` (`id`, `first_name`, `last_name`, `dob`, `email`, `mobile_number`, `phone_number`, `address`, `city`, `state`, `zip_code`, `notes`, `id_roles`, `num_of_children`, `num_noshow`) VALUES
(84, 'Aharon', 'Hannan', '0000-00-00', 'aharon@aharonhannan.com', '', '3179975275', '', '', '', '', '', 1, 0, 0),
(85, 'Fair Hope', 'Children''s Ministry', '0000-00-00', 'null@null.com', '', '1234567890', '', '', '', '', '', 2, 0, 0),
(95, 'Amanda', 'Grupe', '01/01/1991', 'kcl@g.com', NULL, NULL, NULL, NULL, NULL, NULL, 'clothing, layette g, Pnp', 3, 2, 0),
(96, 'Michelle', 'Rodgers', '01/01/01', 'null2@null.com', NULL, NULL, NULL, NULL, NULL, NULL, '', 3, 6, 0),
(97, 'Tamari', 'Red', '01/01/01', 'null3@null.com', NULL, NULL, NULL, NULL, NULL, NULL, '', 3, 4, 0),
(98, 'Ariel', 'Henderson', '01/01/01', 'null4@null.com', NULL, '0000000000', NULL, NULL, NULL, NULL, '', 3, 1, 0),
(99, 'Darla', 'Knipe', '01/01/01', 'null5@null.com', NULL, '123', NULL, NULL, NULL, NULL, '', 3, 4, 0),
(100, 'Jessica', 'Flowers', '01/01/01', 'null6@null.com', NULL, '0', NULL, NULL, NULL, NULL, '', 3, 0, 0),
(101, 'Tabitha', 'Corbin', '01/01/01', 'n@null.com', NULL, '0', NULL, NULL, NULL, NULL, '', 3, 1, 0),
(102, 'Victoria', 'Quinn', '01/01/01', 'null8@null.com', NULL, '0', NULL, NULL, NULL, NULL, '', 3, 1, 0),
(103, 'Carianne', 'Lorenz', '01/01/01', 'null98@null.com', NULL, '0', NULL, NULL, NULL, NULL, '', 3, 0, 0),
(104, 'Deborah', 'McDonald', '01/01/01', 'null12@null.com', NULL, '0', NULL, NULL, NULL, NULL, '', 3, 1, 0),
(105, 'Angela', 'Guerrero', '01/01/01', 'null84@null.com', NULL, '0', NULL, NULL, NULL, NULL, '', 3, 4, 0),
(106, 'Amber', 'James', '01/01/01', 'null9@null.com', NULL, '0', NULL, NULL, NULL, NULL, '', 3, 3, 0),
(107, 'Hope', 'Ott', '01/01/01', 'null91@null.com', NULL, '0', NULL, NULL, NULL, NULL, '', 3, 1, 0),
(108, 'Debrisha', 'Herring', '01/01/01', 'null23@null.com', NULL, '2', NULL, NULL, NULL, NULL, '', 3, 2, 0),
(109, 'Robin', 'McDonald', '01/01/01', 'null914@null.com', NULL, NULL, NULL, NULL, NULL, NULL, '', 3, 2, 0),
(110, 'Roberta', 'Williams', NULL, 'roberta.williams@comcast.net', '', '(217) 474-1357', '', '', '', '', '', 1, 0, 0),
(111, 'Amanda  ', 'Grupe', ' ', 'roberta.williams@comcast.net', NULL, NULL, NULL, NULL, NULL, NULL, 'Clothing, Layette - Girl, PNP', 3, 1, 0),
(112, 'Stephen', 'Wierzbowski', NULL, 'swierzbo@purdue.edu', '', '2604467028', '', '', '', '', '', 1, 0, 0),
(113, 'Admin', 'User', NULL, 'gmcfall@purdue.edu', '', '0000000000', '', '', '', '', '', 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ea_user_settings`
--

CREATE TABLE IF NOT EXISTS `ea_user_settings` (
  `id_users` bigint(20) unsigned NOT NULL,
  `username` varchar(256) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `salt` varchar(512) DEFAULT NULL,
  `working_plan` text,
  `notifications` tinyint(4) DEFAULT '0',
  `google_sync` tinyint(4) DEFAULT '0',
  `google_token` text,
  `google_calendar` varchar(128) DEFAULT NULL,
  `sync_past_days` int(11) DEFAULT '5',
  `sync_future_days` int(11) DEFAULT '5',
  PRIMARY KEY (`id_users`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ea_user_settings`
--

INSERT INTO `ea_user_settings` (`id_users`, `username`, `password`, `salt`, `working_plan`, `notifications`, `google_sync`, `google_token`, `google_calendar`, `sync_past_days`, `sync_future_days`) VALUES
(84, 'ahannan', '60d5411304a1f7e6794bb48b55b64f7842b052107896138967e0f34164c66bec', '7b2c3b691c565fa1369d21c016d787516e4111914824539559785449355e54b1', '{"monday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"tuesday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"wednesday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"thursday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"friday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"saturday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"sunday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]}}', 0, 0, NULL, NULL, 5, 5),
(85, 'default', 'd9756e2f6926bd95020beae75078add39e307e86396ea9dfa1a6d3acb7d68467', 'd1f8026dab9fd09748d6b072234a9a112206d117fd34ce992ac8933b966ce5ce', '{"monday":{"start":"05:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"tuesday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"wednesday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"thursday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"friday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"saturday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"sunday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]}}', 0, 0, NULL, NULL, 5, 5),
(110, 'roberta', '45bd800ec89ff152e7da7b4821be85431296b72c3367e40bab94d2e061ae7ab5', '593a84410099370e43eec2fc8fa2c40d67723211745cd50bd7b1823162cc3f33', NULL, 0, 0, NULL, NULL, 5, 5),
(112, 'swierzbo', '4b18c6b9db151e8ad04eba3d7f06dcf741acc3748d2f2e9018381d43a77908c3', 'e498cce83f118cd0550211f4c2fdf2d0fc88d510522b72dd94b4fdeac3949487', NULL, 0, 0, NULL, NULL, 5, 5),
(113, 'admin', '5553d6a10969e3871d3f60f7a0e399d57afd14636f536b6c49c476ba3755998e', '6f056bb1f3a98580dbe1b783e37dd82b2ae9b93763891c7219add80cae981248', NULL, 0, 0, NULL, NULL, 5, 5);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ea_appointments`
--
ALTER TABLE `ea_appointments`
  ADD CONSTRAINT `ea_appointments_ibfk_2` FOREIGN KEY (`id_users_customer`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ea_appointments_ibfk_3` FOREIGN KEY (`id_services`) REFERENCES `ea_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ea_appointments_ibfk_4` FOREIGN KEY (`id_users_provider`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ea_secretaries_providers`
--
ALTER TABLE `ea_secretaries_providers`
  ADD CONSTRAINT `fk_ea_secretaries_providers_1` FOREIGN KEY (`id_users_secretary`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ea_secretaries_providers_2` FOREIGN KEY (`id_users_provider`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ea_services`
--
ALTER TABLE `ea_services`
  ADD CONSTRAINT `ea_services_ibfk_1` FOREIGN KEY (`id_service_categories`) REFERENCES `ea_service_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `ea_services_providers`
--
ALTER TABLE `ea_services_providers`
  ADD CONSTRAINT `ea_services_providers_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ea_services_providers_ibfk_2` FOREIGN KEY (`id_services`) REFERENCES `ea_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ea_users`
--
ALTER TABLE `ea_users`
  ADD CONSTRAINT `ea_users_ibfk_1` FOREIGN KEY (`id_roles`) REFERENCES `ea_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ea_user_settings`
--
ALTER TABLE `ea_user_settings`
  ADD CONSTRAINT `ea_user_settings_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
