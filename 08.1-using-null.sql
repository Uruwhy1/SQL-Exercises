/*
1. Show the the percentage who STRONGLY AGREE
*/

SELECT a_strongly_agree
  FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science'


/*
2. Show the institution and subject where the score is at least 100 for question 15. 
*/

SELECT institution, subject
  FROM nss
 WHERE question='Q15'
   AND score > 99

/*
3. Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15' 
*/

SELECT institution,score
  FROM nss
  WHERE question='Q15'
   AND subject='(8) Computer Science'
   AND score < 50

/*
4. Show the subject and total number of students who responded to question 22 for each 
    of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'. 
*/

SELECT subject, SUM(response)
  FROM nss
  WHERE question='Q22'
    AND (subject='(8) Computer Science' 
    OR subject = '(H) Creative Arts and Design')
  GROUP BY subject

/*
5. Show the subject and total number of students who A_STRONGLY_AGREE to question 22 
    for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'. 
*/

SELECT subject, SUM(response * a_strongly_agree / 100)
  FROM nss
  WHERE question='Q22'
    AND (subject='(8) Computer Science' 
    OR subject = '(H) Creative Arts and Design')
  GROUP BY subject
  

/*
6. Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject 
    '(8) Computer Science' show the same figure for the subject '(H) Creative Arts and Design'. 
*/

SELECT subject, ROUND(SUM(response * A_STRONGLY_AGREE / 100) / SUM(response) * 100, 0)
  FROM nss
  WHERE question='Q22'
    AND (subject='(8) Computer Science' 
    OR subject='(H) Creative Arts and Design')
  GROUP BY subject;

SELECT subject, SUM(a_strongly_agree / 100)
  FROM nss
  WHERE question='Q22'
    AND (subject='(8) Computer Science' 
    OR subject = '(H) Creative Arts and Design')
  GROUP BY subject

/*
7. Show the average scores for question 'Q22' for each institution that include 'Manchester' in the name. 
*/

SELECT institution , ROUND(SUM(response * score / 100) / SUM(response) * 100, 0)
FROM nss
  WHERE question='Q22'
   AND (institution LIKE '%Manchester%')
  GROUP BY institution
  ORDER BY institution


/*
8. Show the institution, the total sample size and the number of computing students for institutions in Manchester for 'Q01'. 
*/

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