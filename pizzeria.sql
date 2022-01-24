DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

CREATE TABLE IF NOT EXISTS pizzeria.categoria_pizza (
  id INT UNSIGNED NOT NULL,
  nom VARCHAR(45) NOT NULL COMMENT 'nom promoció',
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS pizzeria.provincia (
  id INT UNSIGNED NOT NULL,
  nom VARCHAR(45) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS pizzeria.localitat (
  id INT UNSIGNED NOT NULL,
  nom VARCHAR(45) NOT NULL,
  id_provincia INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  INDEX id_provincia (id_provincia ASC) VISIBLE,
  CONSTRAINT 
    FOREIGN KEY (id_provincia)
    REFERENCES pizzeria.provincia (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS pizzeria.dades_botiga (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  adreca VARCHAR(45) NOT NULL,
  numero INT NOT NULL,
  codi_postal VARCHAR(5) NULL DEFAULT NULL,
  id_localitat INT UNSIGNED NOT NULL,
  id_provincia INT UNSIGNED NOT NULL,
  telefon VARCHAR(9) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX codi_postal (codi_postal ASC) VISIBLE,
  INDEX id_localitat (id_localitat ASC) VISIBLE,
  INDEX id_provincia (id_provincia ASC) VISIBLE,
  CONSTRAINT 
    FOREIGN KEY (id_localitat)
    REFERENCES pizzeria.localitat (id),
  CONSTRAINT 
    FOREIGN KEY (id_provincia)
    REFERENCES pizzeria.provincia (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS pizzeria.dades_client (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL,
  cognom1 VARCHAR(45) NOT NULL,
  cognom2 VARCHAR(45) NULL DEFAULT NULL,
  adreca VARCHAR(45) NOT NULL,
  numero INT NOT NULL,
  pis INT NOT NULL,
  porta INT NOT NULL,
  codi_postal VARCHAR(5) NULL DEFAULT NULL,
  id_localitat INT UNSIGNED NOT NULL,
  id_provincia INT UNSIGNED NOT NULL,
  telefon VARCHAR(9) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX codi_postal (codi_postal ASC) VISIBLE,
  INDEX id_localitat (id_localitat ASC) VISIBLE,
  INDEX id_provincia (id_provincia ASC) VISIBLE,
  CONSTRAINT 
    FOREIGN KEY (id_localitat)
    REFERENCES pizzeria.localitat (id),
  CONSTRAINT 
    FOREIGN KEY (id_provincia)
    REFERENCES pizzeria.provincia (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS pizzeria.dades_comanda (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_botiga INT UNSIGNED NOT NULL COMMENT 'id de la botiga on es fa la comanda',
  data_hora_botiga DATETIME NOT NULL COMMENT 'data i hora de la comanda',
  quantitat_pizzes INT UNSIGNED NULL DEFAULT '0',
  quantitat_hamburgeses INT UNSIGNED NULL DEFAULT '0',
  quantitat_begudes INT UNSIGNED NULL DEFAULT '0',
  preu_total DECIMAL(2,0) NULL DEFAULT '0' COMMENT 'preu total comanda',
  PRIMARY KEY (id),
  INDEX id_botiga (id_botiga ASC) VISIBLE,
  CONSTRAINT 
    FOREIGN KEY (id_botiga)
    REFERENCES pizzeria.dades_botiga (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS pizzeria.dades_empleat (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL,
  cognoms VARCHAR(45) NOT NULL,
  nif VARCHAR(9) NOT NULL,
  telefon VARCHAR(9) NOT NULL,
  rol ENUM('cuiner', 'repartidor') NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS pizzeria.detalls_comanda (
  id_comanda INT UNSIGNED NOT NULL,
  tipus ENUM('repartiment a domicili', 'recollir en botiga') NOT NULL,
  id_empleat INT UNSIGNED NULL DEFAULT NULL COMMENT 'id empleat que entrega la comanda a domicili',
  data_hora_domicili DATETIME NULL DEFAULT NULL COMMENT 'data i hora entrega a domicili',
  INDEX id_comanda (id_comanda ASC) VISIBLE,
  INDEX id_empleat (id_empleat ASC) VISIBLE,
  CONSTRAINT 
    FOREIGN KEY (id_comanda)
    REFERENCES pizzeria.dades_comanda (id),
  CONSTRAINT 
    FOREIGN KEY (id_empleat)
    REFERENCES pizzeria.dades_empleat (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS pizzeria.productes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  tipus ENUM('pizza', 'hamburgesa', 'begudes') NOT NULL,
  id_categoria_pizza INT UNSIGNED NULL DEFAULT NULL COMMENT 'id categoria pizza',
  nom VARCHAR(45) NOT NULL,
  descripcio MULTILINESTRING NOT NULL,
  imatge VARCHAR(45) NOT NULL COMMENT 'URL imatge',
  preu DECIMAL(2,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  INDEX id_categoria_pizza (id_categoria_pizza ASC) VISIBLE,
  CONSTRAINT 
    FOREIGN KEY (id_categoria_pizza)
    REFERENCES pizzeria.categoria_pizza (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

