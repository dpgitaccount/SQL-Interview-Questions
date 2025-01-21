CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE employees (
EmployeeID int primary key not null,
Name VARCHAR(40) not null,
Department VARCHAR(40) not null,
Salary INT not null,
JoinDate date );

INSERT INTO Employees VALUES 
(101, 'Divya Prakash', 'IT', 30000, '2024-12-20'),
(102, 'Rohit', 'Sport', 50000, '2024-02-20'),
(103, 'Anjali Priya', 'Account', 25000, '2025-01-02'),
(104, 'Shahil', 'IT', 12000, '2024-05-05');
SELECT * FROM employees;


-- Find the 3rd highest salary in the Employees table.
select distinct Salary
from employees
Order by Salary DESC
limit 1 offset 2;

-- Find the 3rd lowest salary in the Employees table.
SELECT Salary
FROM (
    SELECT DISTINCT Salary
    FROM employees
    ORDER BY Salary DESC
) AS DistinctSalaries
LIMIT 1 OFFSET 2;
select * from employees;

-- Fetch the details of employees earning the highest salary in their department.
select Department, Name, Salary
from employees e1
where Salary = (
                select max(Salary)
                from employees e2
                where e1.Department = e2.Department
                );
                
                
-- Find the total number of employees in each department.
select Department, count(*) as employee_count
from employees
group by Department;

-- Find employees who joined before the year 2024.
select* from employees
where JoinDate < '2025-01-01';

-- Find employees who joined after the year 2024.
select * from employees
where JoinDate > '2024-12-02';

-- Find employees whose salary is above the average salary in the company.
select * from employees
where Salary > (select avg(Salary) from employees);

-- find the average salary of the department
select Department, avg(Salary) as avg_salary
from employees
group by Department;

-- Retrieve the department with the highest average salary.
select Department
from employees 
group by Department
order by avg(Salary);
-- limit 2;

-- Fetch the names of employees earning salaries within the top 10% in the company.



-- Find employees who do not belong to the 'IT' department but have a salary greater than 30,000.
select * from employees
where Department != 'IT' and Salary > 30000;

-- List the names of employees with the same salary as any other employee in the company.
select e1.Name, e1.Salary
from employees e1
Join employees e2 on e1.Salary = e2.Salary and e1.EmployeeID != e2.EmployeeID;

-- Find the total salary expense for each department.
select Department, sum(Salary) as total_salary
from employees
group by Department;

-- Fetch details of employees who joined in the last 2 years.
select * from employees
where JoinDate >= date_add(curdate(), interval -2 year);

-- List employees whose names start with 'A'.
select * from employees
where Name like 'A%';

-- Identify departments where the total salary expense exceeds 40000.
select Department
from employees
group by Department
having sum(Salary) > 40000;







