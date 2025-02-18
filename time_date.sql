-- current time stanp
select current_timestamp();

-- NOW CAN USED TO GET CURRENT TIMESTAMP

SELECT NOW();

-- TO SELECT DATE
SELECT current_date();


-- TO SELECT TIME
SELECT current_time();

CREATE TABLE date_functions_demo (
    id INT ,
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
 system_date varchar(10)
);

INSERT INTO date_functions_demo (id,start_date, end_date, created_at, updated_at,system_date) VALUES 
(1,'2024-01-01', '2024-12-31', '2024-01-01 10:00:00', '2024-12-31 23:59:59','12/30/2024'),
(2,'2023-06-15', '2024-06-15', '2023-06-15 08:30:00', '2024-06-15 17:45:00','08/15/2024'),
(3,'2022-05-20', '2023-05-20', '2022-05-20 12:15:00', '2023-05-20 18:00:00','10/21/2024');


SELECT *
FROM date_functions_demo;

-- SELECTING FROM TABLE AND CURRENT DATE
SELECT *, current_date() AS CURRENT_DATE_COL
FROM date_functions_demo;

-- DATE FUNCTION
-- dATE(CREATED_AT) - TAKES DATE FROM TIME STAMP & CASR CASTS CREATED AT AS DATE
SELECT ID, CREATED_AT, DATE(CREATED_AT), CAST(CREATED_AT AS date)
FROM date_functions_demo;


-- date format
SELECT id, start_date, date_format(start_date,'%m/%d/%y')
FROM date_functions_demo;

-- date diff - calculates the difference between 2 date
SELECT id, start_date, end_date, datediff(end_date,start_date) as no_of_days
FROM date_functions_demo;

-- same date difference can be done in a simpler manner
SELECT id, start_date, end_date, 
end_date-start_date as no_of_days
FROM date_functions_demo;


-- date add - adds 1 month
SELECT id, start_date, end_date, date_add(end_date,interval 1 month) as no_of_days
FROM date_functions_demo;


-- date add - adds 1 year
SELECT id, start_date, end_date, date_add(end_date,interval 1 year) as no_of_days
FROM date_functions_demo;

Create table order_del
(
orderid int,
custid int,
rest_id int,
order_time	timestamp,
delivery_time timestamp,
delivery_agent_id int,
dname varchar(20)
);

select *
from order_del;