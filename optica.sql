DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;
USE optica;

CREATE TABLE proveedor (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  direccion_postal_id INT NOT NULL,
  telefono VARCHAR(9) NOT NULL,
  fax VARCHAR(9) NOT NULL,
  nif VARCHAR(9) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE gafas (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_proveedor INT UNSIGNED NOT NULL,
  marca VARCHAR(45) NOT NULL,
  graduacion_cristal_derecho DECIMAL(2) ZEROFILL NOT NULL,
  graduacion_cristal_izquierdo DECIMAL(2) ZEROFILL NOT NULL,
  montura ENUM('flotante', 'pasta', 'metalica') NOT NULL,
  color_montura VARCHAR(45) NOT NULL,
  color_cristal_derecho VARCHAR(45) NOT NULL,
  color_cristal_izquierdo VARCHAR(45) NOT NULL,
  precio DECIMAL(2) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE cliente (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  telefono VARCHAR(9) NOT NULL,
  email VARCHAR(45) NOT NULL DEFAULT 'alguien@gmail.com',
  fecha_registro DATETIME NOT NULL,
  PRIMARY KEY (id));
  
  CREATE TABLE empleado (
  id INT AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));
  
  CREATE TABLE direccion_postal (
  id INT NOT NULL AUTO_INCREMENT,
  calle VARCHAR(45) NULL,
  numero INT UNSIGNED NULL,
  piso INT UNSIGNED NULL,
  puerta INT UNSIGNED NULL,
  ciudad VARCHAR(45) NULL,
  codigo_postal VARCHAR(5) NOT NULL,
  pais VARCHAR(45) NULL);
  
  CREATE TABLE venta (
  id_venta INT NOT NULL,
  id_empleado INT NOT NULL,
  id_cliente INT NOT NULL,
  id_gafas INT NOT NULL,
  fecha_venta DATETIME NOT NULL,
  PRIMARY KEY (id_venta, id_empleado, id_cliente, id_gafas));

/*  */
INSERT INTO direccion_postal VALUES ();