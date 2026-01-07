# Brazilian E-commerce Marketplace — Revenue, Logistics & Customer Strategy

End-to-end business analysis of a large Brazilian e-commerce marketplace using SQL and Power BI.  
Focused on revenue concentration, logistics trade-offs, category complexity, and customer value fragmentation to support strategic decision-making.

---

## 📌 Project Overview
This project presents a business-oriented analysis of a Brazilian e-commerce marketplace using the Brazilian E-Commerce Public Dataset by Olist.


End-to-end business analysis of a large Brazilian e-commerce marketplace using SQL and Power BI.  
Focused on revenue concentration, logistics trade-offs, category complexity, and customer value fragmentation to support strategic decision-making.

...


## 📌 Project Overview

This project presents a business-oriented analysis of a Brazilian e-commerce marketplace using the **Brazilian E-Commerce Public Dataset by Olist**.

The analysis focuses on understanding how revenue is generated, how logistics performance scales geographically, and whether customer loyalty represents a sustainable growth driver.

All insights are derived using SQL and supported by data visualizations, simulating a real-world analytical delivery for business stakeholders.

---

## 🔍 Analytical Framework

This project follows a **business-first analytical approach**.

Key business questions are defined upfront based on common e-commerce decision-making challenges (growth, logistics, and customer value).  
Each question is then translated into structured SQL analysis, allowing insights to emerge directly from the data.

Business questions serve as **analytical entry points**.  
Final insights reflect the **strategic implications** of their answers.

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

## 💡 Business Recommendations

Based on the insights derived from the analysis, the following actions are recommended:

1. **Optimize logistics performance in high-volume, low-efficiency states**  
   Several states combine meaningful order volume with average delivery times above 25 days (e.g., RR, AP, AM, AL, PA).  
   Prioritizing logistics optimization in these regions—through regional partnerships or micro-distribution hubs—could significantly reduce delivery times and improve customer satisfaction, with potential positive impact on repeat purchasing behavior.

2. **Reassess category prioritization using risk-adjusted profitability metrics**  
   High-revenue categories also generate higher logistics complexity and fulfillment costs.  
   Category decision-making should move beyond revenue alone and incorporate operational risk, using a composite KPI such as:  
   
   *(Category Revenue × Estimated Margin) / (Average Delivery Days + Estimated Freight Cost)*  

   This would allow the business to prioritize categories with stronger risk-adjusted performance.

3. **Deploy targeted reactivation strategies for high-potential at-risk customers**  
   RFM analysis shows a large share of customers classified as “At Risk,” characterized by recent but infrequent purchases.  
   Targeted reactivation campaigns focused on the top-value segment of these customers—using incentives such as free shipping or category-specific discounts—are likely to generate higher ROI than broad-based acquisition efforts.

4. **Reduce dependency on logistics-intensive categories by promoting lower-complexity segments**  
   Revenue concentration in a narrow set of operationally demanding categories increases execution risk.  
   Encouraging growth in lower-complexity categories (e.g., perfumery, stationery, office furniture) could improve operational stability while diversifying revenue sources.

5. **Establish continuous monitoring of logistics and category performance (optional extension)**  
   Ongoing visibility into delivery performance and category-level efficiency is critical for early risk detection.  
   A lightweight monitoring layer tracking average delivery days and category profitability by state would enable faster, data-driven decision-making.

---

## 📊 Data Availability

This project is built using the **Brazilian E-Commerce Public Dataset by Olist**.

- Raw datasets are publicly available on Kaggle and documented in:
  [data/raw/README.md](data/raw/README.md)

- The final business-ready analytical dataset generated for this project is available here:
  [data/processed/master_sales_clean.csv](data/processed/master_sales_clean.csv)



This structure ensures transparency, reproducibility, and reusability.

---

## 🛠️ Tools & Technologies

- SQL (SQLite-compatible)
- Power BI
- GitHub

---

## 📂 Project Contents

- `sql/`  
SQL scripts for data modeling and business analysis.

- `data/raw/`  
Documentation of raw datasets used in the project.

- `data/processed/`  
Final analytical dataset (`master_sales_clean`) and schema documentation.

- `visuals/`  
Consolidated Power BI visual report aligned with key business insights.

- `docs/`  
Executive summary, business diagnostic and methodology notes.

---

👤 Author

**Franco Palomeque**  
Data Analyst — SQL | Business & Product Analytics


---

This project is part of a personal analytics portfolio and is intended for educational and professional demonstration purposes.
