-- window functions

create table baby_names
(Gender varchar(20),
bname varchar(25),
total int
);


insert into baby_names values ('girl','ava',95);
insert into baby_names values ('girl','emma',106);
insert into baby_names values ('boy','ethan',115);
insert into baby_names values ('girl','isabella',100);
insert into baby_names values ('boy','jacob',101);
insert into baby_names values ('boy','liam',84);
insert into baby_names values ('boy','logan',73);
insert into baby_names values ('boy','noah',120);
insert into baby_names values ('girl','olivia',100);
insert into baby_names values ('girl','sophia',88);


-- viewimg all data from table
select *
from baby_names;

-- order by popularity
select *
from baby_names
order by total desc;

-- add a popularity column ( a window function)
select gender, bname, total,
	row_number () over (order by total desc) as popularity
from baby_names;

-- trying different functions
select gender, bname, total,
	row_number () over (order by total desc) as popularity,
    rank () over (order by total desc) as rank_popularity,
    dense_rank () over (order by total desc) as dense_rank_popularity
from baby_names;

-- trying different windows
select gender, bname, total,
	row_number() over(partition by gender order by total desc) as popularity
from baby_names;

-- list top 2 names per gender (using sub queries)
Select gender, bname, total, Popularity
from
(
	select gender, bname, total,
	row_number() over(partition by gender order by total desc) as popularity
	from baby_names
) as pop
where popularity <= 2
ORDER BY gender, popularity;


-- 2
SELECT gender, bname, total
FROM (
    SELECT gender, bname, total,
           ROW_NUMBER() OVER (PARTITION BY gender ORDER BY total DESC) AS popularity
    FROM baby_names
) AS pop
WHERE popularity <= 3
ORDER BY gender, popularity;


-- using cte to write the same query as above
with pop as (
 SELECT gender, bname, total,
           ROW_NUMBER() OVER (PARTITION BY gender ORDER BY total DESC) AS popularity
    FROM baby_names
)
select * from pop
where Popularity <=2
order by gender, popularity;