Create Database WindowFunctionDB;
Use WindowFunctionDB;

Create Table Employees (
    EmpID Int Primary Key,
    EmpName Varchar(100),
    DeptId Int,
    Salary Decimal(10,2),
    JoiningDate Date );
    
Create Table Departments (
   DeptID Int Primary Key,
   DeptName Varchar(100) );
   
-- Inserting Data in Employee Table
INSERT INTO Employees (EmpID, EmpName, DeptID, Salary, JoiningDate) VALUES
(1, 'Alice', 1, 70000, '2020-01-15'),
(2, 'Bob', 1, 80000, '2021-06-01'),
(3, 'Carol', 2, 60000, '2021-07-15'),
(4, 'David', 2, 90000, '2019-12-01'),
(5, 'Eve', 3, 75000, '2020-09-10'),
(6, 'Frank', 3, 82000, '2021-03-05');


-- Inserting Data in Departments Table
INSERT INTO Departments (DeptID, DeptName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

select * from Employees;
select * from Departments;


                                   -- BASIC LEVEL QUESTION -- 

-- 1.Calculate Running Total of Salaries
select EmpName, Salary,
    sum(Salary) over (order By EmpID) as RunningTotal
from Employees;


-- 2.Rank Employees by Salary
select EmpName, Salary,
    Rank() over (order by Salary Desc) as SalaryRank
from Employees;

-- 3.Assign Row Numbers to Employees
select EmpName, Salary,
    Row_Number() over (order by EmpID) as Rownumber
from Employees;


-- 4.Get Employees’ Percentile Rank by Salary
select EmpName, Salary,
	Percent_rank() over (order by Salary) as percentile_rank
from Employees;


-- 5.Find the Maximum Salary in Each Department
select DeptID, EmpName, Salary,
    max(Salary) over (Partition by DeptID ) as max_salary
from Employees;

-- 6. Calculate Cumulative Count of Employees
select EmpName, 
    count(*) over (order by JoiningDate) as Cumulative_count
from Employees;


-- 7.List Employees with their Department Names
select E.EmpName, D.DeptName,
   Row_Number() over (Partition by D.DeptID order by E.JoiningDate)  as RowNumber
from Employees E
join Departments D on E.DeptID = D.DeptID;

                                          -- INTERMEDIATE LEVEL QUESTIONS--

-- 8.Find the Previous Employee's Salary (LAG)
select EmpName, Salary,
    Lag(Salary) over (order by EmpID) as Previous_salary
from Employees;

-- 9.Find the Next Employee's Salary (LEAD)
select EmpName, Salary,
    Lead(Salary) over (order by EmpID) as Next_Salary
from Employees;

-- 10.Calculate Moving Average of Salaries
select EmpName, Salary,
    Avg(Salary) over (order by EmpId rows between 1 preceding and 1 following) as moving_Average
from Employees;

-- 11.Find Department-Wise Total Salaries
select DeptID, EmpName, Salary,
	sum(Salary) over (partition by DeptID) as DepartmentTotalSalary
from Employees;

-- 12.Rank Employees Within Each Department
select DeptID, EmpName, Salary,
    Rank() over (partition by DeptID order by Salary desc) as DeptRank
from Employees;


-- 13.Calculate Running Total of Salaries for Each Department
select DeptId, EmpName, Salary,
    Sum(Salary) over (partition by DeptID order by EmpID) as RunningTotal
from Employees;


-- 14.Identify Employees in Top 2 Salaries Per Department
select EmpName, DeptID, Salary
from (
       select EmpName, DeptID, Salary,
           Rank() over (Partition by DeptId order by Salary) as Rank_Salary
	   from Employees
	  ) Ranked
where Rank_Salary <= 2;

-- 15.Find the Difference Between an Employee’s Salary and the Department’s Average
select EmpName, Salary, DeptID,
    Salary - avg(Salary) over (partition by DeptID) as SalaryDifference
from Employees;

-- 16.

SELECT EmpName, DeptID, Salary
FROM (
    SELECT EmpName, DeptID, Salary,
           RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS Rank
    FROM Employees
) Ranked
WHERE Rank <= 2;


                                        -- ADVANCE LEVEL QUESTIONS--

-- 16.Find Employees’ Cumulative Salary Percentage
select EmpName, Salary,
       Sum(Salary) over () as total_Salary,
       Sum(Salary) over (order by Salary) / Sum(Salary) over () * 100 as CumulativePercentage
from Employees;


-- 17.Identify Employees Earning More Than the Average Salary in Their Department
select EmpName, Salary, DeptID
from Employees
where Salary > (
	select avg(Salary) from Employees E2 where E2.DeptID = Employees.DeptID
			   );
               
-- 18.Find the Second Highest Salary in Each Department
select EmpName, Salary, DeptID
from (
     select EmpName, Salary, DeptID,
         dense_rank() over (Partition by DeptID order by Salary) as Highest_rank
	 from Employees
	 ) ranked
where Highest_rank = 2;


-- 19.Calculate Yearly Salary Growth
select EmpName, Salary, JoiningDate,
   Salary - Lag(Salary) over (partition by DeptID order by JoiningDate) as SalaryGrowth
from Employees;


-- 20.Find Percentile Distribution of Employees by Salary
select EmpName, Salary,
   Ntile(4) over (order by Salary) as SalaryQuartile
from Employees;

-- 21.Identify Gaps in Employee IDs
select EmpId, EmpName, EmpID - RowNumber as gap
from (
      select EmpID, EmpName,
          row_number() over (order by EmpId) as RowNumber
	  from Employees
      ) as subquery
where EmpID - RowNumber = 0;

-- 22.Calculate Moving Sum of Salaries
select EmpName, Salary,
    Sum(Salary) over (order by EmpID Rows Between 2 Preceding And Current Row) as movingSum
from Employees;

-- 23.Rank Employees by Salary Using Percent Rank
select EmpName, Salary,
    percent_rank() over (order by Salary) as PercentRank
from Employees;


-- 24.Find Employees Earning Above Average Salaries
select EmpName, Salary
from (
      select EmpName, Salary, avg(Salary) over() as avg_salary
      from Employees
     ) as subquery
where Salary > avg_salary;


-- 25.Calculate Median Salary in Each Department
With RankedSalaries as (
    select DeptID, Salary,
         Row_Number() over (Partition by DeptID order by Salary) as RowNum,
         count(*) over (Partition by DeptID) as TotalRows
	from Employees
)
select DeptId,
       Case
           When TotalRows % 2 = 1 Then
                Max(Case When RowNum = (TotalRows / 2) + 1 Then Salary End)
			Else
                Avg(Case When RowNum = (TotalRows / 2) + 1 Then Salary End)
		End As MedianSalary
from RankedSalaries
Group By DeptID;

-- 26. Find the cumulative count of employees in the table based on their joining dates.
select EmpID, EmpName, JoiningDate,
    Count(*) over (order by JoiningDate) as cumulative_count
from Employees;


-- 27.Identify the highest-paid employee in each department and rank other employees based on salary within their department.
select DeptID, EmpName, Salary,
    Rank() over (Partition by DeptID order by Salary Desc) as Rank_in_dept
from Employees;

-- 28.Calculate the percentage contribution of each employee's salary to their department's total salary.
select EmpName, DeptID, Salary,
	Round(100.0 * Salary / Sum(Salary) over (Partition by DeptID), 2) as PercentageContribution
from Employees;


-- 29.Determine the running maximum salary for all employees ordered by their EmpID.
select EmpName, Salary,
    Max(Salary) over (order by EmpID Rows Between Unbounded Preceding and Current Row) as RunningMax
from Employees;

-- 30. Identify employees whose salaries are greater than the department's median salary.
WITH RankedSalaries AS (
    SELECT DeptID, EmpName, Salary,
           ROW_NUMBER() OVER (PARTITION BY DeptID ORDER BY Salary) AS RowNum,
           COUNT(*) OVER (PARTITION BY DeptID) AS TotalRows
    FROM Employees
),
MedianSalaries AS (
    SELECT DeptID,
           CASE 
               WHEN TotalRows % 2 = 1 THEN MAX(CASE WHEN RowNum = (TotalRows / 2) + 1 THEN Salary END)
               ELSE AVG(CASE WHEN RowNum IN (TotalRows / 2, (TotalRows / 2) + 1) THEN Salary END)
           END AS MedianSalary
    FROM RankedSalaries
    GROUP BY DeptID
)
select R.DeptId, R.EmpName, R.Salary
from RankedSalaries R
Join MedianSalaries M on R.DeptID = M.DeptID
Where R.Salary > M.MedianSalary;