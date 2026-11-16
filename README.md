E-commerce sales analytics & data warehouse for Gavaza Sesinyani Design Aprons (PTY) Ltd, a South African apron retailer. Features a MySQL star schema (fact/dimension tables), 100-record OLTP dataset, SQL views/CTEs for KPIs (revenue, YoY/MoM growth, customer segments), and a Power BI sales dashboard.

Gavaza Sesinyani Design Aprons — Sales Analytics & Data Warehouse

An end-to-end data warehouse and business intelligence project for Gavaza Sesinyani Design Aprons (PTY) Ltd, a fictional South African e-commerce company selling premium aprons (chef, barista, welding, leather, denim, braai & custom printed) nationwide across all 9 provinces.

Project Objectives
- Design and implement a star schema data warehouse in MySQL
- Clean and transform raw operational data
- Build analytical SQL views and CTEs for business KPIs
- Visualise sales performance in an interactive Power BI dashboard

Tech Stack
- SQL (MySQL 8+) — database, star schema, views, CTEs
- Power BI Desktop — dashboard & DAX measures
- Excel CSV — raw data export
- Git & GitHub — version control

Dataset
100 records per OLTP table (realistic South African data):
| Table | Records | Description |
|---|---|---|
| customers | 100 | SA names, segments (VIP/Loyal/Regular/New) |
| products | 100 | Aprons across 10 categories, SKUs, pricing |
| orders | 100 | Orders spanning 2023–2025 |
| order_lines | 210 | 1–3 products per order |
| payments | 100 | Card, EFT, SnapScan, Zapper, PayFast, COD |
| locations | 100 | All 9 SA provinces |


Dashboard KPIs (Power BI)
- Total revenue — R267k+
- Monthly sales trend (line chart)
- Top 10 products (bar chart)
- Customer segments (donut chart)
- Revenue by province (SA map visual)
- Average order value (card)
- Repeat customers & repeat rate (27%)
- Year-over-year & month-over-month growth (DAX time intelligence)


Dashboard KPIs (Power BI)
- Total revenue — R267k+
- Monthly sales trend (line chart)
- Top 10 products (bar chart)
- Customer segments (donut chart)
- Revenue by province (SA map visual)
- Average order value (card)
- Repeat customers & repeat rate (27%)
- Year-over-year & month-over-month growth (DAX time intelligence)

Repository Structure

├── gavaza_dw_mysql.sql      # Full warehouse script (DDL, cleaning, star schema, views, CTEs)
├── customers.csv            # Raw customer data (100 records)
├── products.csv             # Raw product data (100 records)
├── orders.csv               # Raw order data (100 records)
├── order_lines.csv          # Order line items (210 records)
├── payments.csv             # Payment data (100 records)
├── locations.csv            # Location data (100 records)
├── Gavaza_Sesinyani_Dashboard.pbix   # Power BI dashboard file
└── README.md

