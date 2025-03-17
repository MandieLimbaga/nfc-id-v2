-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 17, 2025 at 07:40 AM
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
-- Database: `nfc_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `nfcdata`
--

CREATE TABLE `nfcdata` (
  `email` varchar(60) NOT NULL,
  `lastname` text NOT NULL,
  `firstname` text NOT NULL,
  `lrn` bigint(12) NOT NULL,
  `gradeSection` varchar(20) NOT NULL,
  `adviser` text NOT NULL,
  `nfcCardKey` bigint(10) NOT NULL,
  `date_upload` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_img` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nfcdata`
--

INSERT INTO `nfcdata` (`email`, `lastname`, `firstname`, `lrn`, `gradeSection`, `adviser`, `nfcCardKey`, `date_upload`, `user_img`) VALUES
('mandie121605@gmail.com', 'Limbaga', 'Mandie', 136546120514, '12 - Babbage', 'Gina Balajoro', 3872185060, '2025-03-12 12:27:03', ''),
('yoshikagek304@gmail.com', 'Somera', 'Carl', 1356546120514, '12 - Babbage', 'Raymond Cruz', 3872341572, '2025-03-10 01:08:18', 0x433a5c66616b65706174685c4d414e444945204d2e204c494d42414741202831292e706e67);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `nfcdata`
--
ALTER TABLE `nfcdata`
  ADD PRIMARY KEY (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
