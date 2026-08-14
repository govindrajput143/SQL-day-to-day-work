-- SQL Practice | 22 Aug | FINAL MIXED SQL PRACTICE
-- Topics: JOINS + SUBQUERIES + WINDOW FUNCTIONS

DROP DATABASE IF EXISTS sql_final_practice;
CREATE DATABASE sql_final_practice;
USE sql_final_practice;

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
    experience INT,
    city VARCHAR(50),
    joining_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments VALUES
(10,'IT','Jaipur'),
(20,'HR','Delhi'),
(30,'Sales','Mumbai'),
(40,'Finance','Pune'),
(50,'Marketing','Jaipur');

INSERT INTO employees VALUES
(101,'Aditya',10,55000,2,'Jaipur','2024-01-10'),
(102,'Hema',20,48000,3,'Delhi','2023-05-12'),
(103,'Hitesh',10,72000,5,'Jaipur','2022-03-15'),
(104,'Chirag',30,45000,2,'Mumbai','2025-01-20'),
(105,'Nishu',40,85000,7,'Pune','2021-07-11'),
(106,'Ravi',30,60000,4,'Mumbai','2023-08-14'),
(107,'Dimple',10,65000,4,'Jaipur','2023-02-18'),
(108,'Khemish',20,52000,5,'Delhi','2024-06-21'),
(109,'Himanshu',50,58000,3,'Jaipur','2025-02-01'),
(110,'Divanshu',50,62000,4,'Jaipur','2024-09-15');

-- QUESTIONS
-- Q1. Display employee, department and salary rank within department.
-- Q2. Find top 2 highest-paid employees in every department.
-- Q3. Find employees earning above department average.
-- Q4. Find the difference between employee salary and department average.
-- Q5. Find the highest-paid employee in the company.
-- Q6. Find the second-highest salary in the company.
-- Q7. Find the highest-paid employee in every department.
-- Q8. Find departments whose average salary is above company average.
-- Q9. Find each department's total salary and percentage of company payroll.
-- Q10. Find the employee with the earliest joining date in every department.
-- Q11. Find employees whose salary is above the company average and rank them.
-- Q12. Find the difference between each employee's salary and the previous salary within their department.
-- Q13. Find departments with more than one employee.
-- Q14. Find employees who are not in the highest-salary group of their department.
-- Q15. Create a final report containing employee name, department, salary, dept average, dept rank and salary difference from dept average.

-- SOLUTIONS

-- Q1
SELECT e.emp_name, d.department_name, e.salary,
       RANK() OVER (
           PARTITION BY e.department_id
           ORDER BY e.salary DESC
       ) AS dept_rank
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Q2
SELECT *
FROM (
    SELECT e.*, d.department_name,
           ROW_NUMBER() OVER (
               PARTITION BY e.department_id
               ORDER BY e.salary DESC
           ) AS rn
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
) x
WHERE rn <= 2;

-- Q3
SELECT e.*
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

-- Q4
SELECT e.emp_name, d.department_name, e.salary,
       ROUND(
           e.salary - AVG(e.salary) OVER (PARTITION BY e.department_id),
           2
       ) AS difference_from_dept_avg
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Q5
SELECT *
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- Q6
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

-- Q7
SELECT e.emp_name, d.department_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

-- Q8
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING AVG(e.salary) > (SELECT AVG(salary) FROM employees);

-- Q9
SELECT d.department_name,
       SUM(e.salary) AS dept_total,
       ROUND(
           SUM(e.salary) * 100.0 / SUM(SUM(e.salary)) OVER (),
           2
       ) AS payroll_percentage
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

-- Q10
SELECT e.*, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.joining_date = (
    SELECT MIN(e2.joining_date)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

-- Q11
SELECT *
FROM (
    SELECT e.*,
           RANK() OVER (ORDER BY e.salary DESC) AS company_rank
    FROM employees e
    WHERE e.salary > (SELECT AVG(salary) FROM employees)
) x;

-- Q12
SELECT e.*,
       e.salary - LAG(e.salary) OVER (
           PARTITION BY e.department_id
           ORDER BY e.salary
       ) AS salary_difference_from_previous
FROM employees e;

-- Q13
SELECT d.department_name, COUNT(e.emp_id) AS employee_count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.emp_id) > 1;

-- Q14
SELECT *
FROM (
    SELECT e.*,
           RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS dept_rank
    FROM employees e
) x
WHERE dept_rank > 1;

-- Q15
SELECT e.emp_name,
       d.department_name,
       e.salary,
       ROUND(AVG(e.salary) OVER (PARTITION BY e.department_id),2) AS dept_avg,
       RANK() OVER (
           PARTITION BY e.department_id
           ORDER BY e.salary DESC
       ) AS dept_rank,
       ROUND(
           e.salary - AVG(e.salary) OVER (PARTITION BY e.department_id),
           2
       ) AS salary_difference
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY d.department_name, dept_rank;
