 /*segment products into cost ranges and
 count how many products fall into each segment*/
WITH product_segments AS(
 SELECT 
 product_key,
 product_name,
 cost,
 CASE WHEN cost<100 THEN 'Below 100 '
      WHEN cost BETWEEN 100 AND 500 THEN '100-500'
	  WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
	  ELSE 'More than 1000'
END cost_range
 FROM 
 gold.dim_products
 )


 SELECT 
 cost_range,
 COUNT(product_key) AS total_products
 FROM 
 product_segments
 GROUP BY
 cost_range
 ORDER BY
 total_products DESC


 SELECT * FROM gold.dim_customers
 SELECT * FROM gold.dim_products
  SELECT * FROM gold.fact_sales

;WITH customer_spending AS(
SELECT 
c.customer_key,
SUM(f.sales_amount) total_amount,
MIN(order_date) first_order,
MAX(order_date) last_order,
DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS lifespan,
CASE WHEN DATEDIFF(MONTH,MIN(order_date),MAX(order_date))>=12 AND SUM(f.sales_amount) > 5000 THEN 'VIP'
     WHEN DATEDIFF(MONTH,MIN(order_date),MAX(order_date))>=12 AND SUM(f.sales_amount) <= 5000 THEN 'Regular'
	 ELSE 'NEW'
END spending_category
FROM
gold.fact_sales f
LEFT JOIN
gold.dim_customers c
ON f.customer_key=c.customer_key
GROUP BY
c.customer_key
)

SELECT 
COUNT(customer_key) total_customers,
spending_category
FROM customer_spending
GROUP BY spending_category
ORDER BY total_customers DESC

