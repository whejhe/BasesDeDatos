CREATE DATABASE Recetas;
USE Recetas;
CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    nick VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    avatar_url VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Recipes(
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    recipe_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    instructions TEXT NOT NULL,
    cooking_time INT,
    original_country VARCHAR(50),
    category VARCHAR(50) NOT NULL,
    is_public BOOLEAN DEFAULT TRUE,
    image_url VARCHAR(255),
    video_url VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE Ingredients(
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    unit VARCHAR(50) NOT NULL,
    ingredient_name VARCHAR(100) NOT NULL,
    ingredient_type VARCHAR(50) NOT NULL,
    description TEXT
);
CREATE TABLE Recipe_Ingredients(
    recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity VARCHAR(50) NOT NULL,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);
CREATE TABLE Categories(
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);
CREATE TABLE Recipe_Categories(
    recipe_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (recipe_id, category_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
CREATE TABLE Comments(
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    recipe_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id)
);
CREATE TABLE Followers(
    follower_id INT NOT NULL,
    following_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, following_id),
    FOREIGN KEY (follower_id) REFERENCES User(user_id),
    FOREIGN KEY (following_id) REFERENCES User(user_id)
);