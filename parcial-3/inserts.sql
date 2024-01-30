INSERT INTO clientes VALUES
('12345678A', 'Juan', 'Perez', 'Calle 1', 'Localidad 1', '123456789', 'juan@email.com', SHA2('123', 256), NULL),
('12345678B', 'Pedro', 'Gomez', 'Calle 2', 'Localidad 2', '123456789', 'pedro@email.com', SHA2('123', 256), NULL),
('12345678C', 'Maria', 'Lopez', 'Calle 3', 'Localidad 3', '123456789', 'maria@email.com', SHA2('123', 256), NULL),
('12345678D', 'Jose', 'Rodriguez', 'Calle 4', 'Localidad 4', '123456789', 'jose@email.com', SHA2('123', 256), NULL),
('12345678E', 'Ana', 'Martinez', 'Calle 5', 'Localidad 5', '123456789', 'ana@email.com', SHA2('123', 256), NULL),
('12345678F', 'Carlos', 'Sanchez', 'Calle 6', 'Localidad 6', '123456789', 'carlos@email.com', SHA2('123', 256), NULL),
('12345678G', 'Laura', 'Gonzalez', 'Calle 7', 'Localidad 7', '123456789', 'laura@email.com', SHA2('123', 256), NULL),
('12345678H', 'Sergio', 'Diaz', 'Calle 8', 'Localidad 8', '123456789', 'sergio@email.com', SHA2('123', 256), NULL),
('12345678I', 'Sofia', 'Perez', 'Calle 9', 'Localidad 9', '123456789', 'sofia@email.com', SHA2('123', 256), NULL),
('12345678J', 'Jorge', 'Garcia', 'Calle 10', 'Localidad 10', '123456789', 'jorge@email.com', SHA2('123', 256), NULL);

INSERT INTO productos (nombre, precio, descripcion, impresion, acabado, tipo_papel, tamaño, dni_cliente)
VALUES
('Producto 1', 100, 'Descripcion 1', 'Impresion 1', 'Acabado 1', 'Tipo Papel 1', 'Tamaño 1', '12345678A'),
('Producto 2', 200, 'Descripcion 2', 'Impresion 2', 'Acabado 2', 'Tipo Papel 2', 'Tamaño 2', '12345678B'),
('Producto 3', 300, 'Descripcion 3', 'Impresion 3', 'Acabado 3', 'Tipo Papel 3', 'Tamaño 3', '12345678C'),
('Producto 4', 400, 'Descripcion 4', 'Impresion 4', 'Acabado 4', 'Tipo Papel 4', 'Tamaño 4', '12345678D'),
('Producto 5', 500, 'Descripcion 5', 'Impresion 5', 'Acabado 5', 'Tipo Papel 5', 'Tamaño 5', '12345678E'),
('Producto 6', 600, 'Descripcion 6', 'Impresion 6', 'Acabado 6', 'Tipo Papel 6', 'Tamaño 6', '12345678F'),
('Producto 7', 700, 'Descripcion 7', 'Impresion 7', 'Acabado 7', 'Tipo Papel 7', 'Tamaño 7', '12345678G'),
('Producto 8', 800, 'Descripcion 8', 'Impresion 8', 'Acabado 8', 'Tipo Papel 8', 'Tamaño 8', '12345678H'),
('Producto 9', 900, 'Descripcion 9', 'Impresion 9', 'Acabado 9', 'Tipo Papel 9', 'Tamaño 9', '12345678I'),
('Producto 10', 1000, 'Descripcion 10', 'Impresion 10', 'Acabado 10', 'Tipo Papel 10', 'Tamaño 10', '12345678J');

INSERT INTO facturas (fecha, monto, importe, envio, dni_cliente, id_producto)
VALUES
('2020-01-01', 100, 10, 10, '12345678A', 1),
('2020-01-02', 200, 20, 20, '12345678B', 2),
('2020-01-03', 300, 30, 30, '12345678C', 3),
('2020-01-04', 400, 40, 40, '12345678D', 4),
('2020-01-05', 500, 50, 50, '12345678E', 5),
('2020-01-06', 600, 60, 60, '12345678F', 6),
('2020-01-07', 700, 70, 70, '12345678G', 7),
('2020-01-08', 800, 80, 80, '12345678H', 8),
('2020-01-09', 900, 90, 90, '12345678I', 9),
('2020-01-10', 1000, 100, 100, '12345678J', 10);

INSERT INTO diseños (formato, tamaño, id_producto) VALUES
('Formato 1', 'Tamaño 1', 1),
('Formato 2', 'Tamaño 2', 2),
('Formato 3', 'Tamaño 3', 3),
('Formato 4', 'Tamaño 4', 4),
('Formato 5', 'Tamaño 5', 5),
('Formato 6', 'Tamaño 6', 6),
('Formato 7', 'Tamaño 7', 7),
('Formato 8', 'Tamaño 8', 8),
('Formato 9', 'Tamaño 9', 9),
('Formato 10', 'Tamaño 10', 10);

INSERT INTO departamentos (nombre, email) VALUES
('Departamento 1', 'dep1@email.com'),
('Departamento 2', 'dep2@email.com'),
('Departamento 3', 'dep3@email.com'),
('Departamento 4', 'dep4@email.com'),
('Departamento 5', 'dep5@email.com'),
('Departamento 6', 'dep6@email.com'),
('Departamento 7', 'dep7@email.com'),
('Departamento 8', 'dep8@email.com'),
('Departamento 9', 'dep9@email.com'),
('Departamento 10', 'dep10@email.com');

INSERT INTO empleados (dni_empleado, nombre, apellido, direccion, telefono, email, password, salario, comision, id_producto, nombre_departamento)
VALUES
('12345678Z', 'Empleado 1', 'Apellido 1', 'Direccion 1', '123456789', 'emp1@email.com', SHA2('123', 256), 1000, 100, 1, 'Departamento 1'),
('12345678Y', 'Empleado 2', 'Apellido 2', 'Direccion 2', '123456789', 'emp2@email.com', SHA2('123', 256), 2000, 200, 2, 'Departamento 2'),
('12345678X', 'Empleado 3', 'Apellido 3', 'Direccion 3', '123456789', 'emp3@email.com', SHA2('123', 256), 3000, 300, 3, 'Departamento 3'),
('12345678W', 'Empleado 4', 'Apellido 4', 'Direccion 4', '123456789', 'emp4@email.com', SHA2('123', 256), 4000, 400, 4, 'Departamento 4'),
('12345678V', 'Empleado 5', 'Apellido 5', 'Direccion 5', '123456789', 'emp5@email.com', SHA2('123', 256), 5000, 500, 5, 'Departamento 5'),
('12345678U', 'Empleado 6', 'Apellido 6', 'Direccion 6', '123456789', 'emp6@email.com', SHA2('123', 256), 6000, 600, 6, 'Departamento 6'),
('12345678T', 'Empleado 7', 'Apellido 7', 'Direccion 7', '123456789', 'emp7@email.com', SHA2('123', 256), 7000, 700, 7, 'Departamento 7'),
('12345678S', 'Empleado 8', 'Apellido 8', 'Direccion 8', '123456789', 'emp8@email.com', SHA2('123', 256), 8000, 800, 8, 'Departamento 8'),
('12345678R', 'Empleado 9', 'Apellido 9', 'Direccion 9', '123456789', 'emp9@email.com', SHA2('123', 256), 9000, 900, 9, 'Departamento 9'),
('12345678Q', 'Empleado 10', 'Apellido 10', 'Direccion 10', '123456789', 'emp10@email.com', SHA2('123', 256), 10000, 1000, 10, 'Departamento 10');
