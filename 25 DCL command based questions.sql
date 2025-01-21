USE CompanyDB;

CREATE TABLE emp(
EmpID INT primary key not null,
Name varchar(40) not null,
Department varchar(40) not null,
Salary int not null,
Joindate date);

INSERT INTO emp Values
(10001, 'Divya Prakash', 'IT', 30000, '2024-12-20'),
(10002, 'Rohit', 'Sport', 50000, '2024-02-20'),
(10003, 'Anjali Priya', 'Account', 25000, '2025-01-02'),
(10004, 'Aditya Karn', 'Teaching', 55000, '2025-04-02'),
(10005, 'Satya Prakash', 'Marketing', 25000, '2020-01-02'),
(10006, 'Ashish Jangra', 'IT', 120000, '2021-08-01'),
(10007, 'Shahil', 'IT', 12000, '2024-05-05');


-- 1. Grant SELECT permission to a user.
grant select on emp to 'user1';

