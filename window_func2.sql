create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);


select *
from employee;

-- checking max salary per department
select DEPT_NAME, max(SALARY) as max_salary
from employee
group by DEPT_NAME;


-- max as window function here because over function max is considered as window function
select e.*,
max(salary) over () as max_sal
from employee e;


-- max as window function here because over function max is considered as window function + partition by
select e.*,
max(salary) over (partition by DEPT_NAME) as max_sal
from employee e;


-- row number
select e.*,
row_number() over (partition by DEPT_NAME) as rn
from employee e;


-- fetch 2 first 2 employees to join each department
select emp_id, emp_name, DEPT_NAME, salary, ranking
from (
	select emp_id, emp_name, Dept_name, salary,
	row_number() over (partition by DEPT_NAME order by emp_ID) as ranking
	from employee 
) as ej
where ranking <=2
order by dept_name;
