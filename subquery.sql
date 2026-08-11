-- Q1. Find the names, departments, and salaries of all employees whose salary is greater than the average salary of all employees in the company.

SELECT emp_name, department, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

/*
emp_name       department   salary
Rachel King    Finance      82000
Eva Green      Finance      80000
Nate Lewis     Finance      78000
Frank Black    Finance      75000
Alice Johnson  IT           72000
Olivia Walker  IT           71000
Jack Davis     Finance      70000
Grace Lee      IT           68000
Sam Scott      IT           66000
Bob Smith      IT           65000
*/


-- Q2. Display the emp_id, emp_name, department, and salary of the single highest-paid employee in the entire company.

SELECT emp_id, emp_name, department, salary
FROM employees
WHERE salary = (
SELECT MAX(salary)
FROM employees
);

/*
emp_id  emp_name      department  salary
118     Rachel King   Finance     82000
*/

-- Q3. Display the emp_id, emp_name, department, and salary of the employee with the lowest salary in the entire company.

SELECT emp_id, emp_name, department, salary
FROM employees
WHERE salary = (
SELECT MIN(salary)
FROM employees
);

/*
emp_id  emp_name     department  salary
112     Leo Harris   HR          50000
*/

-- Q4. Find all employees other than Rachel King who were hired in the same year as Rachel King.

SELECT emp_name, department, hire_year
FROM employees
WHERE hire_year = (
SELECT hire_year
FROM employees
WHERE emp_name = 'Rachel King'
)
AND emp_name <> 'Rachel King';

/*
emp_name   department  hire_year
Eva Green  Finance     2016
*/

-- Q5. List all products whose price is greater than the average price across all products.

SELECT product_name, category, price
FROM products
WHERE price > (
SELECT AVG(price)
FROM products
)
ORDER BY price DESC;

/*
product_name   category       price
Laptop         Electronics    55000
Smartphone     Electronics    22000
Standing Desk  Furniture      22000
Monitor        Electronics    18000
Smart Watch    Electronics    15000
Printer        Electronics    12000
*/

-- Q6. Retrieve the product_id, product_name, category, and price of the single most expensive product.

SELECT product_id, product_name, category, price
FROM products
WHERE price = (
SELECT MAX(price)
FROM products
);

/*
product_id  product_name  category       price
301         Laptop        Electronics    55000
*/

-- Q7. Retrieve the product_id, product_name, category, and price of the cheapest product.

SELECT product_id, product_name, category, price
FROM products
WHERE price = (
SELECT MIN(price)
FROM products
);

/*
product_id  product_name  category     price
311         Notebook      Stationery   150
*/

-- Q8. List all orders whose amount is greater than the average order amount across all orders.

SELECT order_id, customer_id, amount
FROM orders
WHERE amount > (
SELECT AVG(amount)
FROM orders
)
ORDER BY amount DESC;

/*
order_id  customer_id  amount
1006      205          4500.0
1018      210          4100.0
1016      206          3800.0
1010      207          3300.0
1004      201          3200.0
1012      208          2900.0
1014      201          2700.0
1002      202          2300.0
1020      209          2200.0
1008      206          2100.0
*/

-- Q9. Find the order_id, customer_id, amount, and order_date of the single most expensive order ever placed.

SELECT order_id, customer_id, amount, order_date
FROM orders
WHERE amount = (
SELECT MAX(amount)
FROM orders
);

/*
order_id  customer_id  amount  order_date
1006      205          4500.0  2024-03-15
*/

-- Q10. Using the IN operator with a subquery, find all customers who have placed at least one order.

SELECT customer_id, customer_name, city
FROM customers
WHERE customer_id IN (
SELECT customer_id
FROM orders
)
ORDER BY customer_id;

/*
customer_id  customer_name   city
201          Aarav Mehta     Mumbai
202          Priya Sharma    Delhi
203          Rohan Gupta     Pune
204          Sunita Patel    Ahmedabad
205          Vikram Rao      Bangalore
206          Neha Singh      Chennai
207          Arjun Kumar     Hyderabad
208          Deepa Nair      Kochi
209          Sanjay Joshi    Jaipur
210          Meera Iyer     Coimbatore
*/

-- Q11. Using the NOT IN operator with a subquery, find all customers who have never placed any order.

SELECT customer_id, customer_name, city
FROM customers
WHERE customer_id NOT IN (
SELECT customer_id
FROM orders
)
ORDER BY customer_id;

