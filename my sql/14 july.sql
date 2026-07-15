use world;
 select distinct(continent) , count(name) from country;
 
 select continent, count(name) from country group by Continent;
 
 select count(name) from country where Continent="aisa";
 
 select count(name), count(distinct(name)) from country;
 select name, count(name) from country group by name;
 
 select count(name) from city where district="zuid-holland";
 
 select district, count(name) , sum(population) from city group by district;
 
 
 
 select count(name) from city where countrycode ="afg";
 
 
 select CountryCode,count(name) from city group by CountryCode;
 
 select count(name), count(code), count(continent) , count(indeyear) from country;
 
 
 -- count did count null values , its 
 
 
 
 
 -- count the number of country which have a life expe. from 70.1 to 83.5
 
 select count(name) from country  where  LifeExpectancy between 70.1 and 83.5;
 
 -- get the totel population of the country to got their ind. form 1990
 
 select count(name) , sum(population) from country where IndepYear>=1990; 
 -- count the number of country which are not slaved by any comunity

 select  count(name) from country where IndepYear is null ;
 
 select count(name)-count(indepyear) from country;
 
 -- get the totel country and totel surfaceaera for each region
 
 select count(name), sum(surfacearea) from country;
 -- get the totel country form each continent
 select count(countnent) from country group by countnent;
 -- get the totel country for region for each continent 
 
 
 select continent , region, count(name) from country group by continent, Region;
 
 