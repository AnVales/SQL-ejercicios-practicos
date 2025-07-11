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
SELECT * FROM movies
ORDER BY title asc
LIMIT 5;

-- List the next five Pixar movies sorted alphabetically
SELECT * FROM movies
ORDER BY title asc
LIMIT 5 OFFSET 5;

-- SQL Review: Simple SELECT Queries
-- List all the Canadian cities and their populations
SELECT * FROM north_american_cities
WHERE country like "Canada";

-- Order all the cities in the United States by their latitude from north to south
SELECT * FROM north_american_cities
WHERE country like "United States"
order by latitude desc;

-- List all the cities west of Chicago, ordered from west to east
SELECT * FROM north_american_cities

SELECT * FROM north_american_cities
WHERE longitude < -87.629798
ORDER BY longitude ASC;

SELECT * FROM north_american_cities
WHERE longitude < (
    SELECT longitude FROM north_american_cities WHERE city = 'Chicago'
)
ORDER BY longitude ASC;

-- List the two largest cities in Mexico (by population) ✓
SELECT * FROM north_american_cities
where country like "Mexico"
ORDER BY population desc
LIMIT 2;

-- List the third and fourth largest cities (by population) in the United States and their population
SELECT city,population FROM north_american_cities
ORDER BY population desc
LIMIT 2 OFFSET 4;

-- SQL Lesson 6: Multi-table queries with JOINs
-- Find the domestic and international sales for each movie
select *
from boxoffice 
inner join movies on boxoffice.movie_id = movies.Id

-- Show the sales numbers for each movie that did better internationally rather than domestically
select *
from boxoffice 
inner join movies on movies.Id = boxoffice.movie_id
where international_sales > domestic_sales

-- List all the movies by their ratings in descending order
select *
from boxoffice 
inner join movies on movies.Id = boxoffice.movie_id
ORDER BY rating DESC

-- SQL Lesson 7: OUTER JOINs
-- Find the list of all buildings that have employees 
SELECT DISTINCT building FROM employees
LEFT JOIN buildings ON employees.building = buildings.building_name;

-- Find the list of all buildings and their capacity
SELECT *
from buildings;

-- List all buildings and the distinct employee roles in each building (including empty buildings)
SELECT DISTINCT buildings.building_name, employees.role
FROM buildings
LEFT JOIN employees
  ON buildings.building_name = employees.role;

-- SQL Lesson 8: A short note on NULLs
-- Find the name and role of all employees who have not been assigned to a building
SELECT name,role  FROM employees
where building is null;

-- Find the names of the buildings that hold no employees
SELECT building_name FROM buildings 
left JOIN employees ON employees.building = buildings.building_name
where building IS null;

-- SQL Lesson 9: Queries with expressions
-- List all movies and their combined sales in millions of dollars 
SELECT m.title, (b.domestic_sales + b.international_sales)/1000000 AS sales
FROM movies AS m
inner join boxoffice as b on m.id = b.movie_id;

-- List all movies and their ratings in percent
SELECT m.title, b.rating * 10 AS rating_percent
FROM movies AS m
inner join boxoffice as b on m.id = b.movie_id;

-- List all movies that were released on even number years
SELECT m.title, m.year
FROM movies AS m
inner join boxoffice as b on m.id = b.movie_id
WHERE (m.year % 2) = 0;

-- SQL Lesson 10: Queries with aggregates (Pt. 1)
-- Find the longest time that an employee has been at the studio 
SELECT max(years_employed) FROM employees;

-- For each role, find the average number of years employed by employees in that role
SELECT role, AVG(years_employed) FROM employees
GROUP BY role;

-- Find the total number of employee years worked in each building
SELECT building, SUM(years_employed) FROM employees
GROUP BY building;

-- SQL Lesson 11: Queries with aggregates (Pt. 2)
-- Find the number of Artists in the studio (without a HAVING clause)
select role, COUNT(name) as cantidad_empleados from employees
WHERE role = "Artist"
group by role;

-- select role, COUNT(name) as cantidad_empleados from employees group by role;
select role, COUNT(name) as cantidad_empleados from employees
group by role;

-- Find the total number of years employed by all Engineers
select role, sum(years_employed) from employees
where role = "Engineer"
group by role;

-- SQL Lesson 12: Order of execution of a Query
-- Find the number of movies each director has directed
select count(title) as numero_peliculas, director
from movies
group by director;

-- Find the total domestic and international sales that can be attributed to each director
select m.director, 
sum(b.domestic_sales + b.international_sales) as ventas
from movies as m
INNER JOIN boxoffice AS b on m.id = b.movie_id
group by m.director;

