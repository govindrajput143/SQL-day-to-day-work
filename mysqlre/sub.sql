-- q1. find the names, departments, and salaries of all employees whose salary is greater than the average salary of all employees in the company.

select emp_name, department, salary
from employees
where salary > (
    select avg(salary)
    from employees
);

-- q2. display the emp_id, emp_name, department, and salary of the single highest-paid employee in the entire company.

select emp_id, emp_name, department, salary
from employees
where salary = (
select max(salary)
from employees
);

-- q3. display the emp_id, emp_name, department, and salary of the employee with the lowest salary in the entire company.

select emp_id, emp_name, department, salary
from employees
where salary = (
select min(salary)
from employees
);

-- q4. find all employees other than rachel king who were hired in the same year as rachel king.

select emp_name, department, hire_year
from employees
where hire_year = (
select hire_year
from employees
where emp_name = 'rachel king'
)
and emp_name <> 'rachel king';

-- q5. list all products whose price is greater than the average price across all products.

select product_name, category, price
from products
where price > (
select avg(price)
from products
)
order by price desc;

-- q6. retrieve the product_id, product_name, category, and price of the single most expensive product.

select product_id, product_name, category, price
from products
where price = (
select max(price)
from products
);

-- q7. retrieve the product_id, product_name, category, and price of the cheapest product.

select product_id, product_name, category, price
from products
where price = (
select min(price)
from products
);

-- q8. list all orders whose amount is greater than the average order amount across all orders.

select order_id, customer_id, amount
from orders
where amount > (
select avg(amount)
from orders
)
order by amount desc;

-- q9. find the order_id, customer_id, amount, and order_date of the single most expensive order ever placed.

select order_id, customer_id, amount, order_date
from orders
where amount = (
select max(amount)
from orders
);

-- q10. using the in operator with a subquery, find all customers who have placed at least one order.

select customer_id, customer_name, city
from customers
where customer_id in (
select customer_id
from orders
)
order by customer_id;

-- q11. using the not in operator with a subquery, find all customers who have never placed any order.

select customer_id, customer_name, city
from customers
where customer_id not in (
select customer_id
from orders
)
order by customer_id;

-- q12. using the in operator with a subquery on the orders table, find all products that appear in at least one order.

select product_id, product_name, category, price
from products
where product_id in (
select product_id
from orders
);

-- q13. using the not in operator, find all products that have never appeared in any order.

select product_id, product_name, category, price
from products
where product_id not in (
select product_id
from orders
);

-- q14. using an in subquery against the departments table, retrieve the emp_name and salary of all employees who belong to the finance department.

select emp_name, salary
from employees
where department in (
select dept_name
from departments
where dept_name = 'finance'
)
order by salary desc;

-- q15. find all employees whose salary is less than the minimum salary of any employee in the finance department.

select emp_name, department, salary
from employees
where salary < (
select min(salary)
from employees
where department = 'finance'
)
order by salary desc;

-- q16. find the department with the highest budget from the departments table.

select dept_name, budget, location
from departments
where budget = (
select max(budget)
from departments
);

-- q17. using a subquery with group by and having, find all customers who have placed exactly 1 order.

select customer_id, customer_name, city
from customers
where customer_id in (
select customer_id
from orders
group by customer_id
having count(*) = 1
);

-- q18. using a subquery with group by and having, find all customers who have placed 2 or more orders.

select customer_id, customer_name, city
from customers
where customer_id in (
select customer_id
from orders
group by customer_id
having count(*) >= 2
)
order by customer_id;

-- q19. find all products whose price is greater than the maximum price of any product in the accessories category.

select product_name, category, price
from products
where price > (
select max(price)
from products
where category = 'accessories'
)
order by price desc;

-- q20. using an in subquery, find all orders placed by customers who joined in the year 2021.

select order_id, customer_id, amount, order_date
from orders
where customer_id in (
select customer_id
from customers
where join_year = 2021
)
order by order_date;

-- q21. using exists, find all employees who are managers.

select emp_id, emp_name, department
from employees e
where exists (
select 1
from employees e2
where e2.manager_id = e.emp_id
)
order by emp_name;

-- q22. using not exists, find all employees who are not managers.

select emp_id, emp_name, department
from employees e
where not exists (
select 1
from employees e2
where e2.manager_id = e.emp_id
)
order by emp_id;

