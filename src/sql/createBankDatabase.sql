-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Bank
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Bank` ;

-- -----------------------------------------------------
-- Schema Bank
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Bank` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `Bank` ;

-- -----------------------------------------------------
-- Table `Bank`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bank`.`User` ;

CREATE TABLE IF NOT EXISTS `Bank`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `adress` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bank`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bank`.`Account` ;

CREATE TABLE IF NOT EXISTS `Bank`.`Account` (
  `idAccount` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `balance` DOUBLE NOT NULL,
  `idUser` INT NOT NULL,
  PRIMARY KEY (`idAccount`),
  INDEX `fk_Account_User1_idx` (`idUser` ASC),
  CONSTRAINT `fk_Account_User1`
    FOREIGN KEY (`idUser`)
    REFERENCES `Bank`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bank`.`Transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bank`.`Transaction` ;

CREATE TABLE IF NOT EXISTS `Bank`.`Transaction` (
  `idTransaction` INT NOT NULL AUTO_INCREMENT,
  `amount` DOUBLE NULL,
  `comment` VARCHAR(200) NULL,
  `type` VARCHAR(45) NULL,
  `date` DATETIME NULL,
  `idAccount` INT NOT NULL,
  PRIMARY KEY (`idTransaction`),
  INDEX `fk_Transaction_Account1_idx` (`idAccount` ASC),
  CONSTRAINT `fk_Transaction_Account1`
    FOREIGN KEY (`idAccount`)
    REFERENCES `Bank`.`Account` (`idAccount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- insert data for table user

Delete from user;
INSERT INTO user (name, adress, email,password) VALUES ('name01', 'adress 01', 'email01', 'pass01');
INSERT INTO user (name, adress, email,password) VALUES ('name02', 'adress 02', 'email02', 'pass02');
INSERT INTO user (name, adress, email,password) VALUES ('name03', 'adress 03', 'email03', 'pass03');
INSERT INTO user (name, adress, email,password) VALUES ('name04', 'adress 04', 'email04', 'pass04');
INSERT INTO user (name, adress, email,password) VALUES ('name05', 'adress 05', 'email05', 'pass05');

-- insert data for table account

Delete from account;
INSERT INTO account (date, balance, idUser) VALUES (NOW(), '60000','2');
INSERT INTO account (date, balance, idUser) VALUES (NOW(), '100000','2');
INSERT INTO account (date, balance, idUser) VALUES (NOW(), '70000','3');
INSERT INTO account (date, balance, idUser) VALUES (NOW(), '80000','5');
INSERT INTO account (date, balance, idUser) VALUES (NOW(), '90000','4');
INSERT INTO account (date, balance, idUser) VALUES (NOW(), '100000','2');

-- insert data for table transaction

Delete from transaction;
INSERT INTO transaction (amount, comment, type, date, idAccount) VALUES ('5000','deposit','deposit',NOW(),'2');
INSERT INTO transaction (amount, comment, type, date, idAccount) VALUES ('5000','deposit','deposit',NOW(),'2');
INSERT INTO transaction (amount, comment, type, date, idAccount) VALUES ('2000','withdraw','withdraw',NOW(),'2');
INSERT INTO transaction (amount, comment, type, date, idAccount) VALUES ('6000','deposit','deposit',NOW(),'3');
INSERT INTO transaction (amount, comment, type, date, idAccount) VALUES ('5000','deposit','deposit',NOW(),'4');

 


