DROP DATABASE IF EXISTS universidad_db;
CREATE DATABASE universidad_db;
USE universidad_db;

CREATE TABLE direcciones (
    direccion INT AUTO_INCREMENT,
    calle VARCHAR(100) NOT NULL,
    barrio VARCHAR(100) NOT NULL,
    numero_casa INT NOT NULL,
    PRIMARY KEY (direccion)
);

CREATE TABLE personas (
    numero_identidad INT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    telefono VARCHAR(20),
    id_direccion INT,
    rol SET('estudiante', 'empleado') NOT NULL,
    PRIMARY KEY (numero_identidad),
    FOREIGN KEY (id_direccion) REFERENCES direcciones(direccion)
);

CREATE TABLE estudiantes (
    id_estudiante INT,
    id_acudiente INT NOT NULL,
    id_persona INT,
    PRIMARY KEY (id_estudiante),
    FOREIGN KEY (id_persona) REFERENCES personas(numero_identidad)
);

CREATE TABLE empleados (
    id_empleado INT NOT NULL,
    sueldo INT NOT NULL,
    numero_seguro INT NOT NULL,
    horas_trabajadas INT NOT NULL,
    PRIMARY KEY (id_empleado),
    FOREIGN KEY (id_empleado) REFERENCES personas(numero_identidad)
);

CREATE TABLE administrativos (
    id_administrativo INT NOT NULL,
    cargo SET('rector', 'decano', 'secretaria', 'facturador') NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_administrativo),
    FOREIGN KEY (id_administrativo) REFERENCES empleados(id_empleado)
);

CREATE TABLE profesores (
    id_profesor INT NOT NULL,
    area_docencia VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_profesor),
    FOREIGN KEY (id_profesor) REFERENCES empleados(id_empleado)
);

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    tipo_usuario SET('administrativo', 'profesor') NOT NULL,
    password_usuario VARCHAR(50) NOT NULL,
    id_empleado INT,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_empleado) REFERENCES administrativos(id_administrativo),
    FOREIGN KEY (id_empleado) REFERENCES profesores(id_profesor)
);

CREATE TABLE copia_usuarios (
    id_copia_usuario INT AUTO_INCREMENT,
    nombre_usuario VARCHAR(50) NOT NULL,
    tipo_usuario SET('administrativo', 'profesor') NOT NULL,
    id_usuario INT NOT NULL,
    accion SET('creado', 'modificado', 'eliminado') NOT NULL,
    PRIMARY KEY (id_copia_usuario)
);

CREATE TABLE clases_creadas (
    id_clases_creadas INT AUTO_INCREMENT,
    aula VARCHAR(50) NOT NULL,
    annio INT NOT NULL,
    id_profesor INT NOT NULL,
    PRIMARY KEY (id_clases_creadas),
    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor)
);

CREATE TABLE matriculas (
    id_matricula INT AUTO_INCREMENT,
    annio INT NOT NULL,
    periodo SET('I', 'II') NOT NULL,
    id_estudiante INT NOT NULL,
    id_clases_creadas INT NOT NULL,
    PRIMARY KEY (id_matricula),
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_clases_creadas) REFERENCES clases_creadas(id_clases_creadas)
);

CREATE TABLE carreras (
    id_carrera INT AUTO_INCREMENT,
    nombre_carrera VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_carrera)
);

CREATE TABLE clases (
    id_clase INT AUTO_INCREMENT,
    nombre_clase INT NOT NULL,
    horas_semanales VARCHAR(50) NOT NULL,
    descripcion VARCHAR(10) NOT NULL,
    id_carrera INT,
    PRIMARY KEY (id_clase),
    FOREIGN KEY (id_carrera) REFERENCES carreras(id_carrera)
);

