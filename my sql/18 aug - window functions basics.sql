-- SQL Practice | 18 Aug | WINDOW FUNCTIONS BASICS

DROP DATABASE IF EXISTS sql_practice_18;
CREATE DATABASE sql_practice_18;
USE sql_practice_18;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    joining_date DATE
);

INSERT INTO employees VALUES
(101,'Aditya','IT',55000,'2024-01-10'),
(102,'Hema','HR',48000,'2023-05-12'),
(103,'Hitesh','IT',72000,'2022-03-15'),
(104,'Chirag','Sales',45000,'2025-01-20'),
(105,'Nishu','Finance',85000,'2021-07-11'),
(106,'Ravi','Sales',60000,'2023-08-14'),
(107,'Dimple','IT',65000,'2023-02-18'),
(108,'Khemish','HR',52000,'2024-06-21');

-- QUESTIONS
-- Q1. Add overall average salary to every row.
-- Q2. Add department average salary to every employee.
-- Q3. Calculate salary difference from department average.
-- Q4. Calculate department total salary.
-- Q5. Calculate running salary total ordered by salary.
-- Q6. Calculate running salary total within each department.
-- Q7. Count employees in each department using a window function.
-- Q8. Find each employee's percentage contribution to department salary.

-- SOLUTIONS
SELECT *, AVG(salary) OVER () AS company_avg
FROM employees;

SELECT *, AVG(salary) OVER (PARTITION BY department) AS dept_avg
FROM employees;

SELECT *,
       salary - AVG(salary) OVER (PARTITION BY department) AS difference_from_dept_avg
FROM employees;

SELECT *,
       SUM(salary) OVER (PARTITION BY department) AS dept_total_salary
FROM employees;

SELECT *,
       SUM(salary) OVER (ORDER BY salary) AS running_salary
FROM employees;

SELECT *,
       SUM(salary) OVER (
           PARTITION BY department
           ORDER BY salary
       ) AS dept_running_salary
FROM employees;

SELECT *,
       COUNT(*) OVER (PARTITION BY department) AS dept_employee_count
FROM employees;

SELECT *,
       ROUND(
           salary * 100.0 /
           SUM(salary) OVER (PARTITION BY department), 2
       ) AS dept_salary_percentage
FROM employees;
