-- SQL Practice | 14 Aug | JOINS
-- Topic: INNER JOIN, LEFT JOIN, RIGHT JOIN
-- Run this file in MySQL.

DROP DATABASE IF EXISTS sql_practice_14;
CREATE DATABASE sql_practice_14;
USE sql_practice_14;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2),
    city VARCHAR(50),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments VALUES
(10,'IT','Jaipur'),
(20,'HR','Delhi'),
(30,'Sales','Mumbai'),
(40,'Finance','Pune'),
(50,'Marketing','Jaipur');

INSERT INTO employees VALUES
(101,'Aditya',10,55000,'Jaipur'),
(102,'Hema',20,48000,'Delhi'),
(103,'Hitesh',10,62000,'Jaipur'),
(104,'Chirag',30,45000,'Mumbai'),
(105,'Nishu',40,70000,'Pune'),
(106,'Ravi',30,52000,'Mumbai'),
(107,'Dimple',NULL,40000,'Jaipur');

-- QUESTIONS
-- Q1. Display employee name and department name.
-- Q2. Display employees working in IT.
-- Q3. Display employee name, salary and department location.
-- Q4. Display all departments, including departments with no employees.
-- Q5. Display employees who are not assigned to a department.
-- Q6. Find average salary department-wise.
-- Q7. Find the highest-paid employee in each department.
-- Q8. Display departments having more than one employee.

-- SOLUTIONS
-- Q1
SELECT e.emp_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- Q2
SELECT e.emp_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'IT';

-- Q3
SELECT e.emp_name, e.salary, d.location
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Q4
SELECT d.department_name, e.emp_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;

-- Q5
SELECT e.*
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- Q6
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Q7
SELECT d.department_name, e.emp_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

-- Q8
SELECT d.department_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.emp_id) > 1;
