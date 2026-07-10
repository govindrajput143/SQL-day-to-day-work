show databases;
use world;

describe country; -- tells about colounms and datatype 

-- data access is used by select 
select * from country;

select name, continent from country;

select continent,name,continent,name,continent,name from country ;

select name , continent , population from country ;

select name , continent , population ,population+300 from country ;

-- sql is case insensitive 

SELECT
 * FROM 
 COUntRY;
 
 
 select name , population,population+100+3-23*234/234234 from country;
 
  select name , population,population+100+3-23*234/234234 as new_population  from country;


-- select => coloumn ko access krna 
-- you can write a query logic in any case format 
-- you can give a coloumn name using 'as' keyword 

-- data filteration by using 'where'

select * from country where continent='asia';
 
select * from country where name='india';

select name , continent,population from country where name = 'India';
select * from countary where population = 156483000;
select name ,LocalName from country where population = 156483000;


select * from country where continent = 'europe';

select * from country where continent = 'europe' and indepyear > 1900;


-- class practice 

-- Q1. code , name where surface area > 1900

select code,name from country where surfacearea > 1900;

-- Q2. code , name where region southern europe 

select code,name from country where region = 'southern europe';

-- Q3. name , code where countary belong to africa and the reasion is central africa

select name , code  from country where continent = 'africa' or region = 'central africa';

-- Q4. name contient population where they belong to asia or africa

select name , continent, population from country where continent = 'asia' or continent = 'africa';

-- Q5 name population region with 10% high population for the countries where independent year is after 1950

select name , population , region , Population * 1.10 AS New_Population from country where indepyear >=1950;

-- get all value of countary where the countary name and local name is same 

SELECT * FROM country WHERE Name = LocalName;


show databases;

use world;




-- functions 

-- code block that can use multiple times and make work easier 
-- inbuild functions 

-- scaler functions => applies on every row and return the output for every row 
-- string ,number, date 
use world;
select name , continent , concat_ws(' ',continent,'have',name,'country') from country;

select name, substr(name,2) as first, substr(name,2,4) as second from country;
select name,substr(name,-4) from country where name='Colombia';

select name,length(name)  from country;
select name,length(name) as lenght ,char_length(name) as char_length  from country;
-- length gives total no. of bites 
-- char_length give no. of charcter 


select name , replace(name ,'a','@') as replaced from country;


select trim('     hello world my     ');





-- lpad add in left side 
-- rpad add in right side 

select name , lpad(name ,8, '-') from country;
select name , rpad(name ,8, '-') from country;


-- date related 
-- yyyy-mm-dd     dd-mm-yyyy we can convert it 


select current_date(),current_time(),current_timestamp(),now();

-- current_date() print only date 
-- current_time() print only time 
-- current_timestamp() print date and time 
-- now() print date and time 



select now() , adddate(now(),2);

select now() ,adddate(now(),1),
adddate(now(),-1),
adddate(now(), interval 1 year),
adddate(now(),interval 1 week),
adddate(now(),interval 1 month);



-- extract from date times 

select now(), year(now()),
month(now()),
week(now());



select extract(month from now());
select extract(year from now());
select extract(day from now());
select extract(week from now());


select weekday(now());


select now(), date_format(now(),'today month is %M');
select now(), date_format(now(),'today year is %Y');
select now(), date_format(now(),'today weekday is %W'); -- its present in friday 
select now(), date_format(now(),'today weekday is %w'); -- its present in 5
