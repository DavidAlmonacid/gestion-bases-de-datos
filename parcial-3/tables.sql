DROP DATABASE IF EXISTS parcial3_db;
CREATE DATABASE parcial3_db;
USE parcial3_db;

CREATE TABLE clientes (
    dni_cliente VARCHAR(12) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    localidad VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password CHAR(64) NOT NULL,
    foto_url VARCHAR(100),
    PRIMARY KEY (dni_cliente)
);

CREATE TABLE productos (
    id_producto INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    precio INT NOT NULL,
    foto_url VARCHAR(100),
    descripcion TEXT NOT NULL,
    impresion VARCHAR(50) NOT NULL,
    acabado VARCHAR(50) NOT NULL,
    tipo_papel VARCHAR(50) NOT NULL,
    tamaño VARCHAR(50) NOT NULL,
    dni_cliente VARCHAR(12) NOT NULL,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (dni_cliente) REFERENCES clientes(dni_cliente)
);

CREATE TABLE facturas (
    id_factura INT NOT NULL AUTO_INCREMENT,
    fecha DATE NOT NULL,
    monto INT NOT NULL,
    importe INT NOT NULL,
    envio INT NOT NULL,
    dni_cliente VARCHAR(12) NOT NULL,
    id_producto INT NOT NULL,
    PRIMARY KEY (id_factura),
    FOREIGN KEY (dni_cliente) REFERENCES clientes(dni_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE diseños (
    id_diseño INT NOT NULL AUTO_INCREMENT,
    formato VARCHAR(50) NOT NULL,
    tamaño VARCHAR(50) NOT NULL,
    id_producto INT NOT NULL,
    PRIMARY KEY (id_diseño),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE departamentos (
    nombre VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (nombre)
);

CREATE TABLE empleados (
    dni_empleado VARCHAR(12) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password CHAR(64) NOT NULL,
    salario INT NOT NULL,
    comision INT NOT NULL,
    id_producto INT NOT NULL,
    nombre_departamento VARCHAR(50) NOT NULL,
    PRIMARY KEY (dni_empleado),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (nombre_departamento) REFERENCES departamentos(nombre)
);

CREATE TABLE copia_empleados (
    dni_empleado VARCHAR(12) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    nombre_departamento VARCHAR(50) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    accion VARCHAR(20) NOT NULL,
    fecha_copia DATETIME NOT NULL
);

CREATE TABLE log_messages (
    id INT AUTO_INCREMENT,
    message VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY (id)
);
