-- SQL Practice | 20 Aug | ADVANCED WINDOW FUNCTIONS

USE sql_practice_18;

-- QUESTIONS
-- Q1. Show previous employee salary using LAG.
-- Q2. Show next employee salary using LEAD.
-- Q3. Calculate salary change from the previous employee.
-- Q4. Find the first salary in each department.
-- Q5. Find the last salary in each department.
-- Q6. Calculate salary difference from the highest salary in the department.
-- Q7. Compare each employee's salary with the previous salary.
-- Q8. Find employees whose salary is higher than the previous employee in their department.

-- SOLUTIONS
SELECT *,
       LAG(salary) OVER (ORDER BY salary) AS previous_salary
FROM employees;

SELECT *,
       LEAD(salary) OVER (ORDER BY salary) AS next_salary
FROM employees;

SELECT *,
       salary - LAG(salary) OVER (ORDER BY salary) AS salary_change
FROM employees;

SELECT *,
       FIRST_VALUE(salary) OVER (
           PARTITION BY department
           ORDER BY salary
       ) AS first_salary
FROM employees;

SELECT *,
       LAST_VALUE(salary) OVER (
           PARTITION BY department
           ORDER BY salary
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS last_salary
FROM employees;

SELECT *,
       MAX(salary) OVER (PARTITION BY department) - salary
       AS difference_from_dept_max
FROM employees;

SELECT *,
       LAG(salary) OVER (
           PARTITION BY department
           ORDER BY salary
       ) AS previous_dept_salary
FROM employees;

SELECT *
FROM (
    SELECT e.*,
           LAG(salary) OVER (
               PARTITION BY department
               ORDER BY salary
           ) AS previous_salary
    FROM employees e
) t
WHERE salary > previous_salary;
