use companydb;

create table sales(
customer_id int not null,
customer_name varchar(20),
product_name varchar(20),
product_category varchar(20),
sold_quantity int,
price decimal(10,2),
sale_date date);

drop table sales;
insert into sales values (1, 'Divya Prakash', 'Dell laptop', 'Electronics', 4, 32000, '2025-01-01'),
						 (2, 'Aditya Prakash', 'Drum', 'Instruments', 6, 12000, '2025-01-04'),
                         (3, 'Satya Prakash', 'Iron Rod', 'Iron', 10, 35000, '2025-01-05'),
                         (4, 'Ritesh KUmar', 'Car', 'Automobile', 1, 320000, '2025-01-01'),
                         (5, 'Raounak Rathore', 'Mobile', 'Electronics', 2, 15000, '2025-01-02');

select *from sales;

-- 1.Find the total quantity of products sold.
select sum(sold_quantity) as total_sold_quantity
from sales;

-- 2.Calculate the total revenue from all sales.
select sum(sold_quantity*price) as total_revenue
from sales;

-- 3.Find the average price of products.
select avg(price) as avg_price 
from sales;

-- 4.Determine the maximum quantity sold in a single transaction.
select max(sold_quantity) as max_quantity
from sales;

-- 5.Find the minimum price of a product.
select min(price) as min_price
from sales;

-- 6.Count the total number of sales records.
select count(*) as total_sale_records
from sales;

-- 7.Count the number of unique customers.
select count(distinct customer_name) as unique_customer
from sales;

-- 8.Calculate the total revenue per category.
select product_category, sum(sold_quantity*price) as category_revenue
from sales
group by product_category;

-- 9.Find the average quantity sold per product.
select product_name, avg(sold_quantity) as avg_quantity
from sales
group by product_name;

-- 10.Identify the most expensive product (highest price).
select product_name, max(price) as expensive_product
from sales
group by product_name
order by expensive_product desc;

-- 11.Calculate the average revenue per sale.
select avg(sold_quantity*price) as avg_revenue
from sales;

-- 12.Count the number of transactions in each category.
select product_category, count(*) as transection 
from sales
group by product_category;

-- 13.Determine the total revenue generated by each customer.
select customer_name, sum(sold_quantity*price) as total_revenue
from sales
group by customer_name
order by total_revenue desc;


-- 14.Find the product with the lowest average price.
select product_name, avg(price) as avg_price
from sales
group by product_name
order by avg_price asc
limit 1;

-- 15.Find the product with the highest average price.
select product_name, avg(price) as avg_price
from sales
group by product_name
order by avg_price desc
limit 1;

-- 16.Calculate the total revenue per month.
select month(sale_date) as sale_month, sum(sold_quantity*price) as total_revenue
from sales
group by month(sale_date);

-- 17. Find the most frequently purchased product.
select product_name, count(*) as purchase_count
from sales
group by product_name
order by purchase_count asc
limit 2;

-- 18.Calculate the maximum revenue generated in a single transaction.
select max(sold_quantity*price) as max_revenue
from sales;

-- 19.Determine the category with the highest total sales.
select product_category, sum(sold_quantity) as total_sales
from sales
group by product_category
order by total_sales desc
limit 1;

-- 20.Find the customer with the highest total revenue.
select customer_name, sum(sold_quantity*price) as total_revenue
from sales
group by customer_name
order by total_revenue desc
limit 2;

-- 21.Identify the day with the highest number of sales.
select sale_date, sum(sold_quantity) as daily_sale
from sales
group by sale_date
order by daily_sale desc
limit 1;

-- 22.Calculate the average revenue per category.
select product_category, avg(sold_quantity*price) as avg_revenue
from sales
group by product_category;

-- 23.Calculate the minimum quantity sold per product.
select product_name, min(sold_quantity) as min_quantity
from sales
group by product_name;

-- 24.Determine the product with the highest total revenue.
select product_name, sum(sold_quantity*price) as highest_revenue
from sales
group by product_name
order by highest_revenue desc
limit 2;

-- 25.Find the average number of transactions per customer.
SELECT AVG(CUSTOMER_TRANSACTION_COUNT) AS AVERAGE_TRANSACTIONS
FROM (
    SELECT CUSTOMER_NAME, COUNT(*) AS CUSTOMER_TRANSACTION_COUNT
    FROM SALES
    GROUP BY CUSTOMER_NAME
) AS CUSTOMER_STATS;
 
-- Having with aggregate function-
select customer_name, count(*) from sales
group by customer_name having count(*) > 0;

