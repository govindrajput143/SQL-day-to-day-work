SHOW DATABASES;

CREATE DATABASE windowsdb;
USE windowsdb;

CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(30),
    category VARCHAR(30),
    product VARCHAR(50),
    quantity INT,
    amount DECIMAL(10,2)
);

INSERT INTO orders
(order_id, order_date, customer_id, customer_name, city, category, product, quantity, amount)
VALUES
(1001, '2026-01-05', 201, 'Amit',   'Jaipur',  'Electronics', 'Laptop',       1, 65000),
(1002, '2026-01-10', 202, 'Neha',   'Delhi',   'Electronics', 'Mobile',       2, 50000),
(1003, '2026-01-15', 201, 'Amit',   'Jaipur',  'Furniture',   'Chair',        4, 12000),
(1004, '2026-01-20', 203, 'Rahul',  'Mumbai',  'Electronics', 'Headphones',   3, 9000),
(1005, '2026-01-25', 204, 'Priya',  'Delhi',   'Clothing',    'Jacket',       2, 8000),

(1006, '2026-02-03', 201, 'Amit',   'Jaipur',  'Electronics', 'Mobile',       1, 28000),
(1007, '2026-02-08', 202, 'Neha',   'Delhi',   'Furniture',   'Table',        1, 15000),
(1008, '2026-02-12', 203, 'Rahul',  'Mumbai',  'Clothing',    'Shoes',        2, 10000),
(1009, '2026-02-18', 205, 'Vikas',  'Pune',    'Electronics', 'Laptop',       1, 70000),
(1010, '2026-02-25', 204, 'Priya',  'Delhi',   'Furniture',   'Sofa',         1, 35000),

(1011, '2026-03-02', 201, 'Amit',   'Jaipur',  'Clothing',    'Shirt',        5, 7500),
(1012, '2026-03-07', 202, 'Neha',   'Delhi',   'Electronics', 'Headphones',   2, 6000),
(1013, '2026-03-11', 203, 'Rahul',  'Mumbai',  'Electronics', 'Laptop',       1, 68000),
(1014, '2026-03-16', 205, 'Vikas',  'Pune',    'Furniture',   'Chair',        6, 18000),
(1015, '2026-03-21', 204, 'Priya',  'Delhi',   'Clothing',    'Shoes',        1, 5500),

(1016, '2026-04-04', 201, 'Amit',   'Jaipur',  'Electronics', 'Tablet',       1, 22000),
(1017, '2026-04-09', 202, 'Neha',   'Delhi',   'Clothing',    'Jacket',       1, 4500),
(1018, '2026-04-14', 203, 'Rahul',  'Mumbai',  'Furniture',   'Table',        2, 30000),
(1019, '2026-04-20', 205, 'Vikas',  'Pune',    'Electronics', 'Mobile',       2, 52000),
(1020, '2026-04-27', 204, 'Priya',  'Delhi',   'Electronics', 'Laptop',       1, 72000);

-- =========================================================
-- ORIGINAL QUERIES
-- =========================================================

-- 1. Customer-wise order sequence
SELECT
    customer_id,
    customer_name,
    order_id,
    order_date,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS order_number
FROM orders;

-- 2. Overall order numbering by amount
SELECT
    customer_id,
    customer_name,
    order_id,
    order_date,
    amount,
    ROW_NUMBER() OVER(
        ORDER BY amount DESC
    ) AS rn
FROM orders;

-- 3. Category-wise ranking
SELECT
    category,
    order_id,
    amount,
    RANK() OVER(
        PARTITION BY category
        ORDER BY amount DESC
    ) AS category_rank
FROM orders;

-- 4. Show all orders
SELECT * FROM orders;

-- 5. Category average and difference using subquery
SELECT
    order_id,
    category,
    amount,
    (
        SELECT AVG(o2.amount)
        FROM orders o2
        WHERE o2.category = o1.category
    ) AS category_average,
    amount - (
        SELECT AVG(o2.amount)
        FROM orders o2
        WHERE o2.category = o1.category
    ) AS difference
FROM orders o1
ORDER BY order_id;

-- 6. Category average and difference using window function
SELECT
    order_id,
    category,
    amount,
    AVG(amount) OVER(
        PARTITION BY category
    ) AS category_average,
    ROUND(
        amount - AVG(amount) OVER(
            PARTITION BY category
        ),
        2
    ) AS amount_difference
FROM orders;

-- 7. Highest-value order of every customer using subquery
SELECT
    customer_name,
    order_id,
    amount
FROM orders o
WHERE amount = (
    SELECT MAX(o2.amount)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
)
ORDER BY customer_id;

-- 8. Highest-value order of every customer using ROW_NUMBER
SELECT
    customer_name,
    order_id,
    amount
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id
            ORDER BY amount DESC
        ) AS rn
    FROM orders
) t
WHERE rn = 1;

-- 9. Customer maximum amount using MAX window function
SELECT
    customer_id,
    customer_name,
    order_id,
    amount,
    MAX(amount) OVER(
        PARTITION BY customer_id
    ) AS customer_max
FROM orders;

-- 10. Only highest order of every customer using MAX window function
SELECT *
FROM (
    SELECT
        customer_id,
        customer_name,
        order_id,
        amount,
        MAX(amount) OVER(
            PARTITION BY customer_id
        ) AS customer_max
    FROM orders
) AS t
WHERE amount = customer_max;

-- 11. Top 2 highest-value orders for every customer
SELECT
    customer_name,
    order_id,
    amount,
    rn
FROM (
    SELECT
        customer_id,
        customer_name,
        order_id,
        amount,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id
            ORDER BY amount DESC
        ) AS rn
    FROM orders
) AS t
WHERE rn <= 2;

-- 12. Second-highest order of every customer
SELECT
    customer_name,
    order_id,
    amount
FROM (
    SELECT
        customer_id,
        customer_name,
        order_id,
        amount,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id
            ORDER BY amount DESC
        ) AS rn
    FROM orders
) AS t
WHERE rn = 2;

-- 13. Percentage contribution of each order to customer's total spending
SELECT
    customer_name,
    order_id,
    amount,
    total_spending,
    ROUND(
        (amount / total_spending) * 100,
        2
    ) AS percentage
FROM (
    SELECT
        customer_id,
        customer_name,
        order_id,
        amount,
        SUM(amount) OVER(
            PARTITION BY customer_id
        ) AS total_spending
    FROM orders
) AS t;


-- =========================================================
-- 20 ADDITIONAL BEGINNER QUERIES
-- Each problem has SUBQUERY + WINDOW FUNCTION
-- =========================================================

-- 14. Find orders greater than their category average

-- Subquery
SELECT
    order_id,
    category,
    amount
FROM orders o
WHERE amount > (
    SELECT AVG(o2.amount)
    FROM orders o2
    WHERE o2.category = o.category
);

-- Window Function
SELECT
    order_id,
    category,
    amount
FROM (
    SELECT
        order_id,
        category,
        amount,
        AVG(amount) OVER(
            PARTITION BY category
        ) AS category_avg
    FROM orders
) t
WHERE amount > category_avg;


-- 15. Find customers whose order amount is above 50000

-- Subquery
SELECT DISTINCT
    customer_id,
    customer_name
FROM orders
WHERE amount > 50000;

-- Window Function
SELECT DISTINCT
    customer_id,
    customer_name
FROM (
    SELECT
        customer_id,
        customer_name,
        amount,
        MAX(amount) OVER(
            PARTITION BY customer_id
        ) AS max_amount
    FROM orders
) t
WHERE max_amount > 50000;


-- 16. Find the minimum order of every customer

-- Subquery
SELECT
    o.customer_name,
    o.order_id,
    o.amount