CREATE TABLE seccion (
    id_seccion INT AUTO_INCREMENT,
    codigo_seccion INT NOT NULL UNIQUE,
    id_clases_creadas INT,
    id_clase INT,
    PRIMARY KEY (id_seccion),
    FOREIGN KEY (id_clases_creadas) REFERENCES clases_creadas(id_clases_creadas),
    FOREIGN KEY (id_clase) REFERENCES clases(id_clase)
);


-- Modificar tres campos de la tabla clase.
ALTER TABLE clases MODIFY nombre_clase VARCHAR(50) NOT NULL;
ALTER TABLE clases MODIFY horas_semanales INT NOT NULL;
ALTER TABLE clases MODIFY descripcion VARCHAR(100) NOT NULL;

-- Adicionar el campo 'cedula' en la tabla estudiantes.
ALTER TABLE estudiantes
ADD cedula INT NOT NULL UNIQUE
AFTER id_estudiante;

-- Adicionar y cambiar el nombre del campo 'fecha' en la tabla estudiantes.
ALTER TABLE estudiantes
ADD fecha DATE NOT NULL
AFTER cedula;

ALTER TABLE estudiantes
CHANGE fecha fecha_nacimiento DATE NOT NULL;

-- Cambiar el nombre del campo 'dirección' de la tabla 'direcciones'
-- y también el tipo de dato (INT (20)).
ALTER TABLE direcciones
CHANGE direccion id_direccion INT(20) AUTO_INCREMENT;

-- Cambiar de nombre a dos tablas.
RENAME TABLE usuarios TO usuarios_universidad, carreras TO carreras_universidad;


-- Ingresar 10 registros en cada Tabla.
INSERT INTO direcciones (calle, barrio, numero_casa)
VALUES
('Calle 1', 'Barrio 1', 123),
('Calle 2', 'Barrio 2', 234),
('Calle 3', 'Barrio 3', 345),
('Calle 4', 'Barrio 4', 456),
('Calle 5', 'Barrio 5', 567),
('Calle 6', 'Barrio 6', 678),
('Calle 7', 'Barrio 7', 789),
('Calle 8', 'Barrio 8', 890),
('Calle 9', 'Barrio 9', 901),
('Calle 10', 'Barrio 10', 102);

INSERT INTO personas (numero_identidad, nombre, apellido, telefono, id_direccion, rol)
VALUES
(1022345678, 'Juan', 'Pérez', '555-1234', 1, 'estudiante'),
(98764321, 'María', 'González', '555-5678', 2, 'empleado'),
(1022735498, 'Pedro', 'Ramírez', '555-9012', 3, 'estudiante'),
(32154987, 'Ana', 'Martínez', '555-3456', 4, 'empleado'),
(1023456789, 'Luis', 'García', '555-7890', 5, 'estudiante'),
(65487321, 'Laura', 'Hernández', '555-2345', 6, 'empleado'),
(1024567891, 'Carlos', 'Sánchez', '555-6789', 7, 'estudiante'),
(36928147, 'Sofía', 'López', '555-0123', 8, 'empleado'),
(1023678912, 'Jorge', 'Díaz', '555-4567', 9, 'estudiante'),
(55293741, 'Fernanda', 'Torres', '555-8901', 10, 'empleado'),
(1023789123, 'Marta', 'Gómez', '555-1234', 1, 'estudiante'),
(72451332, 'Camilo', 'Ruiz', '555-5678', 2, 'empleado'),
(1010891234, 'Sara', 'Pérez', '555-9012', 3, 'estudiante'),
(55123763, 'Julián', 'Ramírez', '555-3456', 4, 'empleado'),
(1022912345, 'Santiago', 'García', '555-7890', 5, 'estudiante'),
(85296374, 'Valentina', 'Hernández', '555-2345', 6, 'empleado'),
(1024123456, 'Sofía', 'Sánchez', '555-6789', 7, 'estudiante'),
(52345678, 'Jorge', 'López', '555-0123', 8, 'empleado'),
(1025234567, 'Fernanda', 'Díaz', '555-4567', 9, 'estudiante'),
(52672567, 'Marta', 'Torres', '555-8901', 10, 'empleado');

