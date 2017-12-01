-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2016 at 06:08 AM
-- Server version: 10.1.9-MariaDB
-- PHP Version: 5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fairhope`
--

-- --------------------------------------------------------

--
-- Table structure for table `ea_appointments`
--

CREATE TABLE `ea_appointments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `book_datetime` datetime DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `notes` text,
  `hash` text,
  `is_unavailable` tinyint(4) DEFAULT '0',
  `id_users_provider` bigint(20) UNSIGNED DEFAULT NULL,
  `id_users_customer` bigint(20) UNSIGNED DEFAULT NULL,
  `id_services` bigint(20) UNSIGNED DEFAULT NULL,
  `id_google_calendar` text,
  `layette_boy` int(11) NOT NULL DEFAULT '0',
  `layette_girl` int(11) NOT NULL DEFAULT '0',
  `backpack_qty` int(20) NOT NULL,
  `pnp_qty` int(11) NOT NULL DEFAULT '0',
  `no_show_flag` tinyint(1) NOT NULL,
  `reschedule` tinyint(1) NOT NULL,
  `id_referrer` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ea_appointments`
--

INSERT INTO `ea_appointments` (`id`, `book_datetime`, `start_datetime`, `end_datetime`, `notes`, `hash`, `is_unavailable`, `id_users_provider`, `id_users_customer`, `id_services`, `id_google_calendar`, `layette_boy`, `layette_girl`, `backpack_qty`, `pnp_qty`, `no_show_flag`, `reschedule`, `id_referrer`) VALUES
(104, '2016-03-18 04:27:58', '2016-03-19 09:00:00', '2016-03-19 09:30:00', 'Client02 appointment notes', 'bb69c948d8088c7a6fd64b5ffe87a70b', 0, 123, 161, 3, NULL, 1, 1, 1, 0, 0, 0, 53),
(105, '2016-03-18 04:28:50', '2016-03-19 10:00:00', '2016-03-19 10:30:00', 'Notes for client03 appointment', '4fc376697238d5ffcfe536428f043027', 0, 123, 162, 3, NULL, 1, 0, 0, 1, 0, 0, 54),
(106, '2016-03-18 04:30:48', '2016-03-18 11:00:00', '2016-03-18 11:30:00', '', 'b85fbef4a110c739323216df199a9932', 0, 123, 163, 10, NULL, 1, 1, 1, 1, 0, 0, 55),
(107, '2016-03-18 04:31:31', '2016-03-18 11:00:00', '2016-03-18 11:30:00', '', 'c1eace2e880673c1a7a73d1826786940', 0, 123, 164, 9, NULL, 0, 1, 0, 1, 0, 0, 53),
(108, '2016-03-18 05:17:09', '2016-03-18 09:00:00', '2016-03-18 09:30:00', '', 'e062a8adb02193c179a38e16f4091536', 0, 123, 162, 3, NULL, 1, 1, 1, 1, 0, 0, 53),
(109, '2016-03-18 05:18:06', '2016-03-17 09:00:00', '2016-03-17 09:30:00', '', '4f00556a2afe88c97a878913868cbdbd', 0, 123, 160, 3, NULL, 0, 0, 0, 0, 0, 0, 52),
(110, '2016-03-18 05:18:54', '2016-03-19 11:00:00', '2016-03-19 11:30:00', '', '47afdbb709e6825933fa73ce929243a8', 0, 123, 160, 3, NULL, 0, 0, 0, 0, 0, 0, 53),
(111, '2016-03-18 05:19:18', '2016-03-17 11:00:00', '2016-03-17 11:30:00', '', '1f5222feadc2a6c3cd23f22820ce41dc', 0, 123, 161, 3, NULL, 0, 0, 0, 0, 0, 0, 53),
(112, '2016-03-18 05:20:34', '2016-03-19 09:30:00', '2016-03-19 10:00:00', '', '95747c36d7c8a71a2f78317e009a7329', 0, 123, 161, 3, NULL, 0, 0, 0, 0, 0, 0, 54),
(113, '2016-03-18 05:25:52', '2016-03-18 09:30:00', '2016-03-18 10:00:00', '', 'f08824e080d1f6513beb1715d262a360', 0, 123, 165, 3, NULL, 0, 0, 0, 0, 0, 0, 55);

-- --------------------------------------------------------

--
-- Table structure for table `ea_roles`
--

CREATE TABLE `ea_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `slug` varchar(256) DEFAULT NULL,
  `is_admin` tinyint(4) DEFAULT NULL COMMENT '0',
  `appointments` int(4) DEFAULT NULL COMMENT '0',
  `customers` int(4) DEFAULT NULL COMMENT '0',
  `services` int(4) DEFAULT NULL COMMENT '0',
  `users` int(4) DEFAULT NULL COMMENT '0',
  `system_settings` int(4) DEFAULT NULL COMMENT '0',
  `user_settings` int(11) DEFAULT NULL,
  `report` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `ea_secretaries_providers` (
  `id_users_secretary` bigint(20) UNSIGNED NOT NULL,
  `id_users_provider` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ea_services`
--

CREATE TABLE `ea_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `currency` varchar(32) DEFAULT NULL,
  `description` text,
  `id_service_categories` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ea_services`
--

INSERT INTO `ea_services` (`id`, `name`, `duration`, `price`, `currency`, `description`, `id_service_categories`) VALUES
(3, 'Clothing', 30, '0.00', '0', '', NULL),
(4, 'Clothing, PNP', 30, '0.00', '', '', NULL),
(5, 'Clothing, Layette B', 30, '0.00', '', '', NULL),
(7, 'Clothing, Layette G', 30, '0.00', '', '', NULL),
(8, 'Clothing, Layette B, PNP', 30, '0.00', '', '', NULL),
(9, 'Clothing, Layette G, PNP', 30, '0.00', '', '', NULL),
(10, 'Maternity Clothing', 30, '0.00', '', '', NULL),
(11, 'Others', 30, '0.00', '', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ea_services_providers`
--

CREATE TABLE `ea_services_providers` (
  `id_users` bigint(20) UNSIGNED NOT NULL,
  `id_services` bigint(20) UNSIGNED NOT NULL,
  `max_noshow_num` bigint(20) NOT NULL,
  `no_show_count_period` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ea_services_providers`
--

INSERT INTO `ea_services_providers` (`id_users`, `id_services`, `max_noshow_num`, `no_show_count_period`) VALUES
(123, 3, 1, 1),
(123, 4, 1, 1),
(123, 5, 1, 1),
(123, 7, 1, 1),
(123, 8, 1, 1),
(123, 9, 1, 1),
(123, 10, 1, 1),
(123, 11, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ea_service_categories`
--

CREATE TABLE `ea_service_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ea_settings`
--

CREATE TABLE `ea_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(512) DEFAULT NULL,
  `value` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `ea_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
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
  `id_roles` bigint(20) UNSIGNED NOT NULL,
  `num_of_children` bigint(20) NOT NULL,
  `num_noshow` bigint(20) NOT NULL,
  `id_referrer` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ea_users`
--

INSERT INTO `ea_users` (`id`, `first_name`, `last_name`, `dob`, `email`, `mobile_number`, `phone_number`, `address`, `city`, `state`, `zip_code`, `notes`, `id_roles`, `num_of_children`, `num_noshow`, `id_referrer`) VALUES
(84, 'Aharon', 'Hannan', '0000-00-00', 'aharon@aharonhannan.com', '', '3179975275', '', '', '', '', '', 1, 0, 0, NULL),
(110, 'Roberta', 'Williams', NULL, 'roberta.williams@comcast.net', '', '(217) 474-1357', '', '', '', '', '', 1, 0, 0, NULL),
(112, 'Stephen', 'Wierzbowski', NULL, 'swierzbo@purdue.edu', '', '2604467028', '', '', '', '', '', 1, 0, 0, NULL),
(113, 'Admin', 'User', NULL, 'gmcfall@purdue.edu', '', '0000000000', '', '', '', '', '', 1, 0, 0, NULL),
(114, 'tseqin', 'siah', NULL, 'tsiah@purdue.edu', '', '7654095113', '', '', '', '', '', 1, 0, 0, NULL),
(123, 'Fair Hope', 'Children''s Ministry', NULL, 'abc@abc.com', '', '23', '', '', '', '', '', 2, 0, 0, NULL),
(160, 'Client01', 'a_client', '11/11/1111', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Client 1 notes', 3, 2, 0, 53),
(161, 'Client02', 'b_client', '11/11/1111', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Client2 notes', 3, 1, 0, 54),
(162, 'Client03', 'c_client', '11/11/1111', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'client3 notes', 3, 1, 0, 53),
(163, 'Client04', 'd_client', '11/11/1111', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 3, 0, 0, 55),
(164, 'Client05', 'e_client', '11/11/1111', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 3, 2, 0, 53),
(165, 'Client06', 'a_client', '11/11/1111', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 3, 1, 0, 55);

-- --------------------------------------------------------

--
-- Table structure for table `ea_user_settings`
--

CREATE TABLE `ea_user_settings` (
  `id_users` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(256) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `salt` varchar(512) DEFAULT NULL,
  `working_plan` text,
  `notifications` tinyint(4) DEFAULT '0',
  `google_sync` tinyint(4) DEFAULT '0',
  `google_token` text,
  `google_calendar` varchar(128) DEFAULT NULL,
  `sync_past_days` int(11) DEFAULT '5',
  `sync_future_days` int(11) DEFAULT '5'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ea_user_settings`
--

INSERT INTO `ea_user_settings` (`id_users`, `username`, `password`, `salt`, `working_plan`, `notifications`, `google_sync`, `google_token`, `google_calendar`, `sync_past_days`, `sync_future_days`) VALUES
(84, 'ahannan', '60d5411304a1f7e6794bb48b55b64f7842b052107896138967e0f34164c66bec', '7b2c3b691c565fa1369d21c016d787516e4111914824539559785449355e54b1', '{"monday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"tuesday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"wednesday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"thursday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"friday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"saturday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]},"sunday":{"start":"09:00","end":"18:00","breaks":[{"start":"11:20","end":"11:30"},{"start":"14:30","end":"15:00"}]}}', 0, 0, NULL, NULL, 5, 5),
(110, 'roberta', '45bd800ec89ff152e7da7b4821be85431296b72c3367e40bab94d2e061ae7ab5', '593a84410099370e43eec2fc8fa2c40d67723211745cd50bd7b1823162cc3f33', NULL, 0, 0, NULL, NULL, 5, 5),
(112, 'swierzbo', '4b18c6b9db151e8ad04eba3d7f06dcf741acc3748d2f2e9018381d43a77908c3', 'e498cce83f118cd0550211f4c2fdf2d0fc88d510522b72dd94b4fdeac3949487', NULL, 0, 0, NULL, NULL, 5, 5),
(113, 'admin', '5553d6a10969e3871d3f60f7a0e399d57afd14636f536b6c49c476ba3755998e', '6f056bb1f3a98580dbe1b783e37dd82b2ae9b93763891c7219add80cae981248', NULL, 0, 0, NULL, NULL, 5, 5),
(114, 'tsiah', 'be0ca23ab454aac329f18f7af32475b611bdcf8951211679d8f18aade8e697bf', '1b0c44aac5fb9dbe9ec3670d6ad198c041eb3ce1618890b0c97f8399110cfedc', NULL, 0, 0, NULL, NULL, 5, 5),
(123, 'provider1', '19519a9a2cf846de6775cff9f79fcfb9e81bb0e5afc1fab6426070fc7042a6b1', '7b2a732e98dc31ae7fa60687b06bbb6c80ca8e63ce59f8edff19a6271bf45249', '{"monday":{"start":"09:00","end":"18:00","breaks":[]},"tuesday":{"start":"09:00","end":"18:00","breaks":[]},"wednesday":{"start":"09:00","end":"18:00","breaks":[]},"thursday":{"start":"09:00","end":"18:00","breaks":[]},"friday":{"start":"09:00","end":"18:00","breaks":[]},"saturday":{"start":"09:00","end":"18:00","breaks":[]},"sunday":{"start":"09:00","end":"18:00","breaks":[]}}', 0, 0, NULL, NULL, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `fairhope_referrers`
--

CREATE TABLE `fairhope_referrers` (
  `id_referrer` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(256) NOT NULL,
  `agency` varchar(128) NOT NULL,
  `phone_number` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `notes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fairhope_referrers`
--

INSERT INTO `fairhope_referrers` (`id_referrer`, `name`, `agency`, `phone_number`, `email`, `notes`) VALUES
(52, 'Referrer01', 'Agency01', '', '', ''),
(53, 'Referrer02', 'Agency02', '', '', ''),
(54, 'Referrer03', 'Agency03', '', '', ''),
(55, 'Referrer04', 'Agency04', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ea_appointments`
--
ALTER TABLE `ea_appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_users_customer` (`id_users_customer`),
  ADD KEY `id_services` (`id_services`),
  ADD KEY `id_users_provider` (`id_users_provider`);

--
-- Indexes for table `ea_roles`
--
ALTER TABLE `ea_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ea_secretaries_providers`
--
ALTER TABLE `ea_secretaries_providers`
  ADD PRIMARY KEY (`id_users_secretary`,`id_users_provider`),
  ADD KEY `fk_ea_secretaries_providers_1` (`id_users_secretary`),
  ADD KEY `fk_ea_secretaries_providers_2` (`id_users_provider`);

--
-- Indexes for table `ea_services`
--
ALTER TABLE `ea_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_service_categories` (`id_service_categories`);

--
-- Indexes for table `ea_services_providers`
--
ALTER TABLE `ea_services_providers`
  ADD PRIMARY KEY (`id_users`,`id_services`),
  ADD KEY `id_services` (`id_services`);

--
-- Indexes for table `ea_service_categories`
--
ALTER TABLE `ea_service_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ea_settings`
--
ALTER TABLE `ea_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ea_users`
--
ALTER TABLE `ea_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_roles` (`id_roles`),
  ADD KEY `id_referrer` (`id_referrer`);

--
-- Indexes for table `ea_user_settings`
--
ALTER TABLE `ea_user_settings`
  ADD PRIMARY KEY (`id_users`);

--
-- Indexes for table `fairhope_referrers`
--
ALTER TABLE `fairhope_referrers`
  ADD PRIMARY KEY (`id_referrer`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ea_appointments`
--
ALTER TABLE `ea_appointments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;
--
-- AUTO_INCREMENT for table `ea_roles`
--
ALTER TABLE `ea_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `ea_services`
--
ALTER TABLE `ea_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `ea_service_categories`
--
ALTER TABLE `ea_service_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ea_settings`
--
ALTER TABLE `ea_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `ea_users`
--
ALTER TABLE `ea_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=166;
--
-- AUTO_INCREMENT for table `fairhope_referrers`
--
ALTER TABLE `fairhope_referrers`
  MODIFY `id_referrer` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;
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
  ADD CONSTRAINT `ea_users_ibfk_1` FOREIGN KEY (`id_roles`) REFERENCES `ea_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ea_users_ref_fk` FOREIGN KEY (`id_referrer`) REFERENCES `fairhope_referrers` (`id_referrer`) ON UPDATE CASCADE;

--
-- Constraints for table `ea_user_settings`
--
ALTER TABLE `ea_user_settings`
  ADD CONSTRAINT `ea_user_settings_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
