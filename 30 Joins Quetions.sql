create database InterviewJoins;
use InterviewJoins;

create table Departments(
     DeptID int primary key,
     DeptName varchar(50)
     );
  -- drop table departments;   

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    ManagerID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);


CREATE TABLE Projects (
    ProjID INT PRIMARY KEY,
    ProjName VARCHAR(50),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);


CREATE TABLE Salaries (
    EmpID INT,
    Salary INT,
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);


-- Insert Data
INSERT INTO Departments VALUES 
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO Employees VALUES 
(101, 'Alice', 1, NULL),
(102, 'Bob', 2, 101),
(103, 'Charlie', 3, 102),
(104, 'Daisy', 4, 101),
(105, 'Eve', NULL, 103);

INSERT INTO Projects VALUES 
(201, 'Recruitment System', 1),
(202, 'E-commerce Website', 2),
(203, 'Budget Tracker', 3),
(204, 'SEO Optimization', 4);

INSERT INTO Salaries VALUES 
(101, 70000),
(102, 80000),
(103, 75000),
(104, 65000),
(105, 60000);

select * from salaries;

                                      -- BASIC & INTERMEDIATE SQL JOINS QUESTIONS --
-- 1. Basic INNER JOIN
-- Q: Retrieve employees and their department names.
select EmpName, DeptName
from Employees
inner join Departments on Employees.DeptID = Departments.DeptID;

-- 2. INNER JOIN with WHERE Clause
-- Q: Find employees who work in the IT department.
select EmpName, DeptName
from Employees
inner join Departments on Employees.DeptID = Departments.DeptID
where DeptName = 'IT';


-- 3. LEFT JOIN
-- Q: Retrieve all employees and their department names, including employees with no department.
select EmpName, EmpID
from Employees
left join Departments on Employees.DeptID = Departments.DeptID;

-- 4. RIGHT JOIN
-- Q: Retrieve all departments and their employees, including departments with no employees.
select EmpName, DeptName
from Employees
right join Departments on Employees.DeptID = Departments.DeptID;


-- 5. FULL OUTER JOIN
-- Q: Retrieve all employees and departments, even if there’s no match.
select DeptName,EmpName
from Employees
full join Departments on Employees.DeptID = Departments.DeptID; 


-- CROSS JOIN
-- 6.Show all possible combinations of employees and projects.
select EmpName, ProjName
from Employees
cross join Projects;

-- 7. Self JOIN
-- Q: Retrieve employees and their managers.
Select E1.EmpName as Employees, E2.EmpName as Manager
from Employees E1
left join Employees E2 on E1.ManagerID = E2.EmpID;


-- 8. INNER JOIN with Aggregation
-- Q: Find the total salary for each department.
select DeptName, sum(Salary) as Total_salaries
from Employees
inner join Salaries on Employees.EmpID = Salaries.EmpID
inner join Departments on Employees.DeptID = Departments.DeptID
group by DeptName;

-- 9. Filter LEFT JOIN Results
-- Q: Retrieve employees without a department.
select EmpName
from Employees
left join Departments on Employees.DeptID = Departments.DeptID
where Departments.DeptID is null;


-- 10.RIGHT JOIN with Aggregation
-- Q: Count employees in each department.
select DeptName, count(EmpID) as employee_count
from Employees
right join Departments on Employees.DeptID = Departments.DeptID
group by DeptName;


-- 11. FULL OUTER JOIN Filtering
-- Q: List unmatched employees and departments.
select EmpName, DeptName
from Employees
full outer join Departments on Employees.DeptID = Departments.DeptID
where Employees.DeptID is null or Departments.DeptID is null;


-- 12. Combine INNER JOIN with SELF JOIN
-- Q: List employees with their managers and their department.
select E1.EmpName as Employee, E2.EmpName as Manager, D.DeptName
from Employees E1
Left Join Employees E2 on E1.ManagerID = E2.EmpID
Inner Join Departments D on E1.DeptID = D.DeptID;

-- 13. INNER JOIN with Multiple Tables
-- Q: Retrieve employee names, their salaries, and department names.
select EmpName, Salary, DeptName
from Employees
Inner Join Salaries on Employees.EmpID = Salaries.EmpID
Inner Join Departments on Employees.DeptID = Departments.DeptID;

-- 14. Nested Joins
-- Q: List projects and the employees working in their departments.
select ProjName, EmpName
from Projects
Inner Join Departments on Projects.DeptID = Departments.DeptID
Inner Join Employees on Departments.DeptID = Employees.DeptID;

