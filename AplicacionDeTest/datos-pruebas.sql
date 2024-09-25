INSERT INTO idiomas (nombre_idioma, codigo_idioma) VALUES
('Español', 'es'),
('Ingles', 'en'),
('Frances', 'fr');

INSERT INTO usuarios (nombre_usuario, email, contraseña, fecha_registro, rol, estado) VALUES
('john', 'john@example.com', 'password123', '2022-01-01', 'usuario', 'activo'),
('jane', 'jane@example.com', 'password456', '2022-01-02', 'admin', 'activo');

INSERT INTO categorias (nombre_categoria, creado_por) VALUES
('Categoria 1', 1),
('Categoria 2', 2);

INSERT INTO tests (titulo, descripcion, id_categoria, creado_por, fecha_creacion) VALUES
('Test 1', 'Descripcion del test 1', 1, 1, '2022-01-03'),
('Test 2', 'Descripcion del test 2', 2, 2, '2022-01-04');

INSERT INTO preguntas (id_test, enunciado) VALUES
(1, 'Pregunta 1 del test 1'),
(1, 'Pregunta 2 del test 1'),
(2, 'Pregunta 1 del test 2'),
(2, 'Pregunta 2 del test 2');

INSERT INTO respuestas (id_pregunta, texto_respuesta, es_correcta) VALUES
(1, 'Respuesta 1 a la pregunta 1', TRUE),
(1, 'Respuesta 2 a la pregunta 1', FALSE),
(2, 'Respuesta 1 a la pregunta 2', FALSE),
(2, 'Respuesta 2 a la pregunta 2', TRUE),
(3, 'Respuesta 1 a la pregunta 1 del test 2', TRUE),
(3, 'Respuesta 2 a la pregunta 1 del test 2', FALSE),
(4, 'Respuesta 1 a la pregunta 2 del test 2', FALSE),
(4, 'Respuesta 2 a la pregunta 2 del test 2', TRUE);

INSERT INTO valoraciones (id_test, id_usuario, puntuacion, comentario, id_idioma) VALUES
(1, 1, 4, 'Buen test', 1),
(2, 2, 3, 'Me gusto', 1);

INSERT INTO reportes (id_test, id_usuario, descripcion, fecha_reporte, estado, id_idioma) VALUES
(1, 1, 'Problema con la pregunta 1', '2022-01-05', 'pendiente', 1),
(2, 2, 'Problema con la pregunta 2', '2022-01-06', 'pendiente', 1);

INSERT INTO historial_respuestas (id_usuario, id_pregunta, id_respuesta, fecha_respuesta, es_correcta) VALUES
(1, 1, 1, '2022-01-07', TRUE),
(1, 2, 2, '2022-01-08', FALSE),
(2, 3, 3, '2022-01-09', TRUE),
(2, 4, 4, '2022-01-10', TRUE);

INSERT INTO notificaciones (id_usuario, mensaje, leido, fecha_notificacion) VALUES
(1, 'Nuevo test disponible', FALSE, '2022-01-11'),
(2, 'Comentario en tu test', TRUE, '2022-01-12');
