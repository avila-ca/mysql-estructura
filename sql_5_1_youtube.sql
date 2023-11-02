SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`CANAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CANAL` (
  `id_canal` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `descripcio` VARCHAR(45) NULL,
  `data` DATE NULL,
  `subscripcio_id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_canal`, `subscripcio_id_usuari`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LIKE_VIDEO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LIKE_VIDEO` (
  `id_like_video` INT NOT NULL,
  `is_like` TINYINT NULL,
  PRIMARY KEY (`id_like_video`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`USUARI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`USUARI` (
  `id_usuari` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `nom` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `data_neix` DATE NULL,
  `sexe` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `cp` INT NULL,
  `CANAL_id_canal` INT NOT NULL,
  `LIKE_VIDEO_id_like_video` INT NOT NULL,
  PRIMARY KEY (`id_usuari`, `CANAL_id_canal`, `LIKE_VIDEO_id_like_video`),
  INDEX `fk_USUARI_CANAL1_idx` (`CANAL_id_canal` ASC) VISIBLE,
  INDEX `fk_USUARI_LIKE_VIDEO1_idx` (`LIKE_VIDEO_id_like_video` ASC) VISIBLE,
  CONSTRAINT `fk_USUARI_CANAL1`
    FOREIGN KEY (`CANAL_id_canal`)
    REFERENCES `mydb`.`CANAL` (`id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USUARI_LIKE_VIDEO1`
    FOREIGN KEY (`LIKE_VIDEO_id_like_video`)
    REFERENCES `mydb`.`LIKE_VIDEO` (`id_like_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PLAYLIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PLAYLIST` (
  `id_playlist` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `data` DATE NULL,
  `public` TINYINT NULL,
  `USUARI_id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_playlist`, `USUARI_id_usuari`),
  INDEX `fk_PLAYLIST_USUARI1_idx` (`USUARI_id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_PLAYLIST_USUARI1`
    FOREIGN KEY (`USUARI_id_usuari`)
    REFERENCES `mydb`.`USUARI` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`VIDEO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VIDEO` (
  `id_video` INT NOT NULL,
  `titol` VARCHAR(45) NULL,
  `descripcio` VARCHAR(45) NULL,
  `grandaria` INT NULL,
  `nom_arxiu` VARCHAR(45) NULL,
  `durada` VARCHAR(45) NULL,
  `thumbnail` BLOB NULL,
  `reproduccions` INT NULL,
  `likes` INT NULL,
  `dislikes` INT NULL,
  `data_crea` DATETIME NULL,
  `USUARI_id_usuari` INT NOT NULL,
  `ESTAT_id_video` INT NOT NULL,
  `PLAYLIST_id_playlist` INT NOT NULL,
  `PLAYLIST_USUARI_id_usuari` INT NOT NULL,
  `LIKE_VIDEO_id_like_video` INT NOT NULL,
  PRIMARY KEY (`id_video`, `USUARI_id_usuari`, `ESTAT_id_video`, `PLAYLIST_id_playlist`, `PLAYLIST_USUARI_id_usuari`, `LIKE_VIDEO_id_like_video`),
  INDEX `fk_VIDEO_USUARI_idx` (`USUARI_id_usuari` ASC) VISIBLE,
  INDEX `fk_VIDEO_PLAYLIST1_idx` (`PLAYLIST_id_playlist` ASC, `PLAYLIST_USUARI_id_usuari` ASC) VISIBLE,
  INDEX `fk_VIDEO_LIKE_VIDEO1_idx` (`LIKE_VIDEO_id_like_video` ASC) VISIBLE,
  CONSTRAINT `fk_VIDEO_USUARI`
    FOREIGN KEY (`USUARI_id_usuari`)
    REFERENCES `mydb`.`USUARI` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VIDEO_PLAYLIST1`
    FOREIGN KEY (`PLAYLIST_id_playlist` , `PLAYLIST_USUARI_id_usuari`)
    REFERENCES `mydb`.`PLAYLIST` (`id_playlist` , `USUARI_id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VIDEO_LIKE_VIDEO1`
    FOREIGN KEY (`LIKE_VIDEO_id_like_video`)
    REFERENCES `mydb`.`LIKE_VIDEO` (`id_like_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ETIQUETA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ETIQUETA` (
  `id_etiqueta` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `VIDEO_id_video` INT NOT NULL,
  `VIDEO_USUARI_id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_etiqueta`, `VIDEO_id_video`, `VIDEO_USUARI_id_usuari`),
  INDEX `fk_ETIQUETA_VIDEO1_idx` (`VIDEO_id_video` ASC, `VIDEO_USUARI_id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_ETIQUETA_VIDEO1`
    FOREIGN KEY (`VIDEO_id_video` , `VIDEO_USUARI_id_usuari`)
    REFERENCES `mydb`.`VIDEO` (`id_video` , `USUARI_id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ESTAT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ESTAT` (
  `public` TINYINT NULL,
  `privat` TINYINT NULL,
  `ocult` TINYINT NULL,
  `VIDEO_id_video` INT NOT NULL,
  `VIDEO_USUARI_id_usuari` INT NOT NULL,
  `VIDEO_ESTAT_id_video` INT NOT NULL,
  PRIMARY KEY (`VIDEO_id_video`, `VIDEO_USUARI_id_usuari`, `VIDEO_ESTAT_id_video`),
  CONSTRAINT `fk_ESTAT_VIDEO1`
    FOREIGN KEY (`VIDEO_id_video` , `VIDEO_USUARI_id_usuari` , `VIDEO_ESTAT_id_video`)
    REFERENCES `mydb`.`VIDEO` (`id_video` , `USUARI_id_usuari` , `ESTAT_id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LIKE_COMENTARI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LIKE_COMENTARI` (
  `USUARI_id_usuari` INT NOT NULL,
  `like` TINYINT NULL,
  `data` INT NULL,
  PRIMARY KEY (`USUARI_id_usuari`),
  CONSTRAINT `fk_LIKE_COMENTARI_USUARI1`
    FOREIGN KEY (`USUARI_id_usuari`)
    REFERENCES `mydb`.`USUARI` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COMENTARI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COMENTARI` (
  `id_comentari` INT NOT NULL,
  `text` VARCHAR(45) NULL,
  `data` DATETIME NULL,
  `USUARI_id_usuari` INT NOT NULL,
  `VIDEO_id_video` INT NOT NULL,
  `VIDEO_USUARI_id_usuari` INT NOT NULL,
  `VIDEO_ESTAT_id_video` INT NOT NULL,
  `LIKE_COMENTARI_USUARI_id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_comentari`, `USUARI_id_usuari`, `VIDEO_id_video`, `VIDEO_USUARI_id_usuari`, `VIDEO_ESTAT_id_video`, `LIKE_COMENTARI_USUARI_id_usuari`),
  INDEX `fk_COMENTARI_USUARI1_idx` (`USUARI_id_usuari` ASC) VISIBLE,
  INDEX `fk_COMENTARI_VIDEO1_idx` (`VIDEO_id_video` ASC, `VIDEO_USUARI_id_usuari` ASC, `VIDEO_ESTAT_id_video` ASC) VISIBLE,
  INDEX `fk_COMENTARI_LIKE_COMENTARI1_idx` (`LIKE_COMENTARI_USUARI_id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_COMENTARI_USUARI1`
    FOREIGN KEY (`USUARI_id_usuari`)
    REFERENCES `mydb`.`USUARI` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMENTARI_VIDEO1`
    FOREIGN KEY (`VIDEO_id_video` , `VIDEO_USUARI_id_usuari` , `VIDEO_ESTAT_id_video`)
    REFERENCES `mydb`.`VIDEO` (`id_video` , `USUARI_id_usuari` , `ESTAT_id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMENTARI_LIKE_COMENTARI1`
    FOREIGN KEY (`LIKE_COMENTARI_USUARI_id_usuari`)
    REFERENCES `mydb`.`LIKE_COMENTARI` (`USUARI_id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`USUARI_has_CANAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`USUARI_has_CANAL` (
  `USUARI_id_usuari` INT NOT NULL,
  `USUARI_CANAL_id_canal` INT NOT NULL,
  `CANAL_id_canal` INT NOT NULL,
  PRIMARY KEY (`USUARI_id_usuari`, `USUARI_CANAL_id_canal`, `CANAL_id_canal`),
  INDEX `fk_USUARI_has_CANAL_CANAL1_idx` (`CANAL_id_canal` ASC) VISIBLE,
  INDEX `fk_USUARI_has_CANAL_USUARI1_idx` (`USUARI_id_usuari` ASC, `USUARI_CANAL_id_canal` ASC) VISIBLE,
  CONSTRAINT `fk_USUARI_has_CANAL_USUARI1`
    FOREIGN KEY (`USUARI_id_usuari` , `USUARI_CANAL_id_canal`)
    REFERENCES `mydb`.`USUARI` (`id_usuari` , `CANAL_id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USUARI_has_CANAL_CANAL1`
    FOREIGN KEY (`CANAL_id_canal`)
    REFERENCES `mydb`.`CANAL` (`id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