FROM orders o
WHERE amount = (
    SELECT MIN(o2.amount)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

-- Window Function
SELECT
    customer_name,
    order_id,
    amount
FROM (
    SELECT
        customer_id,
        customer_name,
        order_id,
        amount,
        MIN(amount) OVER(
            PARTITION BY customer_id
        ) AS min_amount
    FROM orders
) t
WHERE amount = min_amount;


-- 17. Find highest order in every category

-- Subquery
SELECT
    o.category,
    o.order_id,
    o.amount
FROM orders o
WHERE amount = (
    SELECT MAX(o2.amount)
    FROM orders o2
    WHERE o2.category = o.category
);

-- Window Function
SELECT
    category,
    order_id,
    amount
FROM (
    SELECT
        category,
        order_id,
        amount,
        MAX(amount) OVER(
            PARTITION BY category
        ) AS max_amount
    FROM orders
) t
WHERE amount = max_amount;


-- 18. Find lowest order in every category

-- Subquery
SELECT
    o.category,
    o.order_id,
    o.amount
FROM orders o
WHERE amount = (
    SELECT MIN(o2.amount)
    FROM orders o2
    WHERE o2.category = o.category
);

-- Window Function
SELECT
    category,
    order_id,
    amount
FROM (
    SELECT
        category,
        order_id,
        amount,
        MIN(amount) OVER(
            PARTITION BY category
        ) AS min_amount
    FROM orders
) t
WHERE amount = min_amount;


-- 19. Find the third-highest order of every customer

-- Subquery
SELECT *
FROM orders o
WHERE 2 = (
    SELECT COUNT(*)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
      AND o2.amount > o.amount
);

-- Window Function
SELECT
    customer_name,
    order_id,
    amount
FROM (
    SELECT
        customer_id,
        customer_name,
        order_id,
        amount,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id
            ORDER BY amount DESC
        ) AS rn
    FROM orders
) t
WHERE rn = 3;


-- 20. Find top 2 orders from every category

-- Subquery
SELECT *
FROM orders o
WHERE 2 > (
    SELECT COUNT(*)
    FROM orders o2
    WHERE o2.category = o.category
      AND o2.amount > o.amount
);

-- Window Function
SELECT
    category,
    order_id,
    amount
FROM (
    SELECT
        category,
        order_id,
        amount,
        ROW_NUMBER() OVER(
            PARTITION BY category
            ORDER BY amount DESC
        ) AS rn
    FROM orders
) t
WHERE rn <= 2;


-- 21. Find each customer's total spending

-- Subquery
SELECT DISTINCT
    customer_id,
    customer_name,
    (
        SELECT SUM(o2.amount)
        FROM orders o2
        WHERE o2.customer_id = o.customer_id
    ) AS total_spending
FROM orders o;

-- Window Function
SELECT DISTINCT
    customer_id,
    customer_name,
    SUM(amount) OVER(
        PARTITION BY customer_id
    ) AS total_spending
FROM orders;


-- 22. Find total sales of every category

-- Subquery
SELECT DISTINCT
    category,
    (
        SELECT SUM(o2.amount)
        FROM orders o2
        WHERE o2.category = o.category
    ) AS category_sales
FROM orders o;

-- Window Function
SELECT DISTINCT
    category,
    SUM(amount) OVER(
        PARTITION BY category
    ) AS category_sales
FROM orders;


-- 23. Find number of orders made by every customer

-- Subquery
SELECT DISTINCT
    customer_id,
    customer_name,
    (
        SELECT COUNT(*)
        FROM orders o2
        WHERE o2.customer_id = o.customer_id
    ) AS total_orders
FROM orders o;

-- Window Function
SELECT DISTINCT
    customer_id,
    customer_name,
    COUNT(*) OVER(
        PARTITION BY customer_id
    ) AS total_orders
FROM orders;


-- 24. Find customers who placed more than 2 orders

-- Subquery
SELECT DISTINCT
    customer_id,
    customer_name
FROM orders o
WHERE (
    SELECT COUNT(*)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
) > 2;

-- Window Function
SELECT DISTINCT
    customer_id,
    customer_name
FROM (
    SELECT
        customer_id,
        customer_name,
        COUNT(*) OVER(
            PARTITION BY customer_id
        ) AS total_orders
    FROM orders
) t
WHERE total_orders > 2;


-- 25. Find difference between customer's order and their maximum order

-- Subquery
SELECT
    customer_name,
    order_id,
    amount,
    (
        SELECT MAX(o2.amount)
        FROM orders o2
        WHERE o2.customer_id = o.customer_id
    ) - amount AS difference
FROM orders o;

-- Window Function
SELECT
    customer_name,
    order_id,
    amount,
    MAX(amount) OVER(
        PARTITION BY customer_id
    ) - amount AS difference
