/* ============================================================
   Project: Brazilian E-Commerce Analysis (Olist)
   File: 01_data_modeling.sql

   Description:
   This script creates the business-ready master tables used
   throughout the analysis. It consolidates orders, payments,
   products, and customers into a clean analytical dataset.
   ============================================================ */
/* ============================================================
   Base Master Table (Raw Delivered Orders)
   ============================================================ */

-- Drop table if it already exists
DROP TABLE IF EXISTS master_sales;

-- Create base master table for delivered orders
CREATE TABLE master_sales AS
SELECT 
    o.order_id,

    -- Customer information
    c.customer_unique_id AS customer_id, -- Real customer identifier
    c.customer_state,

    o.order_status,

    -- Convert string timestamps to SQLite datetime
    DATETIME(o.order_purchase_timestamp) AS purchase_date,
    DATETIME(o.order_delivered_customer_date) AS delivery_date,

    -- Product / item information
    i.product_id,
    i.price,
    i.freight_value,

    -- Payment information
    p.payment_value,
    p.payment_type

FROM olist_orders_dataset o
JOIN olist_order_items_dataset i 
    ON o.order_id = i.order_id
JOIN olist_order_payments_dataset p 
    ON o.order_id = p.order_id
JOIN olist_customers_dataset c 
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered';

-- Quick validation
SELECT * FROM master_sales;


/* ============================================================
   Clean Master Table (Business-Ready Dataset)
   ============================================================ */

-- Drop clean table if it already exists
DROP TABLE IF EXISTS master_sales_clean;

-- Create final master table with aggregated metrics
CREATE TABLE master_sales_clean AS
WITH payments_summary AS (
    -- Aggregate payments to calculate real revenue per order
    SELECT 
        order_id,
        SUM(payment_value) AS total_revenue_order
    FROM olist_order_payments_dataset
    GROUP BY order_id
),
items_summary AS (
    -- Aggregate order items and attach product category
    SELECT 
        i.order_id,
        COUNT(i.product_id) AS total_items_qty,
        SUM(i.price) AS total_products_value,
        SUM(i.freight_value) AS total_freight_value,
        MAX(p.product_category_name) AS main_category
    FROM olist_order_items_dataset i
    LEFT JOIN olist_products_dataset p 
        ON i.product_id = p.product_id
    GROUP BY i.order_id
)

SELECT 
    -- Identifiers
    o.order_id,
    c.customer_unique_id AS customer_id,
    c.customer_state,
    o.order_status,

    -- Dates
    DATETIME(o.order_purchase_timestamp) AS purchase_date,
    DATETIME(o.order_delivered_customer_date) AS delivery_date,
    STRFTIME('%Y-%m', o.order_purchase_timestamp) AS purchase_month,
    STRFTIME('%H', o.order_purchase_timestamp) AS purchase_hour,

    -- Financial metrics
    ROUND(COALESCE(ps.total_revenue_order, 0), 2) AS total_revenue,
    ROUND(COALESCE(its.total_products_value, 0), 2) AS product_value,
    ROUND(COALESCE(its.total_freight_value, 0), 2) AS freight_value,
    COALESCE(its.total_items_qty, 0) AS items_qty,

    -- Product category translated to English
    COALESCE(t.product_category_name_english, 'others') AS category

FROM olist_orders_dataset o
LEFT JOIN payments_summary ps 
    ON o.order_id = ps.order_id
LEFT JOIN items_summary its 
    ON o.order_id = its.order_id
LEFT JOIN olist_customers_dataset c 
    ON o.customer_id = c.customer_id
LEFT JOIN product_category_name_translation t
    ON its.main_category = t.product_category_name
WHERE o.order_status = 'delivered';

-- Validation
SELECT * FROM master_sales_clean;
