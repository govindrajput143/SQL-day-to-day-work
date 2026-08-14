-- SQL Practice | 19 Aug | RANKING WINDOW FUNCTIONS

USE sql_practice_18;

-- QUESTIONS
-- Q1. Assign ROW_NUMBER to all employees by salary descending.
-- Q2. Rank employees by salary.
-- Q3. Rank employees within each department.
-- Q4. Find the top 2 employees in every department.
-- Q5. Find the highest-paid employee in every department.
-- Q6. Find the 2nd-highest salary in every department.
-- Q7. Compare RANK and DENSE_RANK.
-- Q8. Find the bottom employee in every department.

-- SOLUTIONS
SELECT *,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

SELECT *,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

SELECT *,
       RANK() OVER (
           PARTITION BY department
           ORDER BY salary DESC
       ) AS dept_rank
FROM employees;

SELECT *
FROM (
    SELECT e.*,
           ROW_NUMBER() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS rn
    FROM employees e
) t
WHERE rn <= 2;

SELECT *
FROM (
    SELECT e.*,
           RANK() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS rnk
    FROM employees e
) t
WHERE rnk = 1;

SELECT *
FROM (
    SELECT e.*,
           DENSE_RANK() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS drnk
    FROM employees e
) t
WHERE drnk = 2;

SELECT *,
       RANK() OVER (ORDER BY salary DESC) AS rnk,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rnk
FROM employees;

SELECT *
FROM (
    SELECT e.*,
           ROW_NUMBER() OVER (
               PARTITION BY department
               ORDER BY salary
           ) AS rn
    FROM employees e
) t
WHERE rn = 1;
