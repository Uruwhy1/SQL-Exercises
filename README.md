- [00 - Select Basics](#00-select-basics)
- [01 - Select Name](#01-select-name)
- [02 - Select From World](#02-select-from-world)
- [03 - Select From Nobel](#03-select-from-nobel)
- [04 - Select Within Select](#04-select-within-select)
- [05 - Sum and Count](#05-sum-and-count)
- [06 - The Join Operation](#06-the-join-operation)
- [07 - More Join Operations](#07-more-join-operations)
- [08 - Using NULL](#08-using-null)
- [08.1 - Numeric Examples](#081-numeric-examples)
- [09 - Self Join](#09-self-join)
- [09.1 - Window Function](#091-window-function)
- [09.2 - Window Lag](#092-window-lag)

---

### [00] Select Basics

1. Show the population of Germany:

```sql
SELECT population FROM world
  WHERE name = 'Germany'
```

2. Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.

```sql
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');
```

3. Show the country and the area for countries with an area between 200,000 and 250,000.

```sql
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000
```

### [01] Select Name

1. Find the country that starts with Y.

```sql
SELECT name FROM world
  WHERE name LIKE 'Y%'
```

2. Find the country that ends with Y.

```sql
SELECT name FROM world
  WHERE name LIKE '%Y'
```

3. Find the countries that contain the letter X.

```sql
SELECT name FROM world
  WHERE name LIKE '%X%'
```

4. Find the countries that end with [land].

```sql
SELECT name from world
  WHERE name LIKE '%land'
```

5. Find the countries that start with C and end with [ia]

```sql
SELECT name from world
  WHERE name LIKE 'C%ia'
```

6. Find the country that has oo in the name

```sql
SELECT name from world
  WHERE name LIKE '%oo%'
```

7. Find the countries that have three or more a in the name.

```sql
SELECT name FROM world
  WHERE name LIKE '%a%a%a%'
```

8. Find the countries that have "t" as the second character.

```sql
SELECT name FROM world
 WHERE name LIKE '_t%'
```

9. Find the countries that have two "o" characters separated by two others.

```sql
SELECT name FROM world
 WHERE name LIKE '%o__o%'
```

10. Find the countries that have exactly four characters.

```sql
SELECT name FROM world
 WHERE name LIKE '____'
```

11. Find the countries where the name is the capital city.

```sql
SELECT name FROM world
 WHERE name = capital
```

12. Find the country where the capital is the country plus "City".

```sql
SELECT name FROM world
 WHERE capital = CONCAT(name, ' City')
```

13. Find the capital and the name where the capital includes the name of the country.

```sql
SELECT capital, name FROM world
  WHERE capital LIKE CONCAT('%', name, '%');
```

14. Find the capital and the name where the capital is an extension of name of the country.

```sql
SELECT capital, name FROM world
  WHERE capital LIKE CONCAT('%', name, '%')
  AND capital != name
```

15. Show the name and the extension where the capital is a proper (non-empty) extension of name of the country.

```sql
SELECT name, replace(capital, name, "") FROM world
  WHERE capital LIKE CONCAT('%', name, '%')
  AND capital != name
```

### [02] Select From World

2. Show the name for the countries that have a population of at least 200 million..

```sql
SELECT name FROM world
  WHERE population >= 200000000
```

3. Give the name and the per capita GDP for those countries with a population of at least 200 million.

```sql
SELECT name, (gdp / population) as per_capita_GPD FROM world
  WHERE population >= 200000000
```

4. Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.

```sql
SELECT name, (population / 1000000) as population FROM world
  WHERE continent = 'South America'
```

5. Show the name and population for France, Germany, Italy

```sql
SELECT name, population FROM world
  WHERE name = 'France' OR name = 'Germany' OR name = 'Italy'
```

6. Show the countries which have a name that includes the word 'United'

```sql
SELECT name FROM world
  WHERE name LIKE '%United%'
```

7. Show the countries that are big by area or big by population. Show name, population and area. (A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million).

```sql
SELECT name, population, area FROM world
  WHERE population > 250000000
    OR area > 3000000
```

8. Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.

```sql
SELECT name, population, area FROM world
  WHERE population > 250000000
    XOR area > 3000000
```

9. Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.

```sql
SELECT name,
  ROUND((population / 1000000.0), 2) as population,
  ROUND((GDP / 1000000000), 2) AS GDP FROM world
    WHERE continent = 'South America'
```

10. Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.

```sql
SELECT name,
  ROUND((GDP / population), -3) as GDP_pc FROM world
    WHERE GDP > 1000000000000
```

11. Show the name and capital where the name and the capital have the same number of characters.

```sql
SELECT name, capital FROM world
 WHERE LENGTH(name) = LENGTH(capital)
```

12. Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.

```sql
SELECT name, capital FROM world
 WHERE LEFT(name, 1) = LEFT(capital, 1)
  AND name <> capital
```

13. Find the country that has all the vowels and no spaces in its name.

```sql
SELECT name FROM world
 WHERE name NOT LIKE '% %'
  AND name LIKE '%a%'
  AND name LIKE '%o%'
  AND name LIKE '%i%'
  AND name LIKE '%e%'
  AND name LIKE '%u%'
```

### [03] Select from Nobel

1. Change the query shown so that it displays Nobel prizes for 1950.

```sql
SELECT yr, subject, winner FROM nobel
 WHERE yr = 1950
```

2. Show who won the 1962 prize for literature.

```sql
SELECT winner FROM nobel
 WHERE yr = 1962
   AND subject = 'literature'
```

3. Show the year and subject that won 'Albert Einstein' his prize.

```sql
SELECT yr as year, subject FROM nobel
  WHERE winner = 'Albert Einstein'
```

4. Give the name of the 'peace' winners since the year 2000, including 2000.

```sql
SELECT winner FROM nobel
  WHERE subject = 'peace'
    AND yr > 1999
```

5. Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.

```sql
SELECT yr, subject, winner FROM nobel
  WHERE subject = 'literature'
    AND yr > 1979
    AND yr < 1990
```

6. Show all details of the presidential winners:
   Theodore Roosevelt
   Thomas Woodrow Wilson
   Jimmy Carter
   Barack Obama

```sql
SELECT * FROM nobel
  WHERE winner IN ('Theodore Roosevelt', 'Thomas Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')
```

7. Show the winners with first name John

```sql
SELECT winner FROM nobel
  WHERE winner LIKE 'John%'
```

8. Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.

```sql
SELECT yr, subject, winner FROM nobel
  WHERE (subject = 'physics' AND yr = 1980)
  OR (subject = 'chemistry' AND yr = 1984)
```

9. Show the year, subject, and name of winners for 1980 excluding chemistry and medicine

```sql
SELECT yr, subject, winner FROM nobel
  WHERE yr = 1980 AND subject NOT IN ('chemistry', 'medicine')
```

10. Show year, subject, and name of people who won a 'Medicine' prize in an early year
    (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004).

```sql
SELECT yr, subject, winner FROM nobel
  WHERE (yr < 1910 AND subject = 'medicine')
  OR (yr > 2003 AND subject = 'literature')
```

11. Find all details of the prize won by PETER GRÜNBERG.

```sql
SELECT * FROM nobel
  WHERE winner = 'PETER GRÜNBERG';
```

12. Find all details of the prize won by EUGENE O'NEILL

```sql
SELECT * FROM nobel
  WHERE winner = "EUGENE O'NEILL";
```

13. List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.

```sql
SELECT winner, yr, subject FROM nobel
  WHERE winner LIKE 'Sir%' ORDER BY yr DESC, winner
```

14. Show the 1984 winners and subject ordered by subject and winner name; but list chemistry and physics last.

```sql
SELECT winner, subject FROM nobel
  WHERE yr=1984
  ORDER BY FIELD(subject, 'chemistry', 'physics'), subject, winner
```

### [04] Select Within Select

1. List each country name where the population is larger than that of 'Russia'.

```sql
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
```

2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

```sql
SELECT name FROM world
  WHERE continent = 'Europe' AND (gdp / population) >
    (SELECT (gdp / population) FROM world
      WHERE name='United Kingdom'
    )
```

3. List the name and continent of countries in the continents containing either Argentina or Australia.
   Order by name of the country.

```sql
SELECT name, continent FROM world
WHERE continent IN (
    SELECT continent FROM world
    WHERE name = 'Argentina' OR name = 'Australia'
)
ORDER BY name;
```

4. Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.

```sql
SELECT name, population FROM world
WHERE population > (
  SELECT population FROM world
  WHERE name = 'United Kingdom'
) AND population < (
  SELECT population FROM world
  WHERE name = 'Germany'
)
```

5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany (population 80 million).

```sql
SELECT name, CONCAT(ROUND(population / (SELECT population FROM world WHERE name = 'Germany') * 100), '%') AS percentage
FROM world
WHERE continent = 'Europe';
```

6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

```sql
SELECT name FROM world
WHERE gdp > (
  SELECT MAX(gdp) FROM world
    WHERE continent = 'Europe'
  )
```

7. Find the largest country (by area) in each continent, show the continent, the name and the area:

```sql
SELECT continent, name, area FROM world as w1
WHERE area >= ALL(
  SELECT area FROM world as w2
  WHERE w1.continent = w2.continent
)
```

8. List each continent and the name of the country that comes first alphabetically.

```sql
SELECT continent, name FROM world
GROUP BY continent
ORDER BY name
```

9. Find the continents where all countries have a population <= 25000000.
   Then find the names of the countries associated with these continents. Show name, continent and population.

```sql
SELECT name, continent, population FROM world
GROUP BY continent
HAVING MAX(population) <= 25000000;
```

10. Some countries have populations more than three times that of all of their neighbours (in the same continent).
    Give the countries and continents.

```sql
SELECT name, continent FROM world AS w1
  WHERE population >= ALL(SELECT population * 3
                         FROM world AS w2
                         WHERE w1.continent = w2.continent
                         and w2.name != w1.name
)
```

### [05] Sum and Count

1. Show the total population of the world.
   world(name, continent, area, population, gdp)

```sql
SELECT SUM(population)
FROM world
```

2. List all the continents - just once each.

```sql
SELECT DISTINCT continent
FROM world
```

3. Give the total GDP of Africa

```sql
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa'
```

4. How many countries have an area of at least 1000000

```sql
SELECT count(name)
FROM world
WHERE area >= 1000000;
```

5. What is the total population of ('Estonia', 'Latvia', 'Lithuania')

```sql
SELECT sum(population)
FROM world
WHERE name = 'Estonia'
OR name = 'Latvia'
OR name = 'Lithuania'
```

6. For each continent show the continent and number of countries.

```sql
SELECT continent, COUNT(name)
FROM world
GROUP BY continent
```

7. For each continent show the continent and number of countries with populations of at least 10 million.

```sql
SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent
```

8. List the continents that have a total population of at least 100 million.

```sql
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;
```

### [06] The Join Operation

1. Show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'

```sql
SELECT matchid, player FROM goal
  WHERE teamid = 'GER'
```

2. Show id, stadium, team1, team2 for just game 1012

```sql
SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012
```

3. Show the player, teamid, stadium and mdate for every German goal.

```sql
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
  WHERE teamid = 'GER'
```

4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

```sql
SELECT team1, team2, player
  FROM game JOIN goal ON (id = matchid)
  WHERE player LIKE 'Mario%'
```

5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

```sql
SELECT player, teamid, coach, gtime
  FROM game JOIN goal ON (id = matchid)
  JOIN eteam ON (eteam.id = teamid)
  WHERE gtime <= 10
```

6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

```sql
SELECT mdate, teamname
  FROM game JOIN eteam ON (team1 = eteam.id)
  WHERE eteam.coach = 'Fernando Santos'
```

7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

```sql
SELECT player
  FROM goal JOIN game ON (matchid = id)
  WHERE stadium = 'National Stadium, Warsaw'
```

8. Show the name of all players who scored a goal against Germany.

```sql
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id
    WHERE ((team1='GER' OR team2='GER') AND teamid != 'GER')
```

9. Show teamname and the total number of goals scored.

```sql
SELECT teamname, COUNT(player)
  FROM eteam JOIN goal ON id=teamid
  GROUP BY teamname
```

10. Show the stadium and the number of goals scored in each stadium.

```sql
SELECT stadium, COUNT(player)
  FROM game JOIN goal on id=matchid
  GROUP BY stadium
```

11. For every match involving 'POL', show the matchid, date and the number of goals scored.

```sql
SELECT matchid, mdate, COUNT(player)
  FROM game JOIN goal on id=matchid
  WHERE (team1 = 'POL' OR team2 = 'POL')
  GROUP BY matchid
```

12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

```sql
SELECT matchid, mdate, COUNT(player)
  FROM game JOIN goal on id=matchid
  WHERE goal.teamid = 'GER'
  GROUP BY matchid
```

13. List every match with the goals scored by each team as shown

```sql
SELECT mdate, team1,
  SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1, team2,
  SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score2
  FROM game
  JOIN goal ON matchid = id
  GROUP BY mdate, team1;
  ORDER BY mdate, matchid, team1, team2
```

### [07] More Join Operations

1. List the films where the yr is 1962 [Show id, title]

```sql
SELECT id, title
  FROM movie
  WHERE yr=1962
```

2. Give year of 'Citizen Kane'.

```sql
SELECT yr
  FROM movie
  WHERE title = 'Citizen Kane'
```

3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title).
   Order results by year.

```sql
SELECT id, title, yr
  FROM movie
  WHERE title LIKE 'Star Trek%'
  ORDER BY yr
```

4. What id number does the actor 'Glenn Close' have?

```sql
SELECT id
  FROM actor
  WHERE name = 'Glenn Close'
```

5. What is the id of the film 'Casablanca'?

```sql
SELECT name
  FROM actor JOIN movie ON movieid=11768
```

6. Obtain the cast list for 'Casablanca'.

```sql
SELECT DISTINCT name
  FROM casting JOIN actor ON actorid = id
  WHERE movieid = 11768
```

7. Obtain the cast list for the film 'Alien'

```sql
SELECT DISTINCT name
  FROM casting JOIN actor ON actorid = id
  WHERE movieid = (
    SELECT FROM movie
      WHERE title = 'Alien'
  )
```

8. List the films in which 'Harrison Ford' has appeared

```sql
SELECT DISTINCT title
  FROM movie JOIN casting ON movieid = movie.id
  JOIN actor ON actor.id = actorid
  WHERE actorid = (
    SELECT id FROM actor
    WHERE name = 'Harrison Ford'
)
```

9. List the films where 'Harrison Ford' has appeared - but not in the starring role.
   [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

```sql
SELECT DISTINCT title
  FROM movie JOIN casting ON movieid = movie.id
  JOIN actor ON actor.id = actorid
  WHERE actorid = (
    SELECT id FROM actor
    WHERE name = 'Harrison Ford'
    AND casting.ord != 1
)
```

10. List the films together with the leading star for all 1962 films.

```sql
SELECT DISTINCT title
  FROM movie JOIN casting ON movieid = movie.id
  JOIN actor ON actor.id = actorid
  WHERE actorid = (
    SELECT id FROM actor
    WHERE casting.ord = 1
)
  WHERE yr = 1962
```

11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

```sql
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2
```

12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.

```sql
SELECT title, name
  FROM movie JOIN casting ON (movieid = movie.id
                              AND ord=1)
             JOIN actor ON (actorid = actor.id)
WHERE movie.id IN (
  SELECT movieid FROM casting
    WHERE actorid IN (
      SELECT id FROM actor
        WHERE name = 'Julie Andrews'
    )
)
```

13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

```sql
SELECT name
  FROM casting
  JOIN actor ON (id = actorid AND ord=1)
  GROUP BY actorid
  HAVING COUNT(actorid) >= 15
  ORDER BY name
```

14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

```sql
SELECT DISTINCT title, COUNT(actorid)
  FROM movie JOIN casting ON (movie.id = movieid)
  WHERE yr = 1978
  GROUP BY movieid
  ORDER BY COUNT(actorid) DESC, title
```

15. List all the people who have worked with 'Art Garfunkel'.

```sql
SELECT name
  FROM movie JOIN casting ON (movieid = movie.id
                             )
             JOIN actor ON (actorid = actor.id)
WHERE movie.id IN (
  SELECT movieid FROM casting
    WHERE actorid IN (
      SELECT id FROM actor
        WHERE name = 'Art Garfunkel'
    )
)
AND name != 'Art Garfunkel'
```

### [08] Using NULL

1. List the teachers who have NULL for their department.

```sql
SELECT name FROM teacher
  WHERE dept IS NULL
```

2. Note that INNER JOIN misses the teachers with no department and the departments with no teacher.

```sql
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
```

3. Use a different JOIN so that all teachers are listed.

```sql
SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id)
```

4. Use a different JOIN so that all departments are listed.

```sql
SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)
```

5. Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given.
   Show teacher name and mobile number or '07986 444 2266'

```sql
SELECT name, COALESCE(mobile, '07986 444 2266')
  FROM teacher
```

6. Use the COALESCE function and a LEFT JOIN to print the teacher name and department name.
   Use the string 'None' where there is no department.

```sql
SELECT teacher.name, COALESCE(dept.name, 'None')
  FROM teacher LEFT JOIN dept
               ON teacher.dept = dept.id
```

7. Use COUNT to show the number of teachers and the number of mobile phones.

```sql
SELECT COUNT(name), COUNT(mobile)
  FROM teacher
```

8. Use COUNT and GROUP BY dept.name to show each department and the number of staff.
   Use a RIGHT JOIN to ensure that the Engineering department is listed.

```sql
SELECT dept.name, COUNT(teacher.dept) FROM teacher
  RIGHT JOIN dept ON dept.id = teacher.dept
  GROUP BY dept.name
```

9. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.

```sql
SELECT name,
       CASE WHEN dept = 1 OR dept = 2
            THEN 'Sci'
            ELSE 'Art'
       END
 FROM teacher
```

10. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.

```sql
SELECT name,
       CASE WHEN dept = 1 OR dept = 2
            THEN 'Sci'
            WHEN dept = 3
            THEN 'Art'
            ELSE 'None'
       END
 FROM teacher
```

### [08.1] Numeric Examples

1. Show the the percentage who STRONGLY AGREE

```sql
SELECT a_strongly_agree
  FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science'
```

2. Show the institution and subject where the score is at least 100 for question 15.

```sql
SELECT institution, subject
  FROM nss
 WHERE question='Q15'
   AND score > 99
```

3. Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15'

```sql
SELECT institution,score
  FROM nss
  WHERE question='Q15'
   AND subject='(8) Computer Science'
   AND score < 50
```

4. Show the subject and total number of students who responded to question 22 for each
   of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.

```sql
SELECT subject, SUM(response)
  FROM nss
  WHERE question='Q22'
    AND (subject='(8) Computer Science'
    OR subject = '(H) Creative Arts and Design')
  GROUP BY subject
```

5. Show the subject and total number of students who A_STRONGLY_AGREE to question 22
   for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.

```sql
SELECT subject, SUM(response * a_strongly_agree / 100)
  FROM nss
  WHERE question='Q22'
    AND (subject='(8) Computer Science'
    OR subject = '(H) Creative Arts and Design')
  GROUP BY subject
```

6. Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject
   '(8) Computer Science' show the same figure for the subject '(H) Creative Arts and Design'.

```sql
SELECT subject, ROUND(SUM(response * A_STRONGLY_AGREE / 100) / SUM(response) * 100, 0)
  FROM nss
  WHERE question='Q22'
    AND (subject='(8) Computer Science'
    OR subject='(H) Creative Arts and Design')
  GROUP BY subject;
```

7. Show the average scores for question 'Q22' for each institution that include 'Manchester' in the name.

```sql
SELECT institution , ROUND(SUM(response * score / 100) / SUM(response) * 100, 0)
FROM nss
  WHERE question='Q22'
   AND (institution LIKE '%Manchester%')
  GROUP BY institution
  ORDER BY institution
```

8. Show the institution, the total sample size and the number of computing students for institutions in Manchester for 'Q01'.

```sql
SELECT institution, SUM(sample), (
    SELECT sample
    FROM nss as i1
      WHERE subject='(8) Computer Science'
	    AND i2.institution = i1.institution
	    AND question='Q01') AS comp
FROM nss AS i2
  WHERE question='Q01'
   AND (institution LIKE '%Manchester%')
  GROUP BY institution
```

### [09] Self Join

1. How many stops are in the database.

```sql
SELECT count(*) AS count FROM stops
```

2. Find the id value for the stop 'Craiglockhart'

```sql
SELECT id FROM stops
WHERE name = 'Craiglockhart'
```

3. Give the id and the name for the stops on the '4' 'LRT' service.

```sql
SELECT id, name
FROM stops JOIN route ON (route.stop = stops.id)
  WHERE num = 4 AND company = 'LRT'
```

4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).
   Run the query and notice the two services that link these stops have a count of 2.
   Add a HAVING clause to restrict the output to these two routes.

```sql
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING count(*) = 2
```

5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes.
   Change the query so that it shows the services from Craiglockhart to London Road.

```sql
SELECT a.company, a.num, a.stop, b.stop
FROM route AS a JOIN route AS b ON (a.company=b.company AND a.num=b.num)
  WHERE a.stop=53 AND b.stop = (SELECT id FROM stops WHERE name = 'London Road')
```

6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number.
   Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'

```sql
SELECT a.company, a.num, stopa.name, stopb.name
FROM route AS a
    JOIN route AS b ON (a.company=b.company AND a.num=b.num)
    JOIN stops AS stopa ON (a.stop=stopa.id)
    JOIN stops AS stopb ON (b.stop=stopb.id)
  WHERE stopa.name='Craiglockhart'
  AND stopb.name = 'London Road'
```

7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')

```sql
SELECT DISTINCT a.company, a.num
FROM route AS a
    JOIN route AS b ON (a.company=b.company AND a.num=b.num)
    JOIN stops AS stopa ON (a.stop=stopa.id)
    JOIN stops AS stopb ON (b.stop=stopb.id)
  WHERE stopa.name='Haymarket'
  AND stopb.name = 'Leith'
```

8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'

```sql
SELECT DISTINCT a.company, a.num
FROM route AS a
    JOIN route AS b ON (a.company=b.company AND a.num=b.num)
    JOIN stops AS stopa ON (a.stop=stopa.id)
    JOIN stops AS stopb ON (b.stop=stopb.id)
  WHERE stopa.name='Craiglockhart'
  AND stopb.name = 'Tollcross'
```

9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company.
   Include the company and bus no. of the relevant services.

```sql
SELECT DISTINCT name, a.company, a.num
FROM route AS a
    JOIN route AS b ON (a.company = b.company AND a.num = b.num)
    JOIN stops ON a.stop = stops.id
WHERE b.stop = 53;
```

10. Find the routes involving two buses that can go from Craiglockhart to Lochend.
    Show the bus no. and company for the first bus, the name of the stop for the transfer,
    and the bus no. and company for the second bus.

```sql
SELECT a.num, a.company,  stops.name,  d.num, d.company
FROM route AS a
    JOIN route AS b ON a.company = b.company AND a.num = b.num
    JOIN stops ON b.stop = stops.id
    JOIN route AS c ON c.stop = stops.id
    JOIN route AS d ON c.company = d.company AND c.num = d.num
  WHERE a.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart')
  AND d.stop = (SELECT id FROM stops WHERE name = 'Lochend')
ORDER BY a.num, stops.name, d.num
```

### [09.1] Window Function

1. Show the lastName, party and votes for the constituency 'S14000024' in 2017.

```sql
SELECT lastName, party, votes
FROM ge
  WHERE constituency = 'S14000024' AND yr = 2017
  ORDER BY votes DESC
```

2. Show the party and RANK for constituency S14000024 in 2017. List the output by party.

```sql
SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) as rank
FROM ge
  WHERE constituency = 'S14000024' AND yr = 2017
  ORDER BY  party
```

3. Use PARTITION to show the ranking of each party in S14000021 in each year.
   Include yr, party, votes and ranking (the party with the most votes is 1).

```sql
SELECT yr,party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as rank
FROM ge
  WHERE constituency = 'S14000021'
  ORDER BY party,yr
```

4. Use PARTITION BY constituency to show the ranking of each party in Edinburgh in 2017.
   Order your results so the winners are shown first, then ordered by constituency.

```sql
SELECT constituency,party, votes,
      RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as rank
FROM ge
 WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
   AND yr  = 2017
  ORDER BY rank, constituency
```

5. -

```sql
SELECT constituency,party
FROM (
      SELECT constituency,party, votes,
      RANK() OVER (PARTITION BY constituency ORDER BY votes desc) AS c2
      FROM ge
        WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
        AND yr  = 2017
        ORDER BY c2 , constituency
) AS c1
WHERE c1.c2=1
```

6. Show how many seats for each party in Scotland in 2017.

```sql
SELECT party , COUNT(*)
FROM ge AS ge1
WHERE constituency like 'S%'
AND yr = 2017 AND votes >= ALL(SELECT votes FROM ge AS ge2 WHERE ge1.constituency = ge2. constituency AND ge2.yr = 2017)
GROUP BY party
```

### [09.2] Window LAG

1. Modify the query to show data from Spain

```sql
SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn
```

2. Modify the query to show confirmed for the day before.

```sql
SELECT name, DAY(whn), confirmed,
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS dbf
FROM covid
  WHERE name = 'Italy'
    AND MONTH(whn) = 3
    AND YEAR(whn) = 2020
ORDER BY whn
```

3. Show the number of new cases for each day, for Italy, for March.

```sql
SELECT name, DAY(whn), (confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)) AS new
FROM covid
  WHERE name = 'Italy'
    AND MONTH(whn) = 3
    AND YEAR(whn) = 2020
ORDER BY whn
```

4. Show the number of new cases in Italy for each week in 2020 - show Monday only.

```sql
SELECT name, DATE_FORMAT(whn,'%Y-%m-%d') date_, (confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)) AS new
FROM covid
  WHERE (name = 'Italy')
    AND (WEEKDAY(whn) = 0)
    AND YEAR(whn) = 2020
ORDER BY whn;
```

5. Show the number of new cases in Italy for each week - show Monday only.

```sql
SELECT name, DATE_FORMAT(whn,'%Y-%m-%d') date_,
  (confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)) AS new
FROM covid
WHERE (name = 'Italy') AND (WEEKDAY(whn) = 0)
ORDER BY whn;
```

6. Add a column to show the ranking for the number of deaths due to COVID.

```sql
SELECT 
   name,
   confirmed,
   RANK() OVER (ORDER BY confirmed DESC) AS rc,
   deaths,
   RANK() OVER (ORDER BY deaths DESC) AS rd
FROM covid
  WHERE whn = '2020-04-20'
ORDER BY confirmed DESC
```

7. Show the infection rate ranking for each country. Only include countries with a population of at least 10 million.

```sql
SELECT 
   world.name,
   ROUND(100000*confirmed/population,2) AS rate,
   RANK() OVER (ORDER BY rate) AS rank
  FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' AND population >= 10000000
ORDER BY population DESC
```

8. For each country that has had at last 1000 new cases in a single day, show the date of the peak number of new cases.

```sql

```