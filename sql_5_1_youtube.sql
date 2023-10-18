CREATE TABLE IF NOT EXISTS `mydb`.`BOTIGA` (
  `id_botiga` INT NOT NULL,
  `adresa` VARCHAR(45) NULL,
  `cp` INT NULL,
  `localitat` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  PRIMARY KEY (`id_botiga`))
ENGINE = InnoDB
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
  INDEX `fk_COMANDA_CLIENT_idx` (`CLIENT_id_client` ASC) VISIBLE,
  INDEX `fk_COMANDA_BOTIGA1_idx` (`BOTIGA_id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_COMANDA_CLIENT`
    FOREIGN KEY (`CLIENT_id_client`)
    REFERENCES `mydb`.`CLIENT` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMANDA_BOTIGA1`
    FOREIGN KEY (`BOTIGA_id_botiga`)
    REFERENCES `mydb`.`BOTIGA` (`id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CREATE TABLE IF NOT EXISTS `mydb`.`TREBALLADOR` (
  `id_empeat` INT NOT NULL,
  `rol` VARCHAR(45) NULL,
  `BOTIGA_id_botiga` INT NOT NULL,
  `REPARTIDOR_id_empleat` INT NULL,
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
ENGINE = InnoDB
CREATE TABLE IF NOT EXISTS `mydb`.`REPARTIDOR` (
  `id_empleat` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `cognoms` VARCHAR(45) NULL,
  `NIF` VARCHAR(45) NULL,
  `telefon` INT NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB
CREATE TABLE IF NOT EXISTS `mydb`.`CLIENT` (
  `id_client` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `cognoms` VARCHAR(45) NULL,
  `adresa` VARCHAR(45) NULL,
  `cp` INT NULL,
  `localitat` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  `telefon` INT NULL,
  PRIMARY KEY (`id_client`))
ENGINE = InnoDB
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTE` (
  `id_prod` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `descripcio` VARCHAR(45) NULL,
  `imatge` BLOB NULL,
  `preu` DECIMAL(2) NULL,
  `COMANDA_id_comanda` INT NULL,
  `COMANDA_CLIENT_id_client` INT NULL,
  `CATEGORIA_id_categoria` INT NULL,
  UNIQUE INDEX `id_prod_UNIQUE` (`id_prod` ASC) VISIBLE,
  PRIMARY KEY (`COMANDA_id_comanda`, `COMANDA_CLIENT_id_client`, `CATEGORIA_id_categoria`),
  INDEX `fk_PRODUCTE_CATEGORIA1_idx` (`CATEGORIA_id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTE_COMANDA1`
    FOREIGN KEY (`COMANDA_id_comanda` , `COMANDA_CLIENT_id_client`)
    REFERENCES `mydb`.`COMANDA` (`id_comanda` , `CLIENT_id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTE_CATEGORIA1`
    FOREIGN KEY (`CATEGORIA_id_categoria`)
    REFERENCES `mydb`.`CATEGORIA` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CREATE TABLE IF NOT EXISTS `mydb`.`CATEGORIA` (
  `id_categoria` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB
CREATE TABLE IF NOT EXISTS `mydb`.`PIZZA` (
  `id_pizza` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `CATEGORIA_id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_pizza`, `CATEGORIA_id_categoria`),
  INDEX `fk_PIZZA_CATEGORIA1_idx` (`CATEGORIA_id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_PIZZA_CATEGORIA1`
    FOREIGN KEY (`CATEGORIA_id_categoria`)
    REFERENCES `mydb`.`CATEGORIA` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB