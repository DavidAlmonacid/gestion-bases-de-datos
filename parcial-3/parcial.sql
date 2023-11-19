drop database MiBaseDeDatos;

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS MiBaseDeDatos;
USE MiBaseDeDatos;

-- Tabla Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    dniClF VARCHAR(10) PRIMARY KEY,
    nombreCl VARCHAR(50),
    apellidosCl VARCHAR(50),
    direccionCl VARCHAR(100),
    emailCl VARCHAR(100),
    passCl VARCHAR(150),
    imagenCl VARCHAR(100),
    cpCl VARCHAR(10),
    localidad VARCHAR(50),
    telefonoCl VARCHAR(15)
);

-- Tabla Departamento
CREATE TABLE IF NOT EXISTS Departamento (
    nombreDepartamento VARCHAR(50) PRIMARY KEY,
    emailDep VARCHAR(100)
);

-- Tabla Diseño
CREATE TABLE IF NOT EXISTS Diseño (
    idDiseno INT PRIMARY KEY,
    tamañoDiseno VARCHAR(20),
    formato VARCHAR(50)
);

-- Tabla EmpleadoBackup
CREATE TABLE IF NOT EXISTS EmpleadoBackup (
    dniEmp VARCHAR(10) PRIMARY KEY,
    SS VARCHAR(20),
    nombreEmp VARCHAR(50),
    apellidosEmp VARCHAR(50),
    emailEmp VARCHAR(100),
    passEmp VARCHAR(150),
    direccionEmp VARCHAR(100),
    salario DECIMAL(10, 2),
    comision DECIMAL(5, 2),
    telefonoEmp VARCHAR(15),
    nombreDepartamento VARCHAR(50)
);

-- Tabla Empleado
CREATE TABLE IF NOT EXISTS Empleado (
    dniEmp VARCHAR(10) PRIMARY KEY,
    SS VARCHAR(20),
    nombreEmp VARCHAR(50),
    apellidosEmp VARCHAR(50),
    emailEmp VARCHAR(100),
    passEmp VARBINARY(64),
    direccionEmp VARCHAR(100),
    salario DECIMAL(10, 2),
    comision DECIMAL(5, 2),
    telefonoEmp VARCHAR(15),
    nombreDepartamento VARCHAR(50),
    FOREIGN KEY (nombreDepartamento) REFERENCES Departamento (nombreDepartamento)
);

-- Tabla Producto con relación a Cliente
CREATE TABLE IF NOT EXISTS Producto (
    idProducto INT PRIMARY KEY,
    nombreProducto VARCHAR(100),
    imagenProducto VARCHAR(100),
    precio DECIMAL(10, 2),
    descripcion TEXT,
    impresion VARCHAR(50),
    acabado VARCHAR(50),
    tipoPapel VARCHAR(50),
    tamañoProducto VARCHAR(20),
    dniClF VARCHAR(10),
    idDiseno INT,
    dniEmp VARCHAR(10),
    FOREIGN KEY (idDiseno) REFERENCES Diseño (idDiseno),
    FOREIGN KEY (dniEmp) REFERENCES Empleado (dniEmp)
);

-- Tabla Factura
CREATE TABLE IF NOT EXISTS Factura (
    nFactura INT PRIMARY KEY,
    fecha DATE,
    importe DECIMAL(10, 2),
    dniClF VARCHAR(10),
    idProducto INT,
    pago VARCHAR(20),
    envio VARCHAR(20),
    FOREIGN KEY (dniClF) REFERENCES Cliente (dniClF),
    FOREIGN KEY (idProducto) REFERENCES Producto (idProducto)
);

-- Tres vistas de la base de datos
-- Vista tabla empleado
CREATE OR REPLACE VIEW VistaEmpleadosSalarioAlto AS
SELECT dniEmp, nombreEmp, apellidosEmp, salario
FROM Empleado
WHERE salario > 2000.00;

