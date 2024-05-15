# Query the full table

RENAME TABLE adaptation_innovation_in_water_sector_in_africa TO climate;
SELECT * FROM climate;

# Oberserving some nulls; removing from table
DESCRIBE climate;

CREATE TABLE water_climate AS
SELECT *
FROM climate 
WHERE 
    Country <> '' AND
    `Country_[0]` <> '' AND
    Year <> '' AND
    `Water related Adaptation technologies` <> '' AND
    `Trade (% of GDP)` <> '' AND
    `Time required to register property (days)` <> '' AND
    `GDP per capita, PPP (constant 2011 international $)` <> '' AND
    `Employers, total (% of total employment) (modeled ILO estimate)` <> '' AND
    `Gross enrolment ratio, primary, both sexes (%)` <> '' AND
    `Water Stress Index` <> '';



#Summary Statistics

SELECT COUNT(*) FROM water_climate; #from 288 to 29 observations so I will just use climate with NULL

#Using Distinct w/ Country column
SELECT DISTINCT Country
FROM climate
ORDER BY Country;

# Selecting country and ordering by water stress index in descending order
SELECT Country, `Water Stress Index`
FROM climate
ORDER BY `Water Stress Index` DESC;



#Country, Year, Water index stress
SELECT Country, Year, `Water Stress Index`, `GDP per capita, PPP (constant 2011 international $)`
FROM climate
WHERE (Country, `GDP per capita, PPP (constant 2011 international $)`) IN (
    SELECT Country, MIN(`GDP per capita, PPP (constant 2011 international $)`)
    FROM climate
    GROUP BY Country
)
ORDER BY `GDP per capita, PPP (constant 2011 international $)`
LIMIT 10;

#Filtering stress index 0.5 and 0.6

SELECT Country, Year, `Water Stress Index`
FROM climate
WHERE `Water Stress Index` Between 0.5 AND 0.6;

#Filtering country

SELECT Country, Year, `Water Stress Index`
FROM climate
WHERE `Water Stress Index` > 0.5 AND (Country LIKE 'E%' OR Country LIKE 'S%');

# Finding Avg of patent
SELECT Country, AVG(`Water related Adaptation technologies`) AS avg_water_tech
FROM climate
GROUP BY COUNTRY 
ORDER BY avg_water_tech DESC
LIMIT 10;


SELECT Country
FROM climate
GROUP BY country
HAVING AVG(`Water related Adaptation technologies`) > 1; #will only work if used groupby


