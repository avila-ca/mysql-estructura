
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`botiga` (
  `id_botiga` INT NOT NULL,
  `adresa` VARCHAR(45) NULL,
  `cp` INT NULL,
  `localitat` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  PRIMARY KEY (`id_botiga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comanda` (
  `id_comanda` INT NOT NULL,
  `data_hora` INT NOT NULL,
  `domicili` TINYINT NULL,
  `quantitat_prod` INT NULL,
  `preu` DECIMAL(2) NULL,
  `client_id_client` INT NOT NULL,
  `botiga_id_botiga` INT NOT NULL,
  PRIMARY KEY (`id_comanda`, `client_id_client`, `botiga_id_botiga`),
  UNIQUE INDEX `data_hora_UNIQUE` (`data_hora` ASC) VISIBLE,
  INDEX `fk_COMANDA_BOTIGA1_idx` (`botiga_id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_COMANDA_BOTIGA1`
    FOREIGN KEY (`botiga_id_botiga`)
    REFERENCES `mydb`.`botiga` (`id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`client` (
  `id_client` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `cognoms` VARCHAR(45) NULL,
  `adresa` VARCHAR(45) NULL,
  `cp` INT NULL,
  `localitat` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  `telefon` INT NULL,
  `comanda_id_comanda` INT NOT NULL,
  `comanda_client_id_client` INT NOT NULL,
  `comanda_botiga_id_botiga` INT NOT NULL,
  PRIMARY KEY (`id_client`, `comanda_id_comanda`, `comanda_client_id_client`, `comanda_botiga_id_botiga`),
  INDEX `fk_CLIENT_COMANDA1_idx` (`comanda_id_comanda` ASC, `comanda_client_id_client` ASC, `comanda_botiga_id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENT_COMANDA1`
    FOREIGN KEY (`comanda_id_comanda` , `comanda_client_id_client` , `comanda_botiga_id_botiga`)
    REFERENCES `mydb`.`comanda` (`id_comanda` , `client_id_client` , `botiga_id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producte` (
  `id_prod` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `descripcio` VARCHAR(45) NULL,
  `imatge` BLOB NULL,
  `preu` DECIMAL(2) NULL,
  `comanda_id_comanda` INT NOT NULL,
  `comanda_client_id_client` INT NOT NULL,
  PRIMARY KEY (`comanda_id_comanda`, `comanda_client_id_client`, `id_prod`),
  CONSTRAINT `fk_PRODUCTE_COMANDA1`
    FOREIGN KEY (`comanda_id_comanda` , `comanda_client_id_client`)
    REFERENCES `mydb`.`comanda` (`id_comanda` , `client_id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `id_categoria` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pizza` (
  `id_pizza` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `categoria_id_categoria` INT NOT NULL,
  `producte_comanda_id_comanda` INT NOT NULL,
  `producte_comanda_client_id_client` INT NOT NULL,
  `producte_id_prod` INT NOT NULL,
  PRIMARY KEY (`id_pizza`, `categoria_id_categoria`, `producte_comanda_id_comanda`, `producte_comanda_client_id_client`, `producte_id_prod`),
  INDEX `fk_PIZZA_CATEGORIA1_idx` (`categoria_id_categoria` ASC) VISIBLE,
  INDEX `fk_PIZZA_PRODUCTE1_idx` (`producte_comanda_id_comanda` ASC, `producte_comanda_client_id_client` ASC, `producte_id_prod` ASC) VISIBLE,
  CONSTRAINT `fk_PIZZA_CATEGORIA1`
    FOREIGN KEY (`categoria_id_categoria`)
    REFERENCES `mydb`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PIZZA_PRODUCTE1`
    FOREIGN KEY (`producte_comanda_id_comanda` , `producte_comanda_client_id_client` , `producte_id_prod`)
    REFERENCES `mydb`.`producte` (`comanda_id_comanda` , `comanda_client_id_client` , `id_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '\n																	';


-- -----------------------------------------------------
-- Table `mydb`.`repartidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`repartidor` (
  `id_empleat` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `cognoms` VARCHAR(45) NULL,
  `NIF` VARCHAR(45) NULL,
  `telefon` INT NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`treballador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`treballador` (
  `id_empeat` INT NOT NULL,
  `rol` VARCHAR(45) NULL,
  `botiga_id_botiga` INT NOT NULL,
  `repartidor_id_empleat` INT NOT NULL,
  PRIMARY KEY (`id_empeat`, `botiga_id_botiga`, `repartidor_id_empleat`),
  INDEX `fk_TREBALLADOR_BOTIGA1_idx` (`botiga_id_botiga` ASC) VISIBLE,
  INDEX `fk_TREBALLADOR_REPARTIDOR1_idx` (`repartidor_id_empleat` ASC) VISIBLE,
  CONSTRAINT `fk_TREBALLADOR_BOTIGA1`
    FOREIGN KEY (`botiga_id_botiga`)
    REFERENCES `mydb`.`botiga` (`id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TREBALLADOR_REPARTIDOR1`
    FOREIGN KEY (`repartidor_id_empleat`)
    REFERENCES `mydb`.`repartidor` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
