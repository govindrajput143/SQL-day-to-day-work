-- Using MySQL World Database

USE world;


-- Display City Table

SELECT *
FROM city;


-- Q1
-- Find cities where district is same as Abu Dhabi

SELECT Name
FROM city
WHERE District = (
    SELECT District
    FROM city
    WHERE Name = 'Abu Dhabi'
);



-- Q2
-- Get city details having maximum population

SELECT *
FROM city
WHERE Population = (
    SELECT MAX(Population)
    FROM city
);



-- Q3
-- Find District and City having same country code as Herat

SELECT District, Name
FROM city
WHERE CountryCode = (
    SELECT CountryCode
    FROM city
    WHERE Name = 'Herat'
);



-- Q4
-- Find District, City and Population
-- for cities having same country code as Amsterdam

SELECT District, Name, Population
FROM city
WHERE CountryCode = (
    SELECT CountryCode
    FROM city
    WHERE Name = 'Amsterdam'
)
ORDER BY Population;
