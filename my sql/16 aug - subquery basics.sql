-- SQL Practice | 16 Aug | SUBQUERY BASICS

DROP DATABASE IF EXISTS sql_practice_16;
CREATE DATABASE sql_practice_16;
USE sql_practice_16;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    experience INT,
    city VARCHAR(30)
);

INSERT INTO employees VALUES
(101,'Aditya','IT',55000,2,'Jaipur'),
(102,'Hema','HR',48000,3,'Delhi'),
(103,'Hitesh','IT',72000,5,'Jaipur'),
(104,'Chirag','Sales',45000,2,'Mumbai'),
(105,'Nishu','Finance',85000,7,'Pune'),
(106,'Ravi','Sales',60000,4,'Mumbai'),
(107,'Dimple','IT',65000,4,'Jaipur'),
(108,'Khemish','HR',52000,5,'Delhi');

-- QUESTIONS
-- Q1. Find employees earning more than the average salary.
-- Q2. Find the employee with the highest salary.
-- Q3. Find the second-highest salary.
-- Q4. Find employees earning the second-highest salary.
-- Q5. Find employees working in the same department as Aditya.
-- Q6. Find employees earning more than Aditya.
-- Q7. Find departments whose average salary is above 60000.
-- Q8. Find employees from cities where Hema works.

-- SOLUTIONS
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT *
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (SELECT MAX(salary) FROM employees)
);

SELECT *
FROM employees
WHERE department = (
    SELECT department FROM employees WHERE emp_name = 'Aditya'
);

SELECT *
FROM employees
WHERE salary > (
    SELECT salary FROM employees WHERE emp_name = 'Aditya'
);

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;

SELECT *
FROM employees
WHERE city = (
    SELECT city FROM employees WHERE emp_name = 'Hema'
);
