-- auto mpg
Create table auto_mpg(
mpg int,
cylinders int,
displacement int,
horsepower int,
weight int,
acceleration float,
model_year int,
origin int,
car_name varchar(50),
brand_name varchar(20),
model_name varchar(25)
);

select *
from auto_mpg;


-- least fuel effecient car
select min(mpg)
from auto_mpg;



-- most fuel effecient car
select max(mpg)
from auto_mpg;



-- average fuel economy of the cars
select avg(mpg)
from auto_mpg;


-- average fuel economy per brand

select 
brand_name, avg(mpg)
from auto_mpg
group by brand_name
order by 2 desc;


select *
from auto_mpg;

-- distinct cylinders
select distinct(cylinders)
from auto_mpg;

select *
from auto_mpg
where cylinders = 5;


-- avg fuel effeciency per cylinders
select 
cylinders, avg(mpg)
from auto_mpg
group by cylinders
order by 1 asc;

-- avg fuel effeciency per horsepower
select 
horsepower, avg(mpg)
from auto_mpg
group by horsepower
order by 1 asc;



-- avg fuel effeciency per model
select 
brand_name, model_name, avg(mpg)
from auto_mpg
where brand_name is not null or model_name is not null
group by brand_name, model_name
order by 2 asc;


select * 
from auto_mpg
where brand_name = 'audi';

-- saw a naming inconsistency, so we fixed it
update auto_mpg
set model_name = '100 ls'
where model_name like '100%';



select * 
from auto_mpg
where brand_name = 'audi';


select * 
from auto_mpg;


-- fastest accelerating car
select brand_name, model_name, 
min(acceleration) as acceleration_time
from auto_mpg
group by brand_name, model_name
order by 3 asc;


select brand_name, model_name, acceleration
from auto_mpg
order by acceleration asc;

-- verfify the results fom ourselves
select *
from auto_mpg
order by acceleration asc;



-- the 3 slowest accelerating cars
select brand_name, model_name, 
max(acceleration) as acceleration_time
from auto_mpg
group by brand_name, model_name
order by 3 desc
limit 3;


select brand_name, model_name, acceleration
from auto_mpg
order by acceleration desc;

-- verfify the results fom ourselves
select *
from auto_mpg
order by acceleration desc;


select *
from auto_mpg;



select model_year
from auto_mpg;


-- ranking acceleration

select brand_name, model_name, 
min(acceleration) as acceleration_seconds
from auto_mpg
group by brand_name, model_name
order by 3 asc;


-- window function row number rank and dense rank
select brand_name, model_name, acceleration,
row_number() over(order by acceleration asc) as acceleration_seconds,
rank() over(order by acceleration asc) as acceleration_seconds,
dense_rank() over(order by acceleration asc) as acceleration_seconds
from auto_mpg;


select *
from auto_mpg;


-- understanding the understand of the weight displacement cylinders to acceleration comaparision
select weight, horsepower, displacement, acceleration, cylinders,
dense_rank() Over(partition by cylinders order by displacement desc) as displacement_by_clyinder
from auto_mpg;



select *
from auto_mpg;



-- categorising the cylinder to mpg ratio
select mpg, cylinders, brand_name, model_name,
dense_rank() over(partition by cylinders order by mpg desc) as cylinders_mpg
from auto_mpg;




