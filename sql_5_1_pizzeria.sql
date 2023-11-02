-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`BOTIGA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`BOTIGA` (
  `id_botiga` INT NOT NULL,
  `adresa` VARCHAR(45) NULL,
  `cp` INT NULL,
  `localitat` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  PRIMARY KEY (`id_botiga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COMANDA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COMANDA` (
  `id_comanda` INT NOT NULL,
  `data_hora` INT NOT NULL,
  `domicili` TINYINT NULL,
  `quantitat_prod` INT NULL,
  `preu` DECIMAL(2) NULL,
  `CLIENT_id_client` INT NOT NULL,
  `BOTIGA_id_botiga` INT NOT NULL,
  PRIMARY KEY (`id_comanda`, `CLIENT_id_client`, `BOTIGA_id_botiga`),
  UNIQUE INDEX `data_hora_UNIQUE` (`data_hora` ASC) VISIBLE,
  INDEX `fk_COMANDA_BOTIGA1_idx` (`BOTIGA_id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_COMANDA_BOTIGA1`
    FOREIGN KEY (`BOTIGA_id_botiga`)
    REFERENCES `mydb`.`BOTIGA` (`id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CLIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CLIENT` (
  `id_client` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `cognoms` VARCHAR(45) NULL,
  `adresa` VARCHAR(45) NULL,
  `cp` INT NULL,
  `localitat` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  `telefon` INT NULL,
  `COMANDA_id_comanda` INT NOT NULL,
  `COMANDA_CLIENT_id_client` INT NOT NULL,
  `COMANDA_BOTIGA_id_botiga` INT NOT NULL,
  PRIMARY KEY (`id_client`, `COMANDA_id_comanda`, `COMANDA_CLIENT_id_client`, `COMANDA_BOTIGA_id_botiga`),
  INDEX `fk_CLIENT_COMANDA1_idx` (`COMANDA_id_comanda` ASC, `COMANDA_CLIENT_id_client` ASC, `COMANDA_BOTIGA_id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENT_COMANDA1`
    FOREIGN KEY (`COMANDA_id_comanda` , `COMANDA_CLIENT_id_client` , `COMANDA_BOTIGA_id_botiga`)
    REFERENCES `mydb`.`COMANDA` (`id_comanda` , `CLIENT_id_client` , `BOTIGA_id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTE` (
  `id_prod` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `descripcio` VARCHAR(45) NULL,
  `imatge` BLOB NULL,
  `preu` DECIMAL(2) NULL,
  `COMANDA_id_comanda` INT NOT NULL,
  `COMANDA_CLIENT_id_client` INT NOT NULL,
  PRIMARY KEY (`COMANDA_id_comanda`, `COMANDA_CLIENT_id_client`, `id_prod`),
  CONSTRAINT `fk_PRODUCTE_COMANDA1`
    FOREIGN KEY (`COMANDA_id_comanda` , `COMANDA_CLIENT_id_client`)
    REFERENCES `mydb`.`COMANDA` (`id_comanda` , `CLIENT_id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CATEGORIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CATEGORIA` (
  `id_categoria` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PIZZA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PIZZA` (
  `id_pizza` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `CATEGORIA_id_categoria` INT NOT NULL,
  `PRODUCTE_COMANDA_id_comanda` INT NOT NULL,
  `PRODUCTE_COMANDA_CLIENT_id_client` INT NOT NULL,
  `PRODUCTE_id_prod` INT NOT NULL,
  PRIMARY KEY (`id_pizza`, `CATEGORIA_id_categoria`, `PRODUCTE_COMANDA_id_comanda`, `PRODUCTE_COMANDA_CLIENT_id_client`, `PRODUCTE_id_prod`),
  INDEX `fk_PIZZA_CATEGORIA1_idx` (`CATEGORIA_id_categoria` ASC) VISIBLE,
  INDEX `fk_PIZZA_PRODUCTE1_idx` (`PRODUCTE_COMANDA_id_comanda` ASC, `PRODUCTE_COMANDA_CLIENT_id_client` ASC, `PRODUCTE_id_prod` ASC) VISIBLE,
  CONSTRAINT `fk_PIZZA_CATEGORIA1`
    FOREIGN KEY (`CATEGORIA_id_categoria`)
    REFERENCES `mydb`.`CATEGORIA` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PIZZA_PRODUCTE1`
    FOREIGN KEY (`PRODUCTE_COMANDA_id_comanda` , `PRODUCTE_COMANDA_CLIENT_id_client` , `PRODUCTE_id_prod`)
    REFERENCES `mydb`.`PRODUCTE` (`COMANDA_id_comanda` , `COMANDA_CLIENT_id_client` , `id_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '\n																	';


-- -----------------------------------------------------
-- Table `mydb`.`REPARTIDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`REPARTIDOR` (
  `id_empleat` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `cognoms` VARCHAR(45) NULL,
  `NIF` VARCHAR(45) NULL,
  `telefon` INT NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TREBALLADOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TREBALLADOR` (
  `id_empeat` INT NOT NULL,
  `rol` VARCHAR(45) NULL,
  `BOTIGA_id_botiga` INT NOT NULL,
  `REPARTIDOR_id_empleat` INT NOT NULL,
  PRIMARY KEY (`id_empeat`, `BOTIGA_id_botiga`, `REPARTIDOR_id_empleat`),
  INDEX `fk_TREBALLADOR_BOTIGA1_idx` (`BOTIGA_id_botiga` ASC) VISIBLE,
  INDEX `fk_TREBALLADOR_REPARTIDOR1_idx` (`REPARTIDOR_id_empleat` ASC) VISIBLE,
  CONSTRAINT `fk_TREBALLADOR_BOTIGA1`
    FOREIGN KEY (`BOTIGA_id_botiga`)
    REFERENCES `mydb`.`BOTIGA` (`id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TREBALLADOR_REPARTIDOR1`
    FOREIGN KEY (`REPARTIDOR_id_empleat`)
    REFERENCES `mydb`.`REPARTIDOR` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
