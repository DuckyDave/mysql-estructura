/* Genera el diagrama 'Entitat - Relació' de la base de dades en SQL per a que l'òptica "Cul d'ampolla" informatitzi la gestió dels seus clients i la venda d'ulleres */
DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;
USE optica;

CREATE TABLE IF NOT EXISTS optica.dades_client (
  id INT UNSIGNED NOT NULL,
  nom VARCHAR(45) NOT NULL COMMENT 'Nom i cognoms del client',
  carrer VARCHAR(45) NOT NULL,
  numero VARCHAR(3) NOT NULL,
  pis VARCHAR(2) NOT NULL,
  porta VARCHAR(1) NOT NULL,
  ciutat VARCHAR(45) NOT NULL,
  codi_postal CHAR(5) NOT NULL,
  telefon CHAR(9) NOT NULL COMMENT 'telèfon de contacte',
  email VARCHAR(45) NOT NULL,
  data_registre DATETIME NOT NULL COMMENT 'Data en la qual la persona es fa client',
  recomanat_per_client_id INT UNSIGNED NULL COMMENT 'Id client existent que li ha recomant fer-se client',
  PRIMARY KEY (id),
  CONSTRAINT
    FOREIGN KEY (recomanat_per_client_id) REFERENCES dades_client (id))
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
  carrer VARCHAR(45) NOT NULL,
  numero VARCHAR(4) NOT NULL,
  pis VARCHAR(2) NULL,
  porta VARCHAR(1) NULL,
  ciutat VARCHAR(45) NOT NULL,
  codi_postal VARCHAR(5) NOT NULL,
  pais VARCHAR(45) NOT NULL,
  telefon CHAR(12) NOT NULL,
  fax CHAR(12) NULL,
  nif CHAR(10) NOT NULL,
  PRIMARY KEY (id),
  INDEX nom (nom ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS optica.marca (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL,
  id_proveidor INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT
	FOREIGN KEY (id_proveidor) REFERENCES proveidor (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS optica.ulleres (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_marca INT UNSIGNED NOT NULL,
  model VARCHAR(45) NOT NULL,
  graduacio_vidre_dret DECIMAL(3,2) NOT NULL,
  graduacio_vidre_esquerre DECIMAL(3,2) NOT NULL,
  montura ENUM('flotant', 'pasta', 'metall') NOT NULL,
  color_montura VARCHAR(45) NOT NULL,
  color_vidre_dret VARCHAR(45) NOT NULL DEFAULT '',
  color_vidre_esquerre VARCHAR(45) NOT NULL DEFAULT '',
  preu DECIMAL(5,2) UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  INDEX id_marca (id_marca ASC) VISIBLE,
  CONSTRAINT 
    FOREIGN KEY (id_marca)
    REFERENCES optica.marca (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS optica.empleat_ha_venut_ulleres (
  id_empleat INT UNSIGNED NOT NULL,
  id_ulleres INT UNSIGNED NOT NULL,
  id_client INT UNSIGNED NOT NULL,
  data_venda DATETIME NOT NULL,
  INDEX id_empleat (id_empleat ASC) INVISIBLE,
  INDEX id_ulleres (id_ulleres ASC) VISIBLE,
  INDEX id_client (id_client ASC) VISIBLE,
  PRIMARY KEY (id_empleat, id_ulleres, id_client),
  CONSTRAINT 
    FOREIGN KEY (id_empleat)
    REFERENCES optica.empleat (id),
  CONSTRAINT 
    FOREIGN KEY (id_ulleres)
    REFERENCES optica.ulleres (id),
  CONSTRAINT 
    FOREIGN KEY (id_client)
    REFERENCES optica.dades_client (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/* Omple la base de dades amb dades de prova */

/* Clients */
INSERT INTO dades_client (id, nom, carrer, numero, pis, porta, ciutat, codi_postal, telefon, email, data_registre, recomanat_per_client_id) VALUES(1, 'Jordi Sanchez Terol', 'Avinguda Jacint Verdaguer', '115', '3', '1', 'Igualada', '08700', '624879245', 'jordi.san@gmail.com', '2016-09-12 10:06:12', null);
INSERT INTO dades_client (id, nom, carrer, numero, pis, porta, ciutat, codi_postal, telefon, email, data_registre, recomanat_per_client_id) VALUES(2, 'Anna López Carrillo', 'Carrer Virtut', '56', '4', '2', 'Igualada', '08700', '687541827', 'anni_lo456@gmail.com','2017-03-05 17:25:03', null);
INSERT INTO dades_client (id, nom, carrer, numero, pis, porta, ciutat, codi_postal, telefon, email, data_registre, recomanat_per_client_id) VALUES(3, 'Gregori Jimenez Alvarez', 'Carrer Major', '24', '1', '2', 'Vilanova del Camí', '08788', '699458785', 'goyo_123@gmail.com', '2018-06-24 11:54:02', 1);
INSERT INTO dades_client (id, nom, carrer, numero, pis, porta, ciutat, codi_postal, telefon, email, data_registre, recomanat_per_client_id) VALUES(4, 'Antonia Perez Cobos', 'Carrer Sant Jordi', '16', '4', '2', 'Santa Margarida de Montbui', '08710', '632782698', 'antonia_perez_45@gmail.com', '2018-10-14 17:16:09', null);
INSERT INTO dades_client (id, nom, carrer, numero, pis, porta, ciutat, codi_postal, telefon, email, data_registre, recomanat_per_client_id) VALUES(5, 'Bernat Figueres Roca', 'Avinguda Barcelona', '145', '5', '2', 'Igualada', '08700', '618205849', 'bernat_figueres_roca@gmail.com', '2019-01-19 11:05:31', 2);
INSERT INTO dades_client (id, nom, carrer, numero, pis, porta, ciutat, codi_postal, telefon, email, data_registre, recomanat_per_client_id) VALUES(6, 'Karen Zuñiga Flores', 'Carrer Doctor. Fleming', '9', '2', '2', 'Santa Margarida de Montbui', '08710', '699213515', 'karen_zuniga@gmail.com', '2019-03-04 10:02:54', 4);
INSERT INTO dades_client (id, nom, carrer, numero, pis, porta, ciutat, codi_postal, telefon, email, data_registre, recomanat_per_client_id)VALUES(7, 'Alícia Cárdenas Herrera', 'Carrer Santa Maria', '20', '3', '2', 'Igualada', '08700', '691452387',  'alicia_cardenasH@gmail.com', '2020-04-09 17:58:12', 6);

/* Empleats de l'òptica */
INSERT INTO empleat VALUES(1, 'Judit');
INSERT INTO empleat VALUES(2, 'Francesc');
INSERT INTO empleat VALUES(3, 'Laia');

/* Proveídors d'ulleres */
INSERT INTO proveidor (id, nom, carrer, numero, pis, porta, ciutat, codi_postal, pais, telefon, fax, nif) VALUES(1, 'Nice Eyewear Group', 'Anniversary Alley', '3097', null, null, 'Norfolk', '23509', 'United States', '757-829-0812', null, '31-6765838');
INSERT INTO proveidor (id, nom, carrer, numero, pis, porta, ciutat, codi_postal, pais, telefon, fax, nif) VALUES(2, 'Carter-Wiegand','Alpine Park', '051', null, null, 'Huntsville', '35895', 'United States', '256-847-7735', null, '68-1369257');
INSERT INTO proveidor (id, nom, carrer, numero, pis, porta, ciutat, codi_postal, pais, telefon, fax, nif) VALUES(3, 'Fortive Corporation', 'Fairfield Hill', '4', null, null, 'Tucson', '85754', 'United States', '520-529-2538', null, '47-4286945');

/* Marques d'ulleres */
INSERT INTO marca VALUES(1, 'Custo Barcelona', 1);
INSERT INTO marca VALUES(2, 'Mango', 2);
INSERT INTO marca VALUES(3,'Pedro del Hierro', 3);

/* Ulleres disponibles */

INSERT INTO ulleres (id, id_marca, model, graduacio_vidre_dret, graduacio_vidre_esquerre, montura, color_montura, color_vidre_dret, color_vidre_esquerre, preu) VALUES(1, 2,'Robert', 1.25, 1.75, 'metall', 'blau', 'marró', 'marró', 184.85);
INSERT INTO ulleres (id, id_marca, model, graduacio_vidre_dret, graduacio_vidre_esquerre, montura, color_montura, color_vidre_dret, color_vidre_esquerre, preu) VALUES(2, 1, 'Shake', 0.75, 0.75, 'pasta', 'burdeus', 'gris', 'gris', 149.85);
INSERT INTO ulleres (id, id_marca, model, graduacio_vidre_dret, graduacio_vidre_esquerre, montura, color_montura, color_vidre_dret, color_vidre_esquerre, preu) VALUES(3, 3, 'Francesca', -0.5, -0.75, 'metall', 'negre', 'violeta','violeta', 199.85);
INSERT INTO ulleres (id, id_marca, model, graduacio_vidre_dret, graduacio_vidre_esquerre, montura, color_montura, color_vidre_dret, color_vidre_esquerre, preu) VALUES(4, 3, 'Antonella', 1.75, 1.25, 'flotant', 'blau', '', '', 188.85);

/* detalls venda ulleres */
INSERT INTO empleat_ha_venut_ulleres (id_empleat, id_ulleres, id_client, data_venda) VALUES(2, 4, 5, '2020-02-26 17:45:00');
INSERT INTO empleat_ha_venut_ulleres (id_empleat, id_ulleres, id_client, data_venda) VALUES(1, 3, 2, '2020-05-05 10.32:21');
INSERT INTO empleat_ha_venut_ulleres (id_empleat, id_ulleres, id_client, data_venda) VALUES(3, 1, 3, '2020-06-19 12.08:16');
INSERT INTO empleat_ha_venut_ulleres (id_empleat, id_ulleres, id_client, data_venda) VALUES(1, 4, 6, '2020-07-08 18.26:12');
INSERT INTO empleat_ha_venut_ulleres (id_empleat, id_ulleres, id_client, data_venda) VALUES(3, 2, 4, '2020-09-30 16:08:52');
INSERT INTO empleat_ha_venut_ulleres (id_empleat, id_ulleres, id_client, data_venda) VALUES(3, 3, 7, '2020-10-17 10:45:08');
INSERT INTO empleat_ha_venut_ulleres (id_empleat, id_ulleres, id_client, data_venda) VALUES(1, 4, 2, '2021-01-14 11.02:45');
INSERT INTO empleat_ha_venut_ulleres (id_empleat, id_ulleres, id_client, data_venda) VALUES(2, 2, 4, '2021-02-05 12.05:21');
INSERT INTO empleat_ha_venut_ulleres (id_empleat, id_ulleres, id_client, data_venda) VALUES(2, 3, 1, '2021-12-15 17:08:52');