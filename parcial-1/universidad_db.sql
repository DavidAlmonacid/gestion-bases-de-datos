CREATE DATABASE universidad_db;
USE universidad_db;

CREATE TABLE direcciones (
    id_direccion INT AUTO_INCREMENT,
    calle VARCHAR(100) NOT NULL,
    barrio VARCHAR(100) NOT NULL,
    numero_casa INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE personas (
    numero_identidad INT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_direccion INT NOT NULL,
    rol SET('estudiante', 'empleado') NOT NULL,
    PRIMARY KEY (numero_identidad),
    FOREIGN KEY (id_direccion) REFERENCES direcciones(id_direccion)
);

CREATE TABLE estudiantes (
    id_estudiante INT NOT NULL,
    id_acudiente INT NOT NULL,
    PRIMARY KEY (id_estudiante),
    FOREIGN KEY (id_estudiante) REFERENCES personas(numero_identidad)
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
    password VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_usuario)
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
    nombre_clase VARCHAR(50) NOT NULL,
    horas_semanales INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    id_carrera INT NOT NULL,
    PRIMARY KEY (id_clase),
    FOREIGN KEY (id_carrera) REFERENCES carreras(id_carrera)
);

-- numero_seccion INT NOT NULL UNIQUE,
CREATE TABLE seccion (
    id_seccion INT AUTO_INCREMENT,
    codigo_seccion VARCHAR(10) NOT NULL UNIQUE,
    id_clases_creadas INT NOT NULL,
    id_clase INT,
    PRIMARY KEY (id_seccion),
    FOREIGN KEY (id_clases_creadas) REFERENCES clases_creadas(id_clases_creadas),
    FOREIGN KEY (id_clase) REFERENCES clases(id_clase)
);
