-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema VendiCoseSpa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema VendiCoseSpa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `VendiCoseSpa` DEFAULT CHARACTER SET utf8 ;
USE `VendiCoseSpa` ;

-- -----------------------------------------------------
-- Table `VendiCoseSpa`.`Regione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VendiCoseSpa`.`Regione` (
  `ID` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendiCoseSpa`.`Citta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VendiCoseSpa`.`Citta` (
  `ID` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Regione_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `Regione_ID`),
  INDEX `fk_Citta_Regione_idx` (`Regione_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Citta_Regione`
    FOREIGN KEY (`Regione_ID`)
    REFERENCES `VendiCoseSpa`.`Regione` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendiCoseSpa`.`Magazzino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VendiCoseSpa`.`Magazzino` (
  `ID` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Citta_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `Citta_ID`),
  INDEX `fk_Magazzino_Citta1_idx` (`Citta_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Magazzino_Citta1`
    FOREIGN KEY (`Citta_ID`)
    REFERENCES `VendiCoseSpa`.`Citta` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendiCoseSpa`.`PuntoVendita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VendiCoseSpa`.`PuntoVendita` (
  `ID` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Magazzino_ID` INT NOT NULL,
  `Citta_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `Magazzino_ID`, `Citta_ID`),
  INDEX `fk_PuntoVendita_Magazzino1_idx` (`Magazzino_ID` ASC) VISIBLE,
  INDEX `fk_PuntoVendita_Citta1_idx` (`Citta_ID` ASC) VISIBLE,
  CONSTRAINT `fk_PuntoVendita_Magazzino1`
    FOREIGN KEY (`Magazzino_ID`)
    REFERENCES `VendiCoseSpa`.`Magazzino` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PuntoVendita_Citta1`
    FOREIGN KEY (`Citta_ID`)
    REFERENCES `VendiCoseSpa`.`Citta` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendiCoseSpa`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VendiCoseSpa`.`Categoria` (
  `ID` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendiCoseSpa`.`Prodotto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VendiCoseSpa`.`Prodotto` (
  `ID` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Categoria_ID` INT NOT NULL,
  `PrezzoListino` DECIMAL(10,2) NULL,
  PRIMARY KEY (`ID`, `Categoria_ID`),
  INDEX `fk_Prodotto_Categoria1_idx` (`Categoria_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Prodotto_Categoria1`
    FOREIGN KEY (`Categoria_ID`)
    REFERENCES `VendiCoseSpa`.`Categoria` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendiCoseSpa`.`OrdiniMagazzino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VendiCoseSpa`.`OrdiniMagazzino` (
  `ID` INT NOT NULL,
  `PuntoVendita_ID` INT NOT NULL,
  `Prodotto_ID` INT NOT NULL,
  `Data` DATE NULL,
  `Rifornimento` INT NULL,
  PRIMARY KEY (`ID`, `PuntoVendita_ID`, `Prodotto_ID`),
  INDEX `fk_OrdiniMagazzino_PuntoVendita1_idx` (`PuntoVendita_ID` ASC) VISIBLE,
  INDEX `fk_OrdiniMagazzino_Prodotto1_idx` (`Prodotto_ID` ASC) VISIBLE,
  CONSTRAINT `fk_OrdiniMagazzino_PuntoVendita1`
    FOREIGN KEY (`PuntoVendita_ID`)
    REFERENCES `VendiCoseSpa`.`PuntoVendita` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrdiniMagazzino_Prodotto1`
    FOREIGN KEY (`Prodotto_ID`)
    REFERENCES `VendiCoseSpa`.`Prodotto` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendiCoseSpa`.`StockMagazzino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VendiCoseSpa`.`StockMagazzino` (
  `Magazzino_ID` INT NOT NULL,
  `Prodotto_ID` INT NOT NULL,
  `Quantita` INT NULL,
  PRIMARY KEY (`Magazzino_ID`, `Prodotto_ID`),
  INDEX `fk_StockMagazzino_Magazzino1_idx` (`Magazzino_ID` ASC) VISIBLE,
  INDEX `fk_StockMagazzino_Prodotto1_idx` (`Prodotto_ID` ASC) VISIBLE,
  CONSTRAINT `fk_StockMagazzino_Magazzino1`
    FOREIGN KEY (`Magazzino_ID`)
    REFERENCES `VendiCoseSpa`.`Magazzino` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StockMagazzino_Prodotto1`
    FOREIGN KEY (`Prodotto_ID`)
    REFERENCES `VendiCoseSpa`.`Prodotto` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendiCoseSpa`.`StockPuntoVendita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VendiCoseSpa`.`StockPuntoVendita` (
  `Prodotto_ID` INT NOT NULL,
  `PuntoVendita_ID` INT NOT NULL,
  `Quantita` INT NULL,
  PRIMARY KEY (`Prodotto_ID`, `PuntoVendita_ID`),
  INDEX `fk_StockPuntoVendita_Prodotto1_idx` (`Prodotto_ID` ASC) VISIBLE,
  INDEX `fk_StockPuntoVendita_PuntoVendita1_idx` (`PuntoVendita_ID` ASC) VISIBLE,
  CONSTRAINT `fk_StockPuntoVendita_Prodotto1`
    FOREIGN KEY (`Prodotto_ID`)
    REFERENCES `VendiCoseSpa`.`Prodotto` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StockPuntoVendita_PuntoVendita1`
    FOREIGN KEY (`PuntoVendita_ID`)
    REFERENCES `VendiCoseSpa`.`PuntoVendita` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendiCoseSpa`.`Vendita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VendiCoseSpa`.`Vendita` (
  `ID` INT NOT NULL,
  `PuntoVendita_ID` INT NOT NULL,
  `Prodotto_ID` INT NOT NULL,
  `Quantita` INT NULL,
  `Data` DATE NULL,
  `Prezzo` DECIMAL(10,2) NULL,
  PRIMARY KEY (`ID`, `PuntoVendita_ID`, `Prodotto_ID`),
  INDEX `fk_Vendita_PuntoVendita1_idx` (`PuntoVendita_ID` ASC) VISIBLE,
  INDEX `fk_Vendita_Prodotto1_idx` (`Prodotto_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Vendita_PuntoVendita1`
    FOREIGN KEY (`PuntoVendita_ID`)
    REFERENCES `VendiCoseSpa`.`PuntoVendita` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vendita_Prodotto1`
    FOREIGN KEY (`Prodotto_ID`)
    REFERENCES `VendiCoseSpa`.`Prodotto` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VendiCoseSpa`.`Restock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VendiCoseSpa`.`Restock` (
  `LivelloRestock` INT NULL,
  `Categoria_ID` INT NOT NULL,
  `Magazzino_ID` INT NOT NULL,
  `Rifornimento` INT NULL,
  PRIMARY KEY (`Categoria_ID`, `Magazzino_ID`),
  INDEX `fk_Restock_Categoria1_idx` (`Categoria_ID` ASC) VISIBLE,
  INDEX `fk_Restock_Magazzino1_idx` (`Magazzino_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Restock_Categoria1`
    FOREIGN KEY (`Categoria_ID`)
    REFERENCES `VendiCoseSpa`.`Categoria` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Restock_Magazzino1`
    FOREIGN KEY (`Magazzino_ID`)
    REFERENCES `VendiCoseSpa`.`Magazzino` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
