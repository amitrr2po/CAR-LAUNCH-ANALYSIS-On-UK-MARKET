create database project_1;
USE PROJECT_1;
SELECT * FROM AUDI;
SELECT * FROM CCLASS;
SELECT * FROM MERC;
SELECT * FROM HYNDAI;
SELECT * FROM BMW;
SELECT * FROM FUELTYPE;
SELECT * FROM MODELS where model_id is not null and model_name is not null;
SELECT * FROM TRANSMISSION;
--- brands table
select * into CARS_DATA from
(SELECT * FROM AUDI
UNION all
SELECT * FROM BMW
UNION all
SELECT * FROM MERC
UNION all
SELECT * FROM hyndai) as t ;

select * from CARS_DATA

--A.Create an analysis to find income class of UK citizens based on price of Cars
--(You can use per-capita income in UK from internet sources)
select *, case when price < 10000 then 30000
when cast(price as varchar(100)) >= 10001 and cast(price as varchar(100)) <= 15000 then 40000
when cast(price as varchar(100)) >= 15001 and cast(price as varchar(100)) <= 25000 then 50000
when cast(price as varchar(100)) >= 25001 and cast(price as varchar(100)) <= 35001 then 60000
else 70000
end as income_bucket into income_buckets
from CARS_DATA
order by income_bucket;
select * from income_buckets

drop table income_buckets
--A.a.
select income_bucket, count(model_id) as total_car from income_buckets group by income_bucket
order by income_bucket;

--A.a. year_wise
select year, income_bucket, count(model_id) as total_car from income_buckets group by year, income_bucket
order by year desc, income_bucket desc;

--B.
select *, case when price < 10000 then 10000
when price >= 10001 and price <= 20000 then 20000
when price >= 20001 and price <= 30000 then 30000
when price >= 30001 and price <= 40001 then 40000
else 50000
end as Range_of_price into per_capita from CARS_DATA


--b. bucket according to car_price
select count(model_id) as total_car, range_of_price from per_capita  
where range_of_price is not null
group by Range_of_price order by range_of_price asc;

--b.a category(trend fueltype wise top selling)
select year, B.fueltype, count(model_id) as total_car, range_of_price from per_capita 
as A inner join fueltype as B on A.fuel_id = B.fuel_ID
where range_of_price is not null
group by year, Range_of_price, B.fueltype
order by count(model_id)desc;

--B.b. category(transmission)
SELECT YEAR,COUNT(A.MODEL_ID) AS TOTAL_CARS, transmission FROM CARS_DATA AS A
INNER JOIN transmission AS B ON B.ID = A.transmission_ID
GROUP BY YEAR, transmission
ORDER BY year desc, transmission desc, COUNT(A.MODEL_ID) DESC;

--trend transmission, mileage wise top selling
SELECT YEAR,COUNT(A.MODEL_ID) AS TOTAL_CARS, transmission, mileage FROM CARS_DATA AS A
INNER JOIN transmission AS B ON B.ID = A.transmission_ID
GROUP BY YEAR, transmission, mileage
ORDER BY COUNT(A.MODEL_ID) DESC;

--AVG_TAX YEAR WISE
select year, COUNT(MODEL_ID)as total_cars, avg(tax) As avg_tax 
from CARS_DATA 
group by year 
order by year DESC;

select * from per_capita

select * from CARS_DATA;

--c. Find relationship between fuel efficiency & price of car/sales of car/fuel type/, etc.
SELECT YEAR, MPG, PRICE, TAX


--TREND PRICE_WISE 
SELECT year, PRICE, COUNT(MODEL_ID) AS TOATL_MODEL, sum(price) as total_selling FROM
(SELECT year, A.price, A.model_ID, SUM(PRICE) AS TOTAL_SELLING FROM CARS_DATA AS A
INNER JOIN models AS B ON A.model_ID = B.model_ID
INNER JOIN fueltype AS C ON C.fuel_ID = A.fuel_ID
INNER JOIN transmission AS D ON D.ID = A.transmission_ID
GROUP BY year, a.price, A.model_ID) AS T
group by year, price, COUNT(model_ID)
ORDER BY price, COUNT(model_ID);

SELECT * FROM TRANSMISSION;
--TREND TRNSMISSION_SELLING
select year, TRANSMISSION_ID, COUNT(TRANSMISSION) AS TOTAL_CAR from CARS_DATA AS A
INNER JOIN transmission AS B ON A.transmission_ID = B.ID
GROUP BY TRANSMISSION_ID, TRANSMISSION, YEAR ORDER BY YEAR DESC, COUNT(TRANSMISSION) DESC








--2021 = AVG_TAX(
--2020 = AVG_TAX(145)
--2019 = AVG_TAX(145)
--2018 = AVG_TAX(146)
--2017 = AVG_TAX(129)
--2016 = AVG_TAX(97)
--2015 = AVG_TAX(112)
--2014 = AVG_TAX(126)
--2013 = AVG_TAX(122)
--2012 = AVG_TAX(131)
--2011 = AVG_TAX(172)
--2010 = AVG_TAX(189)
--2009 = AVG_TAX(217)

