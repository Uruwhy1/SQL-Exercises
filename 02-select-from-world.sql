/* Read the notes about this table. (https://sqlzoo.net/wiki/Read_the_notes_about_this_table) */

/*
2. Show the name for the countries that have a population of at least 200 million.. 
*/

SELECT name FROM world
  WHERE population >= 200000000

/*
3. Give the name and the per capita GDP for those countries with a population of at least 200 million. 
*/

SELECT name, (gdp / population) as per_capita_GPD FROM world
  WHERE population >= 200000000

/*
4. Show the name and population in millions for the countries of the continent 'South America'. 
Divide the population by 1000000 to get population in millions. 
*/

SELECT name, (population / 1000000) as population FROM world
  WHERE continent = 'South America'

/* 
5. Show the name and population for France, Germany, Italy 
*/

SELECT name, population FROM world
  WHERE name = 'France' OR name = 'Germany' OR name = 'Italy'

/*
6. Show the countries which have a name that includes the word 'United' 
*/

SELECT name FROM world
  WHERE name LIKE '%United%'

/*
7. Show the countries that are big by area or big by population. Show name, population and area. 
(A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million).
*/

SELECT name, population, area FROM world
  WHERE population > 250000000
    OR area > 3000000

/*
8. Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. 
Show name, population and area.
*/

SELECT name, population, area FROM world
  WHERE population > 250000000
    XOR area > 3000000

/*
9. Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. 
Use the ROUND function to show the values to two decimal places.
*/

SELECT name, 
  ROUND((population / 1000000.0), 2) as population, 
  ROUND((GDP / 1000000000), 2) AS GDP FROM world
    WHERE continent = 'South America'

/* 
10. Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). 
Round this value to the nearest 1000. 
*/

SELECT name, 
  ROUND((GDP / population), -3) as GDP_pc FROM world
    WHERE GDP > 1000000000000

/*
11. Show the name and capital where the name and the capital have the same number of characters.
*/

SELECT name, capital FROM world
 WHERE LENGTH(name) = LENGTH(capital)

/*
12. Show the name and the capital where the first letters of each match. 
Don't include countries where the name and the capital are the same word.
*/

SELECT name, capital FROM world
 WHERE LEFT(name, 1) = LEFT(capital, 1)
  AND name <> capital

/*
13. Find the country that has all the vowels and no spaces in its name.
*/

SELECT name FROM world
 WHERE name NOT LIKE '% %' 
  AND name LIKE '%a%'
  AND name LIKE '%o%'
  AND name LIKE '%i%'
  AND name LIKE '%e%'
  AND name LIKE '%u%'