-- Vista tabla factura
CREATE OR REPLACE VIEW VistaProductosVendidos AS
SELECT F.nFactura, P.nombreProducto, F.fecha, F.importe, C.nombreCl AS nombreCliente, E.nombreEmp AS nombreVendedor
FROM Factura F
JOIN Producto P ON F.idProducto = P.idProducto
JOIN Cliente C ON F.dniClF = C.dniClF
JOIN Empleado E ON P.dniEmp = E.dniEmp;

-- Vista tabla empleado
CREATE OR REPLACE VIEW VistaEmpleadosMayorComision AS
SELECT dniEmp, nombreEmp, apellidosEmp, comision
FROM Empleado
ORDER BY comision DESC
LIMIT 5; 

-- Triggers
-- Trigger para insertar en Empleado y hacer copia de seguridad en EmpleadoBackup
DELIMITER //
CREATE TRIGGER InsertarEmpleadoConBackup
AFTER INSERT ON Empleado
FOR EACH ROW
BEGIN
    INSERT INTO EmpleadoBackup
    SELECT *
    FROM Empleado
    WHERE dniEmp = NEW.dniEmp;
END;
//
DELIMITER ;

-- Trigger para actualizar en Empleado y hacer copia de seguridad en EmpleadoBackup
DELIMITER //
CREATE TRIGGER ActualizarEmpleadoConBackup
AFTER UPDATE ON Empleado
FOR EACH ROW
BEGIN
    INSERT INTO EmpleadoBackup
    SELECT *
    FROM Empleado
    WHERE dniEmp = OLD.dniEmp;

    UPDATE Empleado
    SET
        SS = NEW.SS,
        nombreEmp = NEW.nombreEmp,
        apellidosEmp = NEW.apellidosEmp,
        emailEmp = NEW.emailEmp,
        passEmp = NEW.passEmp,
        direccionEmp = NEW.direccionEmp,
        salario = NEW.salario,
        comision = NEW.comision,
        telefonoEmp = NEW.telefonoEmp,
        nombreDepartamento = NEW.nombreDepartamento
    WHERE dniEmp = NEW.dniEmp;
END;
//
DELIMITER ;

-- Trigger para eliminar en Empleado y hacer copia de seguridad en EmpleadoBackup
DELIMITER //
CREATE TRIGGER EliminarEmpleadoConBackup
AFTER DELETE ON Empleado
FOR EACH ROW
BEGIN
    INSERT INTO EmpleadoBackup
    SELECT *
    FROM Empleado
    WHERE dniEmp = OLD.dniEmp;

    DELETE FROM Empleado
    WHERE dniEmp = OLD.dniEmp;
END;
//
DELIMITER ;

-- Procedimientos almacenados
-- Procedimiento para insertar un cliente
DELIMITER //
CREATE PROCEDURE InsertarCliente(
    IN pdniClF VARCHAR(10),
    IN pnombreCl VARCHAR(50),
    IN papellidosCl VARCHAR(50),
    IN pdireccionCl VARCHAR(100),
    IN pemailCl VARCHAR(100),
    IN ppassCl VARCHAR(150),
    IN pimagenCl VARCHAR(100),
    IN pcpCl VARCHAR(10),
    IN plocalidad VARCHAR(50),
    IN ptelefonoCl VARCHAR(15)
)
BEGIN
    INSERT INTO Cliente (dniClF, nombreCl, apellidosCl, direccionCl, emailCl, passCl, imagenCl, cpCl, localidad, telefonoCl)
    VALUES (pdniClF, pnombreCl, papellidosCl, pdireccionCl, pemailCl, sha(ppassCl), pimagenCl, pcpCl, plocalidad, ptelefonoCl);
END;
//
DELIMITER ;

-- Procedimiento para insertar una factura
DELIMITER //
CREATE PROCEDURE InsertarFactura(
    IN pnFactura INT,
    IN ppago VARCHAR(20),
    IN pimporte DECIMAL(10, 2),
    IN penvio VARCHAR(20),
    IN pfecha DATE,
    IN pdniClF VARCHAR(10)
)
BEGIN
    INSERT INTO Factura (nFactura, pago, importe, envio, fecha, dniClF)
    VALUES (pnFactura, ppago, pimporte, penvio, pfecha, pdniClF);
