--Custom Sort

USE sql_practice

--Method 1

SELECT * FROM
(SELECT *,
CASE WHEN Country = 'India' THEN 3 
     WHEN Country = 'Pakistan' THEN 2
	 WHEN Country = 'Sri Lanka' THEN 1
ELSE 0 END AS Country_derived
FROM happiness_index) a
ORDER BY Country_derived DESC, [Happiness_2021 ] DESC


--Method 2

SELECT *
FROM happiness_index
ORDER BY CASE WHEN Country = 'India' THEN 3 
     WHEN Country = 'Pakistan' THEN 2
	 WHEN Country = 'Sri Lanka' THEN 1
ELSE 0 END DESC , [Happiness_2021 ] DESC