use world;

-- multiple row function 

select continent from country;

select distinct(continent) from country;

select count(name),count(distinct(continent)) from country;

-- country name 

select count(name),count(distinct(name)) from country;

select count(population), sum(population), avg(population) from country;

select count(surfacearea), sum(surfacearea), max(surfacearea) from country;

select count(continent), max(continent), min(continent) from country;

select count(now()), max(now());


-- population => non-aggregated column
-- count=> aggregated function



select avg(replace(population,1,4)) from country;


select avg(replace(population,0," ")) from country;

-- data sort krna. (order by clause)
select name continent, region, population from country
order by population;

select name continent, region, population from country
order by population desc;

select name ,continent, region, population from country
order by population,name ;

select name, continent, region, population from country
order by continent,name;

select name ,continent, region, population from country
order by region,population desc;

select name , continent, region, population from country
order by region, population;