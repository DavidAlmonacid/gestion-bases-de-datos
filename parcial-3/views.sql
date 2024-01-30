CREATE VIEW client_purchases AS
SELECT C.dni_cliente, C.nombre, C.apellido, SUM(F.monto) AS total_spent
FROM clientes AS C
JOIN facturas AS F
    ON C.dni_cliente = F.dni_cliente
GROUP BY C.dni_cliente;

SELECT * FROM client_purchases;


CREATE VIEW product_designs AS
SELECT P.id_producto, P.nombre, D.formato, D.tamaño
FROM productos AS P
JOIN diseños AS D
    ON P.id_producto = D.id_producto;

SELECT * FROM product_designs;


CREATE VIEW employee_departments AS
SELECT E.dni_empleado, E.nombre, E.apellido, D.nombre AS department_name
FROM empleados AS E
JOIN departamentos AS D
    ON E.nombre_departamento = D.nombre;

SELECT * FROM employee_departments;


CREATE VIEW product_sales AS
SELECT P.id_producto, P.nombre, SUM(F.monto) AS total_sales
FROM productos AS P
JOIN facturas AS F
    ON P.id_producto = F.id_producto
GROUP BY P.id_producto;

SELECT * FROM product_sales;