/*
customer_id  customer_name       city
211          Ravi Verma          Lucknow
212          Anita Das           Kolkata
213          Kiran Reddy        Vizag
214          Pooja Shah         Surat
215          Amit Bose          Nagpur
216          Tara Menon         Trivandrum
217          Nikhil Kulkarni    Nashik
218          Swati Chatterjee   Bhopal
219          Rahul Pandey       Patna
220          Divya Tiwari       Indore
*/

-- Q12. Using the IN operator with a subquery on the orders table, find all products that appear in at least one order.

SELECT product_id, product_name, category, price
FROM products
WHERE product_id IN (
SELECT product_id
FROM orders
);

/*
product_id  product_name  category       price
301         Laptop        Electronics    55000
302         Smartphone    Electronics    22000
303         Headphones    Electronics    3500
304         Monitor       Electronics    18000
*/

-- Q13. Using the NOT IN operator, find all products that have never appeared in any order.

SELECT product_id, product_name, category, price
FROM products
WHERE product_id NOT IN (
SELECT product_id
FROM orders
);

/*
product_id  product_name       category
305         Keyboard           Accessories
306         Mouse              Accessories
307         Desk Chair         Furniture
308         Standing Desk      Furniture
309         Webcam             Electronics
310         USB Hub            Accessories
311         Notebook            Stationery
312         Pen Set             Stationery
313         Printer             Electronics
314         Scanner             Electronics
315         External SSD        Electronics
316         Lamp                Furniture
317         Whiteboard          Office Supplies
318         Cable Organiser     Accessories
319         Power Bank          Electronics
320         Smart Watch         Electronics
*/

-- Q14. Using an IN subquery against the departments table, retrieve the emp_name and salary of all employees who belong to the Finance department.

SELECT emp_name, salary
FROM employees
WHERE department IN (
SELECT dept_name
FROM departments
WHERE dept_name = 'Finance'
)
ORDER BY salary DESC;

/*
emp_name      salary
Rachel King   82000
Eva Green     80000
Nate Lewis    78000
Frank Black   75000
Jack Davis    70000
*/

-- Q15. Find all employees whose salary is less than the minimum salary of any employee in the Finance department.

SELECT emp_name, department, salary
FROM employees
WHERE salary < (
SELECT MIN(salary)
FROM employees
WHERE department = 'Finance'
)
ORDER BY salary DESC;

/*
emp_name       department  salary
Grace Lee      IT          68000
Sam Scott      IT          66000
Bob Smith      IT          65000
Karen Moore    IT          63000
Mia Clark      Marketing   62000
Henry Wilson   Marketing   60000
Quinn Young    Marketing   59000
Carol White    HR          58000
Ivy Turner     Marketing   56000
Tina Adams     HR          55000
David Brown    HR          54000
Paul Hall      HR          53000
Leo Harris     HR          50000
*/

-- Q16. Find the department with the highest budget from the departments table.

SELECT dept_name, budget, location
FROM departments
WHERE budget = (
SELECT MAX(budget)
FROM departments
);

/*
dept_name  budget  location
Finance    600000  Delhi
*/

-- Q17. Using a subquery with GROUP BY and HAVING, find all customers who have placed exactly 1 order.

SELECT customer_id, customer_name, city
FROM customers
WHERE customer_id IN (
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(*) = 1
);

/*
customer_id  customer_name  city
210          Meera Iyer     Coimbatore
*/

-- Q18. Using a subquery with GROUP BY and HAVING, find all customers who have placed 2 or more orders.

SELECT customer_id, customer_name, city
FROM customers
WHERE customer_id IN (
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >= 2
)
ORDER BY customer_id;

/*
customer_id  customer_name  city
201          Aarav Mehta     Mumbai
202          Priya Sharma    Delhi
203          Rohan Gupta     Pune
204          Sunita Patel    Ahmedabad
205          Vikram Rao      Bangalore
206          Neha Singh      Chennai
207          Arjun Kumar     Hyderabad
208          Deepa Nair      Kochi
209          Sanjay Joshi    Jaipur
*/

-- Q19. Find all products whose price is greater than the maximum price of any product in the Accessories category.

SELECT product_name, category, price
FROM products
WHERE price > (
SELECT MAX(price)
FROM products
WHERE category = 'Accessories'
)
ORDER BY price DESC;

/*
product_name   category          price
Laptop         Electronics       55000
Smartphone     Electronics       22000
Standing Desk  Furniture         22000
Monitor        Electronics       18000
Smart Watch    Electronics       15000
Printer        Electronics       12000
Scanner        Electronics       9000
Desk Chair     Furniture         8500
External SSD   Electronics       7500
Webcam         Electronics       4200
Whiteboard     Office Supplies   3800
Headphones     Electronics       3500
Power Bank     Electronics       2800
Lamp           Furniture         2200
*/

