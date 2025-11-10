# retail_sales_analysis
This project involved analyzing a retail sales dataset using SQL to gain insights into business performance, customer behavior, and sales trends.I performed data cleaning, data exploration, and business analysis using advanced SQL queries.

Tools Used:
PostgreSQL– Database for querying and analysis
pgAdmin– Query execution environment
Excel  – Source data file

Project Steps:

1️.Data Cleaning
Checked for NULL or missing values
Updated missing ages (age = 54)
Deleted incomplete records

UPDATE retail_sales
SET age = 54
WHERE age IS NULL;

2️.Data Exploration

Counted total transactions and unique customers
Identified all available product categories

SELECT COUNT(*) AS total_sales FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

3️.Data Analysis & Business Insights
--> Sales made on a specific date

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

--> Clothing sales with high quantity in Nov 2022

SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;

--> Total Sales by Category

SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

--> Average Age of Customers (Beauty Category)

SELECT ROUND(AVG(age), 2) FROM retail_sales WHERE category = 'Beauty';

--> Top 5 Customers by Total Sales

SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

--> Orders by Time Shift(Morning ≤ 12, Afternoon 12–17, Evening > 17)

WITH hourly_sale AS (
  SELECT *,
    CASE
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;


## Learnings

1.Data Cleaning & Validation in SQL
2.Aggregate & Window Functions
3.Analytical Problem Solving using SQL
4.Business-focused reporting

## Conclusion

This project demonstrates how SQL alone can be used for real-world data analysis without external tools.
The insights derived help understand customer patterns, category performance, and seasonal sales trends — valuable for business decisions.
