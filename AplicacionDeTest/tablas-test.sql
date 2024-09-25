CREATE DATABASE AppTest;
USE AppTest;

DROP TABLE IF EXISTS historial_respuestas;
DROP TABLE IF EXISTS notificaciones;
DROP TABLE IF EXISTS acumulacion_reportes;
DROP TABLE IF EXISTS puntuacion_usuarios;
DROP TABLE IF EXISTS reportes;
DROP TABLE IF EXISTS valoraciones;
DROP TABLE IF EXISTS respuestas;
DROP TABLE IF EXISTS preguntas;
DROP TABLE IF EXISTS tests;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS idiomas;


CREATE TABLE idiomas (
    id_idioma INT PRIMARY KEY AUTO_INCREMENT,
    nombre_idioma VARCHAR(50) NOT NULL,
    codigo_idioma VARCHAR(5) UNIQUE NOT NULL
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

CREATE UNIQUE INDEX idx_nombre_usuario ON usuarios(nombre_usuario);
CREATE INDEX idx_email ON usuarios(email);

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(100) NOT NULL,
    creado_por INT,
    id_idioma INT NOT NULL,
    FOREIGN KEY (creado_por) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_idioma) REFERENCES idiomas(id_idioma)
);

CREATE TABLE tests (
    id_test INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_categoria INT,
    creado_por INT,
    fecha_creacion DATE NOT NULL,
    id_idioma INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (creado_por) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_idioma) REFERENCES idiomas(id_idioma)
);


CREATE TABLE preguntas (
    id_pregunta INT PRIMARY KEY AUTO_INCREMENT,
    id_test INT,
    enunciado TEXT NOT NULL,
    FOREIGN KEY (id_test) REFERENCES tests(id_test)
);
CREATE INDEX idx_test_preguntas ON preguntas(id_test);

CREATE TABLE respuestas (
    id_respuesta INT PRIMARY KEY AUTO_INCREMENT,
    id_pregunta INT,
    texto_respuesta TEXT NOT NULL,
    es_correcta BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id_pregunta)
);
CREATE INDEX idx_pregunta_respuestas ON respuestas(id_pregunta);

CREATE TABLE valoraciones (
    id_valoracion INT PRIMARY KEY AUTO_INCREMENT,
    id_test INT,
    id_usuario INT,
    puntuacion INT CHECK(
        puntuacion BETWEEN 1 AND 5
    ),
    comentario TEXT,
    id_idioma INT NOT NULL,
    FOREIGN KEY (id_test) REFERENCES tests(id_test),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_idioma) REFERENCES idiomas(id_idioma)
);
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