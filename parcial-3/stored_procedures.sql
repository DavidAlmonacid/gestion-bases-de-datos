CREATE PROCEDURE insertar_cliente(IN p_dni_cliente VARCHAR(12), IN p_nombre VARCHAR(50), IN p_apellido VARCHAR(50), IN p_direccion VARCHAR(100), IN p_localidad VARCHAR(50), IN p_telefono VARCHAR(20), IN p_email VARCHAR(100), IN p_password CHAR(64), IN p_foto_url VARCHAR(100))
BEGIN
    INSERT INTO clientes (dni_cliente, nombre, apellido, direccion, localidad, telefono, email, password, foto_url) 
    VALUES (p_dni_cliente, p_nombre, p_apellido, p_direccion, p_localidad, p_telefono, p_email, SHA2(p_password, 256), p_foto_url);
END;

CALL insertar_cliente('12345678', 'John', 'Doe', '123 Main St', 'City', '123-456-7890', 'john.doe@example.com', 'password', 'http://example.com/image.jpg');


CREATE PROCEDURE insertar_producto(IN p_nombre VARCHAR(100), IN p_precio INT, IN p_foto_url VARCHAR(100), IN p_descripcion TEXT, IN p_impresion VARCHAR(50), IN p_acabado VARCHAR(50), IN p_tipo_papel VARCHAR(50), IN p_tamaño VARCHAR(50), IN p_dni_cliente VARCHAR(12))
BEGIN
    INSERT INTO productos (nombre, precio, foto_url, descripcion, impresion, acabado, tipo_papel, tamaño, dni_cliente) 
    VALUES (p_nombre, p_precio, p_foto_url, p_descripcion, p_impresion, p_acabado, p_tipo_papel, p_tamaño, p_dni_cliente);
END;

CALL insertar_producto('Product Name', 100, 'http://example.com/product.jpg', 'Product Description', 'Impression Type', 'Finish Type', 'Paper Type', 'Size', '12345678');


CREATE PROCEDURE insertar_empleado(IN p_dni_empleado VARCHAR(12), IN p_nombre VARCHAR(50), IN p_apellido VARCHAR(50), IN p_direccion VARCHAR(100), IN p_telefono VARCHAR(20), IN p_email VARCHAR(100), IN p_password CHAR(64), IN p_salario INT, IN p_comision INT, IN p_id_producto INT, IN p_nombre_departamento VARCHAR(50))
BEGIN
    INSERT INTO empleados (dni_empleado, nombre, apellido, direccion, telefono, email, password, salario, comision, id_producto, nombre_departamento) 
    VALUES (p_dni_empleado, p_nombre, p_apellido, p_direccion, p_telefono, p_email, SHA2(p_password, 256), p_salario, p_comision, p_id_producto, p_nombre_departamento);
END;

CALL insertar_empleado('87654321', 'Jane', 'Doe', '456 Main St', '987-654-3210', 'jane.doe@example.com', 'password', 50000, 10, 1, 'Departamento 1');
