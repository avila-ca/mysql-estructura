
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`PROVEIDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PROVEIDOR` (
  `id_proveidor` INT NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(45) NULL,
  `telefon` INT NULL,
  `fax` INT NULL,
  PRIMARY KEY (`id_proveidor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EMPLEAT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EMPLEAT` (
  `id_empleat` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `ID_Client` INT NOT NULL,
  PRIMARY KEY (`ID_Client`, `id_empleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ULLERES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ULLERES` (
  `id_ullera` INT NOT NULL,
  `marca` VARCHAR(30) NOT NULL,
  `graduacio` DECIMAL(2) NOT NULL,
  `muntura` VARCHAR(45) NOT NULL,
  `colorMuntura` VARCHAR(45) NOT NULL,
  `colorVidre` VARCHAR(45) NOT NULL,
  `preu` DECIMAL(2) NOT NULL,
  `EMPLEAT_ID_Client` INT NOT NULL,
  `EMPLEAT_id_empleat` INT NOT NULL,
  `PROVEIDOR_id_proveidor` INT NOT NULL,
  PRIMARY KEY (`EMPLEAT_ID_Client`, `EMPLEAT_id_empleat`, `id_ullera`, `PROVEIDOR_id_proveidor`),
  INDEX `fk_ULLERES_EMPLEAT1_idx` (`EMPLEAT_ID_Client` ASC, `EMPLEAT_id_empleat` ASC) VISIBLE,
  INDEX `fk_ULLERES_PROVEIDOR1_idx` (`PROVEIDOR_id_proveidor` ASC) VISIBLE,
  CONSTRAINT `fk_ULLERES_EMPLEAT1`
    FOREIGN KEY (`EMPLEAT_ID_Client` , `EMPLEAT_id_empleat`)
    REFERENCES `mydb`.`EMPLEAT` (`ID_Client` , `id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ULLERES_PROVEIDOR1`
    FOREIGN KEY (`PROVEIDOR_id_proveidor`)
    REFERENCES `mydb`.`PROVEIDOR` (`id_proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `mydb`.`CLIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CLIENT` (
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
-- Table `mydb`.`EMPLEAT_has_CLIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EMPLEAT_has_CLIENT` (
  `EMPLEAT_ID_Client` INT NOT NULL,
  `EMPLEAT_id_empleat` INT NOT NULL,
  `CLIENT_ID_Client` INT NOT NULL,
  `CLIENT_recomana_IDClient` INT NOT NULL,
  PRIMARY KEY (`EMPLEAT_ID_Client`, `EMPLEAT_id_empleat`, `CLIENT_ID_Client`, `CLIENT_recomana_IDClient`),
  INDEX `fk_EMPLEAT_has_CLIENT_CLIENT1_idx` (`CLIENT_ID_Client` ASC, `CLIENT_recomana_IDClient` ASC) VISIBLE,
  INDEX `fk_EMPLEAT_has_CLIENT_EMPLEAT1_idx` (`EMPLEAT_ID_Client` ASC, `EMPLEAT_id_empleat` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLEAT_has_CLIENT_EMPLEAT1`
    FOREIGN KEY (`EMPLEAT_ID_Client` , `EMPLEAT_id_empleat`)
    REFERENCES `mydb`.`EMPLEAT` (`ID_Client` , `id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEAT_has_CLIENT_CLIENT1`
    FOREIGN KEY (`CLIENT_recomana_IDClient`)
    REFERENCES `mydb`.`CLIENT` (`recomana_IDClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
