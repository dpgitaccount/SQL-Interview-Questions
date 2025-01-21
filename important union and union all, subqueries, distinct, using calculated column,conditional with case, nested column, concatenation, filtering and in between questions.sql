use companydb;

create table sales (
sale_id int not null,
product_id int not null,
category_id int not null,
sale_amount decimal(10, 2),
sale_date date,
customer_id int);

drop table sales;
INSERT INTO sales VALUES (1, 11, 111, 120000.00, '2024-11-01', 01),
                         (2, 12, 112, 100000.00, '2024-11-02', 02),
                         (3, 13, 113, 150000.00, '2024-11-03', 03),
                         (4, 14, 114, 113000.00, '2024-11-04', 04),
                         (5, 15, 115, 130000.00, '2024-11-05', 05),
                         (6, 16, 116, 160000.00, '2024-11-06', 06),
                         (7, 17, 117, 120000.00, '2024-11-07', 07),
                         (8, 18, 118, 113000.00, '2024-11-07', 08),
                         (9, 19, 119, 120000.00, '2024-11-07', 09),
                         (10, 20, 200, 130000.00, '2024-11-07', 10);
select * from sales;

drop table archived_sales;
create table archived_sales like sales;

insert into archived_sales values (1, 11, 111, 120000.00, '2024-11-01', 01),
                                  (2, 12, 112, 100000.00, '2024-11-02', 02),
                                  (3, 13, 113, 150000.00, '2024-11-03', 03),
                                  (4, 14, 114, 113000.00, '2024-11-04', 04),
                                  (5, 15, 115, 130000.00, '2024-11-05', 05),
                                  (6, 16, 116, 160000.00, '2024-11-06', 06),
                                  (7, 17, 117, 120000.00, '2024-11-07', 07),
                                  (8, 18, 118, 113000.00, '2024-11-07', 08),
                                  (9, 19, 119, 120000.00, '2024-11-07', 09),
								  (10, 20, 200, 130000.00, '2024-11-07', 10);
select * from archived_sales;

-- UNION AND UNION ALL QUESTIONS

-- 1.Combine sales data with another table called archived_sales.
select * from sales
union
select * from archived_sales;

-- 2.Use UNION ALL to include duplicates.
select * from sales
union all
select * from archived_sales;

-- 3.Select distinct product IDs from both tables.
select product_id from sales 
union
select product_id from archived_sales;

-- 4.Combine sales from both tables only for category 101.
select * from sales where category_id = 101
union
select * from archived_sales where category_id = 101;

-- 5.How do you find all customers from both tables?
select customer_id from sales
union
select customer_id from archived_sales;

-- 6.Combine sales data but include a flag to identify the source.
select sale_id, 'current' as source from sales
union all
select sale_id, 'archived' as source from archived_sales;

-- 7.Combine product IDs but sort the result.
select product_id from sales
union
select product_id from archived_sales
order by product_id; 

-- 8.Filter combined sales data by a date range.
select * from sales where sale_date between '2024-01-01' and '2024-12-31'
union
select * from archived_sales where sale_date between '2024-01-01' and '2024-12-31'; 

-- 9.Combine data and limit results to 5 rows.
select * from sales
union 
select * from archived_sales
limit 5;

-- 10. Select all sales IDs but remove duplicates.
select sale_id from sales
union all
select sale_id from archived_sales;

-- SUBQUERIES QUESTIONS

-- 1. Find sales with amounts greater than the average sale amount.
select * from sales
where sale_amount > (select avg(sale_amount ) from sales);

-- 2.List products sold in a specific category using a subquery.
select product_id from sales
where category_id = (select category_id from sales where product_id = 101);

-- 3.Find the maximum sale amount in each category.
select category_id from sales s1
where sale_amount = (select max(sale_amount) as max_sale from sales s2 where s1.category_id = s2.category_id);

-- 4.How do you list customers who made more than one purchase?
select customer_id from sales 
where customer_id in (select customer_id from sales group by customer_id having count(*) >1 );

-- 5.Find products with no sales using a subquery.
select product_id from sales
where product_id not in (select product_id from sales);

-- 6.List all categories with total sales exceeding 12,0000.
select category_id from sales
where category_id in (select category_id from sales group by category_id having sum(sale_amount) > 120000);

-- 7.Find the second-highest sale amount.
select max(sale_amount) from sales
where sale_amount < (select max(sale_amount) from sales);

-- 8.Retrieve customer IDs who purchased products from category 101.
select distinct customer_id from sales
where customer_id in (select customer_id from archived_sales where category_id = 101);

-- 9.List customers whose total purchases exceed their average sale amount.
select customer_id from sales
where sum(sale_amount) > (select avg(sale_amount) from sales);

-- 10.Find the most recent sale for each customer.
select * from sales
where sale_date = (select max(sale_date) from sales);


-- DISTINCT FUNCTION--

-- 1.Find distinct product IDs from the sales table.
select distinct product_id from sales;

-- 2.List distinct customer IDs who made a purchase.
select distinct customer_id from sales;

-- 3.Retrieve unique combinations of category and product IDs.
select distinct category_id, product_id from sales;

-- 4.Count the number of distinct customers.
select count(distinct customer_id) as unique_customer from sales;

-- 5.How do you find distinct months from the sale dates?
select distinct month(sale_date) as sale_month from sales;