END;
//
DELIMITER ;

-- Procedimiento para insertar un producto
DELIMITER //
CREATE PROCEDURE InsertarProducto(
    IN pidProducto INT,
    IN pnombreProducto VARCHAR(100),
    IN pimagenProducto VARCHAR(100),
    IN pprecio DECIMAL(10, 2),
    IN pdescripcion TEXT,
    IN pimpresion VARCHAR(50),
    IN pacabado VARCHAR(50),
    IN ptipoPapel VARCHAR(50),
    IN ptamañoProducto VARCHAR(20),
    IN pdniEmp VARCHAR(10),
    IN pidDiseno INT
)
BEGIN
    INSERT INTO Producto (idProducto, nombreProducto, imagenProducto, precio, descripcion, impresion, acabado, tipoPapel, tamañoProducto, dniClF, idDiseno, dniEmp)
    VALUES (pidProducto, pnombreProducto, pimagenProducto, pprecio, pdescripcion, pimpresion, pacabado, ptipoPapel, ptamañoProducto, pdniEmp, pidDiseno, pdniEmp);
END;
//
DELIMITER ;

-- Procedimiento para insertar un diseño
DELIMITER //
CREATE PROCEDURE InsertarDiseno(
    IN pidDiseno INT,
    IN ptamanoDiseno VARCHAR(20),
    IN pformato VARCHAR(50)
)
BEGIN
    INSERT INTO Diseño (idDiseno, tamañoDiseno, formato)
    VALUES (pidDiseno, ptamanoDiseno, pformato);
END;
//
DELIMITER ;

-- Procedimiento para insertar un empleado
DELIMITER //
CREATE PROCEDURE InsertarEmpleado(
    IN pdniEmp VARCHAR(10),
    IN pSS VARCHAR(20),
    IN pnombreEmp VARCHAR(50),
    IN papellidosEmp VARCHAR(50),
    IN pemailEmp VARCHAR(100),
    IN ppassEmp VARCHAR(150),
    IN pdireccionEmp VARCHAR(100),
    IN psalario DECIMAL(10, 2),
    IN pcomision DECIMAL(5, 2),
    IN ptelefonoEmp VARCHAR(15),
    IN pnombreDepartamento VARCHAR(50)
)
BEGIN
    INSERT INTO Empleado (dniEmp, SS, nombreEmp, apellidosEmp, emailEmp, passEmp, direccionEmp, salario, comision, telefonoEmp, nombreDepartamento)
    VALUES (pdniEmp, pSS, pnombreEmp, papellidosEmp, pemailEmp, sha(ppassEmp), pdireccionEmp, psalario, pcomision, ptelefonoEmp, pnombreDepartamento);
END;
//
DELIMITER ;

-- Procedimiento para insertar un departamento
DELIMITER //
CREATE PROCEDURE InsertarDepartamento(
    IN pnombreDepartamento VARCHAR(50),
    IN pemailDep VARCHAR(100)
)
BEGIN
    INSERT INTO Departamento (nombreDepartamento, emailDep)
    VALUES (pnombreDepartamento, pemailDep);
END;
//
DELIMITER ;

-- Procedimiento para verificar y realizar acciones cuando se repite el producto y el cliente
DELIMITER //
CREATE PROCEDURE VerificarYRealizarAcciones(
    IN pdniClF VARCHAR(10),
    IN pproductoId INT
)
BEGIN
    DECLARE productoExists INT;
    
    SELECT COUNT(*) INTO productoExists
    FROM Producto
    WHERE idProducto = pproductoId AND dniEmp = pdniClF;
    
    IF productoExists = 0 THEN
        -- Puedes realizar otras acciones aquí
        -- Por ejemplo, insertar un nuevo producto asociado a este cliente
        INSERT INTO Producto (idProducto, nombreProducto, dniEmp)
        VALUES (pproductoId, 'Nuevo Producto', pdniClF);
    END IF;
