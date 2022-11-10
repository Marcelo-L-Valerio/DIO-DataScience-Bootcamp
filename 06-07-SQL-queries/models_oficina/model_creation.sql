-- MySQL Script generated by MySQL Workbench
-- Wed Nov  9 23:42:51 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema machine_shop
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `machine_shop` ;

-- -----------------------------------------------------
-- Schema machine_shop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `machine_shop` DEFAULT CHARACTER SET utf8 ;
USE `machine_shop` ;

-- -----------------------------------------------------
-- Table `machine_shop`.`Clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `machine_shop`.`Clients` ;

CREATE TABLE IF NOT EXISTS `machine_shop`.`Clients` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  `is_pf` TINYINT NOT NULL,
  `cpf` VARCHAR(11) NULL,
  `cnpj` CHAR(14) NULL,
  `address` VARCHAR(150) NOT NULL,
  `cellphone` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `machine_shop`.`Vehicles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `machine_shop`.`Vehicles` ;

CREATE TABLE IF NOT EXISTS `machine_shop`.`Vehicles` (
  `idVehicle` INT NOT NULL AUTO_INCREMENT,
  `vehicle_type` ENUM('Carro', 'Caminhão', 'Moto') NOT NULL DEFAULT 'Carro',
  `automaker` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `vehicle_year` YEAR(4) NOT NULL,
  `idClient` INT NOT NULL,
  `license` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`idVehicle`, `idClient`),
  INDEX `fk_Veiculo_Cliente1_idx` (`idClient` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente1`
    FOREIGN KEY (`idClient`)
    REFERENCES `machine_shop`.`Clients` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `machine_shop`.`Order_of_service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `machine_shop`.`Order_of_service` ;

CREATE TABLE IF NOT EXISTS `machine_shop`.`Order_of_service` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `emission_date` DATE NOT NULL,
  `order_status` ENUM('Fazendo cotação', 'Aguardando aprovação', 'Em execução', 'Concluido') NOT NULL,
  `delivery_preview` DATE NULL,
  `idVehicle` INT NOT NULL,
  PRIMARY KEY (`idOrder`, `idVehicle`),
  INDEX `fk_Ordem de serviço_Veiculo1_idx` (`idVehicle` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de serviço_Veiculo1`
    FOREIGN KEY (`idVehicle`)
    REFERENCES `machine_shop`.`Vehicles` (`idVehicle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `machine_shop`.`Service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `machine_shop`.`Service` ;

CREATE TABLE IF NOT EXISTS `machine_shop`.`Service` (
  `idService` INT NOT NULL AUTO_INCREMENT,
  `labor` FLOAT NOT NULL,
  `service_desc` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idService`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `machine_shop`.`Has_service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `machine_shop`.`Has_service` ;

CREATE TABLE IF NOT EXISTS `machine_shop`.`Has_service` (
  `idOrder` INT NOT NULL,
  `idService` INT NOT NULL,
  PRIMARY KEY (`idOrder`, `idService`),
  INDEX `fk_Ordem de serviço_has_Serviço_Serviço1_idx` (`idService` ASC) VISIBLE,
  INDEX `fk_Ordem de serviço_has_Serviço_Ordem de serviço_idx` (`idOrder` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de serviço_has_Serviço_Ordem de serviço`
    FOREIGN KEY (`idOrder`)
    REFERENCES `machine_shop`.`Order_of_service` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de serviço_has_Serviço_Serviço1`
    FOREIGN KEY (`idService`)
    REFERENCES `machine_shop`.`Service` (`idService`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `machine_shop`.`Pieces`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `machine_shop`.`Pieces` ;

CREATE TABLE IF NOT EXISTS `machine_shop`.`Pieces` (
  `idPiece` INT NOT NULL AUTO_INCREMENT,
  `price` FLOAT NOT NULL,
  `piece_desc` VARCHAR(45) NOT NULL,
  `automaker` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPiece`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `machine_shop`.`Mechanical`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `machine_shop`.`Mechanical` ;

CREATE TABLE IF NOT EXISTS `machine_shop`.`Mechanical` (
  `idMechanical` INT NOT NULL AUTO_INCREMENT,
  `mechanical_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `specialty` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMechanical`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `machine_shop`.`Works_on`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `machine_shop`.`Works_on` ;

CREATE TABLE IF NOT EXISTS `machine_shop`.`Works_on` (
  `idOrder` INT NOT NULL,
  `idMechanical` INT NOT NULL,
  PRIMARY KEY (`idOrder`, `idMechanical`),
  INDEX `fk_Ordem de serviço_has_Mecânico_Mecânico1_idx` (`idMechanical` ASC) VISIBLE,
  INDEX `fk_Ordem de serviço_has_Mecânico_Ordem de serviço1_idx` (`idOrder` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de serviço_has_Mecânico_Ordem de serviço1`
    FOREIGN KEY (`idOrder`)
    REFERENCES `machine_shop`.`Order_of_service` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de serviço_has_Mecânico_Mecânico1`
    FOREIGN KEY (`idMechanical`)
    REFERENCES `machine_shop`.`Mechanical` (`idMechanical`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `machine_shop`.`Uses_piece`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `machine_shop`.`Uses_piece` ;

CREATE TABLE IF NOT EXISTS `machine_shop`.`Uses_piece` (
  `idOrder` INT NOT NULL,
  `idPiece` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`idOrder`, `idPiece`),
  INDEX `fk_Ordem de serviço_has_peça_peça1_idx` (`idPiece` ASC) VISIBLE,
  INDEX `fk_Ordem de serviço_has_peça_Ordem de serviço1_idx` (`idOrder` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de serviço_has_peça_Ordem de serviço1`
    FOREIGN KEY (`idOrder`)
    REFERENCES `machine_shop`.`Order_of_service` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de serviço_has_peça_peça1`
    FOREIGN KEY (`idPiece`)
    REFERENCES `machine_shop`.`Pieces` (`idPiece`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
