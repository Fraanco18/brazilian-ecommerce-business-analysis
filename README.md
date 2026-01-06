# 🇧🇷 Brazilian E-Commerce Business Analysis (Olist)

## 📌 Project Overview

This project presents a business-oriented analysis of a Brazilian e-commerce marketplace using the **Brazilian E-Commerce Public Dataset by Olist**.

The analysis focuses on understanding how revenue is generated, how logistics performance scales geographically, and whether customer loyalty represents a sustainable growth driver.

All insights are derived using SQL and supported by data visualizations, simulating a real-world analytical delivery for business stakeholders.

---

## 🧠 Executive Summary

The analysis reveals four key findings:

- Geographic expansion introduces significant delivery and logistics trade-offs.
- High-revenue categories tend to be operationally complex, with longer delivery times.
- Revenue is highly concentrated across a small set of products, not customers.
- Customer loyalty is structurally weak, with most revenue driven by low-value or at-risk segments.

Together, these insights suggest that growth is driven more by product performance and scale than by customer retention.

---

## 📊 Key Business Insights

### 1️⃣ Geographic Scale Comes with Trade-offs  
**(State × Revenue × Delivery × Freight)**

States with higher sales volume do not necessarily achieve better delivery performance.  
In many cases, scale is associated with longer delivery times, indicating structural logistics constraints.

---

### 2️⃣ High-Revenue Categories Drive Operational Complexity  
**(Category × AOV × Logistics)**

Categories responsible for the majority of revenue also show:
- Higher average order values
- Longer delivery times

This suggests that revenue growth is tied to operationally demanding categories.

---

### 3️⃣ Revenue Is Product-Concentrated, Not Customer-Concentrated  
**(80/20 Products vs Fragmented Customers)**

A small percentage of products accounts for a disproportionate share of total revenue, while customer spending is widely distributed across the base.

This highlights a dependency on product-level performance rather than loyal customers.

---

### 4️⃣ RFM Reveals Structural Lack of Customer Loyalty  
**(New vs Returning + RFM Analysis)**

RFM segmentation shows that most customers fall into **Low Value** or **At Risk** segments, with loyal customers contributing a relatively small share of total revenue.

This indicates a predominantly transactional business model.

---

## 🛠️ Tools & Technologies

- SQL (SQLite-compatible)
- Power BI
- GitHub

---

## 📂 Repository Structure

```text
brazilian-ecommerce-business-analysis/
│
├── data/        # Dataset references and schema notes
├── docs/        # Executive summary and methodology
├── sql/         # SQL queries and business logic
├── visuals/     # Power BI visual exports
└── README.md
```

👤 Author

**Franco Palomeque**
Data Analyst — SQL | Business Analytics

---

This project is part of a personal analytics portfolio and is intended for educational and professional demonstration purposes.
