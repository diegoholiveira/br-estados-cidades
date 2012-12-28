-- -----------------------------------------------------
--
-- Exemplo de estrutura do banco de dados para MySQL
--
-- -----------------------------------------------------

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `tb_state`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tb_state` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `short_name` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tb_city`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tb_city` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `state_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `FK_CITY_STATE`
    FOREIGN KEY (`state_id` )
    REFERENCES `tb_state` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `IDX_STATE_CITY` ON `tb_city` (`state_id` ASC) ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
