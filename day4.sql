use world;
select district, substr(district,2,3) from city;
-- numeric functions
select lifeexpectancy, round(lifeexpectancy) from country;

select 34.58, round(134.3);
 select 76.469, round(76.469,2);
 
 -- round off to nerest 10,100,1000
 
 select 9, round(9,-1);
 
 select 95, round(95,-2);
 
 select round(34.857), truncate(34.857,2),mod(3,5);
 
 select floor(34.99),ceil(34.0001);

select abs(10.11111), abs(-10.111123)