-- 6.Get the total number of distinct products sold.
select count(distinct product_id) as total_unique_product from sales;

-- 7.Find all unique categories.
select distinct category_id from sales;

-- 8.List distinct sale amounts in descending order.
select distinct sale_amount from sales
order by sale_amount desc;

-- 9.Retrieve distinct years from the sale date column.
select distinct year(sale_date) as sale_date from sales;

-- 10.Get distinct customer IDs who purchased a specific product.
select distinct customer_id from sales where product_id = 101;


-- USING CALCULATED COLUMNS QUESTIONS --

-- 1.Calculate the total revenue for each sale.
select sale_id, sale_amount * 1.18 as total_revenue from sales;

-- 2.Add a column for sale year.
select sale_id, year(sale_date) as sale_year from sales;

-- 3.Calculate the profit assuming 20% margin.
select sale_id, sale_amount * 0.2 as Profit from sales;

-- 4.Create a full customer summary.
select customer_id, 
	   count(*) as total_purchase, 
		sum(sale_amount) as total_spent 
from sales
group by customer_id;

-- 5.Add a column for discounted sales.
select sale_id, sale_amount * 0.9 as discoounted_price from sales;

-- 6.Show sale month and quarter.
select sale_id, month(sale_date) as sale_month, 
               quarter(sale_date) as quarter_sale 
from sales;

-- 7.Add an age column to the customer table.
select customer_id, year(current_date) - year(birth_date) as age from sales;

-- 8.Calculate sales tax for each transaction.
select sale_date, sale_amount * 0.08 as tax from sales;

-- 9.Create a column for sale amount in thousands.
select sale_id, sale_amount / 1000 as sale_amount_in_k from sales;

-- 10.Show sales categorized by high and low amounts.
select sale_id, sale_amount,
	   case when sale_amount > 120000 then 'high'
	   else 'low' end as sales_category 
from sales;


-- CONDITIONAL COLUMN WITH CASE STATEMENTS --

-- 1.Add a column that labels sales as 'High' if the amount is above 120000, otherwise 'Low'.
select sale_id, sale_amount,
	   case
          when sale_amount > 120000 then 'high'
          else 'low'
	   end as sale_label
from sales;

-- 2.Categorize sales into 'Small', 'Medium', and 'Large' based on amount.
select sale_id, sale_amount,
	   case
          when sale_amount < 120000 then 'small'
          when sale_amount between 100000 and 120000 then 'medium'
          else 'large'
	   end as sale_category
from sales;
          
-- 3.Add a column to flag weekend sales.
select sale_id , sale_amount,
       case
          when weekday(sale_date) in (5, 6) then 'weekend'
          else 'weekday'
	   end as sale_day
from sales;

-- 4.Mark sales as 'New' if the year is the current year.
select sale_id, sale_amount,
       case
          when year(sale_date) = year(curdate()) then 'new'
          else 'old'
		end as sale_status
from sales;

-- 5. Add a column for tax category based on sale amount.
select sale_id, sale_amount,
       case 
          when sale_amount < 100000 then 'low_tax'
          when sale_amount <= 120000 then 'medium_tax'
          else 'high_tax'
	   end as tax_category
from sales;
       
-- 6. Flag sales above the average sale amount.
select sale_id, sale_amount,
       case
          when sale_amount > (select avg(sale_amount) from sales) then 'above_average'
          else 'below_average'
	   end as comparision
from sales;

-- 7.Add a column showing if a sale is eligible for a discount.
select sale_id, sale_amount,
	   case 
           when sale_amount > 100000 then 'eligible_for_discount'
           else 'not_eligible_for_discount'
		end as discount_aligibility
from sales;

-- 8.Add a region label based on category ID.
select sale_id, category_id,
       case 
          when category_id in (111, 112, 113) then 'north'
          when category_id in (115, 116) then 'south'
          else 'other'
		end as region
from sales;

-- 9.Label sales by quarter.
select sale_id, sale_date,
	   case
          when month(sale_date) in (1,2,3,4) then 'Q1'
          when month(sale_date) in (5,6,7,8) then 'Q2'
          when month(sale_date) in (9,10,11,12) then 'Q3'
		  else '4'
		end as quarter
from sales;

-- 10.Add a 'Loyal Customer' flag for customers with more than 5 purchases.
select customer_id,
       case
          when (select count(*) from sales where sales.customer_id = s.customer_id) > 2 then 'loyal'
          else 'occasional'
	   end as loyalty_status
from (select distinct customer_id from sales) as s;


-- Concatenation Function Questions --

-- 1.Combine sale ID and category ID into a single column.
select concat(sale_id,'-',category_id) as combined_id 
from sales;

-- 2.Display customer details with "CustomerID: X".
select concat('customer_id:', customer_id) as customer_details
from sales;

-- 3.Create a summary string with sale details.
select concat('sale', sale_id, ': ', sale_amount, ' on ', sale_date) as sale_summery
from sales;


-- Filtering Function Questions --

-- 1.Filter sales where sale amount is greater than 500.
SELECT * FROM sales WHERE sale_amount > 120000;

-- 2.Retrieve sales from the last 30 days.
SELECT * FROM sales WHERE sale_date > DATE_SUB(CURDATE(), INTERVAL 15 DAY);




