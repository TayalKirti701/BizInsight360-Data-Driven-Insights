# BizInsight360-Data-Driven-Insights

## Overview
  This project focuses on analyzing retail sales data using SQL Server. The analytics cover various 
  aspects of the business, including product performance, customer behavior, sales trends, and 
  segmentation analysis. 

## Database Structure
   The project uses a SQL Server data warehouse with a gold schema containing three main tables:
   - gold.dim_customers - Customer dimension table
   - gold.dim_products - Product dimension table
   - gold.fact_sales - Sales fact table

## Features 
### 1.Performance Analysis: 
Compare product sales across years and against averages
### 2.Customer Segmentation: 
 Identify VIP, regular, and new customers
### 3.Product Categorization:
 Segment products by cost ranges
### 4.Category Contribution:
 Analyze which product categories drive the most sales
### 5.Temporal Analysis:
Track sales trends over time with cumulative totals
### 6.Comprehensive Reporting:
Generate detailed customer insights


## Technologies Used
- **SQL Server** (for database management and querying)
- **Window Functions** (for analytical calculations)
- **Common Table Expressions (CTEs)** (for modular query design)

## Installation
### 1. Clone the repository:
  ```bash```
  git clone https://github.com/TayalKirti701/BizInsight360-Data-Driven-Insights.git
### 2. Navigate to the project directory:
  ```bash```
  cd BizInsight360-Data-Driven-Insights
### 3. Set up the SQL Server database:
  ```sql```
  USE master;
  GO
### 5.  Load the data from CSV files as specified in the setup script.

## How It Works
1. The SQL Server database stores product, customer, and sales data in a dimensional model
2. Advanced SQL queries extract insights such as product performance, customer segments, and 
   sales trends
   
## Sample Queries

### 1.Product performance analysis

  SELECT 
  order_year,
  product_name,
  current_sales,
  AVG(current_sales) OVER (PARTITION BY product_name) avg_sales,
  current_sales-AVG(current_sales) OVER (PARTITION BY product_name) avg_sales,
  CASE WHEN current_sales-AVG(current_sales) OVER (PARTITION BY product_name) >0 THEN 'Above Avg'
       WHEN current_sales-AVG(current_sales) OVER (PARTITION BY product_name) <0 THEN 'Below Avg'
       ELSE 'Avg'
  END avg_change
  FROM yearly_product_sales
  ORDER BY product_name,order_year

### 2. Category contribution to sales

  SELECT category,total_sales,
  SUM(total_sales) OVER () overall_sales,
  CONCAT(ROUND((CAST(total_sales AS float) / SUM(total_sales) OVER ())*100,2),'%') AS 
  contribution
  FROM category_sales 
  ORDER BY total_sales DESC

### 3. Cumulative sales analysis

  SELECT 
  order_date,
  total_sales,
  SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
  SUM(avg_price) OVER (ORDER BY order_date) AS moving_average_price
  FROM monthly_sales
  
 ### 4.Customer segmentation
  SELECT 
  COUNT(customer_key) total_customers,
  spending_category
  FROM customer_spending
  GROUP BY spending_category
  ORDER BY total_customers DESC

## Future Enhancements:
- Integration with visualization tools (Power BI, Tableau)
- Enhanced customer segmentation with RFM analysis
- Predictive analytics for forecasting sales
 
 
 

 