-- q23. using exists with a correlated subquery on the orders table, find all customers who have placed at least one order.

select customer_id, customer_name, city
from customers c
where exists (
select 1
from orders o
where o.customer_id = c.customer_id
)
order by customer_id;

-- q24. using not exists, find all customers who have never placed any order.

select customer_id, customer_name, city
from customers c
where not exists (
select 1
from orders o
where o.customer_id = c.customer_id
)
order by customer_id;

-- q25. using exists with a correlated subquery on the orders table, find all products that appear in at least one order.

select product_id, product_name, category
from products p
where exists (
select 1
from orders o
where o.product_id = p.product_id
)
order by product_id;

-- q26. find all employees excluding emp_id 105 who work in the same department as emp_id 105.

select emp_name, department, salary
from employees
where department = (
select department
from employees
where emp_id = 105
)
and emp_id <> 105
order by salary desc;

-- q27. find the order with the most recent order_date.

select order_id, customer_id, amount, order_date
from orders
where order_date = (
select max(order_date)
from orders
);

-- q28. find the order with the earliest order_date.

select order_id, customer_id, amount, order_date
from orders
where order_date = (
select min(order_date)
from orders
);

-- q29. find all employees whose salary is greater than the salary of every employee in the hr department.

select emp_name, department, salary
from employees
where salary > (
select max(salary)
from employees
where department = 'hr'
)
order by salary desc;

-- q30. among delivered orders, find those whose amount is greater than the average amount of all delivered orders.

select order_id, customer_id, amount, status
from orders
where status = 'delivered'
and amount > (
select avg(amount)
from orders
where status = 'delivered'
)
order by amount desc;

-- q31. using a correlated subquery, find all employees who earn more than the average salary of their own department.

select e.emp_name, e.department, e.salary,
       round((
           select avg(e2.salary)
           from employees e2
           where e2.department = e.department
       ), 2) as dept_avg
from employees e
where e.salary > (
    select avg(e2.salary)
    from employees e2
    where e2.department = e.department
)
order by e.department, e.salary desc;

-- q32. for every employee, use a correlated subquery to count how many other employees in the same department earn strictly more than them.

select e.emp_name, e.department, e.salary,
       (
           select count(*)
           from employees e2
           where e2.department = e.department
           and e2.salary > e.salary
       ) as higher_earners
from employees e
order by e.department, e.salary desc;

-- q33. using a correlated subquery inside the where clause, find all customers whose total order spend is greater than the average total spend per customer across all ordering customers.

select c.customer_id, c.customer_name,
       (
           select sum(o.amount)
           from orders o
           where o.customer_id = c.customer_id
       ) as total_spend
from customers c
where (
    select sum(o.amount)
    from orders o
    where o.customer_id = c.customer_id
) > (
    select avg(total_spend)
    from (
        select sum(amount) as total_spend
        from orders
        group by customer_id
    ) x
)
order by total_spend desc;

-- q34. using a subquery in the where clause with in and a group by / having inside the subquery, find all employees who belong to departments where the average salary is greater than 65000.

select emp_name, department, salary
from employees
where department in (
    select department
    from employees
    group by department
    having avg(salary) > 65000
)
order by department, salary desc;

-- q35. for every row in the orders table, use a correlated subquery inside a case expression to label each order as above avg or below avg.

select o.order_id, o.customer_id, o.amount,
       case
           when o.amount >= (
               select avg(o2.amount)
               from orders o2
               where o2.customer_id = o.customer_id
           )
           then 'above avg'
           else 'below avg'
       end as vs_cust_avg
from orders o
order by o.customer_id, o.order_id;

-- q36. using a correlated subquery, find all products whose price is greater than the average price of other products in the same category.

select p.product_name, p.category, p.price,
       round((
           select avg(p2.price)
           from products p2
           where p2.category = p.category
           and p2.product_id <> p.product_id
       ), 2) as cat_avg
from products p
where p.price > (
    select avg(p2.price)
    from products p2
    where p2.category = p.category
    and p2.product_id <> p.product_id
)
order by p.category, p.price desc;

-- q37. find all employees whose salary is greater than the salary of at least one employee in the marketing department.

select emp_name, department, salary
from employees
where salary > any (
    select salary
    from employees
    where department = 'marketing'
)
order by salary desc;

-- q38. find all employees whose salary is less than the salary of every employee in the finance department.

