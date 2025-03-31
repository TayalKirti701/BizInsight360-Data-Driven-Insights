select
YEAR(order_date) as order_year,
MONTH(order_date) as order_month,SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key)as total_customers,
SUM(quantity) as total_quantity
from gold.fact_sales
where order_date IS NOT NULL
group by YEAR(order_date),MONTH(order_date)
order by YEAR(order_date),MONTH(order_date)


select
DATETRUNC(month,order_date) as order_date,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key)as total_customers,
SUM(quantity) as total_quantity
from gold.fact_sales
where order_date IS NOT NULL
group by DATETRUNC(month,order_date)
order by DATETRUNC(month,order_date)

select
DATETRUNC(year,order_date) as order_date,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key)as total_customers,
SUM(quantity) as total_quantity
from gold.fact_sales
where order_date IS NOT NULL
group by DATETRUNC(year,order_date)
order by DATETRUNC(year,order_date)


select
FORMAT(order_date,'yyyy-MMM') as order_date,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key)as total_customers,
SUM(quantity) as total_quantity
from gold.fact_sales
where order_date IS NOT NULL
group by FORMAT(order_date,'yyyy-MMM')
order by FORMAT(order_date,'yyyy-MMM')