-- SQL Lesson 13: Inserting rows
-- Add the studio's new production, Toy Story 4 to the list of movies (you can use any director)
INSERT INTO movies 
(id, title, director, year, length_minutes)
VALUES (15, "Toy Story 4", "Lee Unkrich", 2005, 95);

-- Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table.
INSERT INTO boxoffice VALUES movies 
(movie_id, rating, domestic_sales, international_sales)
VALUES (15, 8.7, 340000000000, 270000000000);

-- SQL Lesson 14: Updating rows
-- The director for A Bug's Life is incorrect, it was actually directed by John Lasseter
update movies
set director ="John Lasseter"
where title = "A Bug's Life";

-- The year that Toy Story 2 was released is incorrect, it was actually released in 1999
update movies
set year = "1999"
where title = "Toy Story 2";

-- Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich 
update movies
set director = "Lee Unkrich",
title = "Toy Story 3"
where title = "Toy Story 8";

-- SQL Lesson 15: Deleting rows
-- This database is getting too big, lets remove all movies that were released before 2005.
delete from movies
where year < 2005,

-- Andrew Stanton has also left the studio, so please remove all movies directed by him. 
delete from movies
where director = "Andrew Stanton"

-- SQL Lesson 16: Creating tables
-- Create a new table named Database with the following columns:
-- Name A string (text) describing the name of the database
-- Version A number (floating point) of the latest version of this database
-- Download_count An integer count of the number of times this database was downloaded
-- This table has no constraints.

create table Database(
Name text,
Version float,
Download_count integer
)

-- SQL Lesson 17: Altering tables
-- Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in. 
alter table Movies
add column Aspect_ratio float default 2.39,

-- Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English.
alter table Movies
add column Language text DEFAULT "English" ;

-- SQL Lesson 18: Dropping tables
-- We've sadly reached the end of our lessons, lets clean up by removing the Movies table
drop table Movies

-- And drop the BoxOffice table as well
DROP TABLE IF EXISTS BoxOffice;

-- SQL Topic: Subqueries
-- Display Orders Issued by Salesman 'Paul Adam'
-- From the following tables, write a SQL query to find all the orders issued by the salesman 
-- 'Paul Adam'. Return ord_no, purch_amt, ord_date, customer_id and salesman_id.
-- Crear la tabla Salesman
-- Crear la tabla Salesman

CREATE TABLE Salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    commission DECIMAL(4, 2)
);

-- Insertar los datos
INSERT INTO Salesman (salesman_id, name, city, commission)
VALUES 
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

-- Crear la tabla Orders
CREATE TABLE Orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);

-- Insertar los datos
INSERT INTO Orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES 
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26,  '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60,'2012-07-27', 3007, 5001),
(70008, 5760.00,'2012-09-10', 3002, 5001),
(70010, 1983.43,'2012-10-10', 3004, 5006),
(70003, 2480.40,'2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29,  '2012-08-17', 3003, 5007),
(70013, 3045.60,'2012-04-25', 3002, 5001);

select * from Orders
select * from Salesman

select o.ord_no, o.purch_amt, o.ord_date, o.customer_id, o.salesman_id 
from Orders as o 
inner join Salesman as s on s.salesman_id=o.salesman_id
where name = 'Paul Adam';

-- Display Orders Generated by London-Based Salespeople
-- From the following tables write a SQL query to find all orders generated by London-based salespeople. 
-- Return ord_no, purch_amt, ord_date, customer_id, salesman_id.
-- pedidos en londres

select ord_no, purch_amt, ord_date, customer_id, salesman_id
from Orders
where salesman_id IN (
select salesman_id from Salesman where city = 'London')

-- find all orders generated by the salespeople who may work for customers whose id is 3007. 
-- Return ord_no, purch_amt, ord_date, customer_id, salesman_id.
select * from Orders
select * from Salesman

select ord_no, purch_amt, ord_date, customer_id, salesman_id from Orders 
where salesman_id in
(select salesman_id from Orders where customer_id = '3007')

-- Display Orders Exceeding Average Value on 10-Oct-2012
-- find the order values greater than the average order value of 10th October 2012. 
-- purch_amt mayores de la media de 10th October 2012
-- Return ord_no, purch_amt, ord_date, customer_id, salesman_id.
select ord_no, purch_amt, ord_date, customer_id, salesman_id from Orders
where purch_amt>(select AVG(purch_amt) as media_oct from Orders 
where ord_date = '2012-10-10')

-- Display Orders Generated in New York City
-- Find all the orders generated in New York city. 
-- Return ord_no, purch_amt, ord_date, customer_id and salesman_id.
select ord_no, purch_amt, ord_date, customer_id, salesman_id from Orders
where salesman_id in
(select salesman_id from Salesman where city = 'New York') 