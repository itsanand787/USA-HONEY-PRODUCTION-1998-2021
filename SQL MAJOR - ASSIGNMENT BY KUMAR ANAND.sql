-- Create a table “Station” to store information about weather
-- observation stations:
CREATE TABLE Station ( 
    Id INT PRIMARY KEY, 
    CITY CHAR(20), 
    STATE CHAR(2), 
    LAT_N INT, 
    LONG_W INT 
);
-- Insert the following records into the table:
INSERT INTO Station (Id, CITY, STATE, LAT_N, LONG_W) VALUES
    (13, 'PHOENIX', 'AZ', 33,112),
    (44, 'DENVER', 'CO', 40, 105),
    (66, 'CARIBOU', 'ME', 47, 68);
    
-- Execute a query to look at table STATION in undefined order.
    SELECT * FROM Station;
    
--  Execute a query to select Northern stations (Northern latitude >
-- 39.7).
    SELECT * FROM  Station
    WHERE LAT_N > 39.7;
    
-- Create another table, ‘STATS’, to store normalized temperature and
-- precipitation data:
  CREATE TABLE STATS (
    ID INT,
    MONTH NUMERIC(2,0) CHECK (MONTH BETWEEN 1 AND 12),
    TEMP_F NUMERIC(5,2) CHECK (TEMP_F BETWEEN -80 AND 150),
    RAIN_I NUMERIC(5,2) CHECK (RAIN_I BETWEEN 0 AND 100),
    FOREIGN KEY (ID) REFERENCES STATION(ID)
);

-- Populate the table STATS with some statistics for January and July:
INSERT INTO STATS (ID, MONTH, TEMP_F, RAIN_I)
VALUES
(13,1,57.4,0.31),
(13,7,91.7,5.15),
(44,1,27.3,.18),
(44,7,74.8,2.11),
(66,1,6.7,2.1),
(66,7,65.8,4.52)
;

-- . Execute a query to display temperature stats (from STATS table) for
-- each city (from Station table).
SELECT s.CITY, TEMP_F
FROM Station s
JOIN STATS st ON s.ID = st.ID
GROUP BY s.CITY;

-- Execute a query to look at the table STATS, ordered by month and
-- greatest rainfall, with columns rearranged. It should also show the
-- corresponding cities.
SELECT CITY, MONTH, RAIN_I, TEMP_F
FROM Station 
JOIN STATS ON STATS.Id = STATION.ID
ORDER BY MONTH, RAIN_I DESC;

-- Execute a query to look at temperatures for July from table STATS,
-- lowest temperatures first, picking up city name and latitude.
SELECT CITY, MONTH, TEMP_F, LAT_N, LONG_W
FROM Station 
JOIN STATS ON STATS.ID = STATION.Id
WHERE MONTH = 7
ORDER BY TEMP_F;

-- . Execute a query to show MAX and MIN temperatures as well as
-- average rainfall for each city.
SELECT CITY, 
       MAX(TEMP_F) AS MAX_TEMP_F, 
       MIN(TEMP_F) AS MIN_TEMP_F, 
       AVG(RAIN_I) AS AVG_RAIN_I
FROM Station 
JOIN STATS ON STATS.ID = STATION.ID
GROUP BY CITY;

-- Execute a query to display each city’s monthly temperature in
-- Celcius and rainfall in Centimeter.
SELECT CITY, 
       MONTH, 
       ((TEMP_F - 32) * 5 / 9) AS TEMP_Celcius, 
       (RAIN_I * 2.54)  AS RAIN_cm 
FROM Station
JOIN STATS ON STATS.ID = Station.ID;

-- Update all rows of table STATS to compensate for faulty rain gauges
-- known to read 0.01 inches low.
UPDATE STATS
SET RAIN_I = RAIN_I + 0.01;

-- 3. Update Denver's July temperature reading as 74.9
UPDATE STATS
SET TEMP_F = 74.9
WHERE ID = 44 AND MONTH = 7;














    



