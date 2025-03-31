--which category contribute the most to overall sales?

;WITH category_sales AS(
SELECT 
category,
sum(sales_amount) total_sales
from gold.fact_sales f
LEFT JOIN
gold.dim_products p
ON
p.product_key=f.product_key
GROUP BY category
)

SELECT category,total_sales,
SUM(total_sales) OVER () overall_sales,
CONCAT(ROUND((CAST ( total_sales AS float) / SUM(total_sales) OVER ())*100,2),'%') AS contribution
from category_sales 
ORDER BY total_sales DESC




