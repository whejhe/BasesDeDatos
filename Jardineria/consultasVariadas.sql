--1.	Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
SELECT c.nombre_cliente, COUNT(p.codigo_pedido) AS num_pedidos FROM cliente c LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente GROUP BY c.nombre_cliente;
--2.	Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
SELECT c.nombre_cliente, SUM(pa.total) AS total_pagado FROM cliente c LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente GROUP BY c.nombre_cliente;
--3.	Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
SELECT c.nombre_cliente FROM cliente c JOIN pedido p ON c.codigo_cliente = p.codigo_cliente WHERE YEAR(p.fecha_pedido) = 2008 ORDER BY c.nombre_cliente ASC;
--4.	Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.telefono FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);
--5.	Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;
--6.	Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono FROM empleado e JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);
--7.	Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.
SELECT o.ciudad, COUNT(e.codigo_empleado) AS num_empleados FROM oficina o JOIN empleado e ON o.codigo_oficina = e.codigo_oficina GROUP BY o.ciudad;