FROM orders;


-- 26. Find difference between an order and category maximum

-- Subquery
SELECT
    order_id,
    category,
    amount,
    (
        SELECT MAX(o2.amount)
        FROM orders o2
        WHERE o2.category = o.category
    ) - amount AS difference
FROM orders o;

-- Window Function
SELECT
    order_id,
    category,
    amount,
    MAX(amount) OVER(
        PARTITION BY category
    ) - amount AS difference
FROM orders;


-- 27. Find each customer's average order amount

-- Subquery
SELECT DISTINCT
    customer_id,
    customer_name,
    (
        SELECT AVG(o2.amount)
        FROM orders o2
        WHERE o2.customer_id = o.customer_id
    ) AS average_amount
FROM orders o;

-- Window Function
SELECT DISTINCT
    customer_id,
    customer_name,
    AVG(amount) OVER(
        PARTITION BY customer_id
    ) AS average_amount
FROM orders;


-- 28. Find orders above customer's average spending

-- Subquery
SELECT
    order_id,
    customer_name,
    amount
FROM orders o
WHERE amount > (
    SELECT AVG(o2.amount)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

-- Window Function
SELECT
    order_id,
    customer_name,
    amount
FROM (
    SELECT
        customer_id,
        customer_name,
        order_id,
        amount,
        AVG(amount) OVER(
            PARTITION BY customer_id
        ) AS customer_avg
    FROM orders
) t
WHERE amount > customer_avg;


-- 29. Find the overall highest order

-- Subquery
SELECT
    order_id,
    customer_name,
    amount
FROM orders
WHERE amount = (
    SELECT MAX(amount)
    FROM orders
);

-- Window Function
SELECT
    order_id,
    customer_name,
    amount
FROM (
    SELECT
        order_id,
        customer_name,
        amount,
        MAX(amount) OVER() AS max_amount
    FROM orders
) t
WHERE amount = max_amount;


-- 30. Find the overall second-highest order

-- Subquery
SELECT
    order_id,
    customer_name,
    amount
FROM orders
WHERE amount = (
    SELECT MAX(amount)
    FROM orders
    WHERE amount < (
        SELECT MAX(amount)
        FROM orders
    )
);

-- Window Function
SELECT
    order_id,
    customer_name,
    amount
FROM (
    SELECT
        order_id,
        customer_name,
        amount,
        DENSE_RANK() OVER(
            ORDER BY amount DESC
        ) AS rnk
    FROM orders
) t
WHERE rnk = 2;


-- 31. Find the first order of every customer

-- Subquery
SELECT
    o.customer_name,
    o.order_id,
    o.order_date,
    o.amount
FROM orders o
WHERE o.order_date = (
    SELECT MIN(o2.order_date)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

-- Window Function
SELECT
    customer_name,
    order_id,
    order_date,
    amount
FROM (
    SELECT
        customer_id,
        customer_name,
        order_id,
        order_date,
        amount,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS rn
    FROM orders
) t
WHERE rn = 1;


-- 32. Find the latest order of every customer

-- Subquery
SELECT
    o.customer_name,
    o.order_id,
    o.order_date,
    o.amount
FROM orders o
WHERE o.order_date = (
    SELECT MAX(o2.order_date)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

-- Window Function
SELECT
    customer_name,
    order_id,
    order_date,
    amount
FROM (
    SELECT
        customer_id,
        customer_name,
        order_id,
        order_date,
        amount,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id
            ORDER BY order_date DESC
        ) AS rn
    FROM orders
) t
WHERE rn = 1;


-- 33. Calculate running total for every customer

-- Subquery
SELECT
    o.customer_id,
    o.customer_name,
    o.order_id,
    o.order_date,
    o.amount,
    (
        SELECT SUM(o2.amount)
        FROM orders o2
        WHERE o2.customer_id = o.customer_id
          AND o2.order_date <= o.order_date
    ) AS running_total
FROM orders o
ORDER BY customer_id, order_date;

-- Window Function
SELECT
    customer_id,
    customer_name,
    order_id,
    order_date,
    amount,
    SUM(amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM orders
ORDER BY customer_id, order_date;
