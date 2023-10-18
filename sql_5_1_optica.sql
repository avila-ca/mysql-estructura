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
  `EMPLEAT_ID_Client` INT NOT NULL,
  `EMPLEAT_id_empleat` INT NOT NULL,
  PRIMARY KEY (`id_ullera`, `id_proveidor`, `EMPLEAT_ID_Client`, `EMPLEAT_id_empleat`),
  INDEX `fk_ULLERES_PROVEIDOR1_idx` (`id_proveidor` ASC) VISIBLE,
  INDEX `fk_ULLERES_EMPLEAT1_idx` (`EMPLEAT_ID_Client` ASC, `EMPLEAT_id_empleat` ASC) VISIBLE,
  CONSTRAINT `fk_ULLERES_PROVEIDOR1`
    FOREIGN KEY (`id_proveidor`)
    REFERENCES `mydb`.`PROVEIDOR` (`id_proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ULLERES_EMPLEAT1`
    FOREIGN KEY (`EMPLEAT_ID_Client` , `EMPLEAT_id_empleat`)
    REFERENCES `mydb`.`EMPLEAT` (`ID_Client` , `id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CREATE TABLE IF NOT EXISTS `mydb`.`EMPLEAT` (
  `id_empleat` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `ID_Client` INT NOT NULL,
  PRIMARY KEY (`ID_Client`, `id_empleat`))
ENGINE = InnoDB
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
    FOREIGN KEY (`CLIENT_ID_Client` , `CLIENT_recomana_IDClient`)
    REFERENCES `mydb`.`CLIENT` (`ID_Client` , `recomana_IDClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

