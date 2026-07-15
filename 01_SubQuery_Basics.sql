-- SubQuery Basics
-- An SQL subquery is a query nested inside another SQL query.
-- It is used to pass intermediate data to the main query.
-- Also known as inner query or nested query.


-- Create Database
CREATE DATABASE corrr_db;

USE corrr_db;


-- Create Employee Table
CREATE TABLE employee_c (
    id INT,
    name VARCHAR(20),
    salary INT
);


-- Insert Employee Data
INSERT INTO employee_c VALUES
(1,'a',100),
(2,'b',250),
(3,'c',400),
(4,'d',300);


-- Find Highest Salary
SELECT MAX(salary)
FROM employee_c;


-- Find Employee With Salary 400
SELECT *
FROM employee_c
WHERE salary = 400;


-- Find Employee With Salary 100
SELECT *
FROM employee_c
WHERE salary = 100;


-- SubQuery Example
-- Find Employee Having Minimum Salary

SELECT *
FROM employee_c
WHERE salary = (
    SELECT MIN(salary)
    FROM employee_c
);


-- Insert New Employee

INSERT INTO employee_c VALUES
(5,'aman',250);


-- Display All Employees

SELECT *
FROM employee_c;


-- Nested Query Example
-- Find Employee Having Same Salary As Employee 'b'

SELECT *
FROM employee_c
WHERE salary = (
    SELECT salary
    FROM employee_c
    WHERE name='b'
);
