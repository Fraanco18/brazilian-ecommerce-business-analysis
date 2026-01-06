/* ============================================================
   Project: Brazilian E-Commerce Analysis (Olist)
   File: 02_business_questions.sql

   Description:
   This script answers key business questions using the
   master_sales_clean table. The analysis focuses on revenue
   concentration, operational complexity, and customer loyalty.
   ============================================================ */
/* ============================================================
   Business Question 1
   How has sales performance evolved over time?
   ============================================================ */

SELECT 
    purchase_month, 
    COUNT(order_id) AS orders, 
    SUM(total_revenue) AS revenue
FROM master_sales_clean
GROUP BY purchase_month
ORDER BY purchase_month DESC;


/* ============================================================
   Business Question 2
   How concentrated is revenue across customers? (80/20 analysis)
   ============================================================ */

WITH customer_revenue AS (
    SELECT 
        customer_id,
        SUM(total_revenue) AS total_spent
    FROM master_sales_clean
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT 
        customer_id,
        total_spent,
        SUM(total_spent) OVER (ORDER BY total_spent DESC) AS cumulative_revenue,
        SUM(total_spent) OVER () AS total_global_revenue,
        COUNT(*) OVER () AS total_customers,
        ROW_NUMBER() OVER (ORDER BY total_spent DESC) AS customer_rank
    FROM customer_revenue
)
SELECT 
    customer_rank,
    (CAST(customer_rank AS FLOAT) / total_customers) * 100 AS pct_customers,
    (cumulative_revenue / total_global_revenue) * 100 AS pct_cumulative_revenue
FROM ranked_customers
WHERE customer_rank % 100 = 0 OR customer_rank = 1
LIMIT 20;


/* ============================================================
   80/20 Analysis – Key Customers Driving Revenue
   ============================================================ */

WITH customer_revenue AS (
    SELECT 
        customer_id,
        SUM(total_revenue) AS total_spent
    FROM master_sales_clean
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT 
        customer_id,
        total_spent,
        SUM(total_spent) OVER (ORDER BY total_spent DESC) AS cumulative_revenue,
        SUM(total_spent) OVER () AS total_global_revenue,
        COUNT(*) OVER () AS total_customers,
        ROW_NUMBER() OVER (ORDER BY total_spent DESC) AS customer_rank
    FROM customer_revenue
)
SELECT 
    customer_rank,
    (CAST(customer_rank AS FLOAT) / total_customers) * 100 AS pct_customers,
    (cumulative_revenue / total_global_revenue) * 100 AS pct_cumulative_revenue
FROM ranked_customers
WHERE (cumulative_revenue / total_global_revenue) <= 0.80
ORDER BY customer_rank;


/* ============================================================
   80/20 Analysis by Product
   Identifies how revenue is concentrated across products
   ============================================================ */

WITH order_products AS (
    -- Reconnect products with orders and prices
    SELECT
        i.order_id,
        i.product_id,
        i.price
    FROM olist_order_items_dataset i
),
order_totals AS (
    -- Total product value per order (for proportional allocation)
    SELECT
        order_id,
        SUM(price) AS order_product_total
    FROM order_products
    GROUP BY order_id
),
product_revenue AS (
    -- Allocate order revenue proportionally to each product
    SELECT
        op.product_id,
        COUNT(DISTINCT op.order_id) AS total_orders,
        SUM(
            (op.price / ot.order_product_total) * ms.total_revenue
        ) AS allocated_revenue
    FROM order_products op
    JOIN order_totals ot
        ON op.order_id = ot.order_id
    JOIN master_sales_clean ms
        ON op.order_id = ms.order_id
    GROUP BY op.product_id
),
ranked_products AS (
    SELECT
        product_id,
        total_orders,
        allocated_revenue,

        SUM(allocated_revenue) OVER (ORDER BY allocated_revenue DESC) AS cumulative_revenue,
        SUM(allocated_revenue) OVER () AS total_global_revenue,

        COUNT(*) OVER () AS total_products,
        ROW_NUMBER() OVER (ORDER BY allocated_revenue DESC) AS product_rank
    FROM product_revenue
)
SELECT
    product_rank,
    product_id,
    total_orders,
    ROUND(allocated_revenue, 2) AS total_revenue,
    ROUND((CAST(product_rank AS FLOAT) / total_products) * 100, 2) AS pct_products,
    ROUND((cumulative_revenue / total_global_revenue) * 100, 2) AS pct_cumulative_revenue
FROM ranked_products
WHERE product_rank % 50 = 0 OR product_rank = 1
LIMIT 30;


/* ============================================================
   Business Question 3
   Which product categories generate the highest revenue and
   show operational issues?
   ============================================================ */

SELECT 
    category,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(AVG(product_value), 2) AS avg_ticket,
    ROUND(AVG(JULIANDAY(delivery_date) - JULIANDAY(purchase_date)), 2) AS avg_delivery_days
FROM master_sales_clean
GROUP BY category
HAVING total_orders > 50
ORDER BY total_revenue DESC
LIMIT 10;


/* ============================================================
   Business Question 4
   What is the difference between new and returning customers?
   ============================================================ */

WITH customer_orders AS (
    SELECT
        order_id,
        customer_id,
        purchase_date,
        total_revenue,
        items_qty,
        MIN(purchase_date) OVER (PARTITION BY customer_id) AS first_purchase_date
    FROM master_sales_clean
)
SELECT
    CASE 
        WHEN purchase_date = first_purchase_date THEN 'New'
        ELSE 'Returning'
    END AS customer_type,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(total_revenue), 2) AS avg_order_value,
    ROUND(AVG(items_qty), 2) AS avg_items_per_order
FROM customer_orders
GROUP BY customer_type;


/* ============================================================
   Purchase Frequency Analysis
   ============================================================ */

WITH customer_summary AS (
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders,
        SUM(total_revenue) AS total_revenue
    FROM master_sales_clean
    GROUP BY customer_id
)
SELECT
    CASE 
        WHEN total_orders = 1 THEN 'New'
        ELSE 'Returning'
    END AS customer_type,
    COUNT(customer_id) AS customers,
    ROUND(AVG(total_orders), 2) AS avg_orders_per_customer,
    ROUND(AVG(total_revenue), 2) AS avg_revenue_per_customer
FROM customer_summary
GROUP BY customer_type;


/* ============================================================
   Business Question 5
   How can customers be segmented using RFM analysis?
   ============================================================ */

WITH customer_rfm AS (
    SELECT
        customer_id,
        CAST(JULIANDAY('2018-10-17') - JULIANDAY(MAX(purchase_date)) AS INTEGER) AS recency_days,
        COUNT(order_id) AS frequency,
        SUM(total_revenue) AS monetary
    FROM master_sales_clean
    GROUP BY customer_id
),
rfm_scores AS (
    SELECT
        customer_id,
        NTILE(4) OVER (ORDER BY recency_days ASC) AS r_score,
        NTILE(4) OVER (ORDER BY frequency DESC) AS f_score,
        NTILE(4) OVER (ORDER BY monetary DESC) AS m_score
    FROM customer_rfm
)
SELECT
    CASE
        WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'High Value'
        WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(customer_id) AS customers
FROM rfm_scores
GROUP BY customer_segment
ORDER BY customers DESC;
