CREATE TABLE idiomas (
    id_idioma INT PRIMARY KEY AUTO_INCREMENT,
    nombre_idioma VARCHAR(50) NOT NULL,
    codigo_idioma VARCHAR(5) UNIQUE NOT NULL -- Ej: 'es' para español, 'en' para inglés
);


CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_usuario VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    fecha_registro DATE NOT NULL,
    rol ENUM('usuario', 'admin') DEFAULT 'usuario',
    estado ENUM('activo', 'bloqueado') DEFAULT 'activo'
);

-- Añadimos un índice en la columna email
CREATE UNIQUE INDEX idx_nombre_usuario ON usuarios(nombre_usuario);
CREATE INDEX idx_email ON usuarios(email);


CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(100) NOT NULL,
    creado_por INT,
    FOREIGN KEY (creado_por) REFERENCES usuarios(id_usuario)
);

ALTER TABLE categorias 
ADD COLUMN id_idioma INT NOT NULL,
ADD FOREIGN KEY (id_idioma) REFERENCES idiomas(id_idioma);


CREATE TABLE tests (
    id_test INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_categoria INT,
    creado_por INT,
    fecha_creacion DATE NOT NULL,
    CHECK (id_categoria IS NOT NULL)
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (creado_por) REFERENCES usuarios(id_usuario)
);

ALTER TABLE tests 
ADD COLUMN id_idioma INT,
ADD FOREIGN KEY (id_idioma) REFERENCES idiomas(id_idioma);

-- Añadimos un índice en la columna id_categoria
CREATE INDEX idx_categoria ON tests(id_categoria);


CREATE TABLE preguntas (
    id_pregunta INT PRIMARY KEY AUTO_INCREMENT,
    id_test INT,
    enunciado TEXT NOT NULL,
    CHECK (LENGTH(enunciado) > 10),
    FOREIGN KEY (id_test) REFERENCES tests(id_test)
);
-- Añadimos un índice en la columna id_test
CREATE INDEX idx_test_preguntas ON preguntas(id_test);


CREATE TABLE respuestas (
    id_respuesta INT PRIMARY KEY AUTO_INCREMENT,
    id_pregunta INT,
    texto_respuesta TEXT NOT NULL,
    es_correcta BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id_pregunta)
);
-- Añadimos un índice en la columna id_pregunta
CREATE INDEX idx_pregunta_respuestas ON respuestas(id_pregunta);


CREATE TABLE valoraciones (
    id_valoracion INT PRIMARY KEY AUTO_INCREMENT,
    id_test INT,
    id_usuario INT,
    puntuacion INT CHECK(puntuacion BETWEEN 1 AND 5),
    comentario TEXT,
    FOREIGN KEY (id_test) REFERENCES tests(id_test),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

ALTER TABLE valoraciones 
ADD COLUMN id_idioma INT NOT NULL,
ADD FOREIGN KEY (id_idioma) REFERENCES idiomas(id_idioma);

-- Índices en id_test e id_usuario
CREATE INDEX idx_test_valoraciones ON valoraciones(id_test);
CREATE INDEX idx_usuario_valoraciones ON valoraciones(id_usuario);


CREATE TABLE reportes (
    id_reporte INT PRIMARY KEY AUTO_INCREMENT,
    id_test INT,
    id_usuario INT,
    descripcion TEXT,
    fecha_reporte DATE NOT NULL,
    estado ENUM('pendiente', 'revisado') DEFAULT 'pendiente',
    FOREIGN KEY (id_test) REFERENCES tests(id_test),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
-- Índices en id_test e id_usuario
CREATE INDEX idx_test_reportes ON reportes(id_test);
CREATE INDEX idx_usuario_reportes ON reportes(id_usuario);



CREATE TABLE historial_respuestas (
    id_historial INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_pregunta INT,
    id_respuesta INT,
    fecha_respuesta DATE NOT NULL,
    es_correcta BOOLEAN NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id_pregunta),
    FOREIGN KEY (id_respuesta) REFERENCES respuestas(id_respuesta)
);


CREATE TABLE notificaciones (
    id_notificacion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    mensaje TEXT NOT NULL,
    leido BOOLEAN DEFAULT FALSE,
    fecha_notificacion DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);


CREATE TABLE acumulacion_reportes (
    id_acumulacion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    reportes_acumulados INT DEFAULT 0,
    fecha_ultima_revision DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);


CREATE TABLE puntuacion_usuarios (
    id_usuario INT PRIMARY KEY,
    puntuacion_total INT DEFAULT 0,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
