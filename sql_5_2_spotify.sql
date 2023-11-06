
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`TARJETA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tarjeta` (
  `num_tarjeta` INT NOT NULL,
  `mes_cad` INT NULL,
  `any_cad` INT NULL,
  `codi_seg` VARCHAR(45) NULL,
  PRIMARY KEY (`num_tarjeta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PAYPAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paypal` (
  `usuar_id` INT NOT NULL,
  `nom_usuari` INT NULL,
  PRIMARY KEY (`usuar_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SUBSCRIPCIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`subscripcio` (
  `id_subcripcio` INT NOT NULL,
  `data_inici` DATE NULL,
  `data_renovacio` DATE NULL,
  `es_tarj_cred` TINYINT NULL,
  `TARJETA_num_tarjeta` INT NULL,
  `PAYPAL_usuar_id` INT NULL,
  PRIMARY KEY (`id_subcripcio`, `tarjeta_num_tarjeta`, `paypal_usuar_id`),
  INDEX `fk_SUBSCRIPCIO_TARJETA1_idx` (`tarjeta_num_tarjeta` ASC) VISIBLE,
  INDEX `fk_SUBSCRIPCIO_PAYPAL1_idx` (`PAYPAL_usuar_id` ASC) VISIBLE,
  CONSTRAINT `fk_SUBSCRIPCIO_TARJETA1`
    FOREIGN KEY (`TARJETA_num_tarjeta`)
    REFERENCES `mydb`.`TARJETA` (`num_tarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SUBSCRIPCIO_PAYPAL1`
    FOREIGN KEY (`PAYPAL_usuar_id`)
    REFERENCES `mydb`.`PAYPAL` (`usuar_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`USUARI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuari` (
  `id_usuari` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `nom` VARCHAR(45) NULL,
  `data_neix` DATE NULL,
  `sexe` VARCHAR(1) NULL,
  `pais` VARCHAR(45) NULL,
  `cp` INT NULL,
  `es_premium` TINYINT NULL,
  `subscripcio_id_subcripcio` INT NOT NULL,
  PRIMARY KEY (`id_usuari`, `subscripcio_id_subcripcio`),
  INDEX `fk_USUARI_SUBSCRIPCIO_idx` (`SUBSCRIPCIO_id_subcripcio` ASC) VISIBLE,
  CONSTRAINT `fk_USUARI_SUBSCRIPCIO`
    FOREIGN KEY (`SUBSCRIPCIO_id_subcripcio`)
    REFERENCES `mydb`.`SUBSCRIPCIO` (`id_subcripcio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PAGAMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pagament` (
  `num_ordre` INT NOT NULL,
  `data` DATE NULL,
  `paypal_usuar_id` INT NOT NULL,
  `tarjeta_num_tarjeta` INT NOT NULL,
  PRIMARY KEY (`num_ordre`, `PAYPAL_usuar_id`, `TARJETA_num_tarjeta`),
  INDEX `fk_PAGAMENT_PAYPAL1_idx` (`PAYPAL_usuar_id` ASC) VISIBLE,
  INDEX `fk_PAGAMENT_TARJETA1_idx` (`TARJETA_num_tarjeta` ASC) VISIBLE,
  CONSTRAINT `fk_PAGAMENT_PAYPAL1`
    FOREIGN KEY (`PAYPAL_usuar_id`)
    REFERENCES `mydb`.`PAYPAL` (`usuar_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PAGAMENT_TARJETA1`
    FOREIGN KEY (`TARJETA_num_tarjeta`)
    REFERENCES `mydb`.`TARJETA` (`num_tarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PLAYLIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playlist` (
  `id_playlist` INT NOT NULL,
  `titol` INT NULL,
  `num_cançons` INT NULL,
  `data_crea` DATE NULL,
  `es_eliminada` TINYINT NULL,
  `data_eliminacio` DATE NULL,
  `usuari_id_usuari` INT NOT NULL,
  `usuari_subscripcio_id_subcripcio` INT NOT NULL,
  PRIMARY KEY (`id_playlist`, `USUARI_id_usuari`, `USUARI_SUBSCRIPCIO_id_subcripcio`),
  INDEX `fk_PLAYLIST_USUARI1_idx` (`USUARI_id_usuari` ASC, `USUARI_SUBSCRIPCIO_id_subcripcio` ASC) VISIBLE,
  CONSTRAINT `fk_PLAYLIST_USUARI1`
    FOREIGN KEY (`USUARI_id_usuari` , `USUARI_SUBSCRIPCIO_id_subcripcio`)
    REFERENCES `mydb`.`USUARI` (`id_usuari` , `SUBSCRIPCIO_id_subcripcio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ACTIVA_LIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`activa_list` (
  `agegeix_usr` INT NOT NULL,
  `data_add` DATE NULL,
  PRIMARY KEY (`agegeix_usr`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ARTISTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`artista` (
  `id_artista` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `foto` BLOB NULL,
  `artista_id_artista` INT NOT NULL,
  `usuari_id_usuari` INT NOT NULL,
  `usuari_subscripcio_id_subcripcio` INT NOT NULL,
  PRIMARY KEY (`id_artista`, `artista_id_artista`, `USUARI_id_usuari`, `USUARI_SUBSCRIPCIO_id_subcripcio`),
  INDEX `fk_ARTISTA_ARTISTA1_idx` (`ARTISTA_id_artista` ASC) VISIBLE,
  INDEX `fk_ARTISTA_USUARI1_idx` (`USUARI_id_usuari` ASC, `USUARI_SUBSCRIPCIO_id_subcripcio` ASC) VISIBLE,
  CONSTRAINT `fk_ARTISTA_ARTISTA1`
    FOREIGN KEY (`ARTISTA_id_artista`)
    REFERENCES `mydb`.`ARTISTA` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ARTISTA_USUARI1`
    FOREIGN KEY (`USUARI_id_usuari` , `USUARI_SUBSCRIPCIO_id_subcripcio`)
    REFERENCES `mydb`.`USUARI` (`id_usuari` , `SUBSCRIPCIO_id_subcripcio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `mydb`.`ALBUM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`album` (
  `id_album` INT NOT NULL,
  `titol` VARCHAR(45) NULL,
  `any` DATE NULL,
  `portada` BLOB NULL,
  `artista_id_artista` INT NOT NULL,
  `usuari_id_usuari` INT NOT NULL,
  `usuari_subscripcio_id_subcripcio` INT NOT NULL,
  PRIMARY KEY (`id_album`, `ARTISTA_id_artista`, `USUARI_id_usuari`, `USUARI_SUBSCRIPCIO_id_subcripcio`),
  INDEX `fk_ALBUM_ARTISTA1_idx` (`ARTISTA_id_artista` ASC) VISIBLE,
  INDEX `fk_ALBUM_USUARI1_idx` (`USUARI_id_usuari` ASC, `USUARI_SUBSCRIPCIO_id_subcripcio` ASC) VISIBLE,
  CONSTRAINT `fk_ALBUM_ARTISTA1`
    FOREIGN KEY (`ARTISTA_id_artista`)
    REFERENCES `mydb`.`ARTISTA` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALBUM_USUARI1`
    FOREIGN KEY (`USUARI_id_usuari` , `USUARI_SUBSCRIPCIO_id_subcripcio`)
    REFERENCES `mydb`.`USUARI` (`id_usuari` , `SUBSCRIPCIO_id_subcripcio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CANÇO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`canço` (
  `id_canço` INT NOT NULL,
  `titol` VARCHAR(45) NULL,
  `durada` VARCHAR(45) NULL,
  `num_reprod.` INT NULL,
  `album_id_album` INT NOT NULL,
  `usuari_id_usuari` INT NOT NULL,
  `usuari_subscripcio_id_subcripcio` INT NOT NULL,
  PRIMARY KEY (`id_canço`, `ALBUM_id_album`, `USUARI_id_usuari`, `USUARI_SUBSCRIPCIO_id_subcripcio`),
  INDEX `fk_CANÇO_ALBUM1_idx` (`ALBUM_id_album` ASC) VISIBLE,
  INDEX `fk_CANÇO_USUARI1_idx` (`USUARI_id_usuari` ASC, `USUARI_SUBSCRIPCIO_id_subcripcio` ASC) VISIBLE,
  CONSTRAINT `fk_CANÇO_ALBUM1`
    FOREIGN KEY (`ALBUM_id_album`)
    REFERENCES `mydb`.`ALBUM` (`id_album`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CANÇO_USUARI1`
    FOREIGN KEY (`USUARI_id_usuari` , `USUARI_SUBSCRIPCIO_id_subcripcio`)
    REFERENCES `mydb`.`USUARI` (`id_usuari` , `SUBSCRIPCIO_id_subcripcio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PLAYLIST_has_ACTIVA_LIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PLAYLIST_has_ACTIVA_LIST` (
  `PLAYLIST_id_playlist` INT NOT NULL,
  `PLAYLIST_USUARI_id_usuari` INT NOT NULL,
  `PLAYLIST_USUARI_SUBSCRIPCIO_id_subcripcio` INT NOT NULL,
  `ACTIVA_LIST_agegeix_usr` INT NOT NULL,
  PRIMARY KEY (`PLAYLIST_id_playlist`, `PLAYLIST_USUARI_id_usuari`, `PLAYLIST_USUARI_SUBSCRIPCIO_id_subcripcio`, `ACTIVA_LIST_agegeix_usr`),
  INDEX `fk_PLAYLIST_has_ACTIVA_LIST_ACTIVA_LIST1_idx` (`ACTIVA_LIST_agegeix_usr` ASC) VISIBLE,
  INDEX `fk_PLAYLIST_has_ACTIVA_LIST_PLAYLIST1_idx` (`PLAYLIST_id_playlist` ASC, `PLAYLIST_USUARI_id_usuari` ASC, `PLAYLIST_USUARI_SUBSCRIPCIO_id_subcripcio` ASC) VISIBLE,
  CONSTRAINT `fk_PLAYLIST_has_ACTIVA_LIST_PLAYLIST1`
    FOREIGN KEY (`PLAYLIST_id_playlist` , `PLAYLIST_USUARI_id_usuari` , `PLAYLIST_USUARI_SUBSCRIPCIO_id_subcripcio`)
    REFERENCES `mydb`.`PLAYLIST` (`id_playlist` , `USUARI_id_usuari` , `USUARI_SUBSCRIPCIO_id_subcripcio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PLAYLIST_has_ACTIVA_LIST_ACTIVA_LIST1`
    FOREIGN KEY (`ACTIVA_LIST_agegeix_usr`)
    REFERENCES `mydb`.`ACTIVA_LIST` (`agegeix_usr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
