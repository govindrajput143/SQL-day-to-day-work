-- SQL Practice | 15 Aug | JOINS - INTERMEDIATE

DROP DATABASE IF EXISTS sql_practice_15;
CREATE DATABASE sql_practice_15;
USE sql_practice_15;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    category VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(201,'Rahul','Jaipur'),
(202,'Priya','Delhi'),
(203,'Aman','Mumbai'),
(204,'Neha','Pune'),
(205,'Karan','Jaipur'),
(206,'Riya','Kota');

INSERT INTO orders VALUES
(1001,201,'2026-08-01',12000,'Laptop'),
(1002,201,'2026-08-05',5000,'Mobile'),
(1003,202,'2026-08-03',7000,'Tablet'),
(1004,203,'2026-08-04',15000,'Laptop'),
(1005,203,'2026-08-07',3000,'Accessories'),
(1006,205,'2026-08-08',9000,'Mobile'),
(1007,201,'2026-08-10',2000,'Accessories');

-- QUESTIONS
-- Q1. Show every customer with total order amount.
-- Q2. Show customers who never placed an order.
-- Q3. Find the customer with the highest total spending.
-- Q4. Find average order amount for each city.
-- Q5. Find customers whose total spending is above 10000.
-- Q6. Find the number of orders placed by each customer.
-- Q7. Find the largest order of every customer.
-- Q8. Show customer, order and category details for orders above 5000.

-- SOLUTIONS
SELECT c.customer_name, COALESCE(SUM(o.amount),0) AS total_spending
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT c.*
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT c.customer_name, SUM(o.amount) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC
LIMIT 1;

SELECT c.city, AVG(o.amount) AS avg_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city;

SELECT c.customer_name, SUM(o.amount) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 10000;

SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT c.customer_name, MAX(o.amount) AS largest_order
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT c.customer_name, o.order_id, o.category, o.amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.amount > 5000;
