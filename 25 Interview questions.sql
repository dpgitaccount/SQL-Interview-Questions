CREATE DATABASE interviewdata;
USE interviewdata;

CREATE TABLE Emp (
EmpID INT not null Primary Key,
DeptID INT not null,
FirstName VARCHAR(40) not null,
LastName VARCHAR(40) not null,
Gender VARCHAR(20) not null,
Salary INT not null);

CREATE TABLE Department(
DeptID INT primary key not null,
DeptName varchar(40) not null);

INSERT INTO emp VALUES (1, 101, 'Divya' ,'Prakash', 'MALE', 250000 ),
						  (2, 102, 'Aditya' ,'Prakash', 'MALE', 35000 ),
                          (3,103, 'Anjali' ,'Priya', 'FEMALE', 50000 ),
                          (4,104,  'Puja' ,'karn', 'FEMALE', 45000 ),
                          (5,101, 'Rohit' ,'Raj', 'MALE', 20000 ),
                          (6,102, 'Rajan' ,'karn', 'MALE', 35000 ),
                          (7,101, 'Gaurav' ,'Kumar', 'MALE', 15000 ),
                          (8, 102,'ragini' ,'sharma', 'FEMALE', 125000 );

INSERT INTO Department VALUES(101, 'IT'),
							 (102, 'HR'),
                             (103, 'Finance'),
                             (104, 'R&D');
                          
-- QUESTIONS 

-- 1. Retrieve all employees with a salary greater than 50,000
select * from Emp where salary > 50000;

-- 2. Retrieve all employees with a salary less than 50,000
select * from Emp where salary < 50000; 

-- 3. Fetch the names of all employees.
select FirstName, LastName from Emp;

-- 4. Fetch the names of all male employees.
select FirstName, LastName from Emp where Gender = 'MALE';

-- 5. Fetch the names of all Female employees.
select FirstName, LastName from Emp where Gender = 'Female';

-- 6. Find the average salary of all employees
select AVG(Salary) as avg_salary from EMp;

-- 7. Find the average salary of Male employees
select AVG(Salary) as avg_salary_of_male from Emp where Gender = 'MALE';

-- 8. Find the average salary of Female employees
select AVG(Salary) as avg_salary_of_Female from Emp where Gender = 'FEMALE';

-- 9. Get the count of employees in each department
select DeptID, count(*) as employee_count from Emp group by DeptID;

-- 10. Get the count of Male employees in each department
select DeptID, count(*) as male_employee_count from Emp where Gender = 'Male' group by DeptID;

-- 11. Get the count of Male employees in each department
select DeptID, count(*) as female_employee_count from Emp where Gender = 'Female' group by DeptID;

-- 12. List the highest salary in the organization
select max(salary) as highest_salary from Emp;

-- 13. List the highest Female salary in the organization
select MAx(salary) as female_highest_salary  from Emp where Gender = "Female";

-- 14. List the highest male salary in the organization
select max(Salary) as male_highest_salry from Emp where Gender = 'Male';

-- 15. List the highest 2nd, 3rd and nth salary employee name in the organization


-- 16. Find employees who belong to the HR department.
select e.*
from Emp e
join Department d on e.DeptID = d.DeptID
where d.DeptName = 'HR';

-- 17. Find employees who belong to the IT department.
select e.*
from Emp e
join Department d on e.DeptID = d.DeptID
where d.DeptName = 'IT';

-- 18. Get the details of the department with the most employees
select d.DeptName, count(e.EmpID) as total_employee
from Department d
join Emp e on d.DeptID = e.DeptID
group by d.DeptName
Order by total_employee desc
limit 1;

-- 19. Fetch employees whose last name starts with 'D'.
select * from Emp where LastName like 'P%';

-- 20. Find employees earning the lowest salary in their respective departments.
select min(salary) as lowest_salary
from Emp
group by DeptID;

SELECT 
    e.DeptID, 
    e.FirstName AS employeeName, 
    e.salary AS lowest_salary
FROM 
    Emp e
WHERE 
    e.salary = (
        SELECT MIN(salary)
        FROM Emp
        WHERE DeptID = e.DeptID
    );
    
-- 21. List employees who do not belong to the IT department.
select * from Emp where DeptID != 101;

-- 22. Calculate the total salary paid by each department.
select DeptID, sum(salary) as total_salary from Emp group by DeptID;

-- 23. List employees who earn more than the average salary.
select * from Emp
where Salary > (select avg(Salary) from Emp);

-- 24. Find duplicate salaries (if any).
select salary, count(*) as count
from Emp 
group by salary 
having count(*) > 1;

-- 25. Get employees who have 'e' in their first name.
select * from Emp where FirstName Like 'an%';

-- 26. Fetch the department names along with the count of employees earning more than 50,000.
select d.DeptName, count(e.EmpID) as count_high_salary
from Department d
join Emp e on d.DeptID = e.DeptID
where e.Salary > 50000
group by d.DeptName;

-- 27. Retrieve all female employees sorted by their salary in descending order.
select * from Emp where Gender = 'FEMALE' order by Salary desc;

-- 28. Delete employees who have a salary below 30,000.
delete from Emp where Salary < 30000;

Select * from Emp;

-- 29. Add a new employee to the Employees table.
INSERT INTO Emp VALUES (5, 101, 'Gaurav', 'Kumar', 'MALE', 15000),
                       (7, 102, 'Ram', 'Kumar', 'Male' , 14000);
select * from Emp;

-- 30. Update the salary of employees in the IT department by 10%.
Update Emp 
SET Salary = Salary * 1.1
where DeptID = 101;

select * from Emp;

-- 31. Retrieve employees whose salary is between 45,000 and 60,000.
select * from Emp where Salary between 45000 and 60000;

-- 32. Find departments with no employees.
select d.DeptName
from Department d
left join Emp e on d.DeptID = e.DeptID
where e.EmpID IS NULL;

-- 33. Fetch employees grouped by gender and their respective average salaries.
select Gender, AVG(Salary) as avg_salary from Emp group by Gender;

-- 34.List all departments along with the number of employees, including departments with no employees.
SELECT d.DeptName, COUNT(e.EmpID) AS employee_count
FROM Department d
LEFT JOIN Emp e ON d.DeptID = e.DeptID
GROUP BY d.DeptName;

-- 35. Find the name and department of the employee with the highest salary.
select e.FirstName, e.lastName, d.DeptName
from Emp e 
join Department d on e.DeptID = d.DeptID
where e.Salary = (select max(Salary) from Emp);