END;
//
DELIMITER ;

-- Funciones almacenadas
-- Función para calcular el total de una factura
DELIMITER //
CREATE FUNCTION CalcularTotalFactura(nFactura INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(importe) INTO total FROM Factura WHERE nFactura = nFactura;
    RETURN total;
END;
//
DELIMITER ;

-- Función para verificar la existencia de un cliente
DELIMITER //
CREATE FUNCTION ExisteCliente(pdniClF VARCHAR(10)) RETURNS INT
BEGIN
    DECLARE clienteCount INT;
    SELECT COUNT(*) INTO clienteCount FROM Cliente WHERE dniClF = pdniClF;
    RETURN clienteCount;
END;
//
DELIMITER ;

-- Función para calcular el promedio de comisiones de todos los empleados
DELIMITER //
CREATE FUNCTION CalcularPromedioComision() RETURNS DECIMAL(5, 2)
BEGIN
    DECLARE promedioComision DECIMAL(5, 2);

    SELECT AVG(comision) INTO promedioComision
    FROM Empleado;

    RETURN promedioComision;
END;
//
DELIMITER ;


-- Insertar 10 registros en la tabla Departamento
INSERT INTO Departamento (nombreDepartamento, emailDep)
VALUES 
    ('Ventas', 'ventas@empresa.com'),
    ('Marketing', 'marketing@empresa.com'),
    ('Recursos Humanos', 'rrhh@empresa.com'),
    ('Finanzas', 'finanzas@empresa.com'),
    ('Sistemas', 'sistemas@empresa.com'),
    ('Logística', 'logistica@empresa.com'),
    ('Compras', 'compras@empresa.com'),
    ('Calidad', 'calidad@empresa.com'),
    ('Producción', 'produccion@empresa.com'),
    ('Investigación y Desarrollo', 'i+d@empresa.com');
    
-- Insertar 10 registros en la tabla Diseño
INSERT INTO Diseño (idDiseno, tamañoDiseno, formato)
VALUES 
    (1, 'A4', 'JPEG'),
    (2, 'A3', 'PNG'),
    (3, 'A5', 'PDF'),
    (4, 'A6', 'JPEG'),
    (5, 'A4', 'PDF'),
    (6, 'A3', 'PNG'),
    (7, 'A5', 'JPEG'),
    (8, 'A6', 'PDF'),
    (9, 'A4', 'PNG'),
    (10, 'A3', 'JPEG');

-- Insertar 10 registros en la tabla Empleado
INSERT INTO Empleado (dniEmp, SS, nombreEmp, apellidosEmp, emailEmp, passEmp, direccionEmp, salario, comision, telefonoEmp, nombreDepartamento)
VALUES 
    ('12345678A', '123456789012345', 'Juan', 'Pérez', 'juan.perez@gmail.com', sha('password'), 'Calle Falsa 123', 1500.00, 0.10, '123456789', 'Ventas'),
    ('23456789B', '234567890123456', 'María', 'García', 'maria.garcia@hotmail.com', sha('password'), 'Avenida Principal 456', 1700.00, 0.12, '234567890', 'Marketing'),
    ('34567890C', '345678901234567', 'Pedro', 'López', 'pedro.lopez@yahoo.com', sha('password'), 'Plaza Mayor 789', 1800.00, 0.15, '345678901', 'Ventas'),
    ('45678901D', '456789012345678', 'Ana', 'Martínez', 'ana.martinez@gmail.com', sha('password'), 'Calle Real 12', 2000.00, 0.20, '456789012', 'Marketing'),
    ('56789012E', '567890123456789', 'Luis', 'González', 'luis.gonzalez@hotmail.com', sha('password'), 'Avenida Secundaria 34', 2200.00, 0.25, '567890123', 'Ventas'),
    ('67890123F', '678901234567890', 'Lucía', 'Sánchez', 'lucia.sanchez@yahoo.com', sha('password'), 'Calle Principal 56', 2400.00, 0.30, '678901234', 'Marketing'),
    ('78901234G', '789012345678901', 'Javier', 'Fernández', 'javier.fernandez@gmail.com', sha('password'), 'Avenida Falsa 78', 2600.00, 0.35, '789012345', 'Ventas'),
    ('89012345H', '890123456789012', 'Sara', 'Rodríguez', 'sara.rodriguez@hotmail.com', sha('password'), 'Plaza Secundaria 90', 2800.00, 0.40, '890123456', 'Marketing'),
    ('90123456I', '901234567890123', 'Pablo', 'Gómez', 'pablo.gomez@yahoo.com', sha('password'), 'Calle Secundaria 23', 3000.00, 0.45, '901234567', 'Ventas'),
    ('01234567J', '012345678901234', 'Carmen', 'Ruiz', 'carmen.ruiz@gmail.com', sha('password'), 'Avenida Real 45', 3200.00, 0.50, '012345678', 'Marketing');

-- Insertar 10 registros en la tabla Producto
INSERT INTO Producto (idProducto, nombreProducto, dniEmp)
VALUES 
    (1, 'Camiseta', '12345678A'),
    (2, 'Pantalón', '23456789B'),
    (3, 'Zapatos', '34567890C'),
    (4, 'Bolso', '45678901D'),
    (5, 'Reloj', '56789012E'),
    (6, 'Gafas de sol', '67890123F'),
    (7, 'Sombrero', '78901234G'),
    (8, 'Bufanda', '89012345H'),
    (9, 'Guantes', '90123456I'),
    (10, 'Calcetines', '01234567J');
    
-- Insertar 10 registros en la tabla Cliente
INSERT INTO Cliente (dniClF, nombreCl, apellidosCl, emailCl, direccionCl, telefonoCl)
VALUES 
    ('12345678A', 'Juan', 'Pérez', 'juan.perez@gmail.com', 'Calle Falsa 123', '123456789'),
    ('23456789B', 'María', 'García', 'maria.garcia@hotmail.com', 'Avenida Principal 456', '234567890'),
    ('34567890C', 'Pedro', 'López', 'pedro.lopez@yahoo.com', 'Plaza Mayor 789', '345678901'),
    ('45678901D', 'Ana', 'Martínez', 'ana.martinez@gmail.com', 'Calle Real 12', '456789012'),
    ('56789012E', 'Luis', 'González', 'luis.gonzalez@hotmail.com', 'Avenida Secundaria 34', '567890123'),
    ('67890123F', 'Lucía', 'Sánchez', 'lucia.sanchez@yahoo.com', 'Calle Principal 56', '678901234'),
    ('78901234G', 'Javier', 'Fernández', 'javier.fernandez@gmail.com', 'Avenida Falsa 78', '789012345'),
    ('89012345H', 'Sara', 'Rodríguez', 'sara.rodriguez@hotmail.com', 'Plaza Secundaria 90', '890123456'),
    ('90123456I', 'Pablo', 'Gómez', 'pablo.gomez@yahoo.com', 'Calle Secundaria 23', '901234567'),
    ('01234567J', 'Carmen', 'Ruiz', 'carmen.ruiz@gmail.com', 'Avenida Real 45', '012345678');

-- Insertar 10 registros en la tabla factura
INSERT INTO Factura (nFactura, fecha, importe, dniClF, idProducto)
VALUES 
    (1, '2021-01-01', 50.00, '12345678A', 1),
    (2, '2021-01-02', 75.00, '23456789B', 2),
    (3, '2021-01-03', 100.00, '34567890C', 3),
    (4, '2021-01-04', 25.00, '45678901D', 4),
    (5, '2021-01-05', 150.00, '56789012E', 5),
    (6, '2021-01-06', 30.00, '67890123F', 6),
    (7, '2021-01-07', 20.00, '78901234G', 7),
    (8, '2021-01-08', 10.00, '89012345H', 8),
    (9, '2021-01-09', 5.00, '90123456I', 9),
    (10, '2021-01-10', 15.00, '01234567J', 10);
