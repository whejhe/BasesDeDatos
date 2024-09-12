--Consultas Simples
SELECT * FROM usuarios;

SELECT * FROM categorias;

SELECT * FROM tests;

SELECT * FROM preguntas WHERE id_test = 1;

SELECT * FROM respuestas WHERE id_pregunta = 1;

SELECT * FROM reportes WHERE estado = 'pendiente';


--Consultas con Filtrados y Ordenación
SELECT titulo, descripcion FROM tests WHERE creado_por = 1;

SELECT id_usuario, puntuacion, comentario FROM valoraciones 
WHERE id_test = 1 
ORDER BY puntuacion DESC;

SELECT * FROM usuarios WHERE estado = 'bloqueado';

SELECT * FROM notificaciones 
WHERE id_usuario = 1 AND leido = FALSE;


--Consultas con JOINs
SELECT t.titulo, c.nombre_categoria 
FROM tests t
JOIN categorias c ON t.id_categoria = c.id_categoria;

SELECT p.enunciado, r.texto_respuesta, r.es_correcta
FROM preguntas p
JOIN respuestas r ON p.id_pregunta = r.id_pregunta
WHERE p.id_test = 1;

SELECT u.nombre_usuario, v.puntuacion, v.comentario
FROM valoraciones v
JOIN usuarios u ON v.id_usuario = u.id_usuario
WHERE v.id_test = 1;

SELECT p.enunciado, r.texto_respuesta, h.es_correcta
FROM historial_respuestas h
JOIN preguntas p ON h.id_pregunta = p.id_pregunta
JOIN respuestas r ON h.id_respuesta = r.id_respuesta
WHERE h.id_usuario = 1 AND p.id_test = 1;


--Consultas con Funciones Agregadas
SELECT u.nombre_usuario, COUNT(t.id_test) AS total_tests
FROM usuarios u
JOIN tests t ON u.id_usuario = t.creado_por
GROUP BY u.nombre_usuario;


SELECT AVG(puntuacion) AS valoracion_promedio
FROM valoraciones 
WHERE id_test = 1;


SELECT COUNT(*) AS total_reportes_pendientes 
FROM reportes 
WHERE estado = 'pendiente';

SELECT u.nombre_usuario, pu.puntuacion_total
FROM usuarios u
JOIN puntuacion_usuarios pu ON u.id_usuario = pu.id_usuario;


--Consultas Avanzadas con Subconsultas y Condiciones Complejas
SELECT t.titulo, COUNT(v.id_valoracion) AS total_valoraciones
FROM tests t
JOIN valoraciones v ON t.id_test = v.id_test
GROUP BY t.titulo
ORDER BY total_valoraciones DESC
LIMIT 1;


SELECT u.nombre_usuario, COUNT(r.id_reporte) AS total_reportes
FROM usuarios u
JOIN reportes r ON u.id_usuario = r.id_usuario
GROUP BY u.nombre_usuario
HAVING total_reportes > 1;


SELECT t.titulo, COUNT(h.id_historial) AS correctas
FROM historial_respuestas h
JOIN preguntas p ON h.id_pregunta = p.id_pregunta
JOIN tests t ON p.id_test = t.id_test
WHERE h.id_usuario = 1 AND h.es_correcta = TRUE
GROUP BY t.titulo
HAVING correctas > (SELECT COUNT(*)/2 FROM preguntas WHERE id_test = t.id_test);


SELECT n.mensaje, u.nombre_usuario
FROM notificaciones n
JOIN usuarios u ON n.id_usuario = u.id_usuario
JOIN acumulacion_reportes ar ON u.id_usuario = ar.id_usuario
WHERE n.leido = FALSE AND ar.reportes_acumulados > 2;


--Consultas de Inserción y Actualización
INSERT INTO valoraciones (id_test, id_usuario, puntuacion, comentario)
VALUES (1, 2, 5, 'Gran test, muy útil.');

UPDATE reportes 
SET estado = 'revisado' 
WHERE id_reporte = 1;


UPDATE puntuacion_usuarios 
SET puntuacion_total = puntuacion_total + 1
WHERE id_usuario = 1;
