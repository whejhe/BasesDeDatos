-- DROP TABLE IF EXISTS series_genres;
-- DROP TABLE IF EXISTS movie_genres;
-- DROP TABLE IF EXISTS series_platforms;
-- DROP TABLE IF EXISTS movie_platforms;
-- DROP TABLE IF EXISTS platforms;
-- DROP TABLE IF EXISTS series_people;
-- DROP TABLE IF EXISTS movie_people;
-- DROP TABLE IF EXISTS people;
-- DROP TABLE IF EXISTS view_history;
-- DROP TABLE IF EXISTS playlist_series;
-- DROP TABLE IF EXISTS playlist_movies;
-- DROP TABLE IF EXISTS playlists;
-- DROP TABLE IF EXISTS ratings;
-- DROP TABLE IF EXISTS comments;
-- DROP TABLE IF EXISTS favorite_movie;
-- DROP TABLE IF EXISTS favorite_series;
-- DROP TABLE IF EXISTS user_series;
-- DROP TABLE IF EXISTS user_movies;
-- DROP TABLE IF EXISTS users;
-- DROP TABLE IF EXISTS episodes;
-- DROP TABLE IF EXISTS series;
-- DROP TABLE IF EXISTS movies;
-- DROP TABLE IF EXISTS genres;

-- DROP DATABASE whejheVision;

CREATE DATABASE IF NOT EXISTS whejheVision;

USE whejheVision;

CREATE TABLE IF NOT EXISTS genres (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS movies (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    genre_id INT NOT NULL,
    duration INT,  -- Duración en minutos
    synopsis TEXT, -- Sinopsis de la película
    original_language VARCHAR(255),
    subtitles_language VARCHAR(255),
    image_url VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE IF NOT EXISTS series (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    genre_id INT NOT NULL,
    synopsis TEXT, -- Sinopsis de la serie
    original_language VARCHAR(255),
    subtitles_language VARCHAR(255),
    image_url VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE IF NOT EXISTS episodes (
    id INT NOT NULL AUTO_INCREMENT,
    series_id INT NOT NULL,
    season INT NOT NULL,
    episode_number INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    duration INT, -- Duración en minutos
    synopsis TEXT, -- Sinopsis del episodio
    image_url VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (series_id) REFERENCES series(id)
);

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    nick VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    user_name VARCHAR(255) NOT NULL UNIQUE,
    avatar_url VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'user', -- Rol del usuario, por defecto 'user'
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    reset_token VARCHAR(255),
    reset_token_expires_at DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS user_movie (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

CREATE TABLE IF NOT EXISTS user_series (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    series_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (series_id) REFERENCES series(id)
);

CREATE TABLE IF NOT EXISTS favorite_movie (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

CREATE TABLE IF NOT EXISTS favorite_series (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    series_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (series_id) REFERENCES series(id)
);

CREATE TABLE IF NOT EXISTS comments (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    movie_id INT, -- Puede ser NULL si el comentario es para una serie
    series_id INT, -- Puede ser NULL si el comentario es para una película
    episode_id INT, -- Puede ser NULL si el comentario es para una película o serie completa
    parent_id INT,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (series_id) REFERENCES series(id),
    FOREIGN KEY (episode_id) REFERENCES episodes(id)
);

-- VALORACINES
CREATE TABLE IF NOT EXISTS ratings (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    movie_id INT,
    series_id INT,
    rating INT NOT NULL,
    review TEXT,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (series_id) REFERENCES series(id)
);

-- LISTA DE REPRODUCCIONES
CREATE TABLE IF NOT EXISTS playlists (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS playlist_movies (
    id INT NOT NULL AUTO_INCREMENT,
    playlist_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

CREATE TABLE IF NOT EXISTS playlist_series (
    id INT NOT NULL AUTO_INCREMENT,
    playlist_id INT NOT NULL,
    series_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(id),
    FOREIGN KEY (series_id) REFERENCES series(id)
);


-- HISTORIAL DE VISUALIZACIONES
CREATE TABLE IF NOT EXISTS view_history (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    movie_id INT,
    series_id INT,
    episode_id INT,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    device VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (series_id) REFERENCES series(id),
    FOREIGN KEY (episode_id) REFERENCES episodes(id)
);



--ACTORES Y DIRECTORES
CREATE TABLE IF NOT EXISTS people (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    birth_date DATE,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS movie_people (
    id INT NOT NULL AUTO_INCREMENT,
    movie_id INT NOT NULL,
    person_id INT NOT NULL,
    role VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (person_id) REFERENCES people(id)
);

CREATE TABLE IF NOT EXISTS series_people (
    id INT NOT NULL AUTO_INCREMENT,
    series_id INT NOT NULL,
    person_id INT NOT NULL,
    role VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (series_id) REFERENCES series(id),
    FOREIGN KEY (person_id) REFERENCES people(id)
);


--PLATAFORMA
CREATE TABLE IF NOT EXISTS platforms (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS movie_platforms (
    id INT NOT NULL AUTO_INCREMENT,
    movie_id INT NOT NULL,
    platform_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (platform_id) REFERENCES platforms(id)
);

CREATE TABLE IF NOT EXISTS series_platforms (
    id INT NOT NULL AUTO_INCREMENT,
    series_id INT NOT NULL,
    platform_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (series_id) REFERENCES series(id),
    FOREIGN KEY (platform_id) REFERENCES platforms(id)
);

-- GENEROS SECUNDARIOS
CREATE TABLE IF NOT EXISTS movie_genres (
    id INT NOT NULL AUTO_INCREMENT,
    movie_id INT NOT NULL,
    genre_id INT NOT NULL,
    is_primary BOOLEAN NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE IF NOT EXISTS series_genres (
    id INT NOT NULL AUTO_INCREMENT,
    series_id INT NOT NULL,
    genre_id INT NOT NULL,
    is_primary BOOLEAN NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (series_id) REFERENCES series(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);


