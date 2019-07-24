-- ID fields currently require manual entry, will change to auto_increment once we have a linked and functioning webform for each


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema GamersE3
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `GamersE3` DEFAULT CHARACTER SET utf8 ;
USE `GamersE3`;

-- -----------------------------------------------------
-- Table `GamersE3`.`UserInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GamersE3`.`UserInfo` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `email` VARCHAR(75) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `UserID_UNIQUE` (`UserID` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GamersE3`.`GameInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GamersE3`.`GameInfo` (
  `GameID` INT NOT NULL AUTO_INCREMENT,
  `GameName` VARCHAR(45) NOT NULL,
  `BoxArt` LONGBLOB,
  `ConferenceShown` VARCHAR(45) NULL,
  `Genre` VARCHAR(45) NULL,
  `Developer` VARCHAR(45) NOT NULL,
  `Publisher` VARCHAR(45) NOT NULL,
  `ReleaseDate` DATE NULL,
  `MetacriticScore` INT NULL,
  `Info` VARCHAR(1000) NULL,
  PRIMARY KEY (`GameID`),
  UNIQUE INDEX `GameID_UNIQUE` (`GameID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GamersE3`.`UserSubscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GamersE3`.`UserSubscriptions` (
  `UserID` INT NOT NULL,
  `GameID` INT NOT NULL,
  INDEX `fk_UserSubscriptions_UserInfo_idx` (`UserID` ASC) VISIBLE,
  INDEX `fk_UserSubscriptions_GameInfo1_idx` (`GameID` ASC) VISIBLE,
  PRIMARY KEY (`UserID`, `GameID`),
  CONSTRAINT `fk_UserSubscriptions_UserInfo`
    FOREIGN KEY (`UserID`)
    REFERENCES `GamersE3`.`UserInfo` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserSubscriptions_GameInfo1`
    FOREIGN KEY (`GameID`)
    REFERENCES `GamersE3`.`GameInfo` (`GameID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into UserInfo(UserID,firstname,lastname,email,password)
Values(00000001,'sam','koulermos','sako0518@colorado.edu','password1'),
(00000002,'michael','ren','mire@colorado.edu','password2'),
(00000003,'fake','name','fname@gmail.com','fakepassword'),
(00000004,'james','denbow','jade@colorado.edu','password3'),
(00000005,'marvin','nguyen','mang@colorado.edu','password4');

insert into GameInfo(GameID,GameName,ConferenceShown,Genre,Developer,Publisher,ReleaseDate,MetacriticScore,Info)
Values(00000001,'Cyberpunk 2077','Microsoft','Role-playing','CD Project Red','CD Project','20200416',0,' Adapted from the 1988 tabletop game Cyberpunk 2020, it is set fifty-seven years later in dystopian Night City, California, an open world with six distinct regions. In a first-person perspective, players assume the role of the customisable mercenary V, who can reach prominence in three character classes by applying experience points to stat upgrades. V has an arsenal of ranged weapons and options for melee combat.'),
(00000002,'The Legend of Zelda: Links Awakening','Nintendo Direct','Action-adventure','Nintendo EPD Grezzo','Nintendo','20190920',0,'The Legend of Zelda: Links Awakening is an upcoming action-adventure game developed by Nintendo EPD and Grezzo, and published by Nintendo for the Nintendo Switch. It is a remake of the 1993 game for the Game Boy that retains the original titles top-down perspective and gameplay, along with elements from the 1998 remaster Links Awakening DX. The remake features a "retro-modern" art style unique within the series with toy-like character designs, diorama-like world designs, and tilt-shift visuals that evoke the original games presentation on the Game Boy. It also features customizable dungeons which the player can create and then complete for rewards.'),
(00000003,'My Friend Pedro','Deveolver Digital','Shoot em up','DeadToast Entertainment','Devolver Digital','20190620',81,'My Friend Pedro involves the player traversing a variety of themed levels while killing enemies in a stylish fashion. The game iterates on the gameplay featured in the flash game, including similar controls, mechanics and weaponry. Along with the ability to slow time, the player can now kick objects or enemies, split their aim between targets and dodge bullets by spinning. The game also features parkour elements such as flips, wall jumps and rolls, which can be used to increase the number of points awarded. Another new feature allows players to kill enemies by ricocheting bullets off frying pans or signs, which also adds to the point total.');