-- Q20. Using an IN subquery, find all orders placed by customers who joined in the year 2021.

SELECT order_id, customer_id, amount, order_date
FROM orders
WHERE customer_id IN (
SELECT customer_id
FROM customers
WHERE join_year = 2021
)
ORDER BY order_date;

/*
order_id  customer_id  amount  order_date
1001      201          1500.0  2024-01-05
1004      201          3200.0  2024-02-14
1005      204          1100.0  2024-03-01
1011      204          680.0   2024-05-10
1014      201          2700.0  2024-06-15
1015      209          500.0   2024-06-28
1020      209          2200.0  2024-08-14
*/

-- Q21. Using EXISTS, find all employees who are managers.

SELECT emp_id, emp_name, department
FROM employees e
WHERE EXISTS (
SELECT 1
FROM employees e2
WHERE e2.manager_id = e.emp_id
)
ORDER BY emp_name;

/*
emp_id  emp_name       department
101     Alice Johnson  IT
103     Carol White    HR
105     Eva Green      Finance
108     Henry Wilson   Marketing
*/

-- Q22. Using NOT EXISTS, find all employees who are NOT managers.

SELECT emp_id, emp_name, department
FROM employees e
WHERE NOT EXISTS (
SELECT 1
FROM employees e2
WHERE e2.manager_id = e.emp_id
)
ORDER BY emp_id;

/*
emp_id  emp_name       department
102     Bob Smith      IT
104     David Brown    HR
106     Frank Black    Finance
107     Grace Lee      IT
109     Ivy Turner     Marketing
110     Jack Davis     Finance
111     Karen Moore    IT
112     Leo Harris     HR
113     Mia Clark      Marketing
114     Nate Lewis     Finance
115     Olivia Walker  IT
116     Paul Hall      HR
117     Quinn Young    Marketing
118     Rachel King    Finance
119     Sam Scott      IT
120     Tina Adams     HR
*/

-- Q23. Using EXISTS with a correlated subquery on the orders table, find all customers who have placed at least one order.

SELECT customer_id, customer_name, city
FROM customers c
WHERE EXISTS (
SELECT 1
FROM orders o
WHERE o.customer_id = c.customer_id
)
ORDER BY customer_id;

/*
customer_id  customer_name  city
201          Aarav Mehta     Mumbai
202          Priya Sharma    Delhi
203          Rohan Gupta     Pune
204          Sunita Patel    Ahmedabad
205          Vikram Rao      Bangalore
206          Neha Singh      Chennai
207          Arjun Kumar     Hyderabad
208          Deepa Nair      Kochi
209          Sanjay Joshi    Jaipur
210          Meera Iyer      Coimbatore
*/

-- Q24. Using NOT EXISTS, find all customers who have never placed any order.

SELECT customer_id, customer_name, city
FROM customers c
WHERE NOT EXISTS (
SELECT 1
FROM orders o
WHERE o.customer_id = c.customer_id
)
ORDER BY customer_id;

/*
customer_id  customer_name       city
211          Ravi Verma          Lucknow
212          Anita Das           Kolkata
213          Kiran Reddy         Vizag
214          Pooja Shah          Surat
215          Amit Bose           Nagpur
216          Tara Menon          Trivandrum
217          Nikhil Kulkarni     Nashik
218          Swati Chatterjee    Bhopal
219          Rahul Pandey        Patna
220          Divya Tiwari        Indore
*/

-- Q25. Using EXISTS with a correlated subquery on the orders table, find all products that appear in at least one order.

SELECT product_id, product_name, category
FROM products p
WHERE EXISTS (
SELECT 1
FROM orders o
WHERE o.product_id = p.product_id
)
ORDER BY product_id;

/*
product_id  product_name  category
301         Laptop        Electronics
302         Smartphone    Electronics
303         Headphones    Electronics
304         Monitor       Electronics
*/

-- Q26. Find all employees excluding emp_id 105 who work in the same department as emp_id 105.

SELECT emp_name, department, salary
FROM employees
WHERE department = (
SELECT department
FROM employees
WHERE emp_id = 105
)
AND emp_id <> 105
ORDER BY salary DESC;

/*
emp_name      department  salary
Rachel King   Finance     82000
Nate Lewis    Finance     78000
Frank Black   Finance     75000
Jack Davis    Finance     70000
*/

