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
    Water_related_Adaptation_technologies <> '' AND
    Trade_percent_of_GDP <> '' AND
    Time_required_to_register_property_days <> '' AND
    GDP_per_capita <> '' AND
    Employers__tot_percent_total_employment <> '' AND
    Gross_enrol_ratio_primary_both sexes_percent <> '' AND
    Water_Stress_Index <> '';



#Summary Statistics

SELECT COUNT(*) FROM water_climate; #from 288 to 29 observations so I will just use climate with NULL

#Using Distinct w/ Country column
SELECT DISTINCT Country
FROM climate
ORDER BY Country;

# Selecting country and ordering by water stress index in descending order
SELECT Country, Water_Stress_Index
FROM climate
ORDER BY Water_Stress_Index DESC;



#Country, Year, Water index stress
SELECT Country, Year, Water_Stress_Index, GDP_per_capita
FROM climate
WHERE (Country, GDP_per_capita) IN (
    SELECT Country, MIN(GDP_per_capita)
    FROM climate
    GROUP BY Country
)
ORDER BY GDP_per_capita
LIMIT 10;

#Filtering stress index 0.5 and 0.6

SELECT Country, Year, Water_Stress_Index
FROM climate
WHERE Water_Stress_Index Between 0.5 AND 0.6;

#Filtering country

SELECT Country, Year, Water_Stress_Index
FROM climate
WHERE Water_Stress_Index > 0.5 AND (Country LIKE 'E%' OR Country LIKE 'S%');

# Finding Avg of patent
SELECT Country, AVG(Water_related_Adaptation_technologies) AS avg_water_tech
FROM climate
GROUP BY COUNTRY 
ORDER BY avg_water_tech DESC
LIMIT 10;


SELECT Country
FROM climate
GROUP BY country
HAVING AVG(Water_related_Adaptation_technologies) > 1; #will only work if used groupby


