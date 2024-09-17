-- Eliminar tablas si ya existen
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Ratings;
DROP TABLE IF EXISTS Recipe_Ingredients;
DROP TABLE IF EXISTS Recipe_Categories;
DROP TABLE IF EXISTS Followers;
DROP TABLE IF EXISTS Ingredients;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Recipes;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Ingredient_Types;

DROP DATABASE IF EXISTS Recetas;

-- Crear base de datos
CREATE DATABASE Recetas;

USE Recetas;

-- Tabla de usuarios
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    nick VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    avatar_url VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de tipos de ingredientes
CREATE TABLE Ingredient_Types (
    ingredient_type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL
);

-- Tabla de ingredientes
CREATE TABLE Ingredients(
    ingredient_id INT PRIMARY KEY AUTO_INCREMENT,
    unit VARCHAR(50) NOT NULL,
    ingredient_name VARCHAR(100) NOT NULL,
    ingredient_type_id INT NOT NULL,
    description TEXT,
    FOREIGN KEY (ingredient_type_id) REFERENCES Ingredient_Types(ingredient_type_id)
);

-- Tabla de recetas
CREATE TABLE Recipes(
    recipe_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    recipe_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    instructions TEXT NOT NULL,
    cooking_time INT,
    original_country VARCHAR(50),
    is_public BOOLEAN DEFAULT TRUE,
    image_url VARCHAR(255),
    video_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Tabla de relación receta-ingredientes
CREATE TABLE Recipe_Ingredients(
    recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity DECIMAL(10, 2) NOT NULL,
    unit VARCHAR(50) NOT NULL,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);

-- Tabla de categorías
CREATE TABLE Categories(
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

-- Tabla de relación receta-categorías
CREATE TABLE Recipe_Categories(
    recipe_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (recipe_id, category_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Tabla de comentarios
CREATE TABLE Comments(
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    recipe_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id)
);

-- Tabla de seguidores
CREATE TABLE Followers(
    follower_id INT NOT NULL,
    following_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, following_id),
    FOREIGN KEY (follower_id) REFERENCES User(user_id),
    FOREIGN KEY (following_id) REFERENCES User(user_id)
);

-- Tabla de puntuaciones
CREATE TABLE Ratings(
    user_id INT NOT NULL,
    recipe_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, recipe_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id)
);

-- Índices adicionales
CREATE INDEX idx_recipe_name ON Recipes(recipe_name);
CREATE INDEX idx_ingredient_name ON Ingredients(ingredient_name);
CREATE INDEX idx_user_id ON Comments(user_id);
CREATE INDEX idx_recipe_id ON Comments(recipe_id);
CREATE INDEX idx_follower_following ON Followers(follower_id, following_id);