-- Q27. Find the order with the most recent order_date.

SELECT order_id, customer_id, amount, order_date
FROM orders
WHERE order_date = (
SELECT MAX(order_date)
FROM orders
);

/*
order_id  customer_id  amount  order_date
1020      209          2200.0  2024-08-14
*/

-- Q28. Find the order with the earliest order_date.

SELECT order_id, customer_id, amount, order_date
FROM orders
WHERE order_date = (
SELECT MIN(order_date)
FROM orders
);

/*
order_id  customer_id  amount  order_date
1001      201          1500.0  2024-01-05
*/

-- Q29. Find all employees whose salary is greater than the salary of every employee in the HR department.

SELECT emp_name, department, salary
FROM employees
WHERE salary > (
SELECT MAX(salary)
FROM employees
WHERE department = 'HR'
)
ORDER BY salary DESC;

/*
emp_name       department  salary
Rachel King    Finance     82000
Eva Green      Finance     80000
Nate Lewis     Finance     78000
Frank Black    Finance     75000
Alice Johnson  IT          72000
Olivia Walker  IT          71000
Jack Davis     Finance     70000
Grace Lee      IT          68000
Sam Scott      IT          66000
Bob Smith      IT          65000
Karen Moore    IT          63000
Mia Clark      Marketing   62000
Henry Wilson   Marketing   60000
Quinn Young    Marketing   59000
*/

-- Q30. Among Delivered orders, find those whose amount is greater than the average amount of all Delivered orders.

SELECT order_id, customer_id, amount, status
FROM orders
WHERE status = 'Delivered'
AND amount > (
SELECT AVG(amount)
FROM orders
WHERE status = 'Delivered'
)
ORDER BY amount DESC;

/*
order_id  customer_id  amount  status
1006      205          4500.0  Delivered
1018      210          4100.0  Delivered
1016      206          3800.0  Delivered
1010      207          3300.0  Delivered
1004      201          3200.0  Delivered
1012      208          2900.0  Delivered
*/
-- Q31. Using a correlated subquery, find all employees who earn more than the average salary of their own department.

SELECT e.emp_name, e.department, e.salary,
       ROUND((
           SELECT AVG(e2.salary)
           FROM employees e2
           WHERE e2.department = e.department
       ), 2) AS dept_avg
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
)
ORDER BY e.department, e.salary DESC;

/*
emp_name       department  salary  dept_avg
Rachel King    Finance     82000   77000.0
Eva Green      Finance     80000   77000.0
Nate Lewis     Finance     78000   77000.0
Carol White    HR          58000   54000.0
Tina Adams     HR          55000   54000.0
Alice Johnson  IT          72000   67500.0
Olivia Walker  IT          71000   67500.0
Grace Lee      IT          68000   67500.0
Mia Clark      Marketing   62000   59250.0
Henry Wilson   Marketing   60000   59250.0
*/


-- Q32. For every employee, use a correlated subquery to count how many other employees in the same department earn strictly more than them.

SELECT e.emp_name, e.department, e.salary,
       (
           SELECT COUNT(*)
           FROM employees e2
           WHERE e2.department = e.department
           AND e2.salary > e.salary
       ) AS higher_earners
FROM employees e
ORDER BY e.department, e.salary DESC;

/*
emp_name       department  salary  higher_earners
Rachel King    Finance     82000   0
Eva Green      Finance     80000   1
Nate Lewis     Finance     78000   2
Frank Black    Finance     75000   3
Jack Davis     Finance     70000   4
Carol White    HR          58000   0
Tina Adams     HR          55000   1
David Brown    HR          54000   2
Paul Hall      HR          53000   3
Leo Harris     HR          50000   4
Alice Johnson  IT          72000   0
Olivia Walker  IT          71000   1
Grace Lee      IT          68000   2
Sam Scott      IT          66000   3
Bob Smith      IT          65000   4
Karen Moore    IT          63000   5
Mia Clark      Marketing   62000   0
Henry Wilson   Marketing   60000   1
Quinn Young    Marketing   59000   2
Ivy Turner     Marketing   56000   3
*/


-- Q33. Using a correlated subquery inside the WHERE clause, find all customers whose total order spend is greater than the average total spend per customer across all ordering customers.

SELECT c.customer_id, c.customer_name,
       (
           SELECT SUM(o.amount)
           FROM orders o
           WHERE o.customer_id = c.customer_id
       ) AS total_spend