-- 15. LEFT JOIN with ISNULL
-- Q: Replace NULL department names with 'Unassigned'.
select EmpName, ifnull(DeptName, 'Unassigned') as Department
from Employees
left join Departments on Employees.DeptID = Departments.DeptID;


-- 16. CROSS JOIN with Condition
-- Q: Show combinations of employees and projects only for the IT department.
select EMpName, ProjName
from Employees
cross join Projects
where Employees.DeptID = 2 and Projects.DeptID = 2;

-- 17. Joining Subqueries
-- Q: Find employees earning more than the department average salary.
SELECT E.EmpName, S.Salary
FROM Employees E
INNER JOIN Salaries S ON E.EmpID = S.EmpID
WHERE S.Salary > (
    SELECT COALESCE(AVG(S1.Salary), 0)
    FROM Salaries S1
    INNER JOIN Employees E1 ON S1.EmpID = E1.EmpID
    WHERE E1.DeptID = E.DeptID
);


-- 18. Self JOIN to Find Peers
-- Q: List employees working in the same department.
select E1.EmpName as Employee1, E2.EmpName as Employee2
from Employees E1
Inner Join Employees E2 on E1.DeptID = E2.DeptID
Where E1.EmpID =  E2.EmpID;

-- 19. Joining on Derived Tables
-- Q: Retrieve the highest-paid employee in each department.
select D.DeptName, E.EmpName, S.Salary
from Departments D
Inner Join Employees E on D.DeptID = E.DeptID
Inner Join Salaries S on E.EmpId = S.EmpID
where S.Salary = (
	  select max(Salary)
      from Salaries S1
      inner join Employees E1 on S1.EmpID = E1.EmpID
      where E1.DeptID = D.DeptID
                 );
      
                                        -- ADVANCED LEVEL JOINS QUESTIONS --
-- 20. Employees Without Managers
-- Q: List employees who do not have a manager assigned.
select Employees.EmpName
from Employees
Left Join Employees M on Employees.ManagerId = M.EmpID
where M.EmpID is null;


-- 22. Employees Working on Specific Project Department
-- Q: Find employees working in departments that are managing the project "Budget Tracker."
select EmpName
from Employees
Inner Join Departments on Employees.DeptID = Departments.DeptID
Inner Join Projects on Departments.DeptID = Projects.DeptID
where Projects.ProjName = 'Budget Tracker';


-- 23. Count Projects by Department
-- Q: Count the number of projects assigned to each department.
select DeptName, count(ProjID) as ProjectCount
from Departments
Left Join Projects on Departments.DeptID = Projects.DeptID
group by DeptName;


-- 24. Employees Without Salaries
-- Q: List employees who do not have salary records.
select EmpName
from Employees
Left Join Salaries on Employees.EmpID = Salaries.EmpID
where Salaries.EmpID is null;


-- 25. Department with the Highest Average Salary
-- Q: Find the department with the highest average salary.
select DeptName, Avg(Salary) as Avg_Salary
from Departments
Inner Join Employees on Departments.DeptID = Employees.DeptID
Inner Join Salaries on Employees.EmpID = Salaries.EmpID
group by DeptName
Order by Avg_Salary DESC Limit 1;

-- 26. Employees Who Share Managers
-- Q: List pairs of employees who share the same manager.
select E1.EmpName as Employee2, E2.EmpName as Employee2, M.EmpName as Manager
from Employees E1
Inner Join Employees E2 on E1.ManagerID = E2.ManagerID AND E1.EmpID < E2.EmpID
Inner Join Employees M on E1.ManagerID = M.ManagerID;

-- 27. Employee and Department Mismatches
-- Q: Find employees whose department does not match the department managing their assigned project.
select E.EmpName, D.DeptName as EmployeeDept, p.DeptId as ProjDept
from Employees E
Inner Join Departments D on E.DeptID = D.DeptID
Inner Join Projects P on D.DeptId = p.DeptID;


-- 28. Most Assigned Project
-- Q: Find the project with the most employees assigned (assume employees are assigned to projects through department).
select ProjName, count(E.EmpID) as employeeCount
from Projects P
Inner Join Departments D on p.DeptID = D.DeptID
Inner Join Employees E on D.DeptID = E.DeptID
group by ProjName
Order by EmployeeCount Desc;


-- 29. Employees Managing Their Own Departments
-- Q: Find employees who are also the managers of their own departments.
select EmpName
from Employees
Where EmpId = ManagerID;


-- 30. Employee-Project Matching Based on Department
-- Q: List all employees and their projects if they belong to the same department.
select E.EmpName, P.ProjName
from Employees E
Inner Join Projects P on E.DeptID = P.DeptID;
