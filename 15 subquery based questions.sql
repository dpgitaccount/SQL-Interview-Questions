create database InterviewDb;
use InterviewDB;

create table employee(
    emp_id int primary key,
    name varchar(50),
    department_id int,
    salary decimal(10,2),
    manager_id int );
    
create table department(
    department_id int primary key,
    department_name varchar(50),
    location varchar(50));
    -- drop table department;
    
create table project(
	project_id int primary key,
    project_name varchar(50),
    department_id int);


-- Insert sample data into employee tables
INSERT INTO employee VALUES
(1, 'Alice', 1, 60000, 2),
(2, 'Bob', 1, 75000, NULL),
(3, 'Charlie', 2, 55000, 4),
(4, 'David', 2, 80000, NULL),
(5, 'Eva', 3, 70000, 4);

-- Insert sample data into department tables
INSERT INTO  department VALUES
(1, 'HR', 'New York'),
(2, 'Finance', 'Chicago'),
(3, 'Engineering', 'San Francisco');

-- Insert sample data into projects tables
INSERT INTO project VALUES
(1, 'Project A', 1),
(2, 'Project B', 2),
(3, 'Project C', 3);


select * from employee;
select * from department;
select * from project;


-- SINGLE ROW SUBQUERIES

-- 1.Find the highest salary in the employees table.
select max(salary) as highest_salary 
from employee;

-- 2.Find the name of the employee with the highest salary.
select name from employee
where salary = (select max(salary) as highest_salary from employee);

-- 3.Find the department where the highest-paid employee works.
select department_id, name from employee
where salary = (select max(salary) from employee);

-- 4.Find the department name of the employee with the lowest salary.
select department_name from department
where department_id = (select department_id from employee
					  where salary = (select min(salary) as lowest_salary 
                      from employee));
                      
-- MULTI-ROW SUBQUERIES

-- 5.Find all employees who earn more than the average salary.
select name from employee
where salary > (select avg(salary) from employee);
 
-- 6.List departments with more than one employee.
select department_name from department
where department_id in (select department_id from employee
group by department_id
having count(emp_id) > 1);

-- 7.Find employees who work in the same department as 'Alice'.
select name from employee
where department_id = (select department_id from employee 
                       where name = 'Alice'
					  );
					
                    
-- 8.Find employees who earn more than the average salary of their department.
select name from employee e
where salary > (
	  select avg(salary) 
      from employee 
      where department_id = e.department_id
      );

-- 9.Find the number of employees in the HR department.
select ( select count(*)
from employee
where department_id = (select department_id
                      from department
                      where department_name = 'HR'
                      )
                      ) as HR_employee_count;
                      
-- 10.Find the average salary across all departments.
select (
  select avg(salary) 
  from employee
  ) as avg_salary;
  

-- CORRELATED SUBQUERIES

-- 11.Find employees who are the highest-paid in their department.
select name from employee e1
where salary = (select max(salary) from employee e2
               where e1.department_id = e2.department_id);

-- 12.Find departments where all employees earn above $50,000.
select department_name
from department d 
where not exists ( select 1 from employee e
				 where e.department_id = d.department_id and e.salary <= 50000
                 );
                 
-- 13.Find employees who do not manage anyone.
select name from employee e1
where not exists (select 1 from employee e2
                  where e1.emp_id = e2.manager_id
                  );

-- 14.Find the names of employees working on 'Project A'.
select name 
from employee e
where department_id = (select department_id 
                       from project
                       where project_name = 'Project A'
                       );

-- 15.List the names of managers and their departments
select name, department_id 
from employee
where emp_id in (select manager_id
				from employee
                where manager_id is not null
                );
 
-- 16.Find employees whose salary is higher than the average salary of all departments combined.
select name 
from employee
where salary > (select avg(salary) from employee);

-- 17.List departments with no employees.
select department_name
from department d
where not exists (select 1 from employee e
                  where d.department_id = e.department_id
                  );
                  
-- 18.Find employees who earn more than the highest salary in the HR department.
select name 
from employee
where salary > (select max(salary)
                from employee 
                where department_id = ( select department_id 
                                        from department
                                        where department_name = 'HR'
                                        )
				);
           
-- 19.List all departments and the total number of employees in each.
select department_name, 
(select count(*)
from employee 
where employee.department_id = department.department_id 
) as emp_count
from department;

-- 20.Find employees whose manager's salary is less than $70,000.
select name 
from employee e1
where manager_id is not null and (select salary
                                  from employee e2
                                  where e1.manager_id = e2.emp_id
                                  ) <= 70000;
                                  