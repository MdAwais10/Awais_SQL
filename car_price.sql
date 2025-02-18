create table car_price
(
Brand varchar(10),
Model varchar(20),
Year int,
Engine_Size float,
Fuel_Type varchar(15),
Transmission varchar(18),
Mileage int,
Doors int,
Owner_Count int,
Price int
);


select *
from car_price;


-- car with highest price
select brand, model, max(Price) as high_price
from car_price
group by brand, model, price
order by high_price desc;

select max(Price)
from car_price;


-- car with lowest price
select brand, model, min(Price) as low_price
from car_price
group by brand, model, price
order by low_price asc;

select min(Price)
from car_price;


select *
from car_price;

-- seeing car price hike by year
select brand, Model, Year,price,
row_number() over(partition by model order by Year asc) as price_compare_num
from car_price
where Owner_Count =1;


select *
from car_price;


select *
from car_price
where brand = 'BMW' AND Model = '3 series'
order by year asc;


-- year on year price difference
SELECT 
    brand, model, year, price,
    LAG(price,1,0) OVER (PARTITION BY brand, model ORDER BY year) AS previous_year_price,
    (price - LAG(price,1,0) OVER (PARTITION BY brand, model ORDER BY year)) AS price_difference,
    CONCAT(ROUND(((price - LAG(price,1,0) OVER (PARTITION BY brand, model ORDER BY year)) / LAG(price,1,0) OVER (PARTITION BY brand, model ORDER BY year)) * 100, 2),'%') AS price_change_percentage
FROM car_price
ORDER BY brand,model,year;


-- MY TRY
select Brand, MODEL, Year, Price,
LAG(PRICE,1,0) OVER(partition by Brand,Model ORDER BY YEAR) AS PREVIOUS_PRICE,
PRICE - LAG(PRICE,1,0) OVER(partition by Brand,Model ORDER BY YEAR) AS PRICE_DIFFERENCE
FROM car_price
order by Brand, MODEL, Year;
    
    
 -- average of cars prices by model each year   
SELECT brand, model, year,
AVG(price) AS avg_price
FROM car_price
GROUP BY brand, model, year
ORDER BY brand, model,year;



-- MY TRY
-- AVERAGE PRICE BY MODEL AND YEAR, COMPARE TO PREVIOUS YEAR AVG PRICE AND CALCULATION AVG PRICE DIFFERENCE FROM LAST YEAR
select BRAND, MODEL, YeaR, AVG(PRICE) AS AVG_PRICE,
LAG(AVG(PRICE)) OVER(PARTITION BY BRAND,MODEL ORDER BY YEAR) AS LAST_AVG_PRICE,
AVG(PRICE) - LAG(AVG(PRICE)) OVER(PARTITION BY BRAND, MODEL ORDER BY YEAR) AS AVG_DIFFERENCE_LAST_YEAR
FROM CAR_PRICE
group BY bRAND, MODEL,year
ORDER BY BRAND, MODEL ,YEAR;

-- average of cars prices by model each year + calculate the price increase each year
SELECT brand, model,year,
    AVG(price) AS avg_price,
    AVG(price) - LAG(AVG(price)) OVER (PARTITION BY brand, model ORDER BY year) AS price_increase
FROM car_price
GROUP BY brand, model, year
ORDER BY brand, model, year;

-- check which used car was sold for highest price
SELECT Brand, model, year,  owner_count,
    AVG(Price) OVER (PARTITION BY Brand, model, Owner_Count order by year) AS avg_price
FROM car_price
WHERE 
    Owner_Count > 1
ORDER BY 
    brand, model, year;