INSERT INTO estudiantes (id_estudiante, cedula, fecha_nacimiento, id_acudiente)
VALUES
(1022345678, 1022345678, '1990-01-01', 72451332),
(1022735498, 1022735498, '1991-02-02', 55123763),
(1023456789, 1023456789, '1992-03-03', 36925814),
(1024567891, 1024567891, '1993-04-04', 85296374),
(1023678912, 1023678912, '1994-05-05', 46871652),
(1023789123, 1023789123, '1995-06-06', 52345678),
(1010891234, 1010891234, '1996-07-07', 98764321),
(1022912345, 1022912345, '1997-08-08', 32154987),
(1024123456, 1024123456, '1998-09-09', 65487321),
(1025234567, 1025234567, '1999-10-10', 36928147);

INSERT INTO empleados (id_empleado, sueldo, numero_seguro, horas_trabajadas)
VALUES
(98764321, 1000000, 123456789, 40),
(32154987, 1500000, 987654321, 38),
(65487321, 2000000, 456789123, 42),
(36928147, 2500000, 159753468, 41),
(55293741, 3000000, 753951864, 40),
(72451332, 3500000, 369258147, 39),
(55123763, 4000000, 258147369, 40),
(85296374, 4500000, 147258369, 40),
(52345678, 5000000, 456123789, 40),
(52672567, 5500000, 951357456, 44);

INSERT INTO administrativos (id_administrativo, cargo, departamento)
VALUES
(98764321, 'rector', 'departamento 1'),
(32154987, 'decano', 'ingenieria'),
(65487321, 'secretaria', 'permanencia estudiantil'),
(36928147, 'facturador', 'tesoreria'),
(72451332, 'decano', 'permanencia estudiantil'),
(55123763, 'secretaria', 'tesoreria'),
(85296374, 'facturador', 'tesoreria'),
(52345678, 'decano', 'humanidades'),
(52672567, 'secretaria', 'permanencia estudiantil'),
(55293741, 'facturador', 'tesoreria');

INSERT INTO profesores (id_profesor, area_docencia)
VALUES
(98764321, 'matematicas'),
(32154987, 'fisica'),
(65487321, 'quimica'),
(36928147, 'biologia'),
(72451332, 'lenguaje'),
(55123763, 'filosofia'),
(85296374, 'historia'),
(52345678, 'geografia'),
(52672567, 'ingles'),
(55293741, 'arte');

INSERT INTO usuarios_universidad (nombre_usuario, tipo_usuario, password_usuario, id_empleado)
VALUES
('usuario1', 'administrativo', '123456', 98764321),
('usuario2', 'administrativo', '123456', 32154987),
('usuario3', 'administrativo', '123456', 65487321),
('usuario4', 'administrativo', '123456', 36928147),
('usuario5', 'administrativo', '123456', 72451332),
('usuario6', 'profesor', '123456', 55123763),
('usuario7', 'profesor', '123456', 85296374),
('usuario8', 'profesor', '123456', 52345678),
('usuario9', 'profesor', '123456', 52672567),
('usuario10', 'profesor', '123456', 55293741);

INSERT INTO clases_creadas (aula, annio, id_profesor)
VALUES
('Aula 1', 2023, 98764321),
('Aula 2', 2023, 32154987),
('Aula 3', 2023, 65487321),
('Aula 4', 2023, 36928147),
('Aula 5', 2023, 72451332),
('Aula 6', 2023, 55123763),
('Aula 7', 2023, 85296374),
('Aula 8', 2023, 52345678),
('Aula 9', 2023, 52672567),
('Aula 10', 2023, 55293741);

