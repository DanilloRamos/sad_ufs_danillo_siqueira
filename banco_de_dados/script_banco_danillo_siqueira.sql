-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sgaplus_d
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sgaplus_d
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sgaplus_d` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `sgaplus_d` ;

-- -----------------------------------------------------
-- Table `sgaplus_d`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgaplus_d`.`services` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `initials` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `sgaplus_d`.`attendances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgaplus_d`.`attendances` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `position` INT(11) NULL DEFAULT NULL,
  `service_id` INT(11) NULL DEFAULT NULL,
  `hour` DATETIME NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `type_attendance` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `called` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `attendances_service_id_fk` (`service_id` ASC),
  CONSTRAINT `attendances_service_id_fk`
    FOREIGN KEY (`service_id`)
    REFERENCES `sgaplus_d`.`services` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `sgaplus_d`.`called_passwords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgaplus_d`.`called_passwords` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `attendance_id` INT(11) NULL DEFAULT NULL,
  `guiche` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `called_passwords_attendance_id_fk` (`attendance_id` ASC),
  CONSTRAINT `called_passwords_attendance_id_fk`
    FOREIGN KEY (`attendance_id`)
    REFERENCES `sgaplus_d`.`attendances` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `sgaplus_d`.`patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgaplus_d`.`patients` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `cpf` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `record_number` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `sgaplus_d`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgaplus_d`.`permissions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `object_type` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `action_name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `index_permissions_on_object_type_and_action_name` (`object_type` ASC, `action_name` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `sgaplus_d`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgaplus_d`.`roles` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `index_roles_on_name` (`name` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `sgaplus_d`.`permissions_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgaplus_d`.`permissions_roles` (
  `permission_id` INT(11) NOT NULL,
  `role_id` INT(11) NOT NULL,
  INDEX `index_permissions_roles_on_permission_id_and_role_id` (`permission_id` ASC, `role_id` ASC),
  INDEX `index_permissions_roles_on_role_id_and_permission_id` (`role_id` ASC, `permission_id` ASC),
  CONSTRAINT `permissions_roles_permission_id_fk`
    FOREIGN KEY (`permission_id`)
    REFERENCES `sgaplus_d`.`permissions` (`id`),
  CONSTRAINT `permissions_roles_role_id_fk`
    FOREIGN KEY (`role_id`)
    REFERENCES `sgaplus_d`.`roles` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `sgaplus_d`.`roles_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgaplus_d`.`roles_users` (
  `user_id` INT(11) NOT NULL,
  `role_id` INT(11) NOT NULL,
  INDEX `index_roles_users_on_user_id_and_role_id` (`user_id` ASC, `role_id` ASC),
  INDEX `index_roles_users_on_role_id_and_user_id` (`role_id` ASC, `user_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `sgaplus_d`.`schema_migrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgaplus_d`.`schema_migrations` (
  `version` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  UNIQUE INDEX `unique_schema_migrations` (`version` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `sgaplus_d`.`ticket_windows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgaplus_d`.`ticket_windows` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `sgaplus_d`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgaplus_d`.`users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL DEFAULT '',
  `encrypted_password` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL DEFAULT '',
  `reset_password_token` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `reset_password_sent_at` DATETIME NULL DEFAULT NULL,
  `remember_created_at` DATETIME NULL DEFAULT NULL,
  `sign_in_count` INT(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` DATETIME NULL DEFAULT NULL,
  `last_sign_in_at` DATETIME NULL DEFAULT NULL,
  `current_sign_in_ip` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `last_sign_in_ip` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `is_admin` TINYINT(1) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT NULL,
  `role_id` INT(11) NULL DEFAULT NULL,
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `image` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `index_users_on_email` (`email` ASC),
  UNIQUE INDEX `index_users_on_reset_password_token` (`reset_password_token` ASC),
  INDEX `users_role_id_fk` (`role_id` ASC),
  CONSTRAINT `users_role_id_fk`
    FOREIGN KEY (`role_id`)
    REFERENCES `sgaplus_d`.`roles` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
