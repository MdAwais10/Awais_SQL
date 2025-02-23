Create table Laptop_prices(
Brand varchar(15),
Processor varchar(15),
RAM int,
Storage varchar(10),
GPU varchar(20),
Screen_Size float,
Resolution varchar(15),
Battery_Life float,
Weight float,
Operating_System varchar(20),
Price float
);


select *
from laptop_prices;

-- checking which device has the highest price
select *
from laptop_prices
order by price desc;

-- average battery life
select Brand, AVG(Battery_Life) as battery_life_hours
from laptop_prices
group by Brand
order by Brand asc;

-- average battery life partitioned by brand
select brand, battery_life,
avg(Battery_Life) over(partition by brand)
from laptop_prices
;

-- assigning rank to laptops with higher battery life
select brand, battery_life,
avg(Battery_Life) over(partition by brand order by Battery_Life desc) as avg_battery_life,
rank() over(partition by brand order by Battery_Life desc) as row_numb
from laptop_prices
;

-- selecting top 10 laptops with the highest battery lifer per brand
Select * from
(
select brand, battery_life,
avg(Battery_Life) over(partition by brand order by Battery_Life desc) as avg_battery_life,
rank() over(partition by brand order by Battery_Life desc) as rank_battery
from laptop_prices
) as cal
where rank_battery <= 10;


-- average price
select Brand, AVG(Battery_Life) as battery_life_hours
from laptop_prices
group by Brand
order by Brand asc;

-- average battery life partitioned by brand
select brand, Price,
avg(Price) over(partition by brand)
from laptop_prices;

select brand, Price,
avg(Price) over(partition by brand order by price desc)
from laptop_prices;



-- prices sorted in descending order
-- price descrepency calculated from high to low price based on previous laptop price
select *, prev_price - price as price_descrepency from
(
	select brand, Price,
	lag(Price) over(partition by brand order by price desc) as prev_price
	from laptop_prices
) as cal;



select *
from laptop_prices;

-- checking which laptop is the most heavy
select brand, weight
from laptop_prices
order by brand;

select brand, weight,
max(Weight) over(partition by brand order by weight desc) as max_weight
from laptop_prices
;