FROM customers c
WHERE (
    SELECT SUM(o.amount)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) > (
    SELECT AVG(total_spend)
    FROM (
        SELECT SUM(amount) AS total_spend
        FROM orders
        GROUP BY customer_id
    ) x
)
ORDER BY total_spend DESC;

/*
customer_id  customer_name  total_spend
201           Aarav Mehta    7400.0
206           Neha Singh     5900.0
205           Vikram Rao     5700.0
207           Arjun Kumar    4900.0
*/


-- Q34. Using a subquery in the WHERE clause with IN and a GROUP BY / HAVING inside the subquery, find all employees who belong to departments where the average salary is greater than 65000.

SELECT emp_name, department, salary
FROM employees
WHERE department IN (
    SELECT department
    FROM employees
    GROUP BY department
    HAVING AVG(salary) > 65000
)
ORDER BY department, salary DESC;

/*
emp_name       department  salary
Rachel King    Finance     82000
Eva Green      Finance     80000
Nate Lewis     Finance     78000
Frank Black    Finance     75000
Jack Davis     Finance     70000
Alice Johnson  IT          72000
Olivia Walker  IT          71000
Grace Lee      IT          68000
Sam Scott      IT          66000
Bob Smith      IT          65000
Karen Moore    IT          63000
*/


-- Q35. For every row in the orders table, use a correlated subquery inside a CASE expression to label each order as Above Avg or Below Avg.

SELECT o.order_id, o.customer_id, o.amount,
       CASE
           WHEN o.amount >= (
               SELECT AVG(o2.amount)
               FROM orders o2
               WHERE o2.customer_id = o.customer_id
           )
           THEN 'Above Avg'
           ELSE 'Below Avg'
       END AS vs_cust_avg
FROM orders o
ORDER BY o.customer_id, o.order_id;

/*
order_id  customer_id  amount  vs_cust_avg
1001      201          1500.0  Below Avg
1004      201          3200.0  Above Avg
1014      201          2700.0  Above Avg
1002      202          2300.0  Above Avg
1007      202          950.0   Below Avg
1003      203          800.0   Below Avg
1009      203          1750.0  Above Avg
1005      204          1100.0  Above Avg
1011      204          680.0   Below Avg
1006      205          4500.0  Above Avg
1013      205          1200.0  Below Avg
1008      206          2100.0  Below Avg
1016      206          3800.0  Above Avg
1010      207          3300.0  Above Avg
1017      207          1600.0  Below Avg
1012      208          2900.0  Above Avg
1019      208          720.0   Below Avg
1015      209          500.0   Below Avg
1020      209          2200.0  Above Avg
1018      210          4100.0  Above Avg
*/


-- Q36. Using a correlated subquery, find all products whose price is greater than the average price of other products in the same category.

SELECT p.product_name, p.category, p.price,
       ROUND((
           SELECT AVG(p2.price)
           FROM products p2
           WHERE p2.category = p.category
           AND p2.product_id <> p.product_id
       ), 2) AS cat_avg
FROM products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category = p.category
    AND p2.product_id <> p.product_id
)
ORDER BY p.category, p.price DESC;

/*
product_name  category      price  cat_avg
Keyboard      Accessories   1500   1050.0
USB Hub       Accessories   1200   1050.0
Laptop        Electronics   55000  14900.0
Smartphone    Electronics   22000  14900.0
Monitor       Electronics   18000  14900.0
Smart Watch   Electronics   15000  14900.0
Standing Desk Furniture     22000  10900.0
Pen Set       Stationery    250    200.0
*/


-- Q37. Find all employees whose salary is greater than the salary of at least one employee in the Marketing department.

SELECT emp_name, department, salary
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE department = 'Marketing'
)
ORDER BY salary DESC;

/*
emp_name       department  salary
Rachel King    Finance     82000
Eva Green      Finance     80000
Nate Lewis     Finance     78000
Frank Black    Finance     75000
Alice Johnson  IT          72000
Olivia Walker  IT          71000
Jack Davis     Finance     70000
Grace Lee      IT          68000
Sam Scott      IT          66000
Bob Smith      IT          65000
Karen Moore    IT          63000
Mia Clark      Marketing   62000
Henry Wilson   Marketing   60000
Quinn Young    Marketing   59000
Carol White    HR          58000
*/


-- Q38. Find all employees whose salary is less than the salary of every employee in the Finance department.

SELECT emp_name, department, salary
FROM employees
WHERE salary < ALL (
    SELECT salary
    FROM employees
    WHERE department = 'Finance'
)
ORDER BY salary DESC;

