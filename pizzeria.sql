DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;

/* promocions pizza */
CREATE TABLE IF NOT EXISTS pizzeria.categoria_pizza (
  id INT UNSIGNED NOT NULL,
  nom VARCHAR(45) NOT NULL COMMENT 'nom promoció',
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/* productes a la venda */
CREATE TABLE IF NOT EXISTS pizzeria.producte (
  id INT UNSIGNED NOT NULL,
  tipus ENUM('pizza', 'hamburguesa', 'begudes') NOT NULL,
  id_categoria_pizza INT UNSIGNED NULL DEFAULT NULL COMMENT 'id categoria pizza',
  nom VARCHAR(45) NOT NULL,
  descripcio TEXT NOT NULL,
  imatge VARCHAR(45) NOT NULL COMMENT 'URL imatge',
  preu DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (id, tipus),
  FOREIGN KEY (id_categoria_pizza) REFERENCES pizzeria.categoria_pizza (id),
  INDEX id_categoria_pizza (id_categoria_pizza ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/* provincies */
CREATE TABLE IF NOT EXISTS pizzeria.provincia (
  id INT UNSIGNED NOT NULL,
  nom VARCHAR(45) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/* localitats */
CREATE TABLE IF NOT EXISTS pizzeria.localitat (
  id INT UNSIGNED NOT NULL,
  nom VARCHAR(45) NOT NULL,
  id_provincia INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_provincia) REFERENCES pizzeria.provincia (id),
  INDEX id_provincia (id_provincia ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/* botigues */
CREATE TABLE IF NOT EXISTS pizzeria.botiga (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  adreca VARCHAR(45) NOT NULL,
  numero CHAR(3) NOT NULL,
  codi_postal CHAR(5) NULL DEFAULT NULL,
  id_localitat INT UNSIGNED NOT NULL,
  telefon CHAR(9) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_localitat) REFERENCES pizzeria.localitat (id),
  INDEX codi_postal (codi_postal ASC) VISIBLE,
  INDEX id_localitat (id_localitat ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/* empleats */
CREATE TABLE IF NOT EXISTS pizzeria.empleat (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL,
  cognoms VARCHAR(45) NOT NULL,
  nif CHAR(9) NOT NULL,
  telefon CHAR(9) NOT NULL,
  rol ENUM('cuiner', 'repartidor') NOT NULL,
  id_botiga INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_botiga) REFERENCES pizzeria.botiga (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/* clients */
CREATE TABLE IF NOT EXISTS pizzeria.dades_client (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL,
  cognom1 VARCHAR(45) NOT NULL,
  cognom2 VARCHAR(45) NULL DEFAULT NULL,
  adreca VARCHAR(45) NOT NULL,
  numero CHAR(3) NOT NULL,
  pis CHAR(1) NOT NULL,
  porta CHAR(1) NOT NULL,
  codi_postal CHAR(5) NULL DEFAULT NULL,
  id_localitat INT UNSIGNED NOT NULL,
  telefon CHAR(9) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_localitat) REFERENCES pizzeria.localitat (id),
  INDEX id_localitat (id_localitat ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/* comandes */
CREATE TABLE IF NOT EXISTS pizzeria.comanda (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_botiga INT UNSIGNED NOT NULL COMMENT 'id de la botiga on es fa la comanda',
  data_hora_botiga DATETIME NOT NULL COMMENT 'data i hora de la comanda',
  preu_total DECIMAL(5,2) NULL DEFAULT '0.00' COMMENT 'preu total comanda',
  id_client INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_botiga) REFERENCES pizzeria.botiga (id),
  FOREIGN KEY (id_client) REFERENCES pizzeria.dades_client (id),
  INDEX id_botiga (id_botiga ASC) VISIBLE,
  INDEX id_client (id_client ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/* detall de la comanda: productes i tipus (repartiment a domicili o recollir en botiga */
CREATE TABLE IF NOT EXISTS pizzeria.detall_comanda (
  id_comanda INT UNSIGNED NOT NULL,
  id_pizza INT UNSIGNED NULL,
  id_hamburguesa INT UNSIGNED NULL,
  id_beguda INT UNSIGNED NULL,
  tipus ENUM('repartiment a domicili', 'recollir en botiga') NOT NULL,
  id_empleat INT UNSIGNED NULL DEFAULT NULL COMMENT 'id empleat que entrega la comanda a domicili',
  data_hora_domicili DATETIME NULL DEFAULT NULL COMMENT 'data i hora entrega a domicili',
  FOREIGN KEY (id_comanda) REFERENCES pizzeria.comanda (id),
  FOREIGN KEY (id_pizza) REFERENCES pizzeria.producte (id),
  FOREIGN KEY (id_hamburguesa) REFERENCES pizzeria.producte (id),
  FOREIGN KEY (id_beguda) REFERENCES pizzeria.producte (id),
  FOREIGN KEY (id_empleat) REFERENCES pizzeria.empleat (id),
  INDEX id_comanda (id_comanda ASC) VISIBLE,
  INDEX tipus (tipus ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/* omplim la base dades amb dades de prova */
USE pizzeria;
/* categories pizza */
INSERT INTO pizzeria.categoria_pizza (id, nom) VALUES(1, '3 pizzes mitjanes a 9.45 cadascuna a domicili');
INSERT INTO pizzeria.categoria_pizza (id, nom) VALUES(2, 'Mitjanes a 5.95 a recollir en botiga');
INSERT INTO pizzeria.categoria_pizza (id, nom) VALUES(3, 'Pizza mitjana més beguda a 9.95 a domicili');

/* productes a la venda */
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (1, 'pizza', '1', 'Pizza mitjana Carbonara', 'Masa fresca, doble de bacon, champinyons, salsa carbonara, formatge fos i extra de formatge fos', 'imatges/carbonara.jpg', 9.45);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (2, 'pizza', '1', 'Pizza mitjana Pepperoni', 'La nostra masa de sempre acompanyada de doble racció de pepperoni i formatge fos.', 'imatges/pepperoni.jpg', 9.45);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (3, 'pizza', '1', 'Pizza mitjana 4 formatges', 'Masa fresca, mescla de quatre formatges i tomàquet.', 'imatges/4quesos.jpg', 9.45);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (4, 'pizza', '1', 'Pizza mitjana Barbacoa', 'Masa fresca, bacon, pollastre, formatge fos, salsa barbacoa i doble de carne de bou.', 'imatges/barbacoa.jpg', 9.45);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (5, 'pizza', '2', 'Pizza mitjana Carbonara', 'Masa fresca, doble de bacon, champinyons, salsa carbonara, formatge fos i extra de formatge fos', 'imatges/carbonara.jpg', 5.95);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (6, 'pizza', '2', 'Pizza mitjana Pepperoni', 'La nostra masa de sempre acompanyada de doble racció de pepperoni i formatge fos.', 'imatges/pepperoni.jpg', 5.95);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (7, 'pizza', '2', 'Pizza mitjana 4 formatges', 'Masa fresca, mescla de quatre formatges i tomàquet.', 'imatges/4quesos.jpg', 5.95);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (8, 'pizza', '2', 'Pizza mitjana Barbacoa', 'Masa fresca, bacon, pollastre, formatge fos, salsa barbacoa i doble de carne de bou.', 'imatges/barbacoa.jpg', 5.95);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (9, 'pizza', '3', 'Pizza mitjana Carbonara', 'Masa fresca, doble de bacon, champinyons, salsa carbonara, formatge fos i extra de formatge fos', 'imatges/carbonara.jpg', 7);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (10, 'pizza', '3', 'Pizza mitjana Pepperoni', 'La nostra masa de sempre acompanyada de doble racció de pepperoni i formatge fos.', 'imatges/pepperoni.jpg', 7);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (11, 'pizza', '3', 'Pizza mitjana 4 formatges', 'Masa fresca, mescla de quatre formatges i tomàquet.', 'imatges/4quesos.jpg', 7);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (12, 'pizza', '3', 'Pizza mitjana Barbacoa', 'Masa fresca, bacon, pollastre, formatge fos, salsa barbacoa i doble de carne de bou.', 'imatges/barbacoa.jpg', 7);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (13, 'hamburguesa', null, 'Clàsica', 'La nostra carn a la graella, acompanyada de cogombret, kétchup i mostassa.', 'imatges/burguer.jpg', 4.95);
INSERT INTO pizzeria.producte (id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (14, 'hamburguesa', null, 'Pollastre', 'Carn de pollastre empanat i lleugerament especiat, enciam i maionesa', 'imatges/burguer_pollastre.jpg', 4.95);
INSERT INTO pizzeria.producte (Id, tipus, id_categoria_pizza, nom, descripcio, imatge, preu) VALUES (15, 'begudes', null, 'Coca-Cola', 'Sent la seva màgia', 'imatges/Coca-cola.jpg', 2.95);

/* provincies */
INSERT INTO pizzeria.provincia (id, nom) VALUES(1, 'Barcelona');

/* localitats */
INSERT INTO pizzeria.localitat (id, nom, id_provincia) VALUES(1, 'Igualada', 1);
INSERT INTO pizzeria.localitat (id, nom, id_provincia) VALUES(2, 'Santa Margarida de Montbui', 1);
INSERT INTO pizzeria.localitat (id, nom, id_provincia) VALUES(3, 'Vilanova del Camí', 1);

/* dades botiga */
INSERT INTO pizzeria.botiga (id, adreca, numero, codi_postal, id_localitat, telefon) VALUES(1, 'Avinguada Caresmar', '23', '08700', 1, '938053838');

/* Empleats de la pizzeria */
INSERT INTO empleat (id, nom, cognoms, nif, telefon, rol, id_botiga) VALUES(1, 'Judit', 'Sans Poblet', '26507643M', '621547813', 'repartidor', 1);
INSERT INTO empleat (id, nom, cognoms, nif, telefon, rol, id_botiga) VALUES(2, 'Francesc', 'Hernandez Doncel', '43598611H', '687285193', 'cuiner', 1);
INSERT INTO empleat (id, nom, cognoms, nif, telefon, rol, id_botiga) VALUES(3, 'Anna Maria', 'Verdú Castells', '28568625A', '647276917', 'cuiner', 1);
INSERT INTO empleat (id, nom, cognoms, nif, telefon, rol, id_botiga) VALUES(4, 'Albert', 'Compte Oriol', '98921097Y', '697523748', 'repartidor', 1);

/* dades clients */
INSERT INTO dades_client (id, nom, cognom1, cognom2, adreca, numero, pis, porta, codi_postal, id_localitat, telefon) VALUES(1, 'Jordi','Sanchez', 'Terol', 'Avinguda Jacint Verdaguer', '115', '3', 'A', '08700', 1, '624879245');
INSERT INTO dades_client (id, nom, cognom1, cognom2, adreca, numero, pis, porta, codi_postal, id_localitat, telefon) VALUES(2, 'Anna', 'López', 'Carrillo', 'Carrer Virtut', '56', '4', 'B', '08700', 1, '687541827');
INSERT INTO dades_client (id, nom, cognom1, cognom2, adreca, numero, pis, porta, codi_postal, id_localitat, telefon) VALUES(3, 'Gregori', 'Jimenez', 'Alvarez', 'Carrer Major', '24', '1', 'B', '08788', 3, '699458785');
INSERT INTO dades_client (id, nom, cognom1, cognom2, adreca, numero, pis, porta, codi_postal, id_localitat, telefon) VALUES(4, 'Antonia', 'Perez', 'Cobos', 'Carrer Sant Jordi', '16', '4', 'B', '08710', 3, '632782698');
INSERT INTO dades_client (id, nom, cognom1, cognom2, adreca, numero, pis, porta, codi_postal, id_localitat, telefon) VALUES(5, 'Bernat', 'Figueres', 'Roca', 'Avinguda Barcelona', '145', '5', 'B', '08700', 1, '618205849');
INSERT INTO dades_client (id, nom, cognom1, cognom2, adreca, numero, pis, porta, codi_postal, id_localitat, telefon) VALUES(6, 'Karen', 'Zuñiga', 'Flores', 'Carrer Doctor Fleming', '9', '2', 'B', '08710', 2, '699213515');
INSERT INTO dades_client (id, nom, cognom1, cognom2, adreca, numero, pis, porta, codi_postal, id_localitat, telefon) VALUES(7, 'Alícia', 'Cárdenas', 'Herrera', 'Carrer Santa Maria', '20', '3', 'B','08700', 1, '691452387');

/* dades comanda */
INSERT INTO comanda (id, id_botiga, data_hora_botiga, preu_total, id_client) VALUES (1, 1, '2020-05-18 19:45:12', 28.35, 4);
INSERT INTO comanda (id, id_botiga, data_hora_botiga, preu_total, id_client) VALUES (2, 1, '2020-06-21 20:52:08', 17.8, 6);
INSERT INTO comanda (id, id_botiga, data_hora_botiga, preu_total, id_client) VALUES (3, 1, '2020-09-26 19:56.01', 9.95, 2);

/* detalls de comandes */
INSERT INTO detall_comanda (id_comanda, id_pizza, id_hamburguesa, id_beguda, tipus, id_empleat, data_hora_domicili) VALUES (1, 1, null, null, 'repartiment a domicili', 4, '2020-05-10 22.15:00');
INSERT INTO detall_comanda (id_comanda, id_pizza, id_hamburguesa, id_beguda, tipus, id_empleat, data_hora_domicili) VALUES (1, 2, null, null, 'repartiment a domicili', 4, '2020-05-10 22.15:00');
INSERT INTO detall_comanda (id_comanda, id_pizza, id_hamburguesa, id_beguda, tipus, id_empleat, data_hora_domicili) VALUES (1, 3, null, null, 'repartiment a domicili', 4, '2020-05-10 22.15:00');
INSERT INTO detall_comanda (id_comanda, id_pizza, id_hamburguesa, id_beguda, tipus, id_empleat, data_hora_domicili) VALUES (2, 5, null, 15, 'recollir en botiga', null, null);
INSERT INTO detall_comanda (id_comanda, id_pizza, id_hamburguesa, id_beguda, tipus, id_empleat, data_hora_domicili) VALUES (2, 6, null, 15, 'recollir en botiga', null, null);
INSERT INTO detall_comanda (id_comanda, id_pizza, id_hamburguesa, id_beguda, tipus, id_empleat, data_hora_domicili) VALUES (3, 11, null, 15, 'repartiment a domicili', 1, '2020-06-21 20:52:08');