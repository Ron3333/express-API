-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.30 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para blog
CREATE DATABASE IF NOT EXISTS `blog` /*!40100 DEFAULT CHARACTER SET utf16 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `blog`;

-- Volcando estructura para tabla blog.articulos
CREATE TABLE IF NOT EXISTS `articulos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `contenido` text NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf16;

-- Volcando datos para la tabla blog.articulos: ~3 rows (aproximadamente)
INSERT INTO `articulos` (`id`, `titulo`, `contenido`, `imagen`, `usuario_id`, `created_at`) VALUES
	(4, 'articulo2', 'dsfsdfdsfdsfsfssfsfsfsdfdsdfs', '5f00f08df4ca937d7c20e456d3f26ba310685.jpg', 1, '2024-09-03 12:19:04'),
	(5, 'articulo7', 'sdfsdfsdfs', 'ExcelsusPerfil1214.jpg', 1, '2024-09-03 12:38:47'),
	(6, 'articulo3', 'dfdsfsdfsdfsd', 'sibelius_perf33817.jpg', 1, '2024-09-03 13:07:51');

-- Volcando estructura para tabla blog.comentarios
CREATE TABLE IF NOT EXISTS `comentarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `articulo_id` int DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  `contenido` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `articulo_id` (`articulo_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`),
  CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- Volcando datos para la tabla blog.comentarios: ~0 rows (aproximadamente)

-- Volcando estructura para tabla blog.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(10) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16;

-- Volcando datos para la tabla blog.rol: ~3 rows (aproximadamente)
INSERT INTO `rol` (`id`, `nombre`) VALUES
	(1, 'usuario'),
	(2, 'admin'),
	(3, 'autor');

-- Volcando estructura para tabla blog.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `rol` (`rol`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol`) REFERENCES `rol` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf16;

-- Volcando datos para la tabla blog.usuarios: ~11 rows (aproximadamente)
INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`, `rol`, `created_at`) VALUES
	(1, 'pepe', 'pepe@gmail.com', '123456', 1, '2024-09-02 14:00:00'),
	(2, 'Juan', 'juan2@email.com', '123456', 2, '2025-03-26 12:34:49'),
	(4, 'Ronald2', 'ronal2d@email.com', '123456', 2, '2025-03-26 17:58:29'),
	(11, 'Ronald2', 'ronald33@email.com', '123456', 2, '2025-03-26 18:22:19'),
	(12, 'Ronald2', 'ronald34@email.com', '123456', 2, '2025-03-26 18:22:30'),
	(14, 'Juan3', 'juan3@email.com', '123456', 2, '2025-03-26 19:39:48'),
	(15, 'Juan4', 'juan4@email.com', '123456', 2, '2025-03-26 19:40:19'),
	(16, 'Juan5', 'juan5@email.com', '123456', 2, '2025-03-26 19:43:12'),
	(19, 'Ronald', 'ronald77@email.com', '123456', 2, '2025-03-26 20:39:55'),
	(20, 'Ronald', 'ronaldmel@email.com', '123456', 2, '2025-03-29 14:18:10'),
	(21, 'tomas', 'tomas@email.com', '123456', 2, '2025-03-30 16:20:11');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