/*
emp_name       department  salary
Grace Lee      IT          68000
Sam Scott      IT          66000
Bob Smith      IT          65000
Karen Moore    IT          63000
Mia Clark      Marketing   62000
Henry Wilson   Marketing   60000
Quinn Young    Marketing   59000
Carol White    HR          58000
Ivy Turner     Marketing   56000
Tina Adams     HR          55000
David Brown    HR          54000
Paul Hall      HR          53000
Leo Harris     HR          50000
*/


-- Q39. Find customers who have placed at least one order and whose every order has status Delivered.

SELECT c.customer_id, c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND o.status <> 'Delivered'
)
ORDER BY c.customer_id;

/*
customer_id  customer_name
205          Vikram Rao
206          Neha Singh
207          Arjun Kumar
209          Sanjay Joshi
210          Meera Iyer
*/


-- Q40. Using nested IN subqueries, find all products that were ordered by at least one customer from Mumbai.

SELECT product_id, product_name, category
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM orders
    WHERE customer_id IN (
        SELECT customer_id
        FROM customers
        WHERE city = 'Mumbai'
    )
)
ORDER BY product_id;

/*
product_id  product_name  category
301         Laptop        Electronics
302         Smartphone    Electronics
304         Monitor       Electronics
*/


-- Q41. Find the employee or employees with the second-highest salary in the entire company.

SELECT emp_name, department, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees
    )
);

/*
emp_name   department  salary
Eva Green  Finance     80000
*/


-- Q42. Using NOT EXISTS, find all departments where every single employee earns strictly more than 50000.

SELECT DISTINCT e.department
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.department = e.department
    AND e2.salary <= 50000
)
ORDER BY e.department;

/*
department
Finance
IT
Marketing
*/


-- Q43. Using a correlated subquery in the WHERE clause, find all customers who have placed orders for at least 2 different products.

SELECT c.customer_id, c.customer_name
FROM customers c
WHERE (
    SELECT COUNT(DISTINCT o.product_id)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) >= 2
ORDER BY c.customer_id;

/*
customer_id  customer_name
201          Aarav Mehta
202          Priya Sharma
203          Rohan Gupta
204          Sunita Patel
205          Vikram Rao
207          Arjun Kumar
208          Deepa Nair
209          Sanjay Joshi
*/


-- Q44. Using a correlated subquery, find all employees whose salary is above the average salary of all employees hired in the same year as them.

SELECT e.emp_name, e.department, e.salary, e.hire_year,
       ROUND((
           SELECT AVG(e2.salary)
           FROM employees e2
           WHERE e2.hire_year = e.hire_year
       ), 2) AS year_avg
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.hire_year = e.hire_year
)
ORDER BY e.hire_year, e.salary DESC;

/*
emp_name       department  salary  hire_year  year_avg
Rachel King    Finance     82000   2016       81000.0
Olivia Walker  IT          71000   2017       63000.0
Frank Black    Finance     75000   2018       69666.67
Alice Johnson  IT          72000   2018       69666.67
Nate Lewis     Finance     78000   2019       67000.0
Jack Davis     Finance     70000   2019       67000.0
Karen Moore    IT          63000   2020       56666.67
Grace Lee      IT          68000   2021       59000.0
Sam Scott      IT          66000   2022       61000.0
*/


-- Q45. Using a correlated subquery, find all products whose stock_qty is less than the average stock_qty of all products in the same category.

SELECT p.product_name, p.category, p.stock_qty,
       ROUND((
           SELECT AVG(p2.stock_qty)
           FROM products p2
           WHERE p2.category = p.category
       ), 2) AS cat_avg_stock
FROM products p
WHERE p.stock_qty < (
    SELECT AVG(p2.stock_qty)
    FROM products p2
    WHERE p2.category = p.category
)
ORDER BY p.category, p.stock_qty ASC;

/*
product_name   category       stock_qty  cat_avg_stock
USB Hub        Accessories    180        232.5
Keyboard       Accessories    200        232.5
Scanner        Electronics    20         60.5
Printer        Electronics    25         60.5
Laptop         Electronics    30         60.5
Monitor        Electronics    45         60.5
Smart Watch    Electronics    55         60.5
External SSD   Electronics    60         60.5
Standing Desk  Furniture      15         48.33
Desk Chair     Furniture      40         48.33
Notebook       Stationery     500        550.0
*/


-- Q46. Find all employees whose salary is among the top 3 distinct salary values in the company.

SELECT emp_name, department, salary
FROM employees
WHERE salary IN (
    SELECT DISTINCT salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 3
)
ORDER BY salary DESC;