INSERT INTO matriculas (annio, periodo, id_estudiante, id_clases_creadas)
VALUES
(2023, 'I', 1022345678, 1),
(2023, 'I', 1022735498, 2),
(2023, 'I', 1023456789, 3),
(2023, 'I', 1024567891, 4),
(2023, 'I', 1023678912, 5),
(2023, 'II', 1023789123, 6),
(2023, 'II', 1010891234, 7),
(2023, 'II', 1022912345, 8),
(2023, 'II', 1024123456, 9),
(2023, 'II', 1025234567, 10);

INSERT INTO carreras_universidad (nombre_carrera)
VALUES
('Ingeniería de Sistemas'),
('Ingeniería de Software'),
('Ingeniería Mecánica'),
('Ingeniería Electrónica'),
('Ingeniería Civil'),
('Ingeniería Ambiental'),
('Ingeniería Química'),
('Ingeniería de Alimentos'),
('Ingeniería de Petróleos'),
('Ingeniería de Minas');

INSERT INTO clases (nombre_clase, horas_semanales, descripcion, id_carrera)
VALUES
('Bases de datos I', 4, 'Aprenderás del manejo de una base de datos en MySQL', 1),
('Estructuras de datos I', 2, 'Aprenderás estructuras de datos básicas', 2),
('Inglés I', 4, 'Aprenderás gramática básica del inglés', 3),
('Cálculo I', 2, 'Aprenderás cálculo diferencial', 4),
('Química I', 4, 'Aprenderás química básica', 5),
('Biología I', 4, 'Aprenderás biología celular', 6),
('Lenguaje I', 4, 'Aprenderás gramática básica del español', 7),
('Filosofía I', 4, 'Aprenderás filosofía griega', 8),
('Historia I', 4, 'Aprenderás historia de Colombia', 9),
('Geografía I', 4, 'Aprenderás geografía de Colombia', 10);

INSERT INTO seccion (codigo_seccion, id_clases_creadas, id_clase)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);


-- Realizar tres Triggers para insertar, modificar y eliminar
-- en las tablas de usuarios_universidad, clases y estudiantes.
DELIMITER @
CREATE TRIGGER insertar_usuario
AFTER INSERT ON usuarios_universidad
FOR EACH ROW
BEGIN
    INSERT INTO copia_usuarios (nombre_usuario, tipo_usuario, id_usuario, accion)
    VALUES (NEW.nombre_usuario, NEW.tipo_usuario, NEW.id_usuario, 'creado');
END @

CREATE TRIGGER modificar_usuario
AFTER UPDATE ON usuarios_universidad
FOR EACH ROW
BEGIN
    INSERT INTO copia_usuarios (nombre_usuario, tipo_usuario, id_usuario, accion)
    VALUES (NEW.nombre_usuario, NEW.tipo_usuario, NEW.id_usuario, 'modificado');
END @

CREATE TRIGGER eliminar_usuario
BEFORE DELETE ON usuarios_universidad
FOR EACH ROW
BEGIN
    INSERT INTO copia_usuarios (nombre_usuario, tipo_usuario, id_usuario, accion)
    VALUES (OLD.nombre_usuario, OLD.tipo_usuario, OLD.id_usuario, 'eliminado');
END @
DELIMITER ;

/*INSERT INTO usuarios_universidad (nombre_usuario, tipo_usuario, password_usuario)
VALUES ('usuario11', 'administrativo', '123456');

UPDATE usuarios_universidad
SET tipo_usuario = 'profesor'
WHERE id_usuario = 11;

DELETE FROM usuarios_universidad
WHERE id_usuario = 11;*/


DELIMITER @
CREATE TRIGGER insertar_clase
AFTER INSERT ON clases
FOR EACH ROW
BEGIN
    DECLARE seccion_count INT;

    SELECT COUNT(*) INTO seccion_count FROM seccion;

    INSERT INTO seccion (codigo_seccion, id_clase)
    VALUES (seccion_count + 1, NEW.id_clase);
END @

CREATE TRIGGER modificar_clase
AFTER UPDATE ON clases
FOR EACH ROW
BEGIN
    UPDATE seccion
    SET id_clase = NEW.id_clase
    WHERE id_clase = OLD.id_clase;
