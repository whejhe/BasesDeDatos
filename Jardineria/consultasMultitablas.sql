-- CONSULTAS MULTITABLA (Composición interna)

-- Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. 
-- Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

-- 1.	Obtén un listado con el nombre de cada cliente y el nombre y apellido de su 
--      representante de ventas.
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;


-- 2.	Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre 
--      de sus representantes de ventas.
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

-- O utilizando INNER JOIN
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 FROM cliente c INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

-- 3.	Muestra el nombre de los clientes que no hayan realizado pagos junto con el 
--      nombre de sus representantes de ventas.
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente WHERE p.codigo_cliente IS NULL;

-- O utilizando NOT EXISTS
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado WHERE NOT EXISTS (SELECT 1 FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);

-- 4.	Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus 
--      representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o ON e.codigo_oficina = o.codigo_oficina JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

-- O utilizando INNER JOIN
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad FROM cliente c INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

-- 5.	Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de 
--      sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o ON e.codigo_oficina = o.codigo_oficina LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente WHERE p.codigo_cliente IS NULL;

-- O utilizando NOT EXISTS
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE NOT EXISTS (SELECT 1 FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);

-- 6.	Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT o.linea_direccion1, o.linea_direccion2 FROM oficina o JOIN empleado e ON o.codigo_oficina = e.codigo_oficina JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas WHERE c.ciudad = 'Fuenlabrada';

-- 7.	Devuelve el nombre de los clientes y el nombre de sus representantes junto 
--      con la ciudad de la oficina a la que pertenece el representante.
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

-- 8.	Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT e.nombre, j.nombre AS nombre_jefe FROM empleado e INNER JOIN empleado j ON e.codigo_jefe = j.codigo_empleado;

-- 9.	Devuelve el nombre de los clientes a los que no se les ha entregado a 
--      tiempo un pedido.
SELECT DISTINCT c.nombre_cliente FROM cliente c INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente WHERE p.fecha_entrega IS NULL OR p.fecha_entrega > p.fecha_esperada;

-- 10.	Devuelve un listado de las diferentes gamas de producto que ha comprado 
--      cada cliente.
SELECT DISTINCT c.nombre_cliente, g.gama FROM cliente c INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente INNER JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido INNER JOIN producto pr ON dp.codigo_producto = pr.codigo_producto INNER JOIN gama_producto g ON pr.gama = g.gama GROUP BY c.nombre_cliente, g.gama;