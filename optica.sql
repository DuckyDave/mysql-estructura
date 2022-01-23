/* Genera el diagrama 'Entitat - Relació' de la base de dades en SQL per a que l'òptica "Cul d'ampolla" informatitzi la gestió dels seus clients i la venda d'ulleres */
DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;
USE optica;

CREATE TABLE IF NOT EXISTS optica.dades_client (
  id INT UNSIGNED NOT NULL,
  nom VARCHAR(45) NOT NULL COMMENT 'Nom i cognoms del client',
  telefon VARCHAR(9) NOT NULL COMMENT 'telèfon de contacte',
  carrer VARCHAR(45) NOT NULL,
  pis INT UNSIGNED NOT NULL,
  email VARCHAR(45) NOT NULL DEFAULT 'algu@gmail.com',
  porta INT UNSIGNED NOT NULL,
  ciutat VARCHAR(45) NOT NULL,
  codi_postal VARCHAR(5) NOT NULL DEFAULT '00000',
  pais VARCHAR(45) NOT NULL,
  data_registre DATETIME NOT NULL COMMENT 'Data en la qual la persona es fa client',
  recomanat_per_client_id INT UNSIGNED NULL COMMENT 'Id client existent que li ha recomant fer-se client',
  PRIMARY KEY (id),
  UNIQUE INDEX fecha_registro_UNIQUE (data_registre ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS optica.empleat (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL COMMENT 'nom de qui ven ulleres',
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS optica.proveidor (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL,
  carrrer VARCHAR(45) NOT NULL,
  numero INT UNSIGNED NOT NULL,
  pis INT UNSIGNED NOT NULL,
  porta INT UNSIGNED NOT NULL,
  telefon VARCHAR(9) NOT NULL,
  fax VARCHAR(9) NOT NULL,
  nif VARCHAR(9) NOT NULL DEFAULT '12345678A',
  ciutat VARCHAR(45) NOT NULL,
  codi_postal VARCHAR(5) NOT NULL DEFAULT '00000',
  pais VARCHAR(45) NOT NULL DEFAULT 'USA',
  PRIMARY KEY (id),
  INDEX nom (nom ASC) VISIBLE,
  UNIQUE INDEX nif_UNIQUE (nif ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS optica.marca (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX nombre (nom ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS optica.ulleres (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_proveidor INT UNSIGNED NOT NULL,
  id_marca INT UNSIGNED NOT NULL,
  graduacio_vidre_dret DECIMAL(2,0) NOT NULL,
  graduacio_vidre_esquerre DECIMAL(2,0) NOT NULL,
  montura ENUM('flotant', 'pasta', 'metall') NOT NULL,
  color_montura VARCHAR(45) NOT NULL,
  color_vidre_dret VARCHAR(45) NOT NULL DEFAULT 'transparent',
  color_vidre_esquerre VARCHAR(45) NOT NULL DEFAULT 'transparent',
  preu DECIMAL(2,0) UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  INDEX id_proveidor (id_proveidor ASC) VISIBLE,
  INDEX id_marca (id_marca ASC) VISIBLE,
  CONSTRAINT 
    FOREIGN KEY (id_proveidor)
    REFERENCES optica.proveidor (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT 
    FOREIGN KEY (id_marca)
    REFERENCES optica.marca (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS optica.empleat_ha_venut_ulleres (
  id_empleat INT UNSIGNED NOT NULL,
  id_ulleres INT UNSIGNED NOT NULL,
  id_client INT UNSIGNED NOT NULL,
  data_venta DATETIME NULL,
  UNIQUE INDEX data_venda (data_venta ASC) VISIBLE,
  INDEX id_empleat (id_empleat ASC) INVISIBLE,
  INDEX id_ulleres (id_ulleres ASC) VISIBLE,
  INDEX id_client (id_client ASC) VISIBLE,
  PRIMARY KEY (id_empleat, id_ulleres, id_client),
  CONSTRAINT 
    FOREIGN KEY (id_empleat)
    REFERENCES optica.empleat (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT 
    FOREIGN KEY (id_ulleres)
    REFERENCES optica.ulleres (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT 
    FOREIGN KEY (id_client)
    REFERENCES optica.dades_client (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
