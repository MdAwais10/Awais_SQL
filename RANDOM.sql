use parks_and_recreation;


select * from employee_demographics;
select * from employee_salary;

select dem.first_name, dem.last_name 
from employee_demographics as dem
	join employee_salary as sal
where dem.employee_id = sal.employee_id;


select dem.first_name, dem.last_name , gender, sum(salary) over(partition by gender) as avg_gender_salary
from employee_demographics as dem
	join employee_salary as sal
where dem.employee_id = sal.employee_id;
