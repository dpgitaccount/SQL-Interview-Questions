use CompanyDB;

CREATE TABLE emp(
EmpID INT primary key not null,
Name varchar(40) not null,
Department varchar(40) not null,
Salary int not null,
Joindate date);

-- 1. Insert multiple rows into the Employees table.
INSERT INTO emp Values
(10001, 'Divya Prakash', 'IT', 30000, '2024-12-20'),
(10002, 'Rohit', 'Sport', 50000, '2024-02-20'),
(10003, 'Anjali Priya', 'Account', 25000, '2025-01-02'),
(10004, 'Aditya Karn', 'Teaching', 55000, '2025-04-02'),
(10005, 'Satya Prakash', 'Marketing', 25000, '2020-01-02'),
(10006, 'Ashish Jangra', 'IT', 120000, '2021-08-01'),
(10007, 'Shahil', 'IT', 12000, '2024-05-05');


-- 2. Insert a new row into the Employees table.
insert into emp (EmpID, Name, Department, Salary, JoinDate)
		  values(10008, 'Kohli', 'Sport', 100000, '2008-08-24');
select* from emp;

-- 3. Update the salary of an employee with EmployeeID = 10001.
update emp 
set Salary = 40000
where EmpID = 10001;

-- 4. Update the department of employees in the IT department to Technology.
update emp
set Department = 'Technology'
where Department = 'IT';

-- 5. Delete an employee with EmployeeID = 10006.
delete from emp 
where EmpID = 10006;

-- 6. Delete all employees with a salary less than 20000.
delete from emp
where Salary < 20000;

-- 7. Select all employees in the IT department.
select * from emp 
where Department = 'Technology';

-- 8. Select employees with a salary between 25000 and 45000.
select * from emp
where Salary between 25000 and 45000;

-- 9. Select employees who joined after January 1, 2024.
select * from emp
where Joindate > '2024-01-01';

-- 10. Find employees whose names start with 'A'.
select * from emp
where Name like 'A%';

-- 11. Select unique departments from the Employees table.
select distinct Department
from emp;

-- 12. Count the total number of employees.
select count(*) as total_employee
from  emp;

-- 13. Find the average salary of employees.
select avg(Salary) as avgsalary
from emp;

-- 14. Find the total salary of all employees.
select sum(Salary) as total_salary
from emp;

-- 15. Find the maximum salary in the Employees table.
select max(Salary) as max_salary
from emp;

-- 16. Find the minimum salary in the Employees table.
select min(Salary) as min_salary
from emp;

-- 17. Select employees grouped by their department and count them.
select Department, count(*) as employee_count
from emp
group by Department;


-- 18. Select departments where the average salary is greater than 30000.
select Department, avg(Salary) as avg_salary
from emp 
group by Department
having avg(Salary) > 30000;

-- 19. Select employees ordered by their salary in descending order.
select * from emp
order by Salary desc;

-- 20. Find employees who do not belong to the IT department.
select * from emp 
where Department != 'Technology';

-- 21. Find the second-highest salary in the Employees table.
select max(Salary) as second_highest_salary
from emp
where Salary < (select max(Salary) from emp);

-- 22. Insert data into the Employees table using a SELECT query from another table.
insert into emp (EmpID, Name, Department, Salary, JoinDate)
select EmpID, Name, Department, Salary, Joindate
from oldemp
where Salary > 30000;

-- 23. Increase the salary of all employees by 10%.
update emp
set Salary = Salary * 1.10;

-- 24. Delete all rows from the Employees table without dropping the table.
delete from emp;

-- 25. Find employees with salaries in the top 3 highest salaries.
select * from emp
order by Salary desc
limit 3;





select* from emp;
