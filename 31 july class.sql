
-- Question 1: Find the names of customers who have placed at least one order.
SELECT CUSTOMER_NAME 
FROM CUSTOMERS 
WHERE CUSTOMER_ID IN (
    SELECT DISTINCT CUSTOMER_ID 
    FROM ORDERS
);


-- Question 2: Find products that have NEVER been ordered.
SELECT PRODUCT_NAME 
FROM PRODUCTS 
WHERE PRODUCT_ID NOT IN (
    SELECT DISTINCT PRODUCT_ID 
    FROM ORDERS 
    WHERE PRODUCT_ID IS NOT NULL
);


-- Question 3: Find customers whose credit limit is above the average credit limit of all customers.
SELECT CUSTOMER_NAME, CREDIT_LIMIT 
FROM CUSTOMERS 
WHERE CREDIT_LIMIT > (
    SELECT AVG(CREDIT_LIMIT) 
    FROM CUSTOMERS
);


-- Question 4: Find the most expensive product.
SELECT PRODUCT_NAME, PRICE 
FROM PRODUCTS 
WHERE PRICE = (
    SELECT MAX(PRICE) 
    FROM PRODUCTS
);


-- Question 5: Find orders where the product's price is above 10000.
SELECT ORDER_ID, PRODUCT_ID, STATUS 
FROM ORDERS 
WHERE PRODUCT_ID IN (
    SELECT PRODUCT_ID 
    FROM PRODUCTS 
    WHERE PRICE > 10000
);


-- Question 6: Find customers who have placed more than 2 orders.
SELECT CUSTOMER_NAME 
FROM CUSTOMERS 
WHERE CUSTOMER_ID IN (
    SELECT CUSTOMER_ID 
    FROM ORDERS 
    GROUP BY CUSTOMER_ID 
    HAVING COUNT(*) > 2
);


-- Question 7: Find 'Delivered' orders for products in the 'Electronics' category.
SELECT ORDER_ID, CUSTOMER_ID, PRODUCT_ID 
FROM ORDERS 
WHERE STATUS = 'Delivered' 
  AND PRODUCT_ID IN (
      SELECT PRODUCT_ID 
      FROM PRODUCTS 
      WHERE CATEGORY = 'Electronics'
  );


-- Question 8: Find the customer with the maximum number of total orders.
SELECT CUSTOMER_NAME 
FROM CUSTOMERS 
WHERE CUSTOMER_ID = (
    SELECT CUSTOMER_ID 
    FROM ORDERS 
    GROUP BY CUSTOMER_ID 
    ORDER BY COUNT(*) DESC 
    LIMIT 1
);


-- Question 9: Find products priced higher than ALL products in the 'Stationery' category.
SELECT PRODUCT_NAME, PRICE 
FROM PRODUCTS 
WHERE PRICE > ALL (
    SELECT PRICE 
    FROM PRODUCTS 
    WHERE CATEGORY = 'Stationery'
);


-- Question 10: Find customers who have NOT placed any orders with status 'Cancelled'.
SELECT CUSTOMER_NAME 
FROM CUSTOMERS 
WHERE CUSTOMER_ID NOT IN (
    SELECT DISTINCT CUSTOMER_ID 
    FROM ORDERS 
    WHERE STATUS = 'Cancelled'
);


-- Question 11: Find orders placed by customers from 'Delhi'.
SELECT ORDER_ID, CUSTOMER_ID, PRODUCT_ID 
FROM ORDERS 
WHERE CUSTOMER_ID IN (
    SELECT CUSTOMER_ID 
    FROM CUSTOMERS 
    WHERE CITY = 'Delhi'
);


-- Question 12: Find products that have been ordered with a quantity greater than 3 at least once.
SELECT PRODUCT_NAME 
FROM PRODUCTS 
WHERE PRODUCT_ID IN (
    SELECT DISTINCT PRODUCT_ID 
    FROM ORDERS 
    WHERE QUANTITY > 3
);


-- Question 13: Find all customers whose credit limit is less than the credit limit of 'Ravi Kumar'.
SELECT CUSTOMER_NAME, CREDIT_LIMIT 
FROM CUSTOMERS 
WHERE CREDIT_LIMIT < (
    SELECT CREDIT_LIMIT 
    FROM CUSTOMERS 
    WHERE CUSTOMER_NAME = 'Ravi Kumar'
);


-- Question 14: Find customers who have placed orders for products in the 'Furniture' category.
SELECT CUSTOMER_NAME 
FROM CUSTOMERS 
WHERE CUSTOMER_ID IN (
    SELECT DISTINCT CUSTOMER_ID 
    FROM ORDERS 
    WHERE PRODUCT_ID IN (
        SELECT PRODUCT_ID 
        FROM PRODUCTS 
        WHERE CATEGORY = 'Furniture'
    )
);


-- Question 15: Find products whose price is greater than the average price of their respective category. (Correlated Subquery)
SELECT p1.PRODUCT_NAME, p1.CATEGORY, p1.PRICE 
FROM PRODUCTS p1 
WHERE p1.PRICE > (
    SELECT AVG(p2.PRICE) 
    FROM PRODUCTS p2 
    WHERE p2.CATEGORY = p1.CATEGORY
);


-- Question 16: Using EXISTS, find customers who have placed at least one order.
SELECT c.CUSTOMER_NAME 
FROM CUSTOMERS c 
WHERE EXISTS (
    SELECT 1 
    FROM ORDERS o 
    WHERE o.CUSTOMER_ID = c.CUSTOMER_ID
);


-- Question 17: Using NOT EXISTS, find customers who have NEVER placed any orders.
SELECT c.CUSTOMER_NAME 
FROM CUSTOMERS c 
WHERE NOT EXISTS (
    SELECT 1 
    FROM ORDERS o 
    WHERE o.CUSTOMER_ID = c.CUSTOMER_ID
);


-- Question 18: Find orders where the ordered quantity is greater than the average quantity of orders for that same product. (Correlated Subquery)
SELECT o1.ORDER_ID, o1.PRODUCT_ID, o1.QUANTITY 
FROM ORDERS o1 
WHERE o1.QUANTITY > (
    SELECT AVG(o2.QUANTITY) 
    FROM ORDERS o2 
    WHERE o2.PRODUCT_ID = o1.PRODUCT_ID
);


-- Question 19: Find customers who have placed orders for every product that costs more than 10000.
SELECT c.CUSTOMER_NAME 
FROM CUSTOMERS c 
WHERE NOT EXISTS (
    SELECT p.PRODUCT_ID 
    FROM PRODUCTS p 
    WHERE p.PRICE > 10000 
      AND NOT EXISTS (
          SELECT 1 
          FROM ORDERS o 
          WHERE o.CUSTOMER_ID = c.CUSTOMER_ID 
            AND o.PRODUCT_ID = p.PRODUCT_ID
      )
);


-- Question 20: Find products that have been ordered by at least 2 different customers.
SELECT PRODUCT_NAME 
FROM PRODUCTS 
WHERE PRODUCT_ID IN (
    SELECT PRODUCT_ID 
    FROM ORDERS 
    GROUP BY PRODUCT_ID 
    HAVING COUNT(DISTINCT CUSTOMER_ID) >= 2
);