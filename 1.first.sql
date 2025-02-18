Use parks_and_recration;


SELECT * FROM employee_demographics;

SELECT * FROM employee_salary;
#like
SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;
#group by
select gender, avg(gender)
from employee_demographics
group by gender	;

select gender, 
avg(age), 
min(AGE),
COUNT(AGE)
from employee_demographics
GROUP BY gender;

select * from employee_demographics;

#havimg
SELECT gender, AVG(AGE)
FROM employee_demographics
GROUP BY gender
having AVG(age) > 40
;


Select * from employee_salary;


#having and group by
select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000
;


#limit - limits the number of lines of output shown

select * from employee_demographics
order by age desc
limit 3;

select * from employee_demographics
order by age desc
limit 2, 1;

#limit 2,1 - says start from 2nd row and show one more from there

#alias - lets us rename
select gender, avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > 40;

#join join works on columns

select * 
from employee_demographics as dem
inner join	employee_salary as sal
	on dem.employee_id = sal.employee_id
;


select dem.employee_id, age, occupation
from employee_demographics as dem
inner join	employee_salary as sal
	on dem.employee_id = sal.employee_id
;

select * 
from employee_demographics as dem
left join	employee_salary as sal
	on dem.employee_id = sal.employee_id
;

select * 
from employee_demographics as dem
right join	employee_salary as sal
	on dem.employee_id = sal.employee_id
;

#joining multiple table
select * 
from employee_demographics as dem
inner join	employee_salary as sal
	on dem.employee_id = sal.employee_id
inner join parks_departments as pd
	on sal.dept_id = pd.department_id
;


use parks_and_recreation;
#union - works on rows
select first_name, last_name
from employee_demographics
union all
select first_name, last_name
from employee_salary;



select first_name, last_name
from employee_demographics
union distinct
select first_name, last_name
from employee_salary;



select first_name, last_name, 'old' as Label
from employee_demographics
where age > 50
union
select first_name, last_name, 'high paid employee' as label
from employee_salary
where salary > 70000
;




select first_name, last_name, 'old man' as Label
from employee_demographics
where age > 40 AND gender = 'Male'
union
select first_name, last_name, 'old lady' as Label
from employee_demographics
where age > 40 AND gender = 'Female'
union
select first_name, last_name, 'high paid employee' as label
from employee_salary
where salary > 70000
order by first_name, last_name
;



-- string fuctions

#length functions

select length('skywalk');

select first_name, length(first_name) as Len
from employee_demographics;


select first_name, length(first_name) as Len
from employee_demographics
order by 2;


select first_name, length(first_name) as Len
from employee_demographics
order by first_name asc;

select upper('skywalk');
select lower('SKY');

select first_name, UPPER(first_name) as UPPER
from employee_demographics
order by first_name asc;


SELECT TRIM('      SKY       ');
SELECT LTRIM('      SKY       ');
SELECT RTRIM('      SKY       ');



select first_name,
left(first_name, 4),
right(first_name, 4),
substring(first_name,3,2),
birth_date,
substring(birth_date,6,2) as birth_month
from employee_demographics;


#replace
select first_name, replace(first_name, 'a','z') as new_name
from employee_demographics;


#locate
select locate('i','owais');


select first_name, locate('an',first_name) as new_name
from employee_demographics;


#concatenate string
select first_name, last_name,
concat(first_name,' ',last_name) as Full_Name
from employee_demographics;



-- case statements - like if else statements

select first_name,
last_name,
age,
case
	when age <= 30 then 'young'
    when age between 31 and 50 then 'old'
    when age > 50 then  'oldest'
end as age_bracket
from employee_demographics;


-- pay and bonus
-- < 50000 = 5% raise
-- > 50000 = 7% raise
-- finance = 10% bonus

select first_name, last_name, salary,
case
	when salary < 50000 then salary + (salary * 0.05)
    when salary > 50000 then salary + (salary * 0.07)
    
end as New_salary,
case
	when dept_id = 6 then salary * .10
End as bonus
from employee_salary;



-- subqueries

select * 
from employee_demographics
where employee_id in 
	(select employee_id from employee_salary where dept_id =1
	);


select first_name, salary,
	(select avg(salary) from 
    employee_salary) as AVG_SAL
from employee_salary;


select gender, avg(age), min(age), max(age), count(age)
from employee_demographics
group by gender;


select avg(max_age)
from 
(select gender, 
avg(age) as avg_age, 
min(age) as min_age,
max(age) as max_age,
count(age) as count_age
from employee_demographics
group by gender
) as agg_age
group by gender;


-- window functions

select gender, avg(salary) as Avg_salary
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender;


select dem.first_name, dem.last_name, gender, avg(salary) over(partition by gender)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;
    
    
    
    
    
select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
sum(salary) over(partition by gender order by dem.employee_id) as rolling_total
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;







select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;




select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over (partition by gender order by salary desc) as rank_num,
dense_rank() over (partition by gender order by salary desc) as dense_rank_num
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;
    
    
-- cte - common table expressions

select gender, avg(salary), max(salary), min(salary), count(salary)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender;




with CTE_Example as
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
)
select *
from CTE_Example
;

#above problem solved using subquery
select avg(avg_sal)
from
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
) as example_subquery;


#multiple cte's in same query
with CTE_Example as
(
select employee_id, gender, birth_date
from employee_demographics 
where birth_date > '1985-01-01'
),
CTE_Example2 as
(
	select employee_id, salary
    from employee_salary
    where salary > 50000
)
select *
from CTE_Example
join CTE_Example2
	on CTE_Example.employee_id = CTE_Example2.employee_id
;



 #temporary tables
 
 create temporary table temp_table
 (
 first_name varchar(50),
 last_name varchar(50),
 fav_movie varchar(100)
 );
 
 
 insert into temp_table values ('alex','frank','fast n furious');
 select * from temp_table;
 
 
 create temporary table salary_over_50k
 select *
 from employee_salary
 where salary >= 50000;
 
  select * from salary_over_50k;
 
 
 
 #store procedures
 
 create procedure large_salaries()
 select *
 from employee_salary
 where salary >= 50000;
 
 call large_salaries();
 
 delimiter $$
  create procedure large_salaries2()
  begin
	select *
	from employee_salary
	where salary >= 50000;
	select *
	from employee_salary
	where salary >= 10000;
end$$
delimiter ;
 
 call large_salaries2();

 delimiter $$
  create procedure large_salaries3(p_emp_id int)
  begin
	select salary
	from employee_salary
	where employee_id = p_emp_id;
end $$
delimiter ;

call large_salaries3(1);



#triggers and events - is triggered when a specific event occurs

Delimiter $$
create trigger employee_insert
	After insert on employee_salary
	for each row
Begin
	insert into employee_demographics (employee_id, first_name, last_name)
	values (new.employee_id, new.first_name, new.last_name);
end $$
Delimiter ;


insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id) values
(13, 'jean', 'stan', 'entertainment 720 CEO', 10000000,NULL);


select * from employee_salary;
select * from employee_demographics;


#event - a scheduled event that occurs over time.
#THE EVENT belows scans table every 30 seconds and deletes all data where age of employee is greater then 60


DELIMITER $$
CREATE EVENT DELETE_RETIREE
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
DELETE
FROM EMPLOYEE_DEMOGRAPHICS
WHERE AGE>= 60;
END $$
DELIMITER ;


select * from employee_demographics;