select emp_name, department, salary
from employees
where salary < all (
    select salary
    from employees
    where department = 'finance'
)
order by salary desc;

-- q39. find customers who have placed at least one order and whose every order has status delivered.

select c.customer_id, c.customer_name
from customers c
where exists (
    select 1
    from orders o
    where o.customer_id = c.customer_id
)
and not exists (
    select 1
    from orders o
    where o.customer_id = c.customer_id
    and o.status <> 'delivered'
)
order by c.customer_id;

-- q40. using nested in subqueries, find all products that were ordered by at least one customer from mumbai.

select product_id, product_name, category
from products
where product_id in (
    select product_id
    from orders
    where customer_id in (
        select customer_id
        from customers
        where city = 'mumbai'
    )
)
order by product_id;

-- q41. find the employee or employees with the second-highest salary in the entire company.

select emp_name, department, salary
from employees
where salary = (
    select max(salary)
    from employees
    where salary < (
        select max(salary)
        from employees
    )
);

-- q42. using not exists, find all departments where every single employee earns strictly more than 50000.

select distinct e.department
from employees e
where not exists (
    select 1
    from employees e2
    where e2.department = e.department
    and e2.salary <= 50000
)
order by e.department;

-- q43. using a correlated subquery in the where clause, find all customers who have placed orders for at least 2 different products.

select c.customer_id, c.customer_name
from customers c
where (
    select count(distinct o.product_id)
    from orders o
    where o.customer_id = c.customer_id
) >= 2
order by c.customer_id;

-- q44. using a correlated subquery, find all employees whose salary is above the average salary of all employees hired in the same year as them.

select e.emp_name, e.department, e.salary, e.hire_year,
       round((
           select avg(e2.salary)
           from employees e2
           where e2.hire_year = e.hire_year
       ), 2) as year_avg
from employees e
where e.salary > (
    select avg(e2.salary)
    from employees e2
    where e2.hire_year = e.hire_year
)
order by e.hire_year, e.salary desc;

-- q45. using a correlated subquery, find all products whose stock_qty is less than the average stock_qty of all products in the same category.

select p.product_name, p.category, p.stock_qty,
       round((
           select avg(p2.stock_qty)
           from products p2
           where p2.category = p.category
       ), 2) as cat_avg_stock
from products p
where p.stock_qty < (
    select avg(p2.stock_qty)
    from products p2
    where p2.category = p.category
)
order by p.category, p.stock_qty asc;

-- q46. find all employees whose salary is among the top 3 distinct salary values in the company.

select emp_name, department, salary
from employees
where salary in (
    select distinct salary
    from employees
    order by salary desc
    limit 3
)
order by salary desc;

-- q47. find all customers who have placed at least one order where every single order has an amount strictly greater than 1000.

select c.customer_id, c.customer_name
from customers c
where exists (
    select 1
    from orders o
    where o.customer_id = c.customer_id
)
and not exists (
    select 1
    from orders o
    where o.customer_id = c.customer_id
    and o.amount <= 1000
)
order by c.customer_id;

-- q48. for each department, find the employee whose salary is closest to that department's average salary.

select e.emp_name, e.department, e.salary,
       round((
           select avg(e2.salary)
           from employees e2
           where e2.department = e.department
       ), 2) as dept_avg,
       abs(
           e.salary - (
               select avg(e2.salary)
               from employees e2
               where e2.department = e.department
           )
       ) as diff
from employees e
where abs(
    e.salary - (
        select avg(e2.salary)
        from employees e2
        where e2.department = e.department
    )
) = (
    select min(
        abs(
            e3.salary - (
                select avg(e4.salary)
                from employees e4
                where e4.department = e3.department
            )
        )
    )
    from employees e3
    where e3.department = e.department
)
order by e.department;

-- q49. find all customers other than customer 201 who have ordered every product that customer 201 has ordered.

select c.customer_id, c.customer_name
from customers c
where c.customer_id <> 201
and not exists (
    select 1
    from orders o201
    where o201.customer_id = 201
    and not exists (
        select 1
        from orders oc
        where oc.customer_id = c.customer_id
        and oc.product_id = o201.product_id
    )
)
order by c.customer_id;

-- q50. find all departments whose total salary bill is greater than the total salary bill of at least one other department.

