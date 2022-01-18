DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

CREATE TABLE IF NOT EXISTS clients (
  client_id INT NOT NULL,
  nom VARCHAR(45) NULL,
  cognoms VARCHAR(45) NULL,
  adreca VARCHAR(45) NULL,
  codi_postal VARCHAR(5) NULL,
  provincia_id INT NULL,
  localitat_id INT NULL,
  telefon VARCHAR(9) NULL,
  PRIMARY KEY (client_id));

CREATE TABLE IF NOT EXISTS localitats (
  localitat_id INT NOT NULL,
  nom VARCHAR(45) NULL,
  PRIMARY KEY (localitat_id));

CREATE TABLE IF NOT EXISTS provincies (
  provincia_id INT NOT NULL,
  nom VARCHAR(45) NULL,
  PRIMARY KEY (provincia_id));

CREATE TABLE IF NOT EXISTS comandes (
  comandes_id INT NOT NULL,
  data_hora DATETIME NULL,
  tipus ENUM('repartiment a domicili', 'recollir en botiga') NULL,
  quantitat_pizzes INT NULL,
  quantitat_hamburgeses INT NULL,
  quantitat_begudes INT NULL,
  preu_total VARCHAR(45) NULL,
  empleat_id INT NULL,
  data_hora_lliurament DATETIME NULL,
  PRIMARY KEY (comandes_id));

CREATE TABLE IF NOT EXISTS productes (
  producte_id INT NOT NULL,
  nom VARCHAR(45) NULL,
  descripcio MULTILINESTRING NULL,
  imatge BLOB NULL,
  categoria_id INT NULL,
  PRIMARY KEY (producte_id));



CREATE TABLE IF NOT EXISTS categories (
  categories_id INT NOT NULL,
  nom VARCHAR(45) NULL,
  PRIMARY KEY (categories_id));

CREATE TABLE IF NOT EXISTS botigues (
  botiga_id INT NOT NULL,
  adreca VARCHAR(45) NULL,
  codi_postal VARCHAR(45) NULL,
  localitat_id INT NULL,
  provincia_id INT NULL,
  PRIMARY KEY (botiga_id));

CREATE TABLE IF NOT EXISTS empleats (
  empleat_id INT NOT NULL,
  nom VARCHAR(45) NULL,
  cognoms VARCHAR(45) NULL,
  nif VARCHAR(9) NULL,
  telefon VARCHAR(9) NULL,
  rol ENUM('cuiner', 'repartidor') NULL,
  PRIMARY KEY (empleat_id));