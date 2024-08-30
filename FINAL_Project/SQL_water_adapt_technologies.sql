# Query the full table

SELECT * FROM Adaptation;

# Observing some nulls; removing from table
DESCRIBE Adaptation;

CREATE TABLE water_adapt AS
SELECT Country AS Country,
       Year AS Year,
       Water_related_Adaptation_technologies AS WaterTech,
       Trade_percent_of_GDP AS TradeGDP,
       Time_required_to_register_property_days AS RegTime,
       GDP_per_capita AS GDP,
       Employers__tot_percent_total_employment AS Employers,
       Water_Stress_Index AS WaterStress
FROM Adaptation
WHERE (Country IS NOT NULL AND Country <> '')
  AND (Year IS NOT NULL AND Year <> '')
  AND (Water_related_Adaptation_technologies IS NOT NULL AND Water_related_Adaptation_technologies <> '')
  AND (Trade_percent_of_GDP IS NOT NULL AND Trade_percent_of_GDP <> '')
  AND (Time_required_to_register_property_days IS NOT NULL AND Time_required_to_register_property_days <> '')
  AND (GDP_per_capita IS NOT NULL AND GDP_per_capita <> '')
  AND (Employers__tot_percent_total_employment IS NOT NULL AND Employers__tot_percent_total_employment <> '')
  AND (Water_Stress_Index IS NOT NULL AND Water_Stress_Index <> '');

SELECT*FROM water_adapt;



#Summary Statistics

SELECT COUNT(*) FROM water_adapt; #from 288 to 29 observations

#Using Distinct w/ Country column
SELECT DISTINCT Country
FROM water_adapt
ORDER BY Country;

# Selecting country and ordering by water stress index in descending order
SELECT Country, AVG(WaterStress) AS AvgWaterStress
FROM water_adapt
GROUP BY Country
ORDER BY AvgWaterStress DESC;



#Country, Year, Water index stress
SELECT Country, Year, WaterStress, GDP
FROM water_adapt
WHERE (Country, GDP) IN (
    SELECT Country, MIN(GDP)
    FROM water_adapt
    GROUP BY Country
)
ORDER BY GDP;

#Filtering stress index 0.5 and 0.6
SELECT Country, Year, WaterStress
FROM water_adapt
WHERE WaterStress Between 0.5 AND 0.6;

#Water Stress less than 0.5
SELECT Country, AVG(WaterStress)
FROM water_adapt
WHERE WaterStress < 0.5
GROUP BY Country;

#After viewing the data, I would ike to answer: 
#Does the water stress index corelate with the countries GDP?
#Does implementing water technologies improve water index?

# Finding Avg of patent
SELECT Country, WaterStress, AVG(WaterTech) AS avg_water_tech
FROM water_adapt
GROUP BY COUNTRY, WaterStress
ORDER BY avg_water_tech DESC;


SELECT Country
FROM water_adapt
GROUP BY Country
HAVING AVG(WaterTech) > 1; #will only work if used groupby
