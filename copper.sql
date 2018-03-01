-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2017 at 12:44 AM
-- Server version: 5.6.24
-- PHP Version: 5.5.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `copper`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delcomp`()
    MODIFIES SQL DATA
BEGIN
declare cnt int(1);
declare c int(3);
select complaint_id from involved_in_2 limit 1 into c;
select count(*) from involved_in_2 into cnt;
if(cnt >3) then
	delete from involved_in_2 limit 1;
    end if;
update complaint set status=2  where complaint_id=c;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delreq`()
    NO SQL
BEGIN
declare cnt int(1);
declare c int(3);
select request_request_id from involved_in_1 limit 1 into c;
select count(*) from involved_in_1 into cnt;
if(cnt>3) then
	delete from involved_in_1 limit 1;
    end if;
update request set status=2  where request_id=c;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deltraf`()
    MODIFIES SQL DATA
BEGIN
declare cnt int(1);
declare c int(3);
select issue_id from involved_in_3 limit 1 into c;
select count(*) from involved_in_3 into cnt;
if(cnt>3) then
	delete from involved_in_3 limit 1;
    end if;
update traffic_issue set status=2  where issue_id=c;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `priorityforcomplaint`()
BEGIN

 declare c_id integer;
 declare descr varchar(20);
declare comp CURSOR for 
select complaint_id,description from `complaint`;
OPEN COMP;
LOOP
FETCH COMP INTO c_id,descr ;
CASE descr
when 'MURDER' then
	update complaint set priority=10 where complaint_id=c_id;

when 'SNATCH' then
	update complaint set priority=6 where complaint_id=c_id;
    
when 'BREAKIN' then
	update complaint set priority=8 where complaint_id=c_id;
    
when 'THEFT' then
	update complaint set priority=7 where complaint_id=c_id;
else
	update complaint set priority=0 where complaint_id=c_id;
    
    IF no_more_rows THEN 
	CLOSE comp;
	end if;
end case;
end loop;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `priorityforrequest`()
    NO SQL
BEGIN

 declare c_id integer;
 declare descr varchar(20);
declare comp CURSOR for 
select request_id,description from `request`;
OPEN COMP;
LOOP
FETCH COMP INTO c_id,descr ;
CASE descr
when 'PASSPORT' then
	update request set priority=3 where request_id=c_id;

when 'PROTECTION' then
	update request set priority=6 where request_id=c_id;
    
when 'SECURITY' then
	update request set priority=5 where request_id=c_id;
    
when 'DISTURBANCE' then
	update request set priority=9 where request_id=c_id;
else
	update request set priority=0 where request_id=c_id;
    
    IF no_more_rows THEN 
	CLOSE comp;
	end if;
end case;
end loop;

END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `compstatus`(`c_id` INT(3) UNSIGNED) RETURNS varchar(20) CHARSET latin1
    READS SQL DATA
BEGIN
declare descr varchar(20);
declare st int(1);
select status from complaint where complaint_id=c_id into st;
select description from status where status_id=st into descr;

return descr;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `reqstatus`(`r_id` INT(4)) RETURNS varchar(20) CHARSET latin1
    READS SQL DATA
BEGIN
declare descr varchar(20);
declare st int(1);
select status from request where request_id=r_id into st;
select description from status where status_id=st into descr;

return descr;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `trafstatus`(`i_id` INT(4)) RETURNS varchar(20) CHARSET latin1
    NO SQL
BEGIN
declare descr varchar(20);
declare st int(1);
select status from traffic_issue where issue_id=i_id into st;
select description from status where status_id=st into descr;

return descr;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE IF NOT EXISTS `areas` (
  `AREA_ID` int(11) NOT NULL,
  `AREA_NAME` varchar(45) NOT NULL,
  `PINCODE` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`AREA_ID`, `AREA_NAME`, `PINCODE`) VALUES
(1, 'PORUR', 600116),
(2, 'ASHOKNAGAR', 700116),
(3, 'ALANDUR', 600016),
(4, 'ADAYAR', 600020),
(5, 'AVADI', 600024),
(6, 'KILPAUK', 600010),
(7, 'MYLAPORE', 600004),
(8, 'NUNGAMBAKKAM', 600034),
(9, 'SAIDAPET', 600015),
(10, 'VADAPALANI', 600026),
(11, 'VELACHERRY', 600042),
(12, 'WESTMAMBALAM', 600033),
(13, 'TRIPLICANE', 600014),
(14, 'SOWCARPET', 600079),
(15, 'TAMBARAM', 600059);

-- --------------------------------------------------------

--
-- Table structure for table `complaint`
--

CREATE TABLE IF NOT EXISTS `complaint` (
  `COMPLAINT_ID` int(11) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `AREA` int(11) DEFAULT NULL,
  `TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `PHONE_NUMBER` int(10) NOT NULL,
  `PRIORITY` int(2) DEFAULT NULL,
  `STATUS` int(11) NOT NULL DEFAULT '1',
  `DESCRIPTION` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `complaint`
