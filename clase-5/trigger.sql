DROP DATABASE IF EXISTS trigger_db;

CREATE DATABASE trigger_db;

USE trigger_db;


DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(100),
    documento VARCHAR(100),
    PRIMARY KEY (id, documento)
);


DROP TABLE IF EXISTS copia_clientes;

CREATE TABLE copia_clientes (
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(100),
    documento VARCHAR(100),
    fecha_copia DATETIME,
    accion VARCHAR(100)
);


DELIMITER ;;

CREATE TRIGGER insertar_cliente BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO copia_clientes
    VALUES (NEW.nombre, NEW.apellido, NEW.email, NEW.telefono, NEW.documento, NOW(), 'Agregado');
END;;


CREATE TRIGGER actualizar_cliente BEFORE UPDATE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO copia_clientes
    VALUES (NEW.nombre, NEW.apellido, NEW.email, NEW.telefono, NEW.documento, NOW(), 'Modificado');
END;;


CREATE TRIGGER eliminar_cliente BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO copia_clientes
    VALUES (OLD.nombre, OLD.apellido, OLD.email, OLD.telefono, OLD.documento, NOW(), 'Eliminado');
END;;

DELIMITER ;


INSERT INTO clientes (nombre, apellido, email, telefono, documento)
VALUES
('Juan', 'Pérez', 'juanperez@gmail.com', '555-1234', '123456789'),
('María', 'González', 'mariagonzalez@gmail.com', '555-5678', '987654321'),
('Pedro', 'Rodríguez', 'pedrorodriguez@gmail.com', '555-4321', '456789123'),
('Ana', 'Sánchez', 'anasanchez@gmail.com', '555-8765', '321654987'),
('Luis', 'García', 'luisgarcia@gmail.com', '555-2345', '159753468'),
('Laura', 'Martínez', 'lauramartinez@gmail.com', '555-6789', '753951864'),
('Carlos', 'Fernández', 'carlosfernandez@gmail.com', '555-3456', '369258147'),
('Sofía', 'López', 'sofialopez@gmail.com', '555-7890', '258147369'),
('Jorge', 'Díaz', 'jorgediaz@gmail.com', '555-4567', '147258369'),
('Marta', 'Torres', 'martatorres@gmail.com', '555-9012', '456123789'),
('Diego', 'Ruiz', 'diegoruiz@gmail.com', '555-3456', '789456123'),
('Lucía', 'Hernández', 'luciahernandez@gmail.com', '555-7890', '321654987');


UPDATE clientes
SET nombre = 'Nombre mod', apellido = 'Apellido mod', telefono = 'Teléfono mod', documento = 'Documento mod'
WHERE id = 7;


DELETE FROM clientes
WHERE id = 9;


SELECT DISTINCT(documento), nombre, apellido, accion
FROM copia_clientes;


SHOW TRIGGERS;


DROP TRIGGER IF EXISTS insertar_cliente;