select department, sum(salary) as dept_total
from employees
group by department
having sum(salary) > (
    select min(dept_total)
    from (
        select sum(salary) as dept_total
        from employees
        group by department
    ) x
)
order by dept_total desc;

-- q51. using only subqueries, find all employees who earn strictly more than their own manager's salary.

select e.emp_name,
       e.salary as emp_salary,
       (
           select m.emp_name
           from employees m
           where m.emp_id = e.manager_id
       ) as manager_name,
       (
           select m.salary
           from employees m
           where m.emp_id = e.manager_id
       ) as manager_salary
from employees e
where e.manager_id is not null
and e.salary > (
    select m.salary
    from employees m
    where m.emp_id = e.manager_id
)
order by e.salary desc;

-- q52. find all products whose total number of orders is greater than the average number of orders per product.

select p.product_id, p.product_name,
       (
           select count(*)
           from orders o
           where o.product_id = p.product_id
       ) as order_count
from products p
where p.product_id in (
    select distinct product_id
    from orders
)
and (
    select count(*)
    from orders o
    where o.product_id = p.product_id
) > (
    select avg(cnt)
    from (
        select count(*) as cnt
        from orders
        group by product_id
    ) x
);

-- q53. find the customer whose single highest order amount is equal to the global maximum order amount.

select c.customer_id, c.customer_name,
       (
           select max(o.amount)
           from orders o
           where o.customer_id = c.customer_id
       ) as best_order
from customers c
where (
    select max(o.amount)
    from orders o
    where o.customer_id = c.customer_id
) = (
    select max(amount)
    from orders
);

-- q54. find all employees who belong to departments that have a budget greater than the average budget across all departments.

select emp_name, department, salary
from employees
where department in (
    select dept_name
    from departments
    where budget > (
        select avg(budget)
        from departments
    )
)
order by department, salary desc;

-- q55. for each customer who has placed at least one order, count how many of their own orders have an amount strictly greater than their personal average order amount.

select c.customer_id, c.customer_name,
       (
           select count(*)
           from orders o1
           where o1.customer_id = c.customer_id
           and o1.amount > (
               select avg(o2.amount)
               from orders o2
               where o2.customer_id = c.customer_id
           )
       ) as orders_above_avg
from customers c
where exists (
    select 1
    from orders o
    where o.customer_id = c.customer_id
)
order by orders_above_avg desc, c.customer_id;

-- q56. find all products that were ordered exclusively by customers from a single city.

select p.product_id, p.product_name,
       (
           select min(c.city)
           from customers c
           where c.customer_id in (
               select o.customer_id
               from orders o
               where o.product_id = p.product_id
           )
       ) as only_city
from products p
where p.product_id in (
    select product_id
    from orders
)
and (
    select count(distinct c.city)
    from customers c
    where c.customer_id in (
        select o.customer_id
        from orders o
        where o.product_id = p.product_id
    )
) = 1;

-- q57. find employees who are the sole highest earner in their department.

select e.emp_name, e.department, e.salary
from employees e
where e.salary = (
    select max(e2.salary)
    from employees e2
    where e2.department = e.department
)
and (
    select count(*)
    from employees e3
    where e3.department = e.department
    and e3.salary = e.salary
) = 1
order by e.salary desc;

-- q58. find customers whose total spend is more than double the average total spend per customer.

select c.customer_id, c.customer_name,
       (
           select sum(o.amount)
           from orders o
           where o.customer_id = c.customer_id
       ) as total_spend
from customers c
where (
    select sum(o.amount)
    from orders o
    where o.customer_id = c.customer_id
) > 2 * (
    select avg(total_spend)
    from (
        select sum(amount) as total_spend
        from orders
        group by customer_id
    ) x
);

-- q59. find the department that has the highest count of employees earning above the company-wide average salary.

select e.department,
       (
           select count(*)
           from employees e2
           where e2.department = e.department
           and e2.salary > (
               select avg(salary)
               from employees
           )
       ) as above_avg_count
from employees e
group by e.department
order by above_avg_count desc
limit 1;

-- q60. find all employees who are the highest earner in their own department but whose overall salary rank in the company is beyond position 3.

select e.emp_name, e.department, e.salary
from employees e
where e.salary = (
    select max(e2.salary)
    from employees e2
    where e2.department = e.department
)
and (
    select count(distinct e3.salary)
    from employees e3
    where e3.salary > e.salary
) >= 3
order by e.salary desc;