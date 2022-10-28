-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema stratovarius_db
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema musicstore
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema musicstore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `musicstore` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `musicstore` ;

-- -----------------------------------------------------
-- Table `musicstore`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `musicstore`.`rol` (
  `id_rol` VARCHAR(50) NOT NULL,
  `descripcion_rol` VARCHAR(260) NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `musicstore`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `musicstore`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(250) NULL DEFAULT NULL,
  `apellidos` VARCHAR(250) NULL DEFAULT NULL,
  `correo` VARCHAR(250) NULL DEFAULT NULL,
  `usuario` VARCHAR(250) NOT NULL,
  `id_rol` VARCHAR(50) NULL DEFAULT NULL,
  `img` BLOB NULL DEFAULT NULL,
  `sexo` VARCHAR(50) NULL DEFAULT NULL,
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `fecha_ingreso` DATE NULL DEFAULT NULL,
  `tipo` VARCHAR(50) NULL DEFAULT NULL,
  `contrasena` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `id_rol` (`id_rol` ASC) VISIBLE,
  CONSTRAINT `usuarios_ibfk_1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `musicstore`.`rol` (`id_rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `musicstore`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `musicstore`.`categorias` (
  `id_categoria` VARCHAR(250) NOT NULL,
  `usuario` VARCHAR(250) NULL DEFAULT NULL,
  `descripcion` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`id_categoria`),
  INDEX `usuario` (`usuario` ASC) VISIBLE,
  CONSTRAINT `categorias_ibfk_1`
    FOREIGN KEY (`usuario`)
    REFERENCES `musicstore`.`usuarios` (`usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `musicstore`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `musicstore`.`productos` (
  `id_producto` INT NULL,
  `nombre_producto` VARCHAR(250) NOT NULL,
  `precio` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_categoria` VARCHAR(250) NULL DEFAULT NULL,
  `cantidad` INT NULL DEFAULT NULL,
  `tipo` VARCHAR(50) NULL DEFAULT NULL,
  `valoracion` INT NULL DEFAULT NULL,
  `estatus` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`nombre_producto`),
  INDEX `id_categoria` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `productos_ibfk_1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `musicstore`.`categorias` (`id_categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `musicstore`.`carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `musicstore`.`carrito` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre_producto` VARCHAR(250) NULL DEFAULT NULL,
  `precio` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_categoria` VARCHAR(250) NULL DEFAULT NULL,
  `cantidad` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `nombre_producto_idx` (`nombre_producto` ASC) VISIBLE,
  CONSTRAINT `nombre_producto`
    FOREIGN KEY (`nombre_producto`)
    REFERENCES `musicstore`.`productos` (`nombre_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `musicstore`.`comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `musicstore`.`comentarios` (
  `id_comentario` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(250) NULL DEFAULT NULL,
  `comentario` VARCHAR(250) NULL DEFAULT NULL,
  `fecha_comentario` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_comentario`),
  INDEX `usuario_idx` (`usuario` ASC) VISIBLE,
  CONSTRAINT `usuario`
    FOREIGN KEY (`usuario`)
    REFERENCES `musicstore`.`usuarios` (`usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `musicstore`.`compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `musicstore`.`compras` (
  `id_compra` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(250) NULL DEFAULT NULL,
  `tipo_venta` VARCHAR(250) NULL DEFAULT NULL,
  `nombre_producto` VARCHAR(250) NULL DEFAULT NULL,
  `vendedor` VARCHAR(250) NULL DEFAULT NULL,
  `fecha_hora` DATETIME NULL DEFAULT NULL,
  `precio` DECIMAL(10,2) NULL,
  `comprascol` VARCHAR(45) NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `usuario_idx` (`usuario` ASC) VISIBLE,
  INDEX `nombre_producto_idx` (`nombre_producto` ASC) VISIBLE,
  INDEX `rol_idx` (`tipo_venta` ASC) VISIBLE,
  CONSTRAINT `usuario`
    FOREIGN KEY (`usuario`)
    REFERENCES `musicstore`.`usuarios` (`usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `nombre_producto`
    FOREIGN KEY (`nombre_producto`)
    REFERENCES `musicstore`.`productos` (`nombre_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rol`
    FOREIGN KEY (`tipo_venta`)
    REFERENCES `musicstore`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `musicstore`.`listas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `musicstore`.`listas` (
  `nombre_lista` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(250) NULL DEFAULT NULL,
  `img` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`nombre_lista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `musicstore`.`obj_lista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `musicstore`.`obj_lista` (
  `nombre_lista` VARCHAR(250) NULL,
  `descripcion` VARCHAR(250) NULL DEFAULT NULL,
  `precio` DECIMAL(10,2) NULL DEFAULT NULL,
  `nombre_producto` VARCHAR(50) NULL,
  `cantidad` INT NOT NULL,
  `id_obj` INT NULL,
  `obj_listacol` INT NOT NULL,
  PRIMARY KEY (`obj_listacol`),
  INDEX `nombre_lista_idx` (`nombre_lista` ASC) VISIBLE,
  INDEX `nombre_producto_idx` (`nombre_producto` ASC) VISIBLE,
  CONSTRAINT `nombre_lista`
    FOREIGN KEY (`nombre_lista`)
    REFERENCES `musicstore`.`listas` (`nombre_lista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `nombre_producto`
    FOREIGN KEY (`nombre_producto`)
    REFERENCES `musicstore`.`productos` (`nombre_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
