-- 1. Crear una base de datos y la tabla clientes
create database clase_2;
use clase_2;

create table clientes (
    codigo_cliente int(10) not null auto_increment,
    nombre varchar(30) not null,
    domicilio varchar(30) not null,
    ciudad varchar(20) not null,
    provincia varchar(20) not null,
    telefono varchar(11),
    primary key (codigo_cliente)
);


-- 2. Insertar datos en la tabla clientes
insert into clientes (nombre, domicilio, ciudad, provincia, telefono)
values
('Lopez Marcos', 'Colon 111', 'Córdoba','Cordoba', null),
('Perez Ana', 'San Martin 222', 'Cruz delEje','Cordoba','4578585'),
('Garcia Juan', 'Rivadavia 333', 'Villa Maria','Cordoba','4578445'),
('Perez Luis', 'Sarmiento 444', 'Rosario','Santa Fe', null),
('Pereyra Lucas', 'San Martin 555', 'Cruz delEje','Cordoba','4253685'),
('Gomez Ines', 'San Martin 666', 'Santa Fe','Santa Fe','0345252525'),
('Torres Fabiola', 'Alem 777', 'Villa del Rosario','Cordoba','4554455'),
('Lopez Carlos', 'Irigoyen 888', 'Cruz delEje', 'Cordoba', null),
('Ramos Betina', 'San Martin 999', 'Cordoba', 'Cordoba', '4223366'),
('Lopez Lucas', 'San Martin 1010', 'Posadas', 'Misiones', '0457858745');


-- 3. Crear un índice ordinario
create index idx_domicilio on clientes (domicilio);


-- 4. Crear un índice único
create unique index idx_nombre on clientes (nombre);

show index in clientes;

-- 5. Total de los registros agrupados por provincia
select provincia, count(*) as personas_por_provincia
from clientes
group by provincia;


-- 6. Total de los registros agrupados por ciudad y provincia
select ciudad, count(*) as personas_por_ciudad
from clientes
group by ciudad, provincia;


-- 7. Total de los registros agrupados por ciudad y provincia sin considerar los que tienen menos de 2 clientes
select ciudad, count(*) as personas_por_ciudad
from clientes
group by ciudad, provincia
having personas_por_ciudad > 1;


-- 8. Total de los registros sin teléfono nulo, agrupados por ciudad y provincia sin considerar los que tienen menos de 2 clientes
select ciudad, count(*) as personas_por_ciudad
from clientes
where telefono is not null
group by ciudad, provincia
having personas_por_ciudad > 1;


-- 9. Muestre las distintas provincias y ciudades en las cuales la empresa tiene clientes
select distinct provincia, ciudad from clientes;


-- 10. Obtenga la cantidad de ciudades distintas, por provincia en las cuales hay clientes
select provincia, count(distinct ciudad) as ciudades_distintas
from clientes
group by provincia;


-- 11. Muestre la cantidad de clientes que se apellidan "Pérez" colocando un alias para dicha salida
select count(*) as cantidad_de_perez
from clientes
where nombre like '%Perez%';


-- 12. Realice una consulta limitando la salida a sólo 5 registros
select * from clientes limit 0, 5;


-- 13. Muestre los registros desde el cero al 8 usando un solo argumento
select * from clientes limit 7, 1;


-- 14. Muestre 3 registros a partir del 4
select * from clientes limit 4, 3;


-- 15. Muestre los registros a partir del 2 hasta el final
select * from clientes limit 2, 10;
