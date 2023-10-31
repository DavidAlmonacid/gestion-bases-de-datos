DROP DATABASE IF EXISTS procedimientos_almacenados;
CREATE DATABASE procedimientos_almacenados;
USE procedimientos_almacenados;


CREATE TABLE personas (
    id INT NOT NULL AUTO_INCREMENT,
    peso INT NOT NULL,
    estado SET('no admitido', 'admitido') NOT NULL,
    PRIMARY KEY (id)
);

DELIMITER //
CREATE PROCEDURE puede_donar_sangre (IN _peso INT, OUT _respuesta VARCHAR(20))
BEGIN
    SET @respuesta = 'no admitido';

    IF _peso >= 50 THEN
        SET @respuesta = 'admitido';
    END IF;

    SET _respuesta = @respuesta;

    INSERT INTO personas (peso, estado) VALUES (_peso, _respuesta);
END;
//

DELIMITER ;


CREATE TABLE clientes (
    cedula INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    PRIMARY KEY (cedula)
);

DELIMITER //
CREATE PROCEDURE insertar_cliente (IN _cedula INT, IN _nombre VARCHAR(50), IN _apellido VARCHAR(50))
BEGIN
    INSERT INTO clientes (cedula, nombre, apellido) VALUES (_cedula, _nombre, _apellido);
END;
//

CREATE PROCEDURE actualizar_nombre_cliente (IN _cedula INT, IN _nuevo_nombre VARCHAR(50))
BEGIN
    UPDATE clientes SET nombre = _nuevo_nombre WHERE cedula = _cedula;
END;
//

CREATE PROCEDURE eliminar_cliente (IN _cedula INT)
BEGIN
    DELETE FROM clientes WHERE cedula = _cedula;
END;
//

DELIMITER ;


CREATE TABLE empleados (
    cedula INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    salario_basico INT NOT NULL,
    subsidio_transporte INT NOT NULL,
    aporte_salud DECIMAL(10, 2) NOT NULL,
    salario_total DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (cedula)
);

DELIMITER //
CREATE FUNCTION calcular_auxilio_transporte (salario INT) RETURNS INT DETERMINISTIC
BEGIN
    SET @salario_minimo = 1160000, @aux_transporte = 140606;

    IF salario > @salario_minimo * 2 THEN
        SET @aux_transporte = 0;
    END IF;

    RETURN @aux_transporte;
END;
//

CREATE FUNCTION calcular_aporte_salud (salario INT) RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
    DECLARE valor_aporte_salud DECIMAL(10, 2);

    SELECT (salario * 4) / 100 INTO valor_aporte_salud;

    RETURN valor_aporte_salud;
END;
//

CREATE PROCEDURE insertar_empleado (IN _cedula INT, IN _nombre VARCHAR(50), IN _salario INT)
BEGIN
    DECLARE total DECIMAL(10, 2);
    SET @subsidio_transporte = calcular_auxilio_transporte(_salario);
    SET @aporte_salud = calcular_aporte_salud(_salario);

    SELECT _salario + @subsidio_transporte - @aporte_salud INTO total;

    INSERT INTO empleados (
        cedula,
        nombre,
        salario_basico,
        subsidio_transporte,
        aporte_salud,
        salario_total
    )
    VALUES (
        _cedula,
        _nombre,
        _salario,
        @subsidio_transporte,
        @aporte_salud,
        total
    );
END;
//

DELIMITER ;
