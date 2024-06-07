create database Movie
use Movie;


CREATE TABLE genres (
    genre_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE directors (
    director_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE actors (
    actor_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    genre_id INT,
    director_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
    FOREIGN KEY (director_id) REFERENCES directors(director_id)
);


CREATE TABLE movie_actors (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);


CREATE TABLE ratings (
    rating_id INT PRIMARY KEY,
    movie_id INT,
    user_id INT,
    rating DECIMAL(3, 2),
    rating_date DATE,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

CREATE TABLE movies_list (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    genre_id INT,
    director_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
    FOREIGN KEY (director_id) REFERENCES directors(director_id)
);


CREATE TABLE genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE directors (
    director_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE actors (
    actor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE movie_actors (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);


CREATE TABLE ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    user_id INT,
    rating DECIMAL(2, 1) CHECK (rating >= 0.0 AND rating <= 10.0),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);


CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL
);

INSERT INTO genres (genre_id, name) VALUES (1, 'Action'), (2, 'Drama');
INSERT INTO directors (director_id, name) VALUES (1, 'Christopher Nolan'), (2, 'Steven Spielberg');
INSERT INTO actors (actor_id, name) VALUES (1, 'Leonardo DiCaprio'), (2, 'Brad Pitt');

INSERT INTO movies (movie_id, title, release_year, genre_id, director_id) VALUES (1, 'Inception', 2010, 1, 1);
INSERT INTO movies (movie_id, title, release_year, genre_id, director_id) VALUES (2, 'Fight Club', 1999, 2, 2);

INSERT INTO movie_actors (movie_id, actor_id) VALUES (1, 1), (2, 2);

INSERT INTO ratings (rating_id, movie_id, user_id, rating, rating_date) VALUES (1, 1, 1, 9.0, '2023-06-01');
INSERT INTO ratings (rating_id, movie_id, user_id, rating, rating_date) VALUES (2, 2, 1, 8.5, '2023-06-02');

-- Retrieve top-rated movies in the Action genre
SELECT m.title, AVG(r.rating) AS average_rating
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
JOIN genres g ON m.genre_id = g.genre_id
WHERE g.name = 'Action'
GROUP BY m.title
ORDER BY average_rating DESC;