/*
emp_name      department  salary
Rachel King   Finance     82000
Eva Green     Finance     80000
Nate Lewis    Finance     78000
*/


-- Q47. Find all customers who have placed at least one order where every single order has an amount strictly greater than 1000.

SELECT c.customer_id, c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND o.amount <= 1000
)
ORDER BY c.customer_id;

/*
customer_id  customer_name
201          Aarav Mehta
205          Vikram Rao
206          Neha Singh
207          Arjun Kumar
210          Meera Iyer
*/


-- Q48. For each department, find the employee whose salary is closest to that department's average salary.

SELECT e.emp_name, e.department, e.salary,
       ROUND((
           SELECT AVG(e2.salary)
           FROM employees e2
           WHERE e2.department = e.department
       ), 2) AS dept_avg,
       ABS(
           e.salary - (
               SELECT AVG(e2.salary)
               FROM employees e2
               WHERE e2.department = e.department
           )
       ) AS diff
FROM employees e
WHERE ABS(
    e.salary - (
        SELECT AVG(e2.salary)
        FROM employees e2
        WHERE e2.department = e.department
    )
) = (
    SELECT MIN(
        ABS(
            e3.salary - (
                SELECT AVG(e4.salary)
                FROM employees e4
                WHERE e4.department = e3.department
            )
        )
    )
    FROM employees e3
    WHERE e3.department = e.department
)
ORDER BY e.department;

/*
emp_name      department  salary  dept_avg  diff
Nate Lewis    Finance     78000   77000.0   1000.0
David Brown   HR          54000   54000.0   0.0
Grace Lee     IT          68000   67500.0   500.0
Quinn Young   Marketing   59000   59250.0   250.0
*/


-- Q49. Find all customers other than customer 201 who have ordered every product that customer 201 has ordered.

SELECT c.customer_id, c.customer_name
FROM customers c
WHERE c.customer_id <> 201
AND NOT EXISTS (
    SELECT 1
    FROM orders o201
    WHERE o201.customer_id = 201
    AND NOT EXISTS (
        SELECT 1
        FROM orders oc
        WHERE oc.customer_id = c.customer_id
        AND oc.product_id = o201.product_id
    )
)
ORDER BY c.customer_id;

/*
customer_id  customer_name
No rows
*/


-- Q50. Find all departments whose total salary bill is greater than the total salary bill of at least one other department.

SELECT department, SUM(salary) AS dept_total
FROM employees
GROUP BY department
HAVING SUM(salary) > (
    SELECT MIN(dept_total)
    FROM (
        SELECT SUM(salary) AS dept_total
        FROM employees
        GROUP BY department
    ) x
)
ORDER BY dept_total DESC;

/*
department  dept_total
IT          405000
Finance     385000
HR          270000
*/


-- Q51. Using only subqueries, find all employees who earn strictly more than their own manager's salary.

SELECT e.emp_name,
       e.salary AS emp_salary,
       (
           SELECT m.emp_name
           FROM employees m
           WHERE m.emp_id = e.manager_id
       ) AS manager_name,
       (
           SELECT m.salary
           FROM employees m
           WHERE m.emp_id = e.manager_id
       ) AS manager_salary
FROM employees e
WHERE e.manager_id IS NOT NULL
AND e.salary > (
    SELECT m.salary
    FROM employees m
    WHERE m.emp_id = e.manager_id
)
ORDER BY e.salary DESC;

/*
emp_name    emp_salary  manager_name  manager_salary
Rachel King 82000       Eva Green     80000
Mia Clark   62000       Henry Wilson  60000
*/


-- Q52. Find all products whose total number of orders is greater than the average number of orders per product.

SELECT p.product_id, p.product_name,
       (
           SELECT COUNT(*)
           FROM orders o
           WHERE o.product_id = p.product_id
       ) AS order_count
FROM products p
WHERE p.product_id IN (
    SELECT DISTINCT product_id
    FROM orders
)
AND (
    SELECT COUNT(*)
    FROM orders o
    WHERE o.product_id = p.product_id
) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM orders
        GROUP BY product_id
    ) x
);

/*
product_id  product_name  order_count
No rows
*/


-- Q53. Find the customer whose single highest order amount is equal to the global maximum order amount.

SELECT c.customer_id, c.customer_name,
       (
           SELECT MAX(o.amount)
           FROM orders o
           WHERE o.customer_id = c.customer_id
       ) AS best_order
FROM customers c
WHERE (
    SELECT MAX(o.amount)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) = (
    SELECT MAX(amount)
    FROM orders
);

