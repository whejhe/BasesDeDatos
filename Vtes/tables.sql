CREATE DATABASE Vtes;

USE Vtes;

CREATE TABLE User (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    nick VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    avatar_url VARCHAR(255),
    password VARCHAR(255) NOT NULL
);

CREATE TABLE Card (
    card_id INT PRIMARY KEY,
    card_name VARCHAR(100) NOT NULL,
    card_url VARCHAR(255) NOT NULL,
    card_type VARCHAR(50) NOT NULL,
    card_text TEXT NOT NULL,
    ordered_sets VARCHAR(100),
    title VARCHAR(50),
    clan VARCHAR(50),
    multidiscipline BOOLEAN,
    disciplines VARCHAR(100),
    capacity INT,
    cost_pool INT,
    cost_blood INT,
    rulings TEXT,
    sets VARCHAR(100),
    groups INT
);

CREATE TABLE Deck (
    deck_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    deck_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    author VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    is_public BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE CustomCard (
    custom_card_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    custom_card_name VARCHAR(100) NOT NULL,
    author VARCHAR(50) NOT NULL,
    capacity INT,
    custom_card_url VARCHAR(255) NOT NULL,
    clan VARCHAR(50),
    disciplines VARCHAR(100),
    group INT,
    custom_card_type VARCHAR(50) NOT NULL,
    logo_color VARCHAR(50),
    custom_card_text TEXT NOT NULL,
    is_public BOOLEAN DEFAULT TRUE,
    cost_pool INT,
    cost_blood INT,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Crypt (
    crypt_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    deck_id INT NOT NULL,
    card_id INT NOT NULL,
    -- Add any other relevant crypt information here
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (deck_id) REFERENCES Deck(deck_id),
    FOREIGN KEY (card_id) REFERENCES Card(card_id)
);

CREATE TABLE Library (
    library_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    deck_id INT NOT NULL,
    card_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (deck_id) REFERENCES Deck(deck_id),
    FOREIGN KEY (card_id) REFERENCES Card(card_id)
);

CREATE TABLE Report (
    report_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    card_id INT NOT NULL,
    card_name VARCHAR(100) NOT NULL,
    card_author VARCHAR(50) NOT NULL,
    emai_reporter VARCHAR(50) NOT NULL,
    name_user_reporter VARCHAR(50) NOT NULL,
    reason VARCHAR(100) NOT NULL,
    comment TEXT,
    is_checked BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (card_id) REFERENCES Card(card_id)
);
