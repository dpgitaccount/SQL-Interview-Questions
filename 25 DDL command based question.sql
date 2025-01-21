USE CompanyDB;

-- 1.how do you create a employees table
CREATE TABLE emp(
EmpID INT primary key not null,
Name varchar(40) not null,
Department varchar(40) not null,
Salary int not null,
Joindate date);

INSERT INTO emp Values
(1001, 'Divya Prakash', 'IT', 30000, '2024-12-20'),
(1002, 'Rohit', 'Sport', 50000, '2024-02-20'),
(1003, 'Anjali Priya', 'Account', 25000, '2025-01-02'),
(1004, 'Aditya Karn', 'Teaching', 55000, '2025-04-02'),
(1005, 'Satya Prakash', 'Marketing', 25000, '2020-01-02'),
(1006, 'Ashish Jangra', 'IT', 120000, '2021-08-01'),
(1007, 'Shahil', 'IT', 12000, '2024-05-05');

select * from emp;

-- 2.How do you modify the Employees table to add a new column Email?
alter table emp add age int;

-- 3. How do you remove the Email column from the Employees table?
alter table emp drop column age;

-- 4. How do you rename the Employees table to EmployeeDetails?
-- rename table emp to empdetails;

-- 5. How do you change the data type of the Salary column to DECIMAL(10, 2)? 
alter table emp modify salary decimal(10,2);
select * from emp;

-- 6. How do you add a default value of 'IT' to the Department column?
-- alter table emp alter column Department set default  'IT';

-- 7. How do you remove the default value from the Department column?
select * from emp;

-- 8. How do you drop the Employees table?
-- drop table emp; 

-- 9. How do you create a unique constraint on the Name column?
alter table emp add constraint uniqueName unique(name);
select * from emp;

-- 10. How do you drop the unique constraint on the Name column?
alter table emp drop index uniqueName;

-- 13. How do you create a composite primary key using EmployeeID and
create table emp1(
  EmpID int,
  Department varchar(30),
  Name varchar(30),
  Salary int,
  JoinDate date,
  primary key (EmpID, Department) );
  
  -- 14. How do you add a foreign key ManagerID referencing another table Managers?
  alter table emp add managerID int,
  add constraint fk_manager foreign key(managerID) references manegers(managerID);
  
  -- 15. How do you drop the foreign key constraint FK_Manager?
  alter table emp drop foreign key fk_manager;
  
  
  -- 16. How do you rename the column Name to EmployeeName?
  alter table emp change name empname varchar(20);
  
  -- 17. How do you clone the structure of the Employees table without data?
  create table employeeclone like emp;
  
  -- 18. How do you create an index on the Department column?
  create index indexDepartment on emp(Department);
  
  -- 19. How do you drop the index IndexDepartment?
  drop index indexDepartment on emp;
  
  -- 20. How do you create a temporary table TempEmployees with the same structure?
  create temporary table tableemp like emp;
  
  -- 21. How do you add a check constraint to ensure Salary is greater than 10000?
  alter table emp add constraint checksalary check(Salary > 10000);
  
  -- 22. How do you drop the check constraint CheckSalary?
  alter table emp drop checksalary;
  
  -- 23. How do you truncate the Employees table to delete all rows?
  truncate table emp;
  
  -- 24. How do you create a table ArchivedEmployees with only the Name and Salary columns?
  create table archivedemp as 
  select Name, Salary
  from emp 
  where 1 = 0;
  
  -- 25. How do you alter the Employees table to make the JoinDate column nullable?
  alter table emp modify joindate date null;
  