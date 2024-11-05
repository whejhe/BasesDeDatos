--5.1	Con operadores básicos de comparación
--1.	Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente FROM cliente ORDER BY limite_credito DESC LIMIT 1;
--2.	Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre FROM producto ORDER BY precio_venta DESC LIMIT 1;
--3.	Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código del producto, puede obtener su nombre fácilmente.)
SELECT p.nombre FROM producto p JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto GROUP BY p.nombre ORDER BY SUM(dp.cantidad) DESC LIMIT 1;
--4.	Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
SELECT c.nombre_cliente FROM cliente c WHERE c.limite_credito > (SELECT SUM(p.total) FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);
--5.	Devuelve el producto que más unidades tiene en stock.
SELECT nombre FROM producto ORDER BY cantidad_en_stock DESC LIMIT 1;
--6.	Devuelve el producto que menos unidades tiene en stock.
SELECT nombre FROM producto ORDER BY cantidad_en_stock ASC LIMIT 1;
--7.	Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
SELECT e.nombre, e.apellido1, e.apellido2, e.email FROM empleado e WHERE e.codigo_jefe = (SELECT codigo_empleado FROM empleado WHERE nombre = 'Alberto' AND apellido1 = 'Soria');

--5.2	Subconsultas con ALL y ANY
--8.	Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente FROM cliente WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);
--9.	Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre FROM producto WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);
--10.	Devuelve el producto que menos unidades tiene en stock.
SELECT nombre FROM producto WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);

--5.3	Subconsultas con IN y NOT IN
--11.	Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
SELECT e.nombre, e.apellido1, e.puesto FROM empleado e WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);
--12.	Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT c.nombre_cliente FROM cliente c WHERE c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);
--13.	Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
SELECT c.nombre_cliente FROM cliente c WHERE c.codigo_cliente IN (SELECT codigo_cliente FROM pago);
--14.	Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT p.nombre FROM producto p WHERE p.codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);
--15.	Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono FROM empleado e JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);
--16.	Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT o.ciudad, o.pais FROM oficina o WHERE o.codigo_oficina NOT IN ( SELECT e.codigo_oficina FROM empleado e JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas JOIN pedido p ON c.codigo_cliente = p.codigo_cliente JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido JOIN producto pr ON dp.codigo_producto = pr.codigo_producto WHERE pr.gama = 'Frutales');
--17.	Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT c.* FROM cliente c WHERE c.codigo_cliente IN (SELECT p.codigo_cliente FROM pedido p) AND c.codigo_cliente NOT IN (SELECT pa.codigo_cliente FROM pago pa);

--5.4	Subconsultas con EXISTS y NOT EXISTS
--18.	Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT c.* FROM cliente c WHERE NOT EXISTS (SELECT 1 FROM pago pa WHERE pa.codigo_cliente = c.codigo_cliente);
--19.	Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
SELECT c.* FROM cliente c WHERE EXISTS (SELECT 1 FROM pago pa WHERE pa.codigo_cliente = c.codigo_cliente);
--20.	Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT p.* FROM producto p WHERE NOT EXISTS (SELECT 1 FROM detalle_pedido dp WHERE dp.codigo_producto = p.codigo_producto);
--21.	Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
SELECT p.* FROM producto p WHERE EXISTS (SELECT 1 FROM detalle_pedido dp WHERE dp.codigo_producto = p.codigo_producto);