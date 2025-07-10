-- SQL Lesson 1: SELECT queries 101
-- Find the title of each film
SELECT Title FROM Movies;

-- Find the director of each film
SELECT director FROM Movies;

-- Find the title and director of each film
SELECT title, director FROM Movies;

-- Find the title and year of each film 
SELECT title, year FROM Movies;

-- Find all the information about each film 
SELECT * FROM Movies;

-- SQL Lesson 2: Queries with constraints (Pt. 1)
-- Find the movie with a row id of 6
SELECT * FROM movies WHERE id = 6;

-- Find the movies released in the years between 2000 and 2010
SELECT * FROM movies WHERE year BETWEEN 2000 AND 2010;

-- Find the movies not released in the years between 2000 and 2010
SELECT * FROM movies WHERE year NOT BETWEEN 2000 AND 2010;

-- Find the first 5 Pixar movies and their release year
SELECT Title, year FROM movies limit 5;

-- SQL Lesson 3: Queries with constraints (Pt. 2)
-- Find all the Toy Story movies 
SELECT * FROM movies where Title like "%Toy Story%";

-- Find all the movies directed by John Lasseter
SELECT * FROM movies where director like "John Lasseter";

-- Find all the movies (and director) not directed by John Lasseter
SELECT Title, Director FROM movies where director not like "John Lasseter";

-- Find all the WALL-* movies 
SELECT * FROM movies where Title like "WALL-%";

-- SQL Lesson 4: Filtering and sorting Query results
-- List all directors of Pixar movies (alphabetically), without duplicates
SELECT DISTINCT Director FROM movies
ORDER BY Director ASC;

-- List the last four Pixar movies released (ordered from most recent to least)
SELECT * FROM movies
ORDER BY year desc
LIMIT 4;

-- List the first five Pixar movies sorted alphabetically