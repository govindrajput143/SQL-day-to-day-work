-- SQL Practice | 17 Aug | SUBQUERY - CORRELATED & NESTED

USE sql_practice_16;

-- QUESTIONS
-- Q1. Find employees earning more than their department average.
-- Q2. Find the highest-paid employee in every department.
-- Q3. Find the lowest-paid employee in every department.
-- Q4. Find departments whose maximum salary is above the company average.
-- Q5. Find employees who have the same salary as someone in another department.
-- Q6. Find employees whose salary is greater than every HR employee.
-- Q7. Find employees whose salary is greater than at least one Sales employee.
-- Q8. Find the second-highest salary in each department.

-- SOLUTIONS
SELECT e.*
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
);

SELECT e.*
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
);

SELECT e.*
FROM employees e
WHERE e.salary = (
    SELECT MIN(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
);

SELECT department, MAX(salary) AS max_salary
FROM employees
GROUP BY department
HAVING MAX(salary) > (SELECT AVG(salary) FROM employees);

SELECT e.*
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.salary = e.salary
      AND e2.department <> e.department
);

SELECT *
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE department = 'HR'
);

SELECT *
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE department = 'Sales'
);

SELECT e.*
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
      AND e2.salary < (
          SELECT MAX(e3.salary)
          FROM employees e3
          WHERE e3.department = e.department
      )
);
