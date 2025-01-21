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

select * from sales;


-- 1.alterRetrieve all employees whose customer names start with 'A'.
select * from sales
where customer_name like 'A%';

-- 2. Find all products with 'Electronics' anywhere in their names.
select * from sales
where product_category like '%Electronics%';

-- 3. Retrieve all customers whose names end with 'ash'.
select * from sales
where customer_name like '%ash';

-- 4. Fetch all users with a username of exactly 6 characters.
select * from sales
where customer_name like '_____________';


-- 5. Fetch all product category containing 'automobile'.
select * from sales
where product_category like '%automobile%';


-- 6.Find all products with a name that contains both 'a' and 'e'.
select * from sales
where product_name like '%a%p%' or product_name like '%p%a%';

-- 7.Find all price not starting with '1'.
select * from sales
where price not like '1%';

-- 8. Fetch all products with a name starting with either 'A' or 'D'.
select * from sales
where product_name like '[A]%';

-- 9.Find all customer names containing 1 consecutive vowels.
select * from sales
where customer_name REGEXP '[aeiou] {1}';

-- 10.Retrieve all products that contain the word 'Electronics' regardless of case.
select * from sales
where product_name like '%Electronics%';

-- 11.Retrieve all records where the customer id starts with '1'.
select * from sales
where customer_id like '1%';