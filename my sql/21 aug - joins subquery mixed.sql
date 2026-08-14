-- SQL Practice | 21 Aug | JOINS + SUBQUERY MIXED

DROP DATABASE IF EXISTS sql_practice_21;
CREATE DATABASE sql_practice_21;
USE sql_practice_21;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2),
    experience INT
);

INSERT INTO departments VALUES
(10,'IT'),(20,'HR'),(30,'Sales'),(40,'Finance');

INSERT INTO employees VALUES
(101,'Aditya',10,55000,2),
(102,'Hema',20,48000,3),
(103,'Hitesh',10,72000,5),
(104,'Chirag',30,45000,2),
(105,'Nishu',40,85000,7),
(106,'Ravi',30,60000,4),
(107,'Dimple',10,65000,4),
(108,'Khemish',20,52000,5);

-- QUESTIONS
-- Q1. Find employees earning above their department average and show department name.
-- Q2. Find the highest-paid employee in every department with department name.
-- Q3. Find departments whose average salary is above company average.
-- Q4. Find employees earning above the average salary of IT.
-- Q5. Find departments with at least one employee earning above 70000.
-- Q6. Find the employee with the second-highest salary in each department.
-- Q7. Find employees who earn more than the average salary of their city/department equivalent group.
-- Q8. Find departments whose total salary is greater than the average department total.

-- SOLUTIONS
SELECT e.emp_name, d.department_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

SELECT e.emp_name, d.department_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING AVG(e.salary) > (SELECT AVG(salary) FROM employees);

SELECT e.*
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = 10
);

SELECT d.department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING MAX(e.salary) > 70000;

SELECT e.*
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
      AND e2.salary < (
          SELECT MAX(e3.salary)
          FROM employees e3
          WHERE e3.department_id = e.department_id
      )
);

SELECT e.*
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

SELECT d.department_name, SUM(e.salary) AS dept_total
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING SUM(e.salary) > (
    SELECT AVG(dept_total)
    FROM (
        SELECT SUM(salary) AS dept_total
        FROM employees
        GROUP BY department_id
    ) x
);
