DROP DATABASE IF EXISTS procedimientos_almacenados;
CREATE DATABASE procedimientos_almacenados;
USE procedimientos_almacenados;


CREATE TABLE personas (
    id INT NOT NULL AUTO_INCREMENT,
    peso INT NOT NULL,
    estado SET('no admitido', 'admitido') NOT NULL,
    PRIMARY KEY (id)
);

DELIMITER $$

CREATE PROCEDURE puede_donar_sangre(IN _peso INT, OUT _respuesta VARCHAR(20))
BEGIN
    SET @respuesta = 'no admitido';

    IF _peso >= 50 THEN
        SET @respuesta = 'admitido';
    END IF;

    SET _respuesta = @respuesta;

    INSERT INTO personas (peso, estado) VALUES (_peso, _respuesta);
END $$

DELIMITER ;


CREATE TABLE clientes (
    cedula INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    PRIMARY KEY (cedula)
);

DELIMITER $$

CREATE PROCEDURE insertar_cliente(IN _cedula INT, IN _nombre VARCHAR(50), IN _apellido VARCHAR(50))
BEGIN
    INSERT INTO clientes (cedula, nombre, apellido) VALUES (_cedula, _nombre, _apellido);
END $$

CREATE PROCEDURE actualizar_nombre_cliente(IN _cedula INT, IN _nuevo_nombre VARCHAR(50))
BEGIN
    UPDATE clientes SET nombre = _nuevo_nombre WHERE cedula = _cedula;
END $$

CREATE PROCEDURE eliminar_cliente(IN _cedula INT)
BEGIN
    DELETE FROM clientes WHERE cedula = _cedula;
END $$

DELIMITER ;


CREATE TABLE empleados (
    cedula INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    salario_basico INT NOT NULL,
    subsidio_transporte DECIMAL(10, 2) NOT NULL,
    aporte_salud DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (cedula)
);

DELIMITER $$



DELIMITER ;