END @

CREATE TRIGGER eliminar_clase
BEFORE DELETE ON clases
FOR EACH ROW
BEGIN
    DELETE FROM seccion
    WHERE id_clase = OLD.id_clase;
END @
DELIMITER ;

/*INSERT INTO clases (nombre_clase, horas_semanales, descripcion, id_clase)
VALUES ('Bases de datos II', 4, 'Aprenderás del manejo de una base de datos en MySQL', 11);

UPDATE clases
SET nombre_clase = 'Bases de datos III'
WHERE id_clase = 11;

DELETE FROM clases
WHERE id_clase = 11;*/


DELIMITER @
CREATE TRIGGER insertar_estudiante
BEFORE INSERT ON estudiantes
FOR EACH ROW
BEGIN
    INSERT INTO personas (numero_identidad, rol)
    VALUES (NEW.cedula, 'estudiante');
END @

CREATE TRIGGER modificar_estudiante
AFTER UPDATE ON estudiantes
FOR EACH ROW
BEGIN
    UPDATE personas
    SET numero_identidad = NEW.cedula
    WHERE numero_identidad = OLD.cedula;
END @

CREATE TRIGGER eliminar_estudiante
BEFORE DELETE ON estudiantes
FOR EACH ROW
BEGIN
    DELETE FROM personas
    WHERE numero_identidad = OLD.cedula;
END @
DELIMITER ;

/*INSERT INTO estudiantes (id_estudiante, cedula, fecha_nacimiento, id_acudiente)
VALUES (1027345678, 1027345678, '1997-01-01', 72451332);

UPDATE estudiantes
SET id_estudiante = 1025948032, cedula = 1025948032, fecha_nacimiento = '1997-11-11'
WHERE id_estudiante = 1027345678;

DELETE FROM estudiantes
WHERE id_estudiante = 1025948032;*/


-- Realizar 3 Funciones
DELIMITER @
CREATE FUNCTION nombre_completo_persona (id_persona INT) RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(100);

    SELECT CONCAT(nombre, ' ', apellido) INTO nombre_completo
    FROM personas
    WHERE numero_identidad = id_persona;

    RETURN nombre_completo;
END @
DELIMITER ;

-- SELECT nombre_completo_persona(1022345678) AS nombre_completo;


DELIMITER @
CREATE FUNCTION completar_datos_persona (id_persona INT, nombre VARCHAR(50), apellido VARCHAR(50), telefono VARCHAR(20), id_direccion INT) RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DECLARE numero_documento INT;

    SELECT numero_identidad INTO numero_documento
    FROM personas
    WHERE numero_identidad = id_persona;

    IF numero_documento IS NULL THEN
        RETURN 'El número de documento no existe';
    END IF;
    
    UPDATE personas
    SET nombre = nombre, apellido = apellido, telefono = telefono, id_direccion = id_direccion
    WHERE numero_identidad = numero_documento;

    RETURN CONCAT('Datos de ', nombre_completo_persona(id_persona), ' completados');
END @
DELIMITER ;

-- SELECT completar_datos_persona(1025948032, 'David', 'Almonacid', '555-1234', 1) AS completar_datos_persona;


DELIMITER @
CREATE FUNCTION crear_matricula (id_estudiante INT, annio INT, periodo VARCHAR(10), id_clases_creadas INT) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
    DECLARE id_matricula INT;

    INSERT INTO matriculas (annio, periodo, id_estudiante, id_clases_creadas)
    VALUES (annio, periodo, id_estudiante, id_clases_creadas);

    SELECT LAST_INSERT_ID() INTO id_matricula;

    RETURN CONCAT('Matrícula #', id_matricula, ' creada');
END @
DELIMITER ;

-- SELECT crear_matricula(1025948032, 2023, 'II', 1) AS crear_matricula;
