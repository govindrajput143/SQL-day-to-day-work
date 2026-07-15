CREATE DATABASE retail_sales_db;
USE retail_sales_db;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_category VARCHAR(50),
    product_name VARCHAR(50),
    salesperson VARCHAR(50),
    region VARCHAR(20),
    sale_amount DECIMAL(10,2),
    quantity INT,
    sale_date DATE
);

INSERT INTO sales VALUES
(1,'Electronics','Laptop','Alice','North',75000,2,'2024-01-05'),
(2,'Electronics','Phone','Bob','South',25000,5,'2024-01-10'),
(3,'Clothing','Jacket','Alice','East',8000,3,'2024-01-15'),
(4,'Furniture','Chair','Charlie','West',12000,4,'2024-01-20'),
(5,'Electronics','Tablet','Bob','North',35000,2,'2024-02-03'),
(6,'Clothing','Shirt','Charlie','South',3000,10,'2024-02-08'),
(7,'Furniture','Table','Alice','East',22000,1,'2024-02-12'),
(8,'Electronics','Laptop','Charlie','West',80000,1,'2024-02-18'),
(9,'Clothing','Jeans','Bob','North',6000,5,'2024-02-25'),
(10,'Furniture','Sofa','Alice','South',45000,2,'2024-03-02'),
(11,'Electronics','Phone','Charlie','East',28000,3,'2024-03-07'),
(12,'Clothing','Jacket','Bob','West',9500,2,'2024-03-14'),
(13,'Furniture','Wardrobe','Charlie','North',32000,1,'2024-03-19'),
(14,'Electronics','Headphones','Alice','South',5000,8,'2024-03-25'),
(15,'Clothing','Shirt','Alice','East',3500,12,'2024-04-01'),
(16,'Furniture','Bookshelf','Bob','West',15000,3,'2024-04-06'),
(17,'Electronics','Tablet','Charlie','North',38000,2,'2024-04-11'),
(18,'Clothing','Jeans','Alice','South',7000,4,'2024-04-16'),
(19,'Furniture','Chair','Bob','East',13000,5,'2024-04-21'),
(20,'Electronics','Laptop','Alice','West',72000,1,'2024-04-26'),
(21,'Clothing','Jacket','Charlie','North',10000,3,'2024-05-01'),
(22,'Furniture','Table','Bob','South',24000,2,'2024-05-06'),
(23,'Electronics','Phone','Alice','East',27000,4,'2024-05-11'),
(24,'Clothing','Shirt','Bob','West',4000,8,'2024-05-16');

-- Q1. Find all sales where the sale amount is higher than the overall average sale amount.

SELECT sale_id, product_category, salesperson, sale_amount
FROM sales
WHERE sale_amount >
(
    SELECT AVG(sale_amount)
    FROM sales
)
ORDER BY sale_amount DESC;

-- Q2. Retrieve the complete details of the transaction that recorded the single highest sale amount.

SELECT *
FROM sales
WHERE sale_amount =
(
    SELECT MAX(sale_amount)
    FROM sales
);

-- Q3. Find all sales made by the salesperson who has the highest total number of transactions.

SELECT sale_id, salesperson, product_name, sale_amount
FROM sales
WHERE salesperson =
(
    SELECT salesperson
    FROM sales
    GROUP BY salesperson
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY sale_id;

-- Q4. Find all sales of products that have been sold by more than 2 different salespersons.

SELECT sale_id, product_name, salesperson, sale_amount
FROM sales
WHERE product_name IN
(
    SELECT product_name
    FROM sales
    GROUP BY product_name
    HAVING COUNT(DISTINCT salesperson) > 2
)
ORDER BY sale_id;

-- Q5. Find all sales from regions whose average sale amount is above the overall average sale amount of all regions.

SELECT sale_id, product_category, salesperson, region, sale_amount
FROM sales
WHERE region IN
(
    SELECT region
    FROM sales
    GROUP BY region
    HAVING AVG(sale_amount) >
    (
        SELECT AVG(sale_amount)
        FROM sales
    )
)
ORDER BY sale_id;

-- Q6. Find all sales where the sale amount is higher than every individual sale amount in the Furniture category.

SELECT sale_id, product_name, product_category, sale_amount
FROM sales
WHERE sale_amount >
ALL
(
    SELECT sale_amount
    FROM sales
    WHERE product_category='Furniture'
)
ORDER BY sale_id;

-- Q7. Find all sales where the individual sale amount is above the average sale amount of its own product category.

SELECT sale_id, product_category, salesperson, sale_amount
FROM sales s
WHERE sale_amount >
(
    SELECT AVG(s2.sale_amount)
    FROM sales s2
    WHERE s2.product_category=s.product_category
)
ORDER BY sale_id;

-- Q8. For each salesperson, find the transaction where they recorded their personal highest sale amount.

SELECT sale_id, salesperson, product_name, sale_amount
FROM sales s
WHERE sale_amount =
(
    SELECT MAX(s2.sale_amount)
    FROM sales s2
    WHERE s2.salesperson=s.salesperson
)
ORDER BY sale_amount DESC;

-- Q9. Find all sales where the sale amount exceeds the average sale amount of the salesperson who made that sale.

SELECT sale_id, salesperson, product_category, sale_amount
FROM sales s
WHERE sale_amount >
(
    SELECT AVG(s2.sale_amount)
    FROM sales s2
    WHERE s2.salesperson=s.salesperson
)
ORDER BY salesperson, sale_id;

-- Q10. Find all sales where the quantity sold is greater than the average quantity sold in the same region.

SELECT sale_id, product_category, salesperson, region, quantity
FROM sales s
WHERE quantity >
(
    SELECT AVG(s2.quantity)
    FROM sales s2
    WHERE s2.region=s.region
)
ORDER BY sale_id;
