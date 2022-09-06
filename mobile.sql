-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 05, 2022 at 06:28 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobile`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addmobile` (IN `id` INT, IN `name` VARCHAR(30), IN `description` VARCHAR(30), IN `price` BIGINT, IN `model` VARCHAR(30))   BEGIN
INSERT INTO details(id, name, description, price, model)VALUES(id, name, description, price, model);
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor` ()   BEGIN
    DECLARE mname,mmodel Text;
    DECLARE exit_loop BOOlEAN DEFAULT FALSE;
    DECLARE mob_cursor CURSOR FOR SELECT name, model FROM details;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    OPEN mob_cursor;
    mob_loop: LOOP
         FETCH FROM mob_cursor INTO mname,mmodel;
         IF exit_loop THEN 
             LEAVE mob_loop;
         END IF;
         IF mmodel = "Redmi" THEN
             SELECT mname;
         END IF;
     END LOOP mob_loop;
     CLOSE mob_cursor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletemobile` (IN `mid` INT)   BEGIN
DELETE FROM details WHERE id=mid;
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showmobile` (OUT `mid` INT, OUT `mname` INT, OUT `mdescription` INT, OUT `mprice` INT, OUT `mmodel` INT)   BEGIN
SELECT * FROM details;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatemobile` (IN `mid` INT, IN `mname` VARCHAR(30), IN `mdescription` VARCHAR(30), IN `mprice` BIGINT, IN `mmodel` VARCHAR(30))   BEGIN
UPDATE details SET id=mid, name=mname, description=mdescription, price=mprice, model=mmodel WHERE id=mid;
COMMIT;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `count` () RETURNS INT(11)  RETURN(SELECT COUNT(*) AS HII FROM details)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `details`
--

CREATE TABLE `details` (
  `id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `description` varchar(30) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `model` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `details`
--

INSERT INTO `details` (`id`, `name`, `description`, `price`, `model`) VALUES
(123, 'Redmi Note 10 T', '8 GB RAM 256 GB ROM', 19999, 'Redmi'),
(124, 'Redmi 9 Prime', '4GB RAM 64 GB ROM', 9999, 'Redmi'),
(125, 'iPhone 13 Pro Max', '4GB 1TB ROM', 159999, 'Apple'),
(126, 'iPhone 12', '4GB 1TB ROM', 99999, 'Apple');

--
-- Triggers `details`
--
DELIMITER $$
CREATE TRIGGER `delete` AFTER DELETE ON `details` FOR EACH ROW BEGIN
INSERT INTO trig VALUES(NULL, OLD.id, 'deleted', now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert` BEFORE INSERT ON `details` FOR EACH ROW BEGIN
INSERT INTO trig VALUES(NULL, NEW.id, 'inserted', now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update` AFTER UPDATE ON `details` FOR EACH ROW BEGIN
INSERT INTO trig VALUES(NULL, OLD.id, 'updated', now());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `trig`
--

CREATE TABLE `trig` (
  `id` int(11) NOT NULL,
  `mid` int(11) NOT NULL,
  `action` varchar(30) NOT NULL,
  `cdate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trig`
--

INSERT INTO `trig` (`id`, `mid`, `action`, `cdate`) VALUES
(1, 123, 'inserted', '2022-09-05 21:40:59'),
(2, 124, 'inserted', '2022-09-05 21:45:07'),
(3, 125, 'inserted', '2022-09-05 21:45:46'),
(4, 126, 'inserted', '2022-09-05 21:46:07'),
(5, 127, 'inserted', '2022-09-05 21:47:32'),
(6, 123, 'updated', '2022-09-05 21:48:18'),
(7, 124, 'updated', '2022-09-05 21:48:37'),
(8, 125, 'updated', '2022-09-05 21:48:46'),
(9, 125, 'updated', '2022-09-05 21:49:05'),
(10, 126, 'updated', '2022-09-05 21:49:11'),
(11, 127, 'deleted', '2022-09-05 21:49:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `details`
--
ALTER TABLE `details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trig`
--
ALTER TABLE `trig`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `trig`
--
ALTER TABLE `trig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
