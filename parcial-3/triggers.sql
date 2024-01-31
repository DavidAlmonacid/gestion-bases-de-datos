DROP TRIGGER IF EXISTS empleados_after_insert;

CREATE TRIGGER empleados_after_insert
AFTER INSERT ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO copia_empleados (dni_empleado, nombre, apellido, email, nombre_departamento, estado, accion, fecha_copia) 
    VALUES (NEW.dni_empleado, NEW.nombre, NEW.apellido, NEW.email, NEW.nombre_departamento, 'activo', 'creado', NOW());
END;

INSERT INTO empleados (dni_empleado, nombre, apellido, direccion, telefono, email, password, salario, comision, id_producto, nombre_departamento)
VALUES
('12345678P', 'Empleado 11', 'Apellido 11', 'Direccion 11', '123456789', 'emp11@email.com', SHA2('123', 256), 11000, 1100, 1, 'Departamento 1');


DROP TRIGGER IF EXISTS empleados_after_update;

CREATE TRIGGER empleados_after_update
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO copia_empleados (dni_empleado, nombre, apellido, email, nombre_departamento, estado, accion, fecha_copia) 
    VALUES (NEW.dni_empleado, NEW.nombre, NEW.apellido, NEW.email, NEW.nombre_departamento, 'activo', 'modificado', NOW());
END;

UPDATE empleados SET nombre = 'Empleado 11 Modificado' WHERE dni_empleado = '12345678P';


DROP TRIGGER IF EXISTS empleados_after_delete;

CREATE TRIGGER empleados_after_delete
AFTER DELETE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO copia_empleados (dni_empleado, nombre, apellido, email, nombre_departamento, estado, accion, fecha_copia) 
    VALUES (OLD.dni_empleado, OLD.nombre, OLD.apellido, OLD.email, OLD.nombre_departamento, 'inactivo', 'eliminado', NOW());
END;

DELETE FROM empleados WHERE dni_empleado = '12345678P';
