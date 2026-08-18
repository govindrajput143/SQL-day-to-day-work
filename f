-- ============================================
-- SQL WINDOW FUNCTIONS PRACTICE
-- Topics:
-- LEAD, LAG, ROW_NUMBER, NTILE
-- Running Sum, Running Average
-- Last 3 Orders
-- ============================================


-- ============================================
-- 1. SELECT ALL DATA
-- ============================================

SELECT *
FROM orders;


-- ============================================
-- 2. PERCENTAGE OF CUSTOMER TOTAL
-- ============================================

SELECT
    customer_id,
    customer_name,
    order_id,
    amount,

    ROUND(
        amount / SUM(amount) OVER (
            PARTITION BY customer_id
        ) * 100,
        2
    ) AS percentage_of_customer_total

FROM orders;


-- ============================================
-- 3. LEAD()
-- Next Order Amount
-- ============================================

SELECT
    *,
    LEAD(amount, 1) OVER() AS next_order_amount
FROM orders;


-- ============================================
-- 4. LEAD() - NEXT 2 ORDERS
-- ============================================

SELECT
    *,
    LEAD(amount, 1) OVER() AS next_order_amount,
    LEAD(amount, 2) OVER() AS second_next_order_amount
FROM orders;


-- ============================================
-- 5. LAG()
-- Previous Order Amount
-- ============================================

SELECT
    *,
    LAG(amount, 1) OVER() AS previous_order_amount
FROM orders;


-- ============================================
-- 6. LEAD AND LAG TOGETHER
-- ============================================

SELECT
    *,
    LEAD(amount, 1) OVER() AS next_order_amount,
    LAG(amount, 1) OVER() AS previous_order_amount
FROM orders;


-- ============================================
-- 7. ROW_NUMBER()
-- ============================================

SELECT
    *,
    ROW_NUMBER() OVER() AS row_number
FROM orders;


-- ============================================
-- 8. ROW_NUMBER() BY CUSTOMER
-- ============================================

SELECT
    *,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS customer_order_number
FROM orders;


-- ============================================
-- 9. NTILE()
-- Divide Orders Into 4 Groups
-- ============================================

SELECT
    *,
    NTILE(4) OVER(
        ORDER BY amount
    ) AS order_group
FROM orders;


-- ============================================
-- 10. RUNNING SUM
-- ============================================

SELECT
    order_id,
    customer_name,
    amount,

    SUM(amount) OVER(
        ORDER BY order_date
    ) AS running_sum

FROM orders;


-- ============================================
-- 11. RUNNING SUM BY CUSTOMER
-- ============================================

SELECT
    customer_id,
    customer_name,
    order_id,
    amount,

    SUM(amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS customer_running_sum

FROM orders;


-- ============================================
-- 12. RUNNING AVERAGE
-- ============================================

SELECT
    order_id,
    customer_name,
    amount,

    ROUND(
        AVG(amount) OVER(
            ORDER BY order_date
        ),
        2
    ) AS running_average

FROM orders;


-- ============================================
-- 13. LAST 3 ORDERS
-- Current + Previous 2 Orders
-- ============================================

SELECT
    order_id,
    customer_name,
    amount,

    SUM(amount) OVER(
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS last_3_orders_total

FROM orders;


-- ============================================
-- 14. LAST 3 ORDERS AVERAGE
-- ============================================

SELECT
    order_id,
    customer_name,
    amount,

    ROUND(
        AVG(amount) OVER(
            ORDER BY order_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS last_3_orders_average

FROM orders;


-- ============================================
-- 15. COMPLETE WINDOW FUNCTION QUERY
-- ============================================

SELECT
    order_id,
    customer_id,
    customer_name,
    order_date,
    amount,

    LAG(amount, 1) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_amount,

    LEAD(amount, 1) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_amount,

    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS order_number,

    SUM(amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS running_total,

    ROUND(
        AVG(amount) OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        ),
        2
    ) AS running_average,

    SUM(amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS last_3_orders_total

FROM orders;
