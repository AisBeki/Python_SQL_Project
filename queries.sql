WITH mytable AS (
    SELECT a.AnswerText, a.SurveyID, a.UserID, a.QuestionID,q.QuestionText
    FROM Answer a
    JOIN Question q
    ON a.QuestionID = q.questionid
    WHERE a.QuestionID IN (1, 2, 3, 6, 8, 10, 12, 15, 22, 34, 48, 49, 65, 89, 
    94, 104, 115)),

    sampleinfo AS (
    SELECT *
    FROM mytable
    WHERE QuestionID IN (1, 2, 3, 6, 8, 22, 89))


/*age table
SELECT CAST(AnswerText AS smallint) AS age
FROM sampleinfo
WHERE (QuestionID LIKE 1) AND (age BETWEEN 15 AND 80)*/


/*gender table
SELECT CASE WHEN LOWER(AnswerText)='female' THEN 'Female'
    WHEN LOWER(AnswerText)='male' THEN 'Male'
    ELSE 'Other' END AS gender, COUNT(AnswerText) AS count
FROM sampleinfo
WHERE QuestionID LIKE 2
GROUP BY gender*/


/*country table
SELECT 
    CASE WHEN AnswerText LIKE 'United States%' THEN 'United States of America'
    ELSE AnswerText END AS country, COUNT(AnswerText) AS count
FROM sampleinfo
WHERE QuestionID=3
GROUP BY country
ORDER BY count DESC*/


/*illnesshistory table
SELECT AnswerText AS mental_illness_history, COUNT(AnswerText) AS count
FROM sampleinfo
WHERE QuestionID=6
GROUP BY mental_illness_history
ORDER BY count DESC*/


/*employees table
SELECT AnswerText AS employeesno, COUNT(AnswerText) AS count
FROM sampleinfo
WHERE QuestionID=8 AND AnswerText NOT LIKE '-1'
GROUP BY employeesno
ORDER BY CASE WHEN employeesno LIKE '1-5' THEN 1 
    WHEN employeesno LIKE '6-25' THEN 2 WHEN employeesno LIKE '26-100' THEN 3
    WHEN employeesno LIKE '100-500' THEN 4
    WHEN employeesno LIKE '500-1000' THEN 5 ELSE 6 END*/


/*experience table
SELECT AnswerText AS experience, COUNT(AnswerText) AS count
FROM sampleinfo
WHERE QuestionID=22
GROUP BY experience*/


/*race table
SELECT AnswerText AS race, COUNT(AnswerText) as count
FROM sampleinfo
WHERE (QuestionID=89) AND (race NOT LIKE '-1') AND
      (race NOT LIKE 'I prefer not to answer')
GROUP BY race
ORDER BY count DESC*/


/*diagnosis table
SELECT AnswerText AS diagnosis, Count(AnswerText) AS count
FROM mytable
WHERE (QuestionID=34) AND (AnswerText NOT LIKE '-1')
GROUP BY AnswerText*/


/*disorders table
SELECT COUNT(AnswerText) AS count, 
    CASE WHEN (AnswerText LIKE '%Anxiety%') OR (AnswerText LIKE 'PTSD%')
    OR (AnswerText LIKE 'Post-traumatic%') OR (AnswerText LIKE 'Intimate%')
    THEN 'Anxiety Disorder'
    WHEN (AnswerText LIKE 'ADD%') OR (AnswerText LIKE 'Attention%')
    THEN 'Attention Deficit Disorder(ADHD)'
    WHEN (AnswerText LIKE 'Autism%') OR (AnswerText LIKE 'PDD-NOS') 
    OR (AnswerText LIKE 'Asperges') OR (AnswerText LIKE '%Development%')
    THEN 'Autism'
    WHEN AnswerText LIKE 'Eating%'  THEN 'Eating Disorder'
    WHEN (LOWER(AnswerText) LIKE '%depression%')
    OR (LOWER(AnswerText) LIKE '%Seasonal%') THEN 'Mood disorder' 
    WHEN AnswerText LIKE '%Personality%' THEN 'Personality disorder'
    WHEN (AnswerText LIKE 'Sexual addiction')
    OR (AnswerText LIKE 'Sleeping Disorder') THEN 'Other'
    WHEN AnswerText LIKE 'Psychotic%' THEN 'Psychotic Disorder'
    ELSE AnswerText END AS disorders
FROM mytable
WHERE (QuestionID=115) AND ((AnswerText NOT LIKE '-1')
    AND (AnswerText NOT LIKE '%physical%') AND (AnswerText NOT LIKE 'Burn%')
    AND (AnswerText NOT LIKE '%gender%') AND (AnswerText NOT LIKE '%Injury'))
GROUP BY disorders
ORDER BY count DESC*/


/*interview table
SELECT g.gender, i.interview, COUNT(i.interview) AS count
FROM (SELECT CASE WHEN LOWER(AnswerText) = 'female' THEN 'Female'
       WHEN LOWER(AnswerText) = 'male' THEN 'Male'
       ELSE 'Other' END AS gender, UserID
    FROM sampleinfo
    WHERE QuestionID LIKE 2) g
JOIN (SELECT AnswerText AS interview, UserID
    FROM mytable
    WHERE QuestionID LIKE 12) i 
ON g.UserID = i.UserID
GROUP BY g.gender, i.interview*/


/*negativity table
SELECT AnswerText AS negativity, COUNT(AnswerText) AS count
FROM mytable
WHERE (QuestionID=104) AND (AnswerText NOT LIKE '-1')
GROUP BY AnswerText*/


/*campaign table
SELECT AnswerText AS campaign, COUNT(AnswerText) AS count
FROM mytable
WHERE (QuestionID=15) AND (AnswerText NOT LIKE '-1')
GROUP BY AnswerText
ORDER BY count DESC*/


/*allgrades table
SELECT SurveyID AS year, AnswerText AS grade
FROM mytable
WHERE (QuestionID=65) AND (AnswerText NOT LIKE '-1')
ORDER BY year*/


/*benefits table
SELECT COUNT(AnswerText) AS count, CASE WHEN AnswerText LIKE '%know'
    THEN "Don't know" ELSE AnswerText END AS benefits
FROM mytable
WHERE (QuestionID=10) AND (AnswerText NOT LIKE '-1' AND 
    AnswerText NOT LIKE '%NA')
GROUP BY benefits*/


/*knows table 
SELECT AnswerText AS knows, COUNT(*) AS count, 
    (ROUND(((COUNT(*) * 100.0)/SUM(COUNT(*)) OVER()), 2))||'%' AS percent
FROM mytable
WHERE QuestionID=94
GROUP BY AnswerText*/


/*interference table
SELECT AnswerText AS interference, COUNT(AnswerText) AS count,
    CASE WHEN QuestionID=49 THEN 'Not treated' ELSE 'Treated' END AS treatment
FROM mytable
WHERE (QuestionID=48 OR QuestionID=49) AND (AnswerText NOT LIKE 'Not%')
GROUP BY AnswerText, QuestionID
ORDER BY CASE WHEN AnswerText='Never' THEN 1 WHEN AnswerText='Rarely' THEN 2
    WHEN AnswerText='Sometimes' THEN 3 ELSE 4 END*/