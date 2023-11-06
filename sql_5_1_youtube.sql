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
-- Table `mydb`.`canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`canal` (
  `id_canal` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `descripcio` VARCHAR(45) NULL,
  `data` DATE NULL,
  `subscripcio_id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_canal`, `subscripcio_id_usuari`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`like_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`like_video` (
  `id_like_video` INT NOT NULL,
  `is_like` TINYINT NULL,
  PRIMARY KEY (`id_like_video`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuari` (
  `id_usuari` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `nom` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `data_neix` DATE NULL,
  `sexe` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `cp` INT NULL,
  `canal_id_canal` INT NOT NULL,
  `like_video_id_like_video` INT NOT NULL,
  PRIMARY KEY (`id_usuari`, `canal_id_canal`, `like_video_id_like_video`),
  INDEX `fk_USUARI_CANAL1_idx` (`canal_id_canal` ASC) VISIBLE,
  INDEX `fk_USUARI_LIKE_VIDEO1_idx` (`like_video_id_like_video` ASC) VISIBLE,
  CONSTRAINT `fk_USUARI_CANAL1`
    FOREIGN KEY (`canal_id_canal`)
    REFERENCES `mydb`.`canal` (`id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USUARI_LIKE_VIDEO1`
    FOREIGN KEY (`like_video_id_like_video`)
    REFERENCES `mydb`.`like_video` (`id_like_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playlist` (
  `id_playlist` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `data` DATE NULL,
  `public` TINYINT NULL,
  `usuari_id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_playlist`, `usuari_id_usuari`),
  INDEX `fk_PLAYLIST_USUARI1_idx` (`usuari_id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_PLAYLIST_USUARI1`
    FOREIGN KEY (`usuari_id_usuari`)
    REFERENCES `mydb`.`usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`video` (
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
  `usuari_id_usuari` INT NOT NULL,
  `estat_id_video` INT NOT NULL,
  `playlist_id_playlist` INT NOT NULL,
  `playlist_usuari_id_usuari` INT NOT NULL,
  `like_video_id_like_video` INT NOT NULL,
  PRIMARY KEY (`id_video`, `usuari_id_usuari`, `estat_id_video`, `playlist_id_playlist`, `playlist_usuari_id_usuari`, `like_video_id_like_video`),
  INDEX `fk_VIDEO_USUARI_idx` (`usuari_id_usuari` ASC) VISIBLE,
  INDEX `fk_VIDEO_PLAYLIST1_idx` (`playlist_id_playlist` ASC, `playlist_usuari_id_usuari` ASC) VISIBLE,
  INDEX `fk_VIDEO_LIKE_VIDEO1_idx` (`like_video_id_like_video` ASC) VISIBLE,
  CONSTRAINT `fk_VIDEO_USUARI`
    FOREIGN KEY (`usuari_id_usuari`)
    REFERENCES `mydb`.`usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VIDEO_PLAYLIST1`
    FOREIGN KEY (`playlist_id_playlist` , `playlist_usuari_id_usuari`)
    REFERENCES `mydb`.`playlist` (`id_playlist` , `usuari_id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VIDEO_LIKE_VIDEO1`
    FOREIGN KEY (`like_video_id_like_video`)
    REFERENCES `mydb`.`like_video` (`id_like_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`etiqueta` (
  `id_etiqueta` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `video_id_video` INT NOT NULL,
  `video_usuari_id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_etiqueta`, `video_id_video`, `video_usuari_id_usuari`),
  INDEX `fk_ETIQUETA_VIDEO1_idx` (`video_id_video` ASC, `video_usuari_id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_ETIQUETA_VIDEO1`
    FOREIGN KEY (`video_id_video` , `video_usuari_id_usuari`)
    REFERENCES `mydb`.`video` (`id_video` , `usuari_id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estat` (
  `public` TINYINT NULL,
  `privat` TINYINT NULL,
  `ocult` TINYINT NULL,
  `video_id_video` INT NOT NULL,
  `video_usuari_id_usuari` INT NOT NULL,
  `video_estat_id_video` INT NOT NULL,
  PRIMARY KEY (`video_id_video`, `video_usuari_id_usuari`, `video_estat_id_video`),
  CONSTRAINT `fk_ESTAT_VIDEO1`
    FOREIGN KEY (`video_id_video` , `video_usuari_id_usuari` , `video_estat_id_video`)
    REFERENCES `mydb`.`video` (`id_video` , `usuari_id_usuari` , `estat_id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`like_comentari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`like_comentari` (
  `usuari_id_usuari` INT NOT NULL,
  `like` TINYINT NULL,
  `data` INT NULL,
  PRIMARY KEY (`usuari_id_usuari`),
  CONSTRAINT `fk_LIKE_COMENTARI_USUARI1`
    FOREIGN KEY (`usuari_id_usuari`)
    REFERENCES `mydb`.`usuari` (`id_usuari`)
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
    REFERENCES `mydb`.`usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMENTARI_VIDEO1`
    FOREIGN KEY (`VIDEO_id_video` , `VIDEO_USUARI_id_usuari` , `VIDEO_ESTAT_id_video`)
    REFERENCES `mydb`.`video` (`id_video` , `usuari_id_usuari` , `estat_id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMENTARI_LIKE_COMENTARI1`
    FOREIGN KEY (`LIKE_COMENTARI_USUARI_id_usuari`)
    REFERENCES `mydb`.`like_comentari` (`usuari_id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuari_has_canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuari_has_canal` (
  `usuari_id_usuari` INT NOT NULL,
  `usuari_canal_id_canal` INT NOT NULL,
  `canal_id_canal` INT NOT NULL,
  PRIMARY KEY (`usuari_id_usuari`, `usuari_canal_id_canal`, `canal_id_canal`),
  INDEX `fk_USUARI_has_CANAL_CANAL1_idx` (`canal_id_canal` ASC) VISIBLE,
  INDEX `fk_USUARI_has_CANAL_USUARI1_idx` (`usuari_id_usuari` ASC, `usuari_canal_id_canal` ASC) VISIBLE,
  CONSTRAINT `fk_USUARI_has_CANAL_USUARI1`
    FOREIGN KEY (`usuari_id_usuari` , `usuari_canal_id_canal`)
    REFERENCES `mydb`.`usuari` (`id_usuari` , `canal_id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USUARI_has_CANAL_CANAL1`
    FOREIGN KEY (`canal_id_canal`)
    REFERENCES `mydb`.`canal` (`id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
