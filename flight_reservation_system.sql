-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: flight_management
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `aircraft_id` int NOT NULL AUTO_INCREMENT,
  `aircraft_name` varchar(100) NOT NULL,
  `total_seats` int NOT NULL,
  PRIMARY KEY (`aircraft_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES (1,'Airbus A320',180),(2,'Boeing 737',189),(3,'Airbus A321',220);
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
  `airport_id` int NOT NULL AUTO_INCREMENT,
  `airport_name` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `airport_code` varchar(10) NOT NULL,
  PRIMARY KEY (`airport_id`),
  UNIQUE KEY `airport_code` (`airport_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES (1,'Indira Gandhi International Airport','Delhi','India','DEL'),(2,'Chhatrapati Shivaji Maharaj Airport','Mumbai','India','BOM'),(3,'Kempegowda International Airport','Bangalore','India','BLR'),(4,'Chennai International Airport','Chennai','India','MAA'),(5,'Netaji Subhas Chandra Bose Airport','Kolkata','India','CCU');
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `passenger_id` int DEFAULT NULL,
  `flight_id` int DEFAULT NULL,
  `seat_number` varchar(10) DEFAULT NULL,
  `booking_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `booking_status` varchar(20) DEFAULT 'Confirmed',
  `fare_class` varchar(20) DEFAULT 'Economy',
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `flight_id` (`flight_id`,`seat_number`),
  KEY `passenger_id` (`passenger_id`),
  KEY `idx_booking_lookup` (`flight_id`,`seat_number`,`booking_status`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`passenger_id`) REFERENCES `passengers` (`passenger_id`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,1,1,'A1','2026-11-10 18:10:21','Confirmed','Economy'),(2,2,2,'A2','2026-11-10 18:10:21','Confirmed','Economy'),(3,3,3,'B1','2026-11-10 18:10:21','Confirmed','Economy'),(4,4,4,'B2','2026-11-10 18:10:21','Confirmed','Economy'),(5,5,5,'C1','2026-11-10 18:10:21','Cancelled','Economy');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `flight_occupancy_view`
--

DROP TABLE IF EXISTS `flight_occupancy_view`;
/*!50001 DROP VIEW IF EXISTS `flight_occupancy_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `flight_occupancy_view` AS SELECT 
 1 AS `flight_id`,
 1 AS `flight_number`,
 1 AS `total_seats`,
 1 AS `seats_booked`,
 1 AS `seats_available`,
 1 AS `occupancy_percentage`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `flight_id` int NOT NULL AUTO_INCREMENT,
  `flight_number` varchar(20) DEFAULT NULL,
  `source_airport` int DEFAULT NULL,
  `destination_airport` int DEFAULT NULL,
  `aircraft_id` int DEFAULT NULL,
  `departure_time` datetime DEFAULT NULL,
  `arrival_time` datetime DEFAULT NULL,
  `ticket_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`flight_id`),
  UNIQUE KEY `flight_number` (`flight_number`),
  KEY `destination_airport` (`destination_airport`),
  KEY `aircraft_id` (`aircraft_id`),
  KEY `idx_flight_search` (`source_airport`,`destination_airport`,`departure_time`),
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`source_airport`) REFERENCES `airports` (`airport_id`),
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`destination_airport`) REFERENCES `airports` (`airport_id`),
  CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'AI101',1,2,1,'2026-11-15 08:00:00','2026-11-15 10:00:00',5500.00),(2,'AI202',2,3,2,'2026-11-15 11:00:00','2026-11-15 13:00:00',4200.00),(3,'AI303',1,4,3,'2026-11-16 09:00:00','2026-11-16 12:00:00',6800.00),(4,'AI404',3,5,1,'2026-11-16 14:00:00','2026-11-16 16:30:00',4900.00),(5,'AI505',4,1,2,'2026-11-17 17:00:00','2026-11-17 19:30:00',6000.00);
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passengers`
--

DROP TABLE IF EXISTS `passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passengers` (
  `passenger_id` int NOT NULL AUTO_INCREMENT,
  `passenger_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `passport_number` varchar(30) DEFAULT NULL,
  `loyalty_tier` varchar(20) DEFAULT 'Regular',
  PRIMARY KEY (`passenger_id`),
  UNIQUE KEY `passport_number` (`passport_number`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passengers`
--

LOCK TABLES `passengers` WRITE;
/*!40000 ALTER TABLE `passengers` DISABLE KEYS */;
INSERT INTO `passengers` VALUES (1,'Rahul Sharma','rahul@gmail.com','9876543210','P10001','Gold'),(2,'Priya Verma','priya@gmail.com','9876543211','P10002','Silver'),(3,'Amit Kumar','amit@gmail.com','9876543212','P10003','Platinum'),(4,'Sneha Singh','sneha@gmail.com','9876543213','P10004','Regular'),(5,'Rohan Gupta','rohan@gmail.com','9876543214','P10005','Gold');
/*!40000 ALTER TABLE `passengers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `payment_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,5500.00,'Paid','2026-11-10 18:10:21'),(2,2,4200.00,'Paid','2026-11-10 18:10:21'),(3,3,6800.00,'Paid','2026-11-10 18:10:21'),(4,4,4900.00,'Paid','2026-11-10 18:10:21'),(5,5,6000.00,'Paid','2026-11-10 18:10:21');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `flight_occupancy_view`
--

/*!50001 DROP VIEW IF EXISTS `flight_occupancy_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `flight_occupancy_view` AS select `f`.`flight_id` AS `flight_id`,`f`.`flight_number` AS `flight_number`,`a`.`total_seats` AS `total_seats`,count(`b`.`booking_id`) AS `seats_booked`,(`a`.`total_seats` - count(`b`.`booking_id`)) AS `seats_available`,round(((count(`b`.`booking_id`) * 100.0) / `a`.`total_seats`),2) AS `occupancy_percentage` from ((`flights` `f` join `aircraft` `a` on((`f`.`aircraft_id` = `a`.`aircraft_id`))) left join `bookings` `b` on(((`f`.`flight_id` = `b`.`flight_id`) and (`b`.`booking_status` = 'Confirmed')))) group by `f`.`flight_id`,`f`.`flight_number`,`a`.`total_seats` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-10 21:39:25
