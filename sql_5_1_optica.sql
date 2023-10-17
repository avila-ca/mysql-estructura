CREATE TABLE IF NOT EXISTS `mydb`.`PROVEIDOR` (
  `NIF` VARCHAR(9) NOT NULL,
  `nom` VARCHAR(45) NULL,
  `adreça` VARCHAR(45) NULL,
  `telefon` INT NULL,
  `fax` INT NULL,
  `id_proveidor` INT NOT NULL,
  PRIMARY KEY (`id_proveidor`))
ENGINE = InnoDB
CREATE TABLE IF NOT EXISTS `mydb`.`ULLERES` (
  `marca` VARCHAR(30) NOT NULL,
  `graduacio` DECIMAL(2) NULL,
  `muntura` VARCHAR(45) NULL,
  `colorMuntura` VARCHAR(45) NULL,
  `colorVidre` VARCHAR(45) NULL,
  `preu` DECIMAL(2) NULL,
  `id_ullera` INT NOT NULL,
  `id_proveidor` INT NOT NULL,
  PRIMARY KEY (`id_ullera`, `id_proveidor`),
  INDEX `fk_ULLERES_PROVEIDOR1_idx` (`id_proveidor` ASC) VISIBLE,
  CONSTRAINT `fk_ULLERES_PROVEIDOR1`
    FOREIGN KEY (`id_proveidor`)
    REFERENCES `mydb`.`PROVEIDOR` (`id_proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CREATE TABLE IF NOT EXISTS `mydb`.`EMPLEAT` (
  `id_empleat` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `ID_Client` INT NOT NULL,
  `id_ullera` INT NOT NULL,
  PRIMARY KEY (`ID_Client`, `id_ullera`, `id_empleat`),
  INDEX `fk_empleat_CLIENT1_idx` (`ID_Client` ASC) VISIBLE,
  INDEX `fk_EMPLEAT_ULLERES1_idx` (`id_ullera` ASC) VISIBLE,
  CONSTRAINT `fk_empleat_CLIENT1`
    FOREIGN KEY (`ID_Client`)
    REFERENCES `mydb`.`CLIENT` (`ID_Client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEAT_ULLERES1`
    FOREIGN KEY (`id_ullera`)
    REFERENCES `mydb`.`ULLERES` (`id_ullera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CREATE TABLE IF NOT EXISTS `mydb`.`CLIENT` (
  `nom` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(45) NOT NULL,
  `telefon` INT NULL,
  `correu` VARCHAR(45) NULL,
  `regData` DATE NULL,
  `ID_Client` INT NOT NULL,
  `recomana_IDClient` INT NULL,
  PRIMARY KEY (`ID_Client`),
  INDEX `fk_CLIENT_CLIENT1_idx` (`recomana_IDClient` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENT_CLIENT1`
    FOREIGN KEY (`recomana_IDClient`)
    REFERENCES `mydb`.`CLIENT` (`ID_Client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB