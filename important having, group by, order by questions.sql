CREATE DATABASE SalesDB;

CREATE TABLE sales(
sale_id int,
product_id int,
category_id int,
sale_amount decimal(10,2),
sale_date date,
customer_id int );

INSERT INTO sales VALUES (1, 11, 111, 120000.00, '2024-11-01', 01),
                         (2, 12, 112, 100000.00, '2024-11-02', 02),
                         (3, 13, 113, 150000.00, '2024-11-03', 03),
                         (4, 14, 114, 113000.00, '2024-11-04', 04),
                         (5, 15, 115, 130000.00, '2024-11-05', 05),
                         (6, 16, 116, 160000.00, '2024-11-06', 06),
                         (7, 17, 117, 120000.00, '2024-11-07', 07);
					
select * from sales;

-- 10 GROUP BY QUESTIONS

-- 1.Q: Write a query to find the total sales amount for each product.
select product_id, sum(sale_amount) as total_amount
from sales
group by product_id;

-- 2.Q: How do you calculate the number of sales per category?
select category_id, count(sale_id) as sale_count
from sales
group by category_id;

-- 3.Q: Find the average sale amount for each customer.
select customer_id, avg(sale_id) as avg_sale
from sales
group by customer_id;

-- 4.Q: Write a query to group sales by month and find the total sales for each month.
select month(sale_date) as sale_month, sum(sale_amount) as total_sales
from sales
group by month(sale_date);

-- 5.Q: Calculate the maximum sale amount per product.
select product_id, max(sale_amount) as max_sale
from sales
group by product_id;

-- 6.Q: How can you find the minimum sale amount for each category?
select category_id, min(sale_amount) as min_amount
from sales
group by category_id;

-- 7.Q: Group sales by year and find the number of sales per year.
select year(sale_date) as sale_year, count(sale_id) as sale_per_year
from sales
group by year(sale_date);

-- 8.Q: Write a query to find the total sales for each product and order by the product ID.
select product_id, sum(sale_amount) as total_sales
from sales
group by product_id
order by product_id;

-- 9.Q: Can you find the distinct number of customers who made purchases in each category?
select category_id, count(distinct customer_id) as unique_customer
from sales
group by category_id;

-- 10.Q: Calculate the average sale amount for each product, and rename the column as avg_sales.\
select product_id, avg(sale_amount) as avg_sale
from sales
group by product_id;


-- 10 ORDER BY QUESTION

-- 1.Q: Write a query to sort the sales by sale_amount in ascending and descending order.
select * from sales
order by sale_amount ASC;

select *from sales
order by sale_amount desc;

-- 2. Q: How can you sort sales by sale_date in descending order?
select * from sales
order by sale_date desc;

-- 3.Q: Find the top 5 highest sales amounts.
select * from sales
order by sale_amount desc
limit 5;

-- 4.Q: Write a query to sort by category_id first, then by sale_amount in descending order.
select * from sales
order by category_id asc, sale_amount desc;

-- 5.Q: Sort the sales by customer_id in ascending order and display the top 6 results.
select * from sales
order by customer_id asc
limit 6;

-- 6. Q: Sort the products by their total sales amount in descending order.
select product_id, sum(sale_amount) as total_sale
from sales
group by product_id
order by total_sale desc;

-- 7.Q: Write a query to sort sales by the year of sale_date in ascending order.
select * from sales
order by(sale_date) asc;

-- 8.Q: How do you sort sales within each category by sale_amount in ascending order?
select * from sales
order by category_id asc, sale_amount asc;

-- 9.Q: Sort the customers based on their average sale amount in descending order.
select customer_id, avg(sale_amount) as avg_sale
from sales
group by customer_id
order by avg_sale desc;

-- 10.Q: Find the minimum sale amount per category and order the results by category in descending order.
select category_id, min(sale_amount) as min_sale
from sales
group by category_id
order by category_id;


-- 10 HAVING QUESTIONS

-- 1.Q: Find products with total sales greater than 50,000.
select product_id, sum(sale_amount) as total_sale
from sales
group by product_id
having sum(sale_amount) > 50000;

-- 2.Q: Write a query to list categories where the number of sales exceeds 5.
select category_id, count(sale_id) as sale_count
from sales
group by category_id
having count(sale_id) > 5;

-- 3.Q: How can you find customers whose average sale amount is above 125000?
select customer_id, avg(sale_amount) as avg_sale
from sales
group by customer_id
having avg(sale_amount) > 125000;

-- 4.Q: List months where total sales are less than 120000
select month(sale_date) as sale_month, sum(sale_amount) as total_sale
from sales
group by month(sale_date)
having sum(sale_amount) < 120000;

-- 5.Q: Find the categories with at least 7 unique customers.
select category_id, count(distinct customer_id) as unique_customer
from sales
group by category_id
having count(distinct customer_id) >= 0;

-- 6. Q: Write a query to filter products with maximum sales amount above 1,00000.
select product_id, max(sale_amount) as max_sale
from sales
group by product_id
having max(sale_amount) > 100000;

-- 7.Q: Find customers whose total purchase amount exceeds 120000.
select customer_id, sum(sale_amount) as total_sale
from sales
group by customer_id
having sum(sale_amount) > 120000;

-- 8.Q: How do you list categories where the average sale amount is between 50000 and 120000?
select category_id, avg(sale_amount) as avg_sale
from sales
group by category_id
having avg(sale_amount) between 50000 and 120000;

-- 9.Q: Find products with total sales greater than 1,00000, sorted by their total sales.
select product_id, sum(sale_amount) as total_sale
from sales
group by product_id
having sum(sale_amount) > 100000
order by total_sale desc;

-- 10.Q: Filter customers who made purchases in at least 0 different categories.
select customer_id, count(distinct category_id) as category_count
from sales
group by customer_id
having count(distinct category_id) >= 0;
