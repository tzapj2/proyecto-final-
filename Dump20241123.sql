CREATE DATABASE  IF NOT EXISTS `chicles` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `chicles`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: chicles
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `chiclebase`
--

DROP TABLE IF EXISTS `chiclebase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chiclebase` (
  `ID_BaseChicle` int NOT NULL AUTO_INCREMENT,
  `Tamaño` varchar(50) NOT NULL,
  `Fórmula` text,
  PRIMARY KEY (`ID_BaseChicle`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chiclebase`
--

LOCK TABLES `chiclebase` WRITE;
/*!40000 ALTER TABLE `chiclebase` DISABLE KEYS */;
INSERT INTO `chiclebase` VALUES (1,'Pequeño','Fórmula básica'),(2,'Mediano','Fórmula estándar'),(3,'Grande','Fórmula avanzada'),(4,'Extra Grande','Fórmula premium'),(5,'Mini','Fórmula concentrada'),(6,'mediano2','Fórmula vegana');
/*!40000 ALTER TABLE `chiclebase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `ID_Cliente` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `PreferenciasSabor` text,
  `HistorialCombinaciones` text,
  PRIMARY KEY (`ID_Cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Juan Pérez','Fresa, Limón','Combinación de Fresa y Limón'),(2,'María López','Menta, Uva','Combinación de Menta y Uva'),(3,'Carlos Gómez','Chocolate, Vainilla','Combinación de Chocolate y Vainilla'),(4,'Ana Martínez','Mango, Piña','Combinación de Mango y Piña'),(5,'Pedro Sánchez','Frambuesa, Mora','Combinación de Frambuesa y Mora');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `combinacionsabor`
--

DROP TABLE IF EXISTS `combinacionsabor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `combinacionsabor` (
  `ID_Combinacion` int NOT NULL AUTO_INCREMENT,
  `ID_BaseChicle` int DEFAULT NULL,
  `ID_Sabor` int DEFAULT NULL,
  `CantidadPolvos` int NOT NULL,
  PRIMARY KEY (`ID_Combinacion`),
  KEY `ID_BaseChicle` (`ID_BaseChicle`),
  KEY `ID_Sabor` (`ID_Sabor`),
  CONSTRAINT `combinacionsabor_ibfk_1` FOREIGN KEY (`ID_BaseChicle`) REFERENCES `chiclebase` (`ID_BaseChicle`) ON DELETE CASCADE,
  CONSTRAINT `combinacionsabor_ibfk_2` FOREIGN KEY (`ID_Sabor`) REFERENCES `polvosabor` (`ID_Sabor`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `combinacionsabor`
--

LOCK TABLES `combinacionsabor` WRITE;
/*!40000 ALTER TABLE `combinacionsabor` DISABLE KEYS */;
INSERT INTO `combinacionsabor` VALUES (16,1,1,2),(17,2,3,3),(18,3,5,1),(19,4,6,4),(20,5,2,3),(21,1,4,1),(22,2,7,2),(23,3,8,3),(24,4,9,1),(25,5,10,4),(26,1,6,2),(27,2,7,1),(28,3,8,2),(29,4,5,3),(30,5,4,1);
/*!40000 ALTER TABLE `combinacionsabor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paqueteproducto`
--

DROP TABLE IF EXISTS `paqueteproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paqueteproducto` (
  `ID_Paquete` int NOT NULL AUTO_INCREMENT,
  `ID_BaseChicle` int DEFAULT NULL,
  `ID_Sabor` int DEFAULT NULL,
  PRIMARY KEY (`ID_Paquete`),
  KEY `ID_BaseChicle` (`ID_BaseChicle`),
  KEY `ID_Sabor` (`ID_Sabor`),
  CONSTRAINT `paqueteproducto_ibfk_1` FOREIGN KEY (`ID_BaseChicle`) REFERENCES `chiclebase` (`ID_BaseChicle`) ON DELETE CASCADE,
  CONSTRAINT `paqueteproducto_ibfk_2` FOREIGN KEY (`ID_Sabor`) REFERENCES `polvosabor` (`ID_Sabor`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paqueteproducto`
--

LOCK TABLES `paqueteproducto` WRITE;
/*!40000 ALTER TABLE `paqueteproducto` DISABLE KEYS */;
INSERT INTO `paqueteproducto` VALUES (1,1,1),(2,2,3),(3,3,5);
/*!40000 ALTER TABLE `paqueteproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `pedidosid` int NOT NULL,
  `ID_Cliente` int NOT NULL,
  `ID_Paquete` int NOT NULL,
  PRIMARY KEY (`pedidosid`),
  KEY `ID_Cliente_idx` (`ID_Cliente`),
  KEY `ID_Paquete_idx` (`ID_Paquete`),
  CONSTRAINT `ID_Cliente` FOREIGN KEY (`ID_Cliente`) REFERENCES `cliente` (`ID_Cliente`),
  CONSTRAINT `ID_Paquete` FOREIGN KEY (`ID_Paquete`) REFERENCES `paqueteproducto` (`ID_Paquete`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,1),(2,2,2),(3,3,3),(4,1,2),(5,2,3);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polvosabor`
--

DROP TABLE IF EXISTS `polvosabor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `polvosabor` (
  `ID_Sabor` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Intensidad` int DEFAULT NULL,
  `Tipo` varchar(50) DEFAULT NULL,
  `FechaExpiración` date DEFAULT NULL,
  PRIMARY KEY (`ID_Sabor`),
  CONSTRAINT `polvosabor_chk_1` CHECK (((`Intensidad` >= 1) and (`Intensidad` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polvosabor`
--

LOCK TABLES `polvosabor` WRITE;
/*!40000 ALTER TABLE `polvosabor` DISABLE KEYS */;
INSERT INTO `polvosabor` VALUES (1,'Fresa',8,'Fruta','2025-06-01'),(2,'Limón',6,'Fruta','2025-01-15'),(3,'Menta',9,'Hierba','2024-12-31'),(4,'Canela',7,'Especia','2024-09-20'),(5,'Coco',5,'Exótico','2026-03-10'),(6,'Uva',7,'Fruta','2025-11-11'),(7,'Chocolate',8,'Dulce','2025-08-05'),(8,'Vainilla',6,'Dulce','2025-07-20'),(9,'Manzana',7,'Fruta','2025-10-10'),(10,'Cereza',9,'Fruta','2026-01-01');
/*!40000 ALTER TABLE `polvosabor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polvosabor_proveedor`
--

DROP TABLE IF EXISTS `polvosabor_proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `polvosabor_proveedor` (
  `ID_Sabor` int NOT NULL,
  `ID_Proveedor` int NOT NULL,
  `Precio` decimal(10,2) NOT NULL,
  `FechaUltimaCompra` date DEFAULT NULL,
  `cantidad_comprada` int DEFAULT NULL,
  `ultima_fecha_de_compra` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Sabor`,`ID_Proveedor`),
  KEY `ID_Proveedor` (`ID_Proveedor`),
  CONSTRAINT `polvosabor_proveedor_ibfk_1` FOREIGN KEY (`ID_Sabor`) REFERENCES `polvosabor` (`ID_Sabor`) ON DELETE CASCADE,
  CONSTRAINT `polvosabor_proveedor_ibfk_2` FOREIGN KEY (`ID_Proveedor`) REFERENCES `proveedor` (`ID_Proveedor`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polvosabor_proveedor`
--

LOCK TABLES `polvosabor_proveedor` WRITE;
/*!40000 ALTER TABLE `polvosabor_proveedor` DISABLE KEYS */;
INSERT INTO `polvosabor_proveedor` VALUES (1,1,10.50,'2024-10-01',51,'2024-11-22 04:16:33'),(2,2,15.00,'2024-11-01',30,NULL),(3,3,12.75,'2024-09-15',40,NULL),(4,1,11.00,'2024-10-10',25,NULL),(5,2,9.99,'2024-12-01',20,NULL),(6,3,14.50,'2024-10-20',60,NULL),(7,1,13.25,'2024-11-15',35,NULL),(8,2,8.50,'2024-12-05',15,NULL),(9,3,10.75,'2024-11-25',45,NULL),(10,1,12.00,'2024-12-15',55,NULL);
/*!40000 ALTER TABLE `polvosabor_proveedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_actualizar_fecha` BEFORE UPDATE ON `polvosabor_proveedor` FOR EACH ROW begin
if new.cantidad_comprada <> old.cantidad_comprada 
then
set new.ultima_fecha_de_compra= now();
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `ID_Proveedor` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Contacto` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID_Proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'Sabores Naturales S.A.','Juan Ríos','555-1234','contacto@naturales.com','Av. Principal 123'),(2,'Esencias Gourmet','María Vega','555-5678','ventas@gourmet.com','Calle Secundaria 456'),(3,'Aromas del Mundo','Pedro Díaz','555-9101','info@aromas.com','Boulevard Tercero 789');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'chicles'
--

--
-- Dumping routines for database 'chicles'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-23 22:20:33
