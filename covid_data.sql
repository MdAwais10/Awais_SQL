create table covid(city varchar(50),days date,cases int);
delete from covid;
insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);

insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);

insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);

insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);

select *
from covid;


-- total cases per state
select city,
sum(cases) over (partition by city order by cases desc) as total_cases
from covid;


SELECT city, SUM(cases) AS total_cases
FROM covid
GROUP BY city
order by total_cases desc;

-- checking which state has cases incresing daily
select *,
rank() over (partition by city order by days asc) as rn_days,
rank() over (partition by city order by cases asc) as rn_cases
from covid
order by city, days;