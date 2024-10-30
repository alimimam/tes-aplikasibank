-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2024 at 04:08 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ebanking`
--

-- --------------------------------------------------------

--
-- Table structure for table `m_customer`
--

CREATE TABLE `m_customer` (
  `id` bigint(20) NOT NULL,
  `customer_name` varchar(30) NOT NULL,
  `customer_username` varchar(50) NOT NULL,
  `customer_pin` varchar(200) NOT NULL,
  `customer_phone` varchar(20) DEFAULT NULL,
  `customer_email` varchar(50) DEFAULT NULL,
  `cif_number` varchar(30) DEFAULT NULL,
  `failed_login_attempts` int(11) DEFAULT 0,
  `failed_ib_token_attempts` int(11) DEFAULT 0,
  `failed_mb_token_attempts` int(11) DEFAULT 0,
  `ib_status` varchar(1) DEFAULT NULL,
  `mb_status` varchar(1) DEFAULT NULL,
  `previous_ib_status` varchar(1) DEFAULT NULL,
  `previous_mb_status` varchar(1) DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `last_token_id` varchar(50) DEFAULT NULL,
  `registration_card_number` varchar(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `createdby` int(11) NOT NULL DEFAULT 1,
  `updated` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedby` int(11) NOT NULL DEFAULT 1,
  `m_customer_group_id` int(11) NOT NULL DEFAULT 1,
  `auto_close_date` timestamp NULL DEFAULT NULL,
  `last_link_token` timestamp NULL DEFAULT NULL,
  `user_link_token` varchar(20) DEFAULT NULL,
  `spv_link_token` varchar(20) DEFAULT NULL,
  `token_type` varchar(1) DEFAULT NULL,
  `registration_account_number` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `m_customer`
--

INSERT INTO `m_customer` (`id`, `customer_name`, `customer_username`, `customer_pin`, `customer_phone`, `customer_email`, `cif_number`, `failed_login_attempts`, `failed_ib_token_attempts`, `failed_mb_token_attempts`, `ib_status`, `mb_status`, `previous_ib_status`, `previous_mb_status`, `last_login`, `last_token_id`, `registration_card_number`, `created`, `createdby`, `updated`, `updatedby`, `m_customer_group_id`, `auto_close_date`, `last_link_token`, `user_link_token`, `spv_link_token`, `token_type`, `registration_account_number`) VALUES
(1, 'alfian fathur rahman', 'alfian', '$2y$10$hK8r8Eg1ZehxGJsmkUaS4O/SkXnydFgMx.8NlxlooiPg6gHs2jYY2', '081330445365', 'muhammaderiman@gmail.com', NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-11 06:54:42', 1, '2024-10-11 06:54:42', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'm iqbal hasan', 'iqbal', '$2y$10$g3hdGhE09TsGmvo4JyAbU.7zU1tYiWVr3PnWS/6CuOaadwDqnL.Rm', '0878380083323', 'sotokeju007@gmail.com', NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-28 13:35:42', 1, '2024-10-28 13:35:42', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `m_parameter`
--

CREATE TABLE `m_parameter` (
  `id` bigint(20) NOT NULL,
  `parameter_name` varchar(30) DEFAULT NULL,
  `parameter_value` varchar(200) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `createdby` int(11) NOT NULL DEFAULT 1,
  `updated` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `updatedby` int(11) NOT NULL DEFAULT 1,
  `access_type` int(11) DEFAULT NULL,
  `parameter_value_binary` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `m_portfolio_account`
--

CREATE TABLE `m_portfolio_account` (
  `id` bigint(20) NOT NULL,
  `m_customer_id` int(11) DEFAULT NULL,
  `account_number` varchar(20) DEFAULT NULL,
  `account_status` varchar(1) DEFAULT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `account_type` varchar(10) DEFAULT NULL,
  `product_code` varchar(10) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `branch_code` varchar(10) DEFAULT NULL,
  `plafond` decimal(30,5) DEFAULT NULL,
  `clear_balance` decimal(30,5) DEFAULT NULL,
  `available_balance` decimal(30,5) DEFAULT NULL,
  `confidential` varchar(1) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `createdby` int(11) NOT NULL DEFAULT 1,
  `updated` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedby` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `m_portfolio_account`
--

INSERT INTO `m_portfolio_account` (`id`, `m_customer_id`, `account_number`, `account_status`, `account_name`, `account_type`, `product_code`, `product_name`, `currency_code`, `branch_code`, `plafond`, `clear_balance`, `available_balance`, `confidential`, `created`, `createdby`, `updated`, `updatedby`) VALUES
(1, 1, 'BLA00001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100000.00000, 3550000.00000, NULL, '2024-10-11 06:54:42', 1, '2024-10-11 06:54:42', 1),
(2, 2, 'BLA00002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100000.00000, 7551256.00000, NULL, '2024-10-28 13:35:42', 1, '2024-10-28 13:35:42', 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_transaction`
--

CREATE TABLE `t_transaction` (
  `id` bigint(20) NOT NULL,
  `m_customer_id` int(11) NOT NULL,
  `mti` char(4) DEFAULT NULL,
  `transaction_type` varchar(2) NOT NULL DEFAULT '',
  `card_number` varchar(20) DEFAULT NULL,
  `transaction_amount` decimal(30,5) DEFAULT NULL,
  `fee_indicator` varchar(1) DEFAULT NULL,
  `fee` decimal(30,5) DEFAULT NULL,
  `transmission_date` timestamp NULL DEFAULT NULL,
  `transaction_date` timestamp NULL DEFAULT NULL,
  `value_date` timestamp NULL DEFAULT NULL,
  `conversion_rate` decimal(30,5) DEFAULT NULL,
  `stan` decimal(6,0) DEFAULT NULL,
  `merchant_type` varchar(4) DEFAULT NULL,
  `terminal_id` varchar(8) DEFAULT NULL,
  `reference_number` varchar(12) DEFAULT NULL,
  `approval_number` varchar(12) DEFAULT NULL,
  `response_code` char(2) DEFAULT NULL,
  `currency_code` char(3) DEFAULT NULL,
  `customer_reference` varchar(50) DEFAULT NULL,
  `biller_name` varchar(50) DEFAULT NULL,
  `from_account_number` varchar(20) DEFAULT NULL,
  `to_account_number` varchar(20) DEFAULT NULL,
  `from_account_type` varchar(2) DEFAULT '00',
  `to_account_type` varchar(2) DEFAULT '00',
  `balance` varchar(100) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `to_bank_code` varchar(3) DEFAULT NULL,
  `execution_type` varchar(10) NOT NULL DEFAULT 'N',
  `status` varchar(10) NOT NULL,
  `translation_code` varchar(1000) DEFAULT NULL,
  `free_data1` mediumtext DEFAULT NULL,
  `free_data2` mediumtext DEFAULT NULL,
  `free_data3` varchar(1000) DEFAULT NULL,
  `free_data4` varchar(1000) DEFAULT NULL,
  `free_data5` varchar(1000) DEFAULT NULL,
  `delivery_channel` varchar(10) DEFAULT NULL,
  `delivery_channel_id` varchar(50) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `createdby` int(11) NOT NULL DEFAULT 1,
  `updated` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedby` int(11) NOT NULL DEFAULT 1,
  `archive` tinyint(1) DEFAULT 0,
  `t_transaction_queue_id` int(11) DEFAULT NULL,
  `biller_id` varchar(20) DEFAULT NULL,
  `product_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_transaction`
--

INSERT INTO `t_transaction` (`id`, `m_customer_id`, `mti`, `transaction_type`, `card_number`, `transaction_amount`, `fee_indicator`, `fee`, `transmission_date`, `transaction_date`, `value_date`, `conversion_rate`, `stan`, `merchant_type`, `terminal_id`, `reference_number`, `approval_number`, `response_code`, `currency_code`, `customer_reference`, `biller_name`, `from_account_number`, `to_account_number`, `from_account_type`, `to_account_type`, `balance`, `description`, `to_bank_code`, `execution_type`, `status`, `translation_code`, `free_data1`, `free_data2`, `free_data3`, `free_data4`, `free_data5`, `delivery_channel`, `delivery_channel_id`, `created`, `createdby`, `updated`, `updatedby`, `archive`, `t_transaction_queue_id`, `biller_id`, `product_id`) VALUES
(85, 2, NULL, 'TO', NULL, 10000000.00000, NULL, NULL, NULL, '2024-10-29 14:50:19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SYSTEM', 'BLA00002', '00', '00', NULL, NULL, NULL, 'N', 'success', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-29 14:50:19', 1, '2024-10-29 14:50:19', 1, 0, NULL, NULL, NULL),
(86, 2, NULL, 'TF', NULL, 500000.00000, NULL, NULL, NULL, '2024-10-29 14:50:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'BLA00002', 'BLA00001', '00', '00', NULL, 'Transfer lokal', NULL, 'N', 'SUCCESS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-29 14:50:55', 1, '2024-10-29 14:50:55', 1, 0, NULL, NULL, NULL),
(87, 2, NULL, 'TF', NULL, 500000.00000, NULL, NULL, NULL, '2024-10-29 14:55:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'BLA00002', 'BLA00001', '00', '00', NULL, 'Transfer lokal', NULL, 'N', 'SUCCESS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-29 14:55:32', 1, '2024-10-29 14:55:32', 1, 0, NULL, NULL, NULL),
(88, 2, NULL, 'TF', NULL, 500000.00000, NULL, NULL, NULL, '2024-10-29 14:57:34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'BLA00002', 'BLA00001', '00', '00', NULL, 'Transfer lokal', NULL, 'N', 'SUCCESS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-29 14:57:34', 1, '2024-10-29 14:57:34', 1, 0, NULL, NULL, NULL),
(89, 2, NULL, 'TF', NULL, 500000.00000, NULL, NULL, NULL, '2024-10-29 14:57:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'BLA00002', 'BLA00001', '00', '00', NULL, 'Transfer lokal', NULL, 'N', 'SUCCESS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-29 14:57:40', 1, '2024-10-29 14:57:40', 1, 0, NULL, NULL, NULL),
(90, 2, NULL, 'TF', NULL, 1000000.00000, NULL, NULL, NULL, '2024-10-29 14:59:22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'BLA00002', 'BLA00001', '00', '00', NULL, 'Transfer lokal', NULL, 'N', 'SUCCESS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-29 14:59:22', 1, '2024-10-29 14:59:22', 1, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `t_transaction_data`
--

CREATE TABLE `t_transaction_data` (
  `id` bigint(20) NOT NULL,
  `t_transaction_id` bigint(20) NOT NULL,
  `class_name` varchar(100) DEFAULT NULL,
  `transaction_data` varchar(5000) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `createdby` int(11) NOT NULL DEFAULT 1,
  `updated` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedby` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `m_customer`
--
ALTER TABLE `m_customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `m_parameter`
--
ALTER TABLE `m_parameter`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `m_portfolio_account`
--
ALTER TABLE `m_portfolio_account`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_transaction`
--
ALTER TABLE `t_transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_transaction_data`
--
ALTER TABLE `t_transaction_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_transaction_fk` (`t_transaction_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `m_customer`
--
ALTER TABLE `m_customer`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `m_portfolio_account`
--
ALTER TABLE `m_portfolio_account`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_transaction`
--
ALTER TABLE `t_transaction`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_transaction_data`
--
ALTER TABLE `t_transaction_data`
  ADD CONSTRAINT `t_transaction_fk` FOREIGN KEY (`t_transaction_id`) REFERENCES `t_transaction` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
