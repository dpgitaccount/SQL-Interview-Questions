CREATE DATABASE CompanyDB;
USE CompanyDB;

-- Employees Table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary DECIMAL(10, 2),
    JoinDate DATE
);
drop table Employees;

-- Departments Table
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    ManagerID INT
);

-- Transactions Table
CREATE TABLE Transactions (
    TransID INT PRIMARY KEY,
    EmpID INT,
    Amount DECIMAL(10, 2),
    TransDate DATE,
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

-- Insert Sample Data
INSERT INTO Employees VALUES 
(1, 'Alice', 101, 75000, '2020-01-15'),
(2, 'Bob', 102, 55000, '2019-05-20'),
(3, 'Charlie', 101, 60000, '2021-03-10'),
(4, 'Diana', 103, 80000, '2022-07-18'),
(5, 'Eve', 102, 90000, '2018-11-01');

INSERT INTO Departments VALUES 
(101, 'HR', 1),
(102, 'Finance', 2),
(103, 'Engineering', 4);

INSERT INTO Transactions VALUES
(1, 1, 5000, '2023-01-01'),
(2, 2, 7000, '2023-02-10'),
(3, 3, 6000, '2023-03-05'),
(4, 4, 8000, '2023-04-12'),
(5, 5, 4500, '2023-05-20');


                                              -- BASIC QUESTIONS--

-- 1.Create a View for High-Earning Employees (Salary > 70,000).
create View HighEarningEmployees as 
select EmpID, EmpName, Salary
from Employees
where Salary > 70000;

-- 2.Select Data from the View.
select * from HighEarningEmployees;
 

-- 3.Create a View Showing Each Department’s Total Salary.
create View DeptSalary as 
select DeptID, sum(Salary) as Total_Salary
from Employees
group by DeptID;
select * from DeptSalary;

-- 4.Update a View’s Data and Reflect Changes in the Underlying Table.
create View FinanceDept as 
select EmpID, EmpName, Salary
from Employees
where DeptID = 102;

Update FinanceDept 
Set Salary = 95000
Where EmpName = 'Bob';

select * from FinanceDept;


-- 5.Check All Views in the Database.
select Table_Name
from Information_Schema.Views
where Table_Schema = 'CompanyDB';


                                              -- INTERMEDIATE QUESTIONS--

-- 6.Create a Transaction to Update Multiple Records in One Go.
Start transaction;

update Employees
Set Salary = Salary + 5000
where DeptId = 101;
Commit;
select * from Employees;


-- 7.Rollback a Transaction If a Condition Fails.
Start transaction;

Update Employees
Set Salary = Salary - 10000
where EmpName = 'Diana';

IF (SELECT Salary FROM Employees WHERE EmpName = 'Diana') < 70000 THEN
   ROLLBACK;
ELSE
   COMMIT;
END IF;


-- 8. Save a Table’s Data into Another Table for Archiving.
create Table ArchivedEmployees as 
Select * from Employees where JoinDate < '2022-01-01';
select * from ArchivedEmployees;


-- 9.Create a Temporary Table for Staging Data.
create temporary Table TempTransaction as
select * from Transactions where TransDate > '2023-01-01';
select * from TempTransaction;

-- 10.Calculate Running Total of Transaction Amounts for Each Employee Using a View.
create View RunningTotalTransections as 
select EmpID, TransDate, Amount,
	Sum(Amount) over (partition by EmpID order by TransDate) as RunningTotal
from Transactions;

select * from RunningTotalTransections;

 
                                               -- ADVANCED QUESTIONS--

-- 11.Use Nested Transactions with Savepoints.
Start transaction;

Savepoint BeforeUpdate;

Update Employees Set Salary = Salary + 10000 where DeptId = 101;

RollBack To Savepoint BeforeUpdate;

Commit;

select * from Employees;


-- 12.Optimize Performance with Indexed Views.
create view IndexedDeptSalary as 
select DeptId, sum(Salary) as TotalSalary
from Employees
group by DeptID;
select * from IndexedDeptSalary;


-- 13.Log All Transactions into an Audit Table Using Triggers.
create table TransactionAudit(
    AuditID int auto_increment primary key,
    EmpID int,
    Amount decimal(10, 2),
    TransDate date,
    AuditTime timestamp default current_timestamp
);

Delimiter &&

create Trigger AfterTransactionInsert
After Insert on Transactions
for each row
Begin
     insert into TransactionAudit (EmpID, Amount, TransDate)
     values (New.EmpID, 'Insert', now()),
     values (New.Amount, 'insert', now()),
     values (New.TransDate, 'insert', now());

END
Delimiter &&;
select * from TransactionAudit;


-- 14.Find Gaps in Employee IDs Using a View.
create view GapInEmpID as 
select EmpID, EmpID - Row_Number() over (order by EmpID) as GapGroup
from employees;
select * from GapInEmpID;

-- 15.Perform a Transaction Across Multiple Tables (Atomicity).
start Transaction;

update Employees 
set Salary = Salary - 4500 
where EmpID = 5;
insert into Transactions (EmpID, Amount, TransDate) 
Values (5, -4500, curdate());
RollBack;
Commit;

alter table Transactions
modify column TransID int auto_increment;

SELECT * FROM Employees WHERE EmpID = 5;

SELECT * FROM Transactions;

