-- CONSULTAS RESUMEN

-- 1.	¿Cuántos empleados hay en la compañía?
SELECT COUNT(*) FROM empleado;

-- 2.	¿Cuántos clientes tiene cada país?
SELECT pais, COUNT(*) FROM cliente GROUP BY pais;

-- 3.	¿Cuál fue el pago medio en 2009?
SELECT AVG(total) FROM pago WHERE fecha_pago BETWEEN '2009-01-01' AND '2009-12-31';

-- 4.	¿Cuántos pedidos hay en cada estado? Ordena el resultado de 
--      forma descendente por el número de pedidos.
SELECT estado, COUNT(*) FROM pedido GROUP BY estado ORDER BY COUNT(*) DESC;

-- 5.	Calcula el precio de venta del producto más caro y más barato 
--      en una misma consulta.
SELECT MAX(precio_venta) AS precio_max, MIN(precio_venta) AS precio_min FROM producto;

-- 6.	Calcula el número de clientes que tiene la empresa.
SELECT COUNT(*) FROM cliente;

-- 7.	¿Cuántos clientes tiene la ciudad de Madrid?
SELECT COUNT(*) FROM cliente WHERE ciudad = 'Madrid';

-- 8.	¿Calcula cuántos clientes tiene cada una de las ciudades que 
--      empiezan por M?
SELECT ciudad, COUNT(*) FROM cliente WHERE ciudad LIKE 'M%' GROUP BY ciudad;

-- 9.	Devuelve el nombre de los representantes de ventas y el número 
--      de clientes al que atiende cada uno.
SELECT e.nombre, e.apellido1, COUNT(c.codigo_cliente) AS num_clientes FROM empleado e JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas GROUP BY e.nombre, e.apellido1;

-- 10.	Calcula el número de clientes que no tiene asignado representante 
--      de ventas.
SELECT COUNT(*) FROM cliente WHERE codigo_empleado_rep_ventas IS NULL;

-- 11.	Calcula la fecha del primer y último pago realizado por cada 
--      uno de los clientes. El listado deberá mostrar el nombre y los 
--      apellidos de cada cliente.
SELECT c.nombre_cliente, c.apellido_contacto, MIN(p.fecha_pago) AS fecha_primer_pago, MAX(p.fecha_pago) AS fecha_ultimo_pago FROM cliente c JOIN pago p ON c.codigo_cliente = p.codigo_cliente GROUP BY c.nombre_cliente, c.apellido_contacto;

-- 12.	Calcula el número de productos diferentes que hay en cada uno 
--      de los pedidos.
SELECT p.codigo_pedido, COUNT(DISTINCT dp.codigo_producto) AS num_productos FROM pedido p JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido GROUP BY p.codigo_pedido;

-- 13.	Calcula la suma de la cantidad total de todos los productos 
--      que aparecen en cada uno de los pedidos.
SELECT p.codigo_pedido, SUM(dp.cantidad) AS total_cantidad FROM pedido p JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido GROUP BY p.codigo_pedido;

-- 14.	Devuelve un listado de los 20 productos más vendidos y el 
--      número total de unidades que se han vendido de cada uno. 
--      El listado deberá estar ordenado por el número total de unidades 
--      vendidas.
SELECT p.codigo_producto, SUM(dp.cantidad) AS total_unidades FROM producto p JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto GROUP BY p.codigo_producto ORDER BY total_unidades DESC LIMIT 20;

-- 15.	La facturación que ha tenido la empresa en toda la historia, 
--      indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
SELECT SUM(dp.cantidad * p.precio_venta) AS base_imponible, SUM(dp.cantidad * p.precio_venta * 0.21) AS iva, SUM(dp.cantidad * p.precio_venta * 1.21) AS total_facturado FROM detalle_pedido dp JOIN producto p ON dp.codigo_producto = p.codigo_producto;

-- 16.	La misma información que en la pregunta anterior, pero agrupada 
--      por código de producto.
SELECT p.codigo_producto, SUM(dp.cantidad * p.precio_venta) AS base_imponible, SUM(dp.cantidad * p.precio_venta * 0.21) AS iva, SUM(dp.cantidad * p.precio_venta * 1.21) AS total_facturado FROM detalle_pedido dp JOIN producto p ON dp.codigo_producto = p.codigo_producto GROUP BY p.codigo_producto;

-- 17.	La misma información que en la pregunta anterior, pero agrupada 
--      por código de producto filtrada por los códigos que empiecen 
--      por OR.
SELECT p.codigo_producto, SUM(dp.cantidad * p.precio_venta) AS base_imponible, SUM(dp.cantidad * p.precio_venta * 0.21) AS iva, SUM(dp.cantidad * p.precio_venta * 1.21) AS total_facturado FROM detalle_pedido dp JOIN producto p ON dp.codigo_producto = p.codigo_producto WHERE p.codigo_producto LIKE 'OR%' GROUP BY p.codigo_producto;

-- 18.	Lista las ventas totales de los productos que hayan facturado 
--      más de 3000 euros. Se mostrará el nombre, unidades vendidas, 
--      total facturado y total facturado con impuestos (21% IVA).
SELECT p.nombre, SUM(dp.cantidad) AS unidades_vendidas, SUM(dp.cantidad * p.precio_venta) AS total_facturado, SUM(dp.cantidad * p.precio_venta * 1.21) AS total_facturado_con_iva FROM detalle_pedido dp JOIN producto p ON dp.codigo_producto = p.codigo_producto GROUP BY p.nombre HAVING SUM(dp.cantidad * p.precio_venta) > 3000;
 