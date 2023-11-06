
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`proveidor` (
  `id_proveidor` INT NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(45) NULL,
  `telefon` INT NULL,
  `fax` INT NULL,
  PRIMARY KEY (`id_proveidor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleat` (
  `id_empleat` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ulleres` (
  `id_ullera` INT NOT NULL,
  `marca` VARCHAR(30) NOT NULL,
  `graduacio` DECIMAL(2) NOT NULL,
  `muntura` VARCHAR(45) NOT NULL,
  `colorMuntura` VARCHAR(45) NOT NULL,
  `colorVidre` VARCHAR(45) NOT NULL,
  `preu` DECIMAL(2) NOT NULL,
  `proveidor_id_proveidor` INT NOT NULL,
  `empleat_ID_Client` INT NOT NULL,
  `empleat_id_empleat` INT NOT NULL,
  PRIMARY KEY (`id_ullera`, `proveidor_id_proveidor`, `empleat_ID_Client`, `empleat_id_empleat`),
  INDEX `fk_ulleres_proveidor1_idx` (`proveidor_id_proveidor` ASC) VISIBLE,
  INDEX `fk_ulleres_empleat1_idx` (`empleat_ID_Client` ASC, `empleat_id_empleat` ASC) VISIBLE,
  CONSTRAINT `fk_ulleres_proveidor1`
    FOREIGN KEY (`proveidor_id_proveidor`)
    REFERENCES `mydb`.`proveidor` (`id_proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ulleres_empleat1`
    FOREIGN KEY (`empleat_id_empleat`)
    REFERENCES `mydb`.`empleat` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `mydb`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`client` (
  `id_client` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(45) NULL,
  `telefon` INT NULL,
  `correu` VARCHAR(45) NULL,
  `regData` DATE NULL,
  `recomana_IDClient` INT NOT NULL,
  PRIMARY KEY (`recomana_IDClient`, `id_client`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleat_has_client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleat_has_client` (
  `empleat_id_empleat` INT NOT NULL,
  `client_recomana_IDClient` INT NOT NULL,
  `client_id_client` INT NOT NULL,
  PRIMARY KEY (`empleat_id_empleat`, `client_recomana_IDClient`, `client_id_client`),
  INDEX `fk_empleat_has_client_client1_idx` (`client_recomana_IDClient` ASC, `client_id_client` ASC) VISIBLE,
  INDEX `fk_empleat_has_client_empleat1_idx` (`empleat_id_empleat` ASC) VISIBLE,
  CONSTRAINT `fk_empleat_has_client_empleat1`
    FOREIGN KEY (`empleat_id_empleat`)
    REFERENCES `mydb`.`empleat` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleat_has_client_client1`
    FOREIGN KEY (`client_recomana_IDClient` , `client_id_client`)
    REFERENCES `mydb`.`client` (`recomana_IDClient` , `id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
