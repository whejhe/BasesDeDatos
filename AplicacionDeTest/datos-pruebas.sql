INSERT INTO usuarios (nombre_usuario, email, contraseña, fecha_registro, rol) 
VALUES 
('Juan Perez', 'juan@example.com', 'hashedpassword1', CURDATE(), 'usuario'),
('Maria Gomez', 'maria@example.com', 'hashedpassword2', CURDATE(), 'usuario'),
('Pedro Rodriguez', 'pedro@example.com', 'hashedpassword3', CURDATE(), 'usuario'),
('Ana Sanchez', 'ana@example.com', 'hashedpassword4', CURDATE(), 'usuario'),
('Admin', 'admin@example.com', 'adminpassword', CURDATE(), 'admin');


INSERT INTO categorias (nombre_categoria, creado_por) 
VALUES 
('Matemáticas', 1),
('Ciencias', 2),
('Historia', 3),
('Lenguaje', 4);


INSERT INTO tests (titulo, descripcion, id_categoria, creado_por, fecha_creacion) 
VALUES 
('Álgebra Básica', 'Test sobre álgebra básica.', 1, 1, CURDATE()),
('Física Elemental', 'Test de física para principiantes.', 2, 2, CURDATE()),
('Historia Universal', 'Test de historia universal.', 3, 3, CURDATE()),
('Ortografía Española', 'Test sobre reglas de ortografía.', 4, 4, CURDATE()),
('Geometría Avanzada', 'Test para usuarios con conocimiento avanzado de geometría.', 1, 1, CURDATE());


INSERT INTO preguntas (id_test, enunciado) 
VALUES 
(1, '¿Cuánto es 2 + 2?'),
(1, '¿Cuál es la fórmula del área de un círculo?'),
(2, '¿Cuál es la velocidad de la luz en el vacío?'),
(2, '¿Qué es la primera ley de Newton?'),
(3, '¿En qué año ocurrió la Revolución Francesa?'),
(3, '¿Quién fue Alejandro Magno?'),
(4, '¿Cuál es la palabra correcta, haber o a ver?'),
(4, '¿Cuándo se acentúa una palabra aguda?'),
(5, '¿Qué es un triángulo equilátero?'),
(5, '¿Qué es el teorema de Pitágoras?');


INSERT INTO respuestas (id_pregunta, texto_respuesta, es_correcta) 
VALUES 
(1, '4', TRUE),
(1, '5', FALSE),
(2, 'πr^2', TRUE),
(2, '2πr', FALSE),
(3, '299,792,458 m/s', TRUE),
(3, '150,000,000 m/s', FALSE),
(4, 'La ley de inercia', TRUE),
(4, 'La ley de la gravedad', FALSE),
(5, '1789', TRUE),
(5, '1804', FALSE),
(6, 'Un conquistador', FALSE),
(6, 'Un rey y militar macedonio', TRUE),
(7, 'Haber', FALSE),
(7, 'A ver', TRUE),
(8, 'Cuando termina en consonante que no sea "n" ni "s"', TRUE),
(8, 'Siempre se acentúa', FALSE),
(9, 'Un triángulo con tres lados iguales', TRUE),
(9, 'Un triángulo con tres ángulos diferentes', FALSE),
(10, 'a^2 + b^2 = c^2', TRUE),
(10, 'a^2 + b^2 = 2ab', FALSE);


INSERT INTO valoraciones (id_test, id_usuario, puntuacion, comentario) 
VALUES 
(1, 2, 5, 'Excelente test, muy educativo.'),
(2, 3, 4, 'Buen test, pero algunas preguntas confusas.'),
(3, 4, 3, 'Interesante, pero faltan más preguntas.'),
(4, 1, 5, 'Muy útil para repasar la ortografía.'),
(5, 2, 4, 'Un buen reto para la mente.');


INSERT INTO reportes (id_test, id_usuario, descripcion, fecha_reporte) 
VALUES 
(1, 3, 'Hay un error en una de las preguntas.', CURDATE()),
(2, 4, 'Las respuestas no son claras.', CURDATE()),
(5, 3, 'El test es confuso en algunas partes.', CURDATE());


INSERT INTO historial_respuestas (id_usuario, id_pregunta, id_respuesta, fecha_respuesta, es_correcta) 
VALUES 
(1, 1, 1, CURDATE(), TRUE),
(1, 2, 3, CURDATE(), TRUE),
(2, 3, 5, CURDATE(), TRUE),
(2, 4, 7, CURDATE(), TRUE),
(3, 5, 9, CURDATE(), TRUE),
(3, 6, 11, CURDATE(), TRUE),
(4, 7, 13, CURDATE(), TRUE),
(4, 8, 15, CURDATE(), TRUE),
(2, 9, 17, CURDATE(), TRUE),
(1, 10, 19, CURDATE(), TRUE);


INSERT INTO notificaciones (id_usuario, mensaje, leido, fecha_notificacion) 
VALUES 
(1, 'Tienes un nuevo test disponible: Álgebra Básica.', FALSE, CURDATE()),
(2, 'Tienes un nuevo test disponible: Física Elemental.', FALSE, CURDATE()),
(3, 'Tienes un nuevo test disponible: Historia Universal.', FALSE, CURDATE()),
(4, 'Tienes un nuevo test disponible: Ortografía Española.', FALSE, CURDATE()),
(1, 'Tienes un nuevo test disponible: Geometría Avanzada.', FALSE, CURDATE());


INSERT INTO acumulacion_reportes (id_usuario, reportes_acumulados, fecha_ultima_revision) 
VALUES 
(1, 1, CURDATE()),
(3, 2, CURDATE()),
(4, 1, CURDATE());


INSERT INTO puntuacion_usuarios (id_usuario, puntuacion_total) 
VALUES 
(1, 10),
(2, 8),
(3, 6),
(4, 9),
(5, 7);
