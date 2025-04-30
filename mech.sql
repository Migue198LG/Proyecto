-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: merch
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
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `accion` varchar(255) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_usuario` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `bitacora_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `persona` (`id_persona`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
INSERT INTO `bitacora` VALUES (1,3,'Inicio de sesión','2025-04-04 20:46:44','cliente'),(6,1,'Creó una nueva cita','2025-04-29 19:31:30','cliente'),(7,2,'Le fue asignada una nueva cita','2025-04-29 19:31:30','mecanico'),(8,3,'Creó una nueva cita','2025-04-29 19:31:30','cliente'),(9,2,'Le fue asignada una nueva cita','2025-04-29 19:31:30','mecanico'),(10,3,'Inicio de sesión','2025-04-29 19:56:31','cliente'),(11,3,'Creó una nueva cita','2025-04-29 19:57:58','cliente'),(12,3,'Le fue asignada una nueva cita','2025-04-29 19:57:58','mecanico'),(13,3,'Inicio de sesión','2025-04-29 21:34:28','cliente'),(14,3,'Inicio de sesión','2025-04-29 21:42:36','cliente');
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrito1`
--

DROP TABLE IF EXISTS `carrito1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrito1` (
  `id_pieza` int NOT NULL,
  `cantidad` int NOT NULL,
  `total` int NOT NULL,
  KEY `id_pieza` (`id_pieza`),
  CONSTRAINT `carrito1_ibfk_1` FOREIGN KEY (`id_pieza`) REFERENCES `pzsmotor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito1`
--

LOCK TABLES `carrito1` WRITE;
/*!40000 ALTER TABLE `carrito1` DISABLE KEYS */;
/*!40000 ALTER TABLE `carrito1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_mecanico` int NOT NULL,
  `fecha` datetime NOT NULL,
  `estado` enum('pendiente','confirmada','cancelada','finalizada') NOT NULL DEFAULT 'pendiente',
  PRIMARY KEY (`id`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_mecanico` (`id_mecanico`),
  CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `persona` (`id_persona`),
  CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`id_mecanico`) REFERENCES `persona` (`id_persona`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
INSERT INTO `citas` VALUES (1,3,2,'2025-05-01 10:00:00','pendiente'),(2,3,2,'2025-05-02 14:30:00','confirmada'),(3,1,2,'2025-05-03 09:15:00','finalizada'),(4,3,3,'2025-05-01 13:57:00','pendiente');
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_vehiculo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `gastos` int NOT NULL,
  `saldo_D` int NOT NULL,
  `estatus` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_vehiculo`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estatus`
--

DROP TABLE IF EXISTS `estatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estatus` (
  `id_vehiculo` int NOT NULL,
  `estatus` varchar(70) NOT NULL,
  KEY `id_vehiculo` (`id_vehiculo`),
  CONSTRAINT `estatus_ibfk_1` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estatus`
--

LOCK TABLES `estatus` WRITE;
/*!40000 ALTER TABLE `estatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `estatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gastos`
--

DROP TABLE IF EXISTS `gastos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gastos` (
  `id_vehiculo` int NOT NULL,
  `gastos` int NOT NULL,
  KEY `id_vehiculo` (`id_vehiculo`),
  CONSTRAINT `gastos_ibfk_1` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gastos`
--

LOCK TABLES `gastos` WRITE;
/*!40000 ALTER TABLE `gastos` DISABLE KEYS */;
/*!40000 ALTER TABLE `gastos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas`
--

DROP TABLE IF EXISTS `marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marcas` (
  `idmar` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`idmar`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas`
--

LOCK TABLES `marcas` WRITE;
/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` VALUES (1,'Audi'),(2,'BMW'),(3,'Chrysler'),(4,'Ford'),(5,'General_Motors (Chevrolet, GMC)'),(6,'Honda'),(7,'Kia'),(8,'Mazda'),(9,'Nissan'),(10,'Toyota'),(11,'Volkswagen');
/*!40000 ALTER TABLE `marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modelos`
--

DROP TABLE IF EXISTS `modelos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modelos` (
  `ModeloID` int NOT NULL AUTO_INCREMENT,
  `NombreModelo` varchar(50) DEFAULT NULL,
  `MarcaID` int DEFAULT NULL,
  PRIMARY KEY (`ModeloID`),
  KEY `MarcaID` (`MarcaID`),
  CONSTRAINT `modelos_ibfk_1` FOREIGN KEY (`MarcaID`) REFERENCES `marcas` (`idmar`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelos`
--

LOCK TABLES `modelos` WRITE;
/*!40000 ALTER TABLE `modelos` DISABLE KEYS */;
INSERT INTO `modelos` VALUES (1,'Q5',1),(2,'A6',1),(3,'Q7',1),(4,'A3',1),(5,'Q3',1),(6,'5 Series',2),(7,'X5',2),(8,'X3',2),(9,'7 Series',2),(10,'X1',2),(11,'Pacifica',3),(12,'Voyager',3),(13,'PT Cruiser',3),(14,'300M',3),(15,'Sebring',3),(16,'Mustang',4),(17,'Explorer',4),(18,'Escape',4),(19,'Focus',4),(20,'Fusion',4),(21,'Camaro',5),(22,'Malibu',5),(23,'Equinox',5),(24,'Traverse',5),(25,'Colorado',5),(26,'Civic',6),(27,'CR-V',6),(28,'Accord',6),(29,'Pilot',6),(30,'Fit',6),(31,'Sportage',7),(32,'Soul',7),(33,'Forte',7),(34,'Seltos',7),(35,'Rio',7),(36,'CX-9',8),(37,'MX-5 Miata',8),(38,'Mazda3',8),(39,'Mazda6',8),(40,'CX-30',8),(41,'Sentra',9),(42,'Rogue',9),(43,'Altima',9),(44,'Maxima',9),(45,'Versa',9),(46,'Camry',10),(47,'Corolla',10),(48,'RAV4',10),(49,'Highlander',10),(50,'Prius',10),(51,'Jetta',11),(52,'Passat',11),(53,'Tiguan',11),(54,'Atlas',11),(55,'Arteon',11);
/*!40000 ALTER TABLE `modelos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `id_persona` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(30) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `contraseña` varchar(50) NOT NULL,
  `tipo_usuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,'Saul','saul@gmail.com','12345678','cliente'),(2,'Adrian','ass@gmail.com','12345678','mecanico'),(3,'Brian','brian@gmail.com','12345678','cliente');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pzscarroceria`
--

DROP TABLE IF EXISTS `pzscarroceria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pzscarroceria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `precio` varchar(10) NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pzscarroceria`
--

LOCK TABLES `pzscarroceria` WRITE;
/*!40000 ALTER TABLE `pzscarroceria` DISABLE KEYS */;
INSERT INTO `pzscarroceria` VALUES (1,'Manilla','150',10),(2,'Parabrisas','5000',15),(3,'Toma de Aire','2000',25),(4,'Defensa T.','700',14),(5,'Facia','4650',20),(6,'Espejo Retrovisor','200',31),(7,'Defenda F.','4000',8),(8,'Faros','7500',40),(9,'Tablero','3000',7),(10,'Cristal Ventana','500',22);
/*!40000 ALTER TABLE `pzscarroceria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pzsmecanicas`
--

DROP TABLE IF EXISTS `pzsmecanicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pzsmecanicas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `precio` varchar(10) NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pzsmecanicas`
--

LOCK TABLES `pzsmecanicas` WRITE;
/*!40000 ALTER TABLE `pzsmecanicas` DISABLE KEYS */;
INSERT INTO `pzsmecanicas` VALUES (1,'Bateria','2399',10),(2,'Carter','500',10),(3,'Bujias','100',10),(4,'Filtro de Aceite','100',10),(5,'Sensor cigueñal','1100',10),(6,'Aceite','350',41),(7,'Filtro Aire','208',10),(8,'Bobinas','60',10),(9,'Sensor de Aceite','230',10),(10,'Anticongelante','230',10);
/*!40000 ALTER TABLE `pzsmecanicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pzsmotor`
--

DROP TABLE IF EXISTS `pzsmotor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pzsmotor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `precio` varchar(10) NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pzsmotor`
--

LOCK TABLES `pzsmotor` WRITE;
/*!40000 ALTER TABLE `pzsmotor` DISABLE KEYS */;
INSERT INTO `pzsmotor` VALUES (1,'Piston','380',20),(2,'Biela','380',20),(3,'Arbol de Levas','550',20),(4,'Cabeza Motor','4500',20),(5,'Ventilador','390',20),(6,'Bomba Gasolina','350',20),(7,'Alternador','1500',20),(8,'Marcha','300',20),(9,'Bomba de Agua','300',20),(10,'Radiador','1000',20);
/*!40000 ALTER TABLE `pzsmotor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro`
--

DROP TABLE IF EXISTS `registro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro` (
  `id_persona` int NOT NULL,
  `id_vehiculo` int NOT NULL,
  `bitacora` varchar(200) NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `id_persona` (`id_persona`),
  KEY `id_vehiculo` (`id_vehiculo`),
  CONSTRAINT `registro_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`),
  CONSTRAINT `registro_ibfk_2` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro`
--

LOCK TABLES `registro` WRITE;
/*!40000 ALTER TABLE `registro` DISABLE KEYS */;
/*!40000 ALTER TABLE `registro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiculo`
--

DROP TABLE IF EXISTS `vehiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiculo` (
  `id_vehiculo` int NOT NULL AUTO_INCREMENT,
  `id_persona` int NOT NULL,
  `nom_c` varchar(50) NOT NULL,
  `marca` varchar(40) NOT NULL,
  `modelo` varchar(30) NOT NULL,
  `placa` varchar(10) NOT NULL,
  `año` varchar(4) NOT NULL,
  `motivo` varchar(50) NOT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `gastos` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_vehiculo`),
  KEY `id_persona` (`id_persona`),
  CONSTRAINT `vehiculo_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiculo`
--

LOCK TABLES `vehiculo` WRITE;
/*!40000 ALTER TABLE `vehiculo` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehiculo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-29 18:00:23