/*
customer_id  customer_name  best_order
205          Vikram Rao     4500.0
*/


-- Q54. Find all employees who belong to departments that have a budget greater than the average budget across all departments.

SELECT emp_name, department, salary
FROM employees
WHERE department IN (
    SELECT dept_name
    FROM departments
    WHERE budget > (
        SELECT AVG(budget)
        FROM departments
    )
)
ORDER BY department, salary DESC;

/*
emp_name       department  salary
Rachel King    Finance     82000
Eva Green      Finance     80000
Nate Lewis     Finance     78000
Frank Black    Finance     75000
Jack Davis     Finance     70000
Alice Johnson  IT          72000
Olivia Walker  IT          71000
Grace Lee      IT          68000
Sam Scott      IT          66000
Bob Smith      IT          65000
Karen Moore    IT          63000
*/


-- Q55. For each customer who has placed at least one order, count how many of their own orders have an amount strictly greater than their personal average order amount.

SELECT c.customer_id, c.customer_name,
       (
           SELECT COUNT(*)
           FROM orders o1
           WHERE o1.customer_id = c.customer_id
           AND o1.amount > (
               SELECT AVG(o2.amount)
               FROM orders o2
               WHERE o2.customer_id = c.customer_id
           )
       ) AS orders_above_avg
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
ORDER BY orders_above_avg DESC, c.customer_id;

/*
customer_id  customer_name  orders_above_avg
201          Aarav Mehta    2
202          Priya Sharma   1
203          Rohan Gupta    1
204          Sunita Patel   1
205          Vikram Rao     1
206          Neha Singh     1
207          Arjun Kumar    1
208          Deepa Nair     1
209          Sanjay Joshi    1
210          Meera Iyer     0
*/


-- Q56. Find all products that were ordered exclusively by customers from a single city.

SELECT p.product_id, p.product_name,
       (
           SELECT MIN(c.city)
           FROM customers c
           WHERE c.customer_id IN (
               SELECT o.customer_id
               FROM orders o
               WHERE o.product_id = p.product_id
           )
       ) AS only_city
FROM products p
WHERE p.product_id IN (
    SELECT product_id
    FROM orders
)
AND (
    SELECT COUNT(DISTINCT c.city)
    FROM customers c
    WHERE c.customer_id IN (
        SELECT o.customer_id
        FROM orders o
        WHERE o.product_id = p.product_id
    )
) = 1;

/*
product_id  product_name  only_city
No rows
*/


-- Q57. Find employees who are the sole highest earner in their department.

SELECT e.emp_name, e.department, e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
)
AND (
    SELECT COUNT(*)
    FROM employees e3
    WHERE e3.department = e.department
    AND e3.salary = e.salary
) = 1
ORDER BY e.salary DESC;

/*
emp_name       department  salary
Rachel King    Finance     82000
Alice Johnson  IT          72000
Mia Clark      Marketing   62000
Carol White    HR          58000
*/


-- Q58. Find customers whose total spend is more than double the average total spend per customer.

SELECT c.customer_id, c.customer_name,
       (
           SELECT SUM(o.amount)
           FROM orders o
           WHERE o.customer_id = c.customer_id
       ) AS total_spend
FROM customers c
WHERE (
    SELECT SUM(o.amount)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) > 2 * (
    SELECT AVG(total_spend)
    FROM (
        SELECT SUM(amount) AS total_spend
        FROM orders
        GROUP BY customer_id
    ) x
);

/*
customer_id  customer_name  total_spend
No rows
*/


-- Q59. Find the department that has the highest count of employees earning above the company-wide average salary.

SELECT e.department,
       (
           SELECT COUNT(*)
           FROM employees e2
           WHERE e2.department = e.department
           AND e2.salary > (
               SELECT AVG(salary)
               FROM employees
           )
       ) AS above_avg_count
FROM employees e
GROUP BY e.department
ORDER BY above_avg_count DESC
LIMIT 1;

/*
department  above_avg_count
IT          5
*/


-- Q60. Find all employees who are the highest earner in their own department but whose overall salary rank in the company is beyond position 3.

SELECT e.emp_name, e.department, e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
)
AND (
    SELECT COUNT(DISTINCT e3.salary)
    FROM employees e3
    WHERE e3.salary > e.salary
) >= 3
ORDER BY e.salary DESC;

/*
emp_name       department  salary
Alice Johnson  IT          72000
Mia Clark      Marketing   62000
Carol White    HR          58000
*/
