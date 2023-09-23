-- 1. Crear base de datos
CREATE DATABASE campeonato_db;


-- 2. Activar base de datos
USE campeonato_db;


-- 3. Crear tablas equipos y jugadores
CREATE TABLE equipos (
    id_equipo INT(2) NOT NULL AUTO_INCREMENT,
    equipo VARCHAR(50) NOT NULL,
    tecnico VARCHAR(50) NOT NULL,
    fundacion DATE NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_equipo)
);

CREATE TABLE jugadores (
    id_jugador INT(10) NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    nacimiento DATE NOT NULL,
    tipo_sangre VARCHAR(3) NOT NULL,
    codigo_equipo INT(2) NOT NULL,
    PRIMARY KEY (id_jugador),
    FOREIGN KEY (codigo_equipo) REFERENCES equipos(id_equipo)
);


-- 4. Insertar 5 registros a cada tabla
INSERT INTO equipos (equipo, tecnico, fundacion, ciudad, direccion, telefono)
VALUES
('Barcelona', 'Guillermo Almada', '1925-05-01', 'Guayaquil', 'Estadio Monumental', '042-123-456'),
('Emelec', 'Alfredo Arias', '1929-04-28', 'Guayaquil', 'Estadio Capwell', '042-123-456'),
('Liga de Quito', 'Pablo Repetto', '1930-01-11', 'Quito', 'Estadio Rodrigo Paz', '042-123-456'),
('Delfin', 'Guillermo Sanguinetti', '1989-03-01', 'Manta', 'Estadio Jocay', '042-123-456'),
('Macara', 'Paúl Vélez', '1939-04-01', 'Ambato', 'Estadio Bellavista', '042-123-456');

INSERT INTO jugadores
VALUES
(1, 'Damián', 'Díaz', '1986-05-11', 'O+', 1),
(2, 'Esteban', 'Dreer', '1981-05-11', 'AB-', 2),
(3, 'Adrián', 'Gabbarini', '1985-05-11', 'O+', 3),
(4, 'Pedro', 'Ortiz', '1986-05-11', 'O+', 4),
(5, 'Carlos', 'Feraud', '1986-05-11', 'O-', 5);


-- 5. Agregar nuevo campo llamado "cedula" int(20) a la tabla jugadores
ALTER TABLE jugadores
ADD cedula INT(20) NOT NULL;

SET SQL_SAFE_UPDATES = 0;

UPDATE jugadores
SET cedula = id_jugador;

SET SQL_SAFE_UPDATES = 1;


-- 6. Ingrese un sexto registro y reemplace ese registro en las 2 tablas
REPLACE INTO equipos (equipo, tecnico, fundacion, ciudad, direccion, telefono)
VALUES
('Independiente del Valle', 'Miguel Ángel Ramírez', '1958-05-11', 'Sangolquí', 'Estadio Rumiñahui', '042-123-456');

REPLACE INTO jugadores
VALUES
(6, 'Cristian', 'Pellerano', '1981-05-11', 'B+', 6, 234566);


-- 7. Agregar un nuevo campo llamado "barrio" varchar(40) a la tabla equipos
ALTER TABLE equipos
ADD barrio VARCHAR(40) NOT NULL;


-- 8. Modificar campo de la tabla equipos "direccion" varchar(70)
ALTER TABLE equipos
MODIFY direccion VARCHAR(70) NOT NULL;


-- 9. Modificar campo de la tabla jugadores "apellidos" varchar(50)
ALTER TABLE jugadores
MODIFY apellido VARCHAR(50) NOT NULL;


-- 10. Cambiar el nombre de un campo Equipo por Nombequipo de la tabla equipo
ALTER TABLE equipos
CHANGE equipo nombre_equipo VARCHAR(50) NOT NULL;


-- 11. Cambiar el nombre de un campo Nacimiento por Fechanacimiento de la tabla jugadores
ALTER TABLE jugadores
CHANGE nacimiento fecha_nacimiento DATE NOT NULL;


-- 12. Cambiar la clave primaria de la tabla de jugador por la cedula
ALTER TABLE jugadores
DROP PRIMARY KEY;

ALTER TABLE jugadores
ADD PRIMARY KEY (cedula);


-- 13. Cambiar el nombre de las tablas
RENAME TABLE equipos TO equipos_futbol, jugadores TO jugadores_futbol;


-- 14. Eliminar un campo de cada tabla
ALTER TABLE equipos_futbol
DROP COLUMN barrio;

ALTER TABLE jugadores_futbol
DROP COLUMN tipo_sangre;
