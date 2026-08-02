create database newdb;

use newdb;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    gender CHAR(1),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);


INSERT INTO Department VALUES
(101, 'HR', 'Delhi'),
(102, 'IT', 'Bangalore'),
(103, 'Finance', 'Mumbai'),
(104, 'Sales', 'Pune'),
(105, 'Marketing', 'Hyderabad');



INSERT INTO Employee VALUES
(1, 'Amit',    'M', 55000, 101, NULL),
(2, 'Neha',    'F', 48000, 101, 1),
(3, 'Raj',     'M', 62000, 101, 1),
(4, 'Priya',   'F', 70000, 102, NULL),
(5, 'Arjun',   'M', 68000, 102, 4),
(6, 'Kiran',   'F', 72000, 102, 4),
(7, 'Rohit',   'M', 61000, 102, 4),
(8, 'Sneha',   'F', 80000, 103, NULL),
(9, 'Vikas',   'M', 75000, 103, 8),
(10,'Anjali',  'F', 78000, 103, 8),
(11,'Mohit',   'M', 50000, 104, NULL),
(12,'Pooja',   'F', 45000, 104, 11),
(13,'Deepak',  'M', 53000, 104, 11),
(14,'Riya',    'F', 60000, 104, 11),
(15,'Kunal',   'M', 65000, 105, NULL),
(16,'Nisha',   'F', 62000, 105, 15),
(17,'Varun',   'M', 59000, 105, 15),
(18,'Isha',    'F', 67000, 105, 15),
(19,'Manish',  'M', 64000, 105, 15),
(20,'Kavya',   'F', 52000, 101, 1);





select * from employee where dept_id = 104
and salary = (select max(salary) from employee where dept_id = 104);

select * from employee where dept_id = 104
and salary >=all (select salary from employee where dept_id = 104);

select * from employee as eout where 
salary >=all (select salary from employee where dept_id = eout.dept_id);


select e.emp_id , e.emp_name , d.dept_name, e.salary from employee as e
join department as d on e.dept_id = d.dept_id 
where salary > (select avg(salary) from employee where dept_id = e.dept_id);



-- employee who earn more than every other employee in there department (by using max)
SELECT 
    e.emp_id, 
    e.emp_name, 
    d.dept_name, 
    e.salary 
FROM Employee AS e
JOIN Department AS d 
    ON e.dept_id = d.dept_id
WHERE e.salary = (
    SELECT MAX(salary) 
    FROM Employee 
    WHERE dept_id = e.dept_id
);
-- employee who earn more than every other employee in there department (by using all)
SELECT 
    e.emp_name 
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id
WHERE e.salary > ALL (
    SELECT salary 
    FROM Employee 
    WHERE dept_id = e.dept_id 
      AND emp_id <> e.emp_id
);


-- department having al least one employee earning more than 70000
SELECT 
    dept_id, 
    dept_name
FROM Department
WHERE dept_id IN (
    SELECT dept_id 
    FROM Employee 
    WHERE salary > 70000
);


WITH RankedEmployees AS (SELECT e.emp_id,e.emp_name,d.dept_name,e.salary,
        DENSE_RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS rnk
    FROM Employee e
    JOIN Department d ON e.dept_id = d.dept_id
)
SELECT 
    emp_id, 
    emp_name, 
    dept_name, 
    salary 
FROM RankedEmployees
WHERE rnk = 2;



-- Find Employees Earning Above Average Salary
SELECT emp_id, emp_name, salary
FROM Employee
WHERE salary > (
    SELECT AVG(salary) 
    FROM Employee
);


-- Find Departments with at Least One Employee Earning > ₹70,000

SELECT dept_id, dept_name, location
FROM Department
WHERE dept_id IN (
    SELECT DISTINCT dept_id
    FROM Employee
    WHERE salary > 70000
);

-- Find Employees Who Are NOT Managers

SELECT emp_id, emp_name, salary
FROM Employee
WHERE emp_id NOT IN (
    SELECT DISTINCT manager_id 
    FROM Employee 
    WHERE manager_id IS NOT NULL
);

-- Find the Second Highest Salary
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (
    SELECT MAX(salary) 
    FROM Employee
);