--
DELIMITER $$
CREATE TRIGGER `COMPLAINT_AFTER_INSERT` AFTER INSERT ON `complaint`
 FOR EACH ROW BEGIN
declare tmplft integer;
 SELECT  POLICE_ID FROM POLICE_OFFICER WHERE STATION IN(SELECT STATION_NAME FROM POLICE_STATION WHERE STATION_AREA IN (SELECT AREA_ID FROM AREAS WHERE AREA_ID IN(SELECT AREA FROM COMPLAINT WHERE COMPLAINT_ID=NEW.COMPLAINT_ID))) into tmplft;
insert into  involved_in_2 values (tmplft,new.complaint_id);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `COMPLAINT_BEFORE_DELETE` BEFORE DELETE ON `complaint`
 FOR EACH ROW BEGIN
update police_officer set status=1 where police_id in( select police_officer_police_id from involved_in_2 where complaint_id =old.complaint_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `involved_in_1`
--

CREATE TABLE IF NOT EXISTS `involved_in_1` (
  `POLICE_OFFICER_POLICE_ID` int(11) NOT NULL,
  `REQUEST_REQUEST_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `involved_in_1`
--
DELIMITER $$
CREATE TRIGGER `INVOLVED_IN_1_AFTER_DELETE` AFTER DELETE ON `involved_in_1`
 FOR EACH ROW BEGIN
update police_officer set status=1 where police_id = old.police_officer_police_id;
UPDATE REQUEST SET STATUS=2 WHERE REQUEST_ID=OLD.REQUEST_REQUEST_ID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `INVOLVED_IN_1_AFTER_INSERT` AFTER INSERT ON `involved_in_1`
 FOR EACH ROW BEGIN
update police_officer set status=0 where police_id = new.police_officer_police_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `involved_in_2`
--

CREATE TABLE IF NOT EXISTS `involved_in_2` (
  `POLICE_OFFICER_POLICE_ID` int(11) NOT NULL,
  `COMPLAINT_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `involved_in_2`
--
DELIMITER $$
CREATE TRIGGER `INVOLVED_IN_2_AFTER_DELETE` AFTER DELETE ON `involved_in_2`
 FOR EACH ROW BEGIN
update police_officer set status=1 where police_id = old.police_officer_police_id;
UPDATE COMPLAINT SET STATUS=2 WHERE COMPLAINT_ID=OLD.COMPLAINT_ID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `INVOLVED_IN_2_AFTER_INSERT` AFTER INSERT ON `involved_in_2`
 FOR EACH ROW BEGIN
update police_officer set status=0 where police_id = new.police_officer_police_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `involved_in_3`
--

CREATE TABLE IF NOT EXISTS `involved_in_3` (
  `ISSUE_ID` int(11) NOT NULL,
  `POLICE_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `involved_in_3`
--
DELIMITER $$
CREATE TRIGGER `INVOLVED_IN_3_AFTER_DELETE` AFTER DELETE ON `involved_in_3`
 FOR EACH ROW BEGIN
update police_officer set status=1 where police_id = old.police_id;
UPDATE TRAFFIC_ISSUE SET STATUS=2 WHERE ISSUE_ID=OLD.ISSUE_ID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `INVOLVED_IN_3_AFTER_INSERT` AFTER INSERT ON `involved_in_3`
 FOR EACH ROW BEGIN
update police_officer set status=0 where police_id = new.police_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `officer_status`
--

CREATE TABLE IF NOT EXISTS `officer_status` (
  `STATUS_CODE` varchar(3) NOT NULL,
  `DESCRIPTION` varchar(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `officer_status`
--

INSERT INTO `officer_status` (`STATUS_CODE`, `DESCRIPTION`) VALUES
('0', 'NOTAVAILABLE'),
('1', 'AVAILABLE');

-- --------------------------------------------------------

--
-- Table structure for table `police_officer`
--

CREATE TABLE IF NOT EXISTS `police_officer` (
  `POLICE_ID` int(11) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `PHONE_NUMBER` int(10) NOT NULL,
  `STATION` varchar(32) NOT NULL,
  `STATUS` varchar(3) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `police_officer`
--

INSERT INTO `police_officer` (`POLICE_ID`, `NAME`, `PHONE_NUMBER`, `STATION`, `STATUS`) VALUES
(601, 'FLASH', 9566686, 'T-7', '1'),
(602, 'ARROW', 9524273, 'R-6', '1'),
(603, 'WONDERWOMAN', 9597648, 'R-4', '1'),
(604, 'HULK', 7600042, 'R-3', '1'),
(605, 'IRONMAN', 9677212, 'G-7', '1'),
(606, 'SPIDERMAN', 9688070, 'D-3', '1'),
(607, 'SUPERMAN', 9786209, 'S-5', '1'),
(608, 'CAPTAINAMERICA', 9787129, 'G-8', '1'),
(609, 'JOKER', 9790412, 'M-4', '1'),
(610, 'HARLEYQUINN', 9840013, 'B-12', '1'),
(611, 'AQUAMAN', 9944586, 'N-7', '1'),
(612, 'LOGAN', 9976512, 'Q-5', '1'),
(613, 'SANDMAN', 9500333, 'P-1', '1'),
(614, 'DEADPOOL', 9488413, 'S-7', '1'),
(615, 'HEMAN', 9445800, 'A-1', '1'),
(616, 'SHAKTHIMAAN', 9434343, 'G-8', '1'),
(617, 'CATWOMAN', 9556565, 'M-4', '1'),
(618, 'BATGIRL', 9444912, 'A-1', '1'),
(619, 'ANTMAN', 9564535, 'S-7', '1'),
(620, 'BATMAN', 9380777, 'G-8', '1');

-- --------------------------------------------------------

--
-- Table structure for table `police_station`
--

CREATE TABLE IF NOT EXISTS `police_station` (
  `STATION_NAME` varchar(32) NOT NULL,
  `PHONE_NUMBER` int(11) NOT NULL,
  `ADDRESS` varchar(45) DEFAULT NULL,
  `STATION_AREA` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `police_station`
--

INSERT INTO `police_station` (`STATION_NAME`, `PHONE_NUMBER`, `ADDRESS`, `STATION_AREA`) VALUES
('A-1', 24899460, '29,PHOENIX ROAD', 11),
('B-12', 98765432, '51,ELANGO ST', 13),
('D-3', 12345678, '13,11TH AVENUE', 8),
('G-7', 34347575, '8,RAJNIKANTH ST', 5),
('G-8', 11335577, '44,MOUNTAIN VIEW', 15),
('M-4', 12568934, '9,LAKE VIEW ROAD', 12),
('N-7', 93810610, '33,SUBASH ST', 1),
('P-1', 23715958, '50,HEMACHANDRAN ST', 9),
('Q-5', 22334455, '43,PUNEETHAKUMAR ST', 3),
('R-3', 79347246, '11,VALLUVAR ST', 4),
('R-4', 67453545, '9,KAMBAR ST', 7),
('R-6', 89898939, '15,40 FEET ROAD', 6),
('S-5', 22446688, '19,FIRST CROSS ST', 14),
('S-7', 24767602, '19,MOUNT ROAD', 10),
('T-7', 98765345, '12,VARADHAPPAN ST', 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `police_view`
--
CREATE TABLE IF NOT EXISTS `police_view` (
`complaint_id` int(11)
,`name` varchar(45)
,`phone_number` int(11)
,`description` varchar(100)
,`status` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE IF NOT EXISTS `request` (
  `REQUEST_ID` int(11) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `AREA` int(11) NOT NULL,
  `TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `PHONE_NUMBER` int(10) NOT NULL,
  `PRIORITY` int(2) DEFAULT NULL,
  `STATUS` int(11) NOT NULL DEFAULT '1',
  `DESCRIPTION` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `request`
--
DELIMITER $$
CREATE TRIGGER `REQUEST_AFTER_DELETE` AFTER DELETE ON `request`
 FOR EACH ROW BEGIN
update police_officer set status=1 where police_id in( select police_officer_police_id from involved_in_1 where request_request_id =old.request_id);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `REQUEST_AFTER_INSERT` AFTER INSERT ON `request`
 FOR EACH ROW BEGIN
declare tmplft integer;
 SELECT  POLICE_ID FROM POLICE_OFFICER WHERE STATION IN(SELECT STATION_NAME FROM POLICE_STATION WHERE STATION_AREA IN (SELECT AREA_ID FROM AREAS WHERE AREA_ID IN(SELECT AREA FROM REQUEST WHERE REQUEST_ID=NEW.REQUEST_ID))) into tmplft;
insert into  involved_in_1 values (tmplft,new.request_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE IF NOT EXISTS `status` (
  `STATUS_CODE` int(11) NOT NULL,
  `DESCRIPTION` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`STATUS_CODE`, `DESCRIPTION`) VALUES
(0, 'REJECTED'),
(1, 'UNDERGOING'),
(2, 'COMPLETED');

-- --------------------------------------------------------

--
-- Stand-in structure for view `statusofproblems`
--
CREATE TABLE IF NOT EXISTS `statusofproblems` (
`police_id` int(11)
,`name` varchar(45)
,`phone_number` int(10)
);

-- --------------------------------------------------------

--
-- Table structure for table `traffic_issue`
--

CREATE TABLE IF NOT EXISTS `traffic_issue` (
  `ISSUE_ID` int(11) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `AREA` int(2) NOT NULL,
  `TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `PHONE_NUMBER` int(10) NOT NULL,
  `STATUS` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `traffic_issue`
--
DELIMITER $$
CREATE TRIGGER `TRAFFIC_ISSUE_AFTER_INSERT` AFTER INSERT ON `traffic_issue`
 FOR EACH ROW BEGIN
declare tmplft integer;
 SELECT  POLICE_ID FROM POLICE_OFFICER WHERE STATION IN(SELECT STATION_NAME FROM POLICE_STATION WHERE STATION_AREA IN (SELECT AREA_ID FROM AREAS WHERE AREA_ID IN(SELECT AREA FROM TRAFFIC_ISSUE WHERE ISSUE_ID =NEW.ISSUE_ID))) into tmplft;

insert into  involved_in_3 values (new.issue_id,tmplft);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TRAFFIC_ISSUE_BEFORE_DELETE` BEFORE DELETE ON `traffic_issue`
 FOR EACH ROW BEGIN
update police_officer set status=1 where police_id in( select police_id from involved_in_3 where issue_id =old.issue_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `traffic_signal`
--

CREATE TABLE IF NOT EXISTS `traffic_signal` (
  `SIGNAL_ID` int(11) NOT NULL,
  `ROAD_NAME` varchar(32) DEFAULT NULL,
  `ISSUE_ID` int(11) DEFAULT NULL,
  `AREA_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `traffic_signal`
--
DELIMITER $$
CREATE TRIGGER `TRAFFIC_SIGNAL_AFTER_INSERT` AFTER INSERT ON `traffic_signal`
 FOR EACH ROW BEGIN
declare tmplft integer;
 SELECT  POLICE_ID FROM POLICE_OFFICER WHERE STATION IN(SELECT STATION_NAME FROM POLICE_STATION WHERE STATION_AREA IN (SELECT AREA_ID FROM AREAS WHERE AREA_ID IN(SELECT AREA_ID FROM TRAFFIC_SIGNAL WHERE ISSUE_ID =NEW.ISSUE_ID))) into tmplft;

insert into  involved_in_3 values (new.issue_id,tmplft);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `traffic_status`
--

CREATE TABLE IF NOT EXISTS `traffic_status` (
  `STATUS_CODE` int(11) NOT NULL,
  `DESCRIPTION` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `traffic_status`
--

INSERT INTO `traffic_status` (`STATUS_CODE`, `DESCRIPTION`) VALUES
(0, 'REJECTED'),
(1, 'UNDERGOING'),
(2, 'COMPLETED');

-- --------------------------------------------------------

--
-- Structure for view `police_view`
--
DROP TABLE IF EXISTS `police_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `police_view` AS select `complaint`.`COMPLAINT_ID` AS `complaint_id`,`complaint`.`NAME` AS `name`,`complaint`.`PHONE_NUMBER` AS `phone_number`,`complaint`.`DESCRIPTION` AS `description`,`complaint`.`STATUS` AS `status` from `complaint` union select `request`.`REQUEST_ID` AS `request_id`,`request`.`NAME` AS `name`,`request`.`PHONE_NUMBER` AS `phone_number`,`request`.`DESCRIPTION` AS `description`,`request`.`STATUS` AS `status` from `request`;

-- --------------------------------------------------------

--
-- Structure for view `statusofproblems`
--
DROP TABLE IF EXISTS `statusofproblems`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `statusofproblems` AS select `police_officer`.`POLICE_ID` AS `police_id`,`police_officer`.`NAME` AS `name`,`police_officer`.`PHONE_NUMBER` AS `phone_number` from `police_officer` where `police_officer`.`POLICE_ID` in (select `involved_in_2`.`POLICE_OFFICER_POLICE_ID` from `involved_in_2`);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`AREA_ID`), ADD UNIQUE KEY `AREA_ID_UNIQUE` (`AREA_ID`);

--
-- Indexes for table `complaint`
--
ALTER TABLE `complaint`
  ADD PRIMARY KEY (`COMPLAINT_ID`), ADD UNIQUE KEY `COMPLAINT_ID_UNIQUE` (`COMPLAINT_ID`), ADD KEY `fk_COMPLAINT_STATUS1_idx` (`STATUS`), ADD KEY `ADDRESS_idx` (`AREA`);

--
-- Indexes for table `involved_in_1`
--
ALTER TABLE `involved_in_1`
  ADD KEY `fk_INVOLVED_IN_POLICE_OFFICER1_idx` (`POLICE_OFFICER_POLICE_ID`), ADD KEY `fk_INVOLVED_IN_REQUEST1_idx` (`REQUEST_REQUEST_ID`);

--
-- Indexes for table `involved_in_2`
--
ALTER TABLE `involved_in_2`
  ADD KEY `COMPLAINT_idx` (`COMPLAINT_ID`), ADD KEY `POLICE_idx` (`POLICE_OFFICER_POLICE_ID`);

--
-- Indexes for table `involved_in_3`
--
ALTER TABLE `involved_in_3`
  ADD KEY `POLICE_ID_idx` (`POLICE_ID`), ADD KEY `ISSUE_idx` (`ISSUE_ID`);

--
-- Indexes for table `officer_status`
--
ALTER TABLE `officer_status`
  ADD PRIMARY KEY (`STATUS_CODE`);

--
-- Indexes for table `police_officer`
--
ALTER TABLE `police_officer`
  ADD PRIMARY KEY (`POLICE_ID`), ADD UNIQUE KEY `PHONE_NUMBER_UNIQUE` (`PHONE_NUMBER`), ADD UNIQUE KEY `POLICE_ID_UNIQUE` (`POLICE_ID`), ADD KEY `fk_POLICE_OFFICER_POLICE_STATION2_idx` (`STATION`), ADD KEY `fk_POLICE_OFFICER_OFFICER_STATUS2_idx` (`STATUS`);

--
-- Indexes for table `police_station`
--
ALTER TABLE `police_station`
  ADD PRIMARY KEY (`STATION_NAME`,`STATION_AREA`), ADD UNIQUE KEY `STATION_NAME_UNIQUE` (`STATION_NAME`), ADD KEY `fk_POLICE_STATION_AREAS1_idx` (`STATION_AREA`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`REQUEST_ID`), ADD UNIQUE KEY `COMPLAINT_ID_UNIQUE` (`REQUEST_ID`), ADD KEY `fk_REQUEST_STATUS2_idx` (`STATUS`), ADD KEY `ADDRESS_idx` (`AREA`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`STATUS_CODE`), ADD UNIQUE KEY `STATUS_CODE_UNIQUE` (`STATUS_CODE`);

--
-- Indexes for table `traffic_issue`
--
ALTER TABLE `traffic_issue`
  ADD PRIMARY KEY (`ISSUE_ID`), ADD UNIQUE KEY `COMPLAINT_ID_UNIQUE` (`ISSUE_ID`), ADD KEY `fk_TRAFFIC_ISSUE_TRAFFIC_STATUS2_idx` (`STATUS`);

--
-- Indexes for table `traffic_signal`
--
ALTER TABLE `traffic_signal`
  ADD PRIMARY KEY (`SIGNAL_ID`), ADD UNIQUE KEY `SIGNAL_ID_UNIQUE` (`SIGNAL_ID`), ADD KEY `AREA_ID_idx` (`AREA_ID`), ADD KEY `ISSUE_ID_idx` (`ISSUE_ID`);

--
-- Indexes for table `traffic_status`
--
ALTER TABLE `traffic_status`
  ADD PRIMARY KEY (`STATUS_CODE`), ADD UNIQUE KEY `STATUS_CODE_UNIQUE` (`STATUS_CODE`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `complaint`
--
ALTER TABLE `complaint`
ADD CONSTRAINT `AREA` FOREIGN KEY (`AREA`) REFERENCES `areas` (`AREA_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_COMPLAINT_STATUS1` FOREIGN KEY (`STATUS`) REFERENCES `status` (`STATUS_CODE`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `involved_in_1`
--
ALTER TABLE `involved_in_1`
ADD CONSTRAINT `fk_INVOLVED_IN_POLICE_OFFICER1` FOREIGN KEY (`POLICE_OFFICER_POLICE_ID`) REFERENCES `police_officer` (`POLICE_ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_INVOLVED_IN_REQUEST1` FOREIGN KEY (`REQUEST_REQUEST_ID`) REFERENCES `request` (`REQUEST_ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `involved_in_2`
--
ALTER TABLE `involved_in_2`
ADD CONSTRAINT `COMPLAINT` FOREIGN KEY (`COMPLAINT_ID`) REFERENCES `complaint` (`COMPLAINT_ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
ADD CONSTRAINT `POLICE` FOREIGN KEY (`POLICE_OFFICER_POLICE_ID`) REFERENCES `police_officer` (`POLICE_ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `involved_in_3`
--
ALTER TABLE `involved_in_3`
ADD CONSTRAINT `ISSUE` FOREIGN KEY (`ISSUE_ID`) REFERENCES `traffic_issue` (`ISSUE_ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
ADD CONSTRAINT `POLICE_ID` FOREIGN KEY (`POLICE_ID`) REFERENCES `police_officer` (`POLICE_ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `police_officer`
--
ALTER TABLE `police_officer`
ADD CONSTRAINT `fk_POLICE_OFFICER_OFFICER_STATUS2` FOREIGN KEY (`STATUS`) REFERENCES `officer_status` (`STATUS_CODE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_POLICE_OFFICER_POLICE_STATION2` FOREIGN KEY (`STATION`) REFERENCES `police_station` (`STATION_NAME`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `police_station`
--
ALTER TABLE `police_station`
ADD CONSTRAINT `fk_POLICE_STATION_AREAS1` FOREIGN KEY (`STATION_AREA`) REFERENCES `areas` (`AREA_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `request`
--
ALTER TABLE `request`
ADD CONSTRAINT `ADDRESS` FOREIGN KEY (`AREA`) REFERENCES `areas` (`AREA_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_REQUEST_STATUS2` FOREIGN KEY (`STATUS`) REFERENCES `status` (`STATUS_CODE`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `traffic_issue`
--
ALTER TABLE `traffic_issue`
ADD CONSTRAINT `fk_TRAFFIC_ISSUE_TRAFFIC_STATUS2` FOREIGN KEY (`STATUS`) REFERENCES `traffic_status` (`STATUS_CODE`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `traffic_signal`
--
ALTER TABLE `traffic_signal`
ADD CONSTRAINT `AREA_ID` FOREIGN KEY (`AREA_ID`) REFERENCES `areas` (`AREA_ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
ADD CONSTRAINT `ISSUE_ID` FOREIGN KEY (`ISSUE_ID`) REFERENCES `traffic_issue` (`ISSUE_ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
