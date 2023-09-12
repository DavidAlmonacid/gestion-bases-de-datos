DROP DATABASE IF EXISTS peliculas_db;

CREATE DATABASE peliculas_db;
USE peliculas_db;


DROP TABLE IF EXISTS directores;

CREATE TABLE directores (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    nacionalidad SET('canadiense', 'aleman', 'español', 'norteamericano', 'frances', 'italiano', 'ingles') NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    PRIMARY KEY (id)
);


DROP TABLE IF EXISTS actores;

CREATE TABLE actores (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    nacionalidad SET('canadiense', 'aleman', 'español', 'norteamericano', 'frances', 'italiano', 'ingles') NOT NULL,
    personaje VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);


DROP TABLE IF EXISTS peliculas;

CREATE TABLE peliculas (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(50) NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL,
    idioma SET('español', 'ingles', 'frances', 'aleman', 'italiano') NOT NULL,
    resumen VARCHAR(255) NOT NULL,
    annio INT NOT NULL,
    espectadores INT NOT NULL,
    color BOOLEAN NOT NULL DEFAULT TRUE,
    id_director INT NOT NULL,
    id_actor INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_director) REFERENCES directores(id),
    FOREIGN KEY (id_actor) REFERENCES actores(id)
);


INSERT INTO directores (nombre, nacionalidad, fecha_nacimiento)
VALUES
('Francis Ford Coppola', 'norteamericano', '1939-04-07'),
('Karl Freund', 'aleman', '1890-01-16'),
('Tim Burton', 'norteamericano,frances', '1958-08-25'),
('Roberto Benigni', 'italiano', '1952-10-27'),
('Anthony Russo', 'canadiense,norteamericano', '1970-02-03');


INSERT INTO actores (nombre, nacionalidad, personaje)
VALUES
('Marlon Brando', 'norteamericano', 'Don Vito Corleone'),
('Brendan Fraser', 'ingles,frances', "Rick O'Connell"),
('Mia Wasikowska', 'aleman', 'Alice Kingsleigh'),
('Roberto Benigni', 'italiano,norteamericano', 'Guido Orefice'),
('Robert Downey Jr.', 'norteamericano,frances', 'Iron Man');


INSERT INTO peliculas (titulo, nacionalidad, idioma, resumen, annio, espectadores, color, id_director, id_actor)
VALUES
('El Padrino', 'Estados Unidos', 'ingles,español,italiano', 'Película estadounidense dirigida por Francis Ford Coppola.', 1972, 1000000, TRUE, 1, 1),
('La Momia', 'Alemania', 'ingles,español,aleman', 'Película alemana dirigida por Karl Freund.', 1932, 2000000, FALSE, 2, 2),
('Alicia en el País de las Maravillas', 'Estados Unidos', 'ingles,español,frances', 'Película estadounidense dirigida por Tim Burton.', 2010, 3000000, TRUE, 3, 3),
('La Vida es Bella', 'Italia', 'italiano,español,ingles,aleman,frances', 'Película italiana dirigida por Roberto Benigni.', 1997, 2500000, TRUE, 4, 4),
('Avengers: Endgame', 'Estados Unidos', 'ingles,español,frances', 'Película estadounidense dirigida por Anthony Russo y Joe Russo.', 2019, 4000000, TRUE, 5, 5);


SELECT *
FROM peliculas
ORDER BY RAND()
LIMIT 3;

SELECT *
FROM peliculas
WHERE FIND_IN_SET('español', idioma) > 0;


SELECT *
FROM directores
ORDER BY RAND();

SELECT *
FROM directores
WHERE FIND_IN_SET('norteamericano', nacionalidad) > 0;


SELECT *
FROM actores
ORDER BY RAND()
LIMIT 5;

SELECT *
FROM actores
WHERE FIND_IN_SET('frances', nacionalidad) > 0;
