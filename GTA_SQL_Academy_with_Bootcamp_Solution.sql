/*
--------------------------------------------------------------------------------
-- GTA: SQL Bay City Hustle - Training Missions & Solutions
-- Database Schema (Relevant for these exercises):
-- GTA.Citizens: CitizenID (PK), Name, Alias, Age, Profession, WantedLevel
-- GTA.Vehicles: VehicleID (PK), OwnerID (FK), Type, Brand, Speed, IsStolen
-- GTA.Missions: MissionID (PK), Title, Difficulty, Reward, Location
-- GTA.Assignments: AssignmentID (PK), CitizenID (FK), MissionID (FK), Completed, TimeSpent
--------------------------------------------------------------------------------
*/

-- Welcome to Bay City SQL Bootcamp
-- Welcome, agent. Before you hit the streets and run SQL ops for real, you need to master the tools of your trade.
-- This section introduces you to the basic SQL syntax you'll use to survive, thrive, and dominate in Bay City.
-- Each concept comes with a quick mission to reinforce your training.

--------------------------------------------------------------------------------
-- 1. SELECT & FROM – Scanning the Grid
--------------------------------------------------------------------------------
-- In Bay City, intelligence is power. To retrieve information, you’ll use the SELECT statement,
-- and FROM tells the system where to look.

-- Syntax:
-- SELECT column1, column2 FROM TableName;

-- Example:
-- SELECT Name, WantedLevel FROM GTA.Citizens;

-- Quick Mission:
-- List all citizen names and their professions from the GTA.Citizens table.
SELECT
    Name,
    Profession
FROM
    GTA.Citizens;

--------------------------------------------------------------------------------
-- 2. WHERE – Filtering Suspects
--------------------------------------------------------------------------------
-- You don't need the entire city report — just the troublemakers.
-- The WHERE clause lets you filter results based on a condition.

-- Syntax:
-- SELECT * FROM TableName WHERE condition;

-- Example:
-- SELECT * FROM GTA.Citizens WHERE WantedLevel > 1;

-- Quick Mission:
-- Retrieve all citizens who are under 25 years old.
SELECT
    *
FROM
    GTA.Citizens
WHERE
    Age < 25;

--------------------------------------------------------------------------------
-- 3. ORDER BY – Ranking the Danger
--------------------------------------------------------------------------------
-- Sometimes you need your results sorted — fastest to slowest, richest to poorest,
-- or highest risk to lowest. Use ORDER BY to make sense of chaos.

-- Syntax:
-- SELECT * FROM TableName ORDER BY column ASC|DESC;

-- Example:
-- SELECT Name, Speed FROM GTA.Vehicles ORDER BY Speed DESC;

-- Quick Mission:
-- List all vehicle types sorted from slowest to fastest.
-- (Note: Displaying Type, Brand, and Speed to validate the sort order)
SELECT
    Type,
    Brand,
    Speed
FROM
    GTA.Vehicles
ORDER BY
    Speed ASC;

--------------------------------------------------------------------------------
-- 4. GROUP BY – Squad-Level Insights
--------------------------------------------------------------------------------
-- Want to know how many missions each suspect completed? Or the average reward per mission?
-- GROUP BY turns messy data into smart summaries.

-- Syntax:
-- SELECT column, AGG(column2) FROM Table GROUP BY column;

-- Example:
-- SELECT CitizenID, COUNT(*) FROM GTA.Assignments GROUP BY CitizenID;

-- Quick Mission:
-- How many vehicles does each citizen own?
SELECT
    C.Name,
    COUNT(V.VehicleID) AS NumberOfVehicles
FROM
    GTA.Citizens C
LEFT JOIN -- Use LEFT JOIN to also show citizens with 0 vehicles
    GTA.Vehicles V ON C.CitizenID = V.OwnerID
GROUP BY
    C.CitizenID, C.Name -- Group by ID for uniqueness and Name for display
ORDER BY
    NumberOfVehicles DESC;

--------------------------------------------------------------------------------
-- 5. BONUS: Aggregates – The City at a Glance
--------------------------------------------------------------------------------
-- SQL lets you calculate totals, averages, and more using aggregate functions:
-- - COUNT()
-- - SUM()
-- - AVG()
-- - MIN()
-- - MAX()

-- Example:
-- SELECT AVG(Speed) FROM GTA.Vehicles;

-- Quick Mission:
-- What is the highest wanted level in the city?
SELECT
    MAX(WantedLevel) AS HighestWantedLevel
FROM
    GTA.Citizens;

--------------------------------------------------------------------------------
-- SQL Operations: Full Training Missions
--------------------------------------------------------------------------------
-- Now that you’ve completed bootcamp, it’s time to dive into real missions.
-- These 10 scenarios (5 provided here) take place in the gritty streets of Bay City.
-- Each one pushes your skills further.

--------------------------------------------------------------------------------
-- MISSION 1: Suspect Scanner
--------------------------------------------------------------------------------
-- Objective: Practice using WHERE to filter data
-- Story:
-- Claudia “Codewitch” Trejo has tapped into the Bay City suspect registry.
-- She’s looking for known troublemakers with a Wanted Level of 2 or higher to flag for further investigation.
-- Assignment:
-- Write a SQL query to return all suspects with a WantedLevel of 2 or more.
-- Include the suspect's name, alias, and wanted level.

SELECT
    Name,
    Alias,
    WantedLevel
FROM
    GTA.Citizens
WHERE
    WantedLevel >= 2;

/*
Expected Result for MISSION 1 (based on provided data):
Name                 Alias             WantedLevel
-------------------- ----------------- -----------
Chi-neme-rem Agana   Ghostface         2
Marq Alejandro       Firewall          2
Frederick Canning    Freddie Finesse   3
Jakeyl Millan        Beardstorm        2
J Torres             Midnight Mapper   2
(5 rows affected)
*/

--------------------------------------------------------------------------------
-- MISSION 2: Vehicle Watchlist
--------------------------------------------------------------------------------
-- Objective: Use JOIN and WHERE to combine tables and filter stolen data
-- Story:
-- Jakeyl “Beardstorm” Millan is tasked with locating all stolen vehicles.
-- He needs a list that matches each stolen vehicle to its owner.
-- Assignment:
-- Write a query that returns the name of the suspect, the vehicle type,
-- and the brand of all stolen vehicles (where IsStolen = 1).

SELECT
    C.Name AS SuspectName,
    V.Type AS VehicleType,
    V.Brand AS VehicleBrand
FROM
    GTA.Citizens C
JOIN
    GTA.Vehicles V ON C.CitizenID = V.OwnerID
WHERE
    V.IsStolen = 1;

/*
Expected Result for MISSION 2 (based on provided data):
SuspectName        VehicleType   VehicleBrand
------------------ ------------- -------------
Remsey Mailjard    Motorcycle    ShadowRider
Jakeyl Millan      Scooter       Zoomie
J Torres           Van           StealthWagon
(3 rows affected)
*/

--------------------------------------------------------------------------------
-- MISSION 3: Reward Tracker
--------------------------------------------------------------------------------
-- Objective: Use GROUP BY, SUM, and ORDER BY to calculate totals
-- Story:
-- Frederick “Freddie Finesse” is reviewing his crew’s earnings.
-- He wants to know who completed the most valuable missions so he can pay out bonuses.
-- Assignment:
-- Write a SQL query that shows:
-- - The name of each suspect
-- - The total money earned from completed missions
-- Group by name and order by earnings from highest to lowest.

SELECT
    C.Name AS SuspectName,
    SUM(M.Reward) AS TotalEarnings
FROM
    GTA.Citizens C
JOIN
    GTA.Assignments A ON C.CitizenID = A.CitizenID
JOIN
    GTA.Missions M ON A.MissionID = M.MissionID
WHERE
    A.Completed = 1
GROUP BY
    C.CitizenID, C.Name -- Group by ID for uniqueness and Name for display
ORDER BY
    TotalEarnings DESC;

/*
Expected Result for MISSION 3 (based on provided data):
SuspectName         TotalEarnings
------------------- -------------
Claudia Trejo       6000.00
Marq Alejandro      5000.00
Remsey Mailjard     3000.00
Cricelia Prado      1500.00
Chi-neme-rem Agana  1500.00
(5 rows affected)
*/

--------------------------------------------------------------------------------
-- MISSION 4: Mission Speed Metrics
--------------------------------------------------------------------------------
-- Objective: Use GROUP BY with MIN, MAX, and aggregate logic
-- Story:
-- Kevin “Sunset Sniper” Gagante wants a speed report. Some agents move like lightning, others crawl.
-- He wants to know who’s fastest, who’s slowest, and how many missions each agent has completed.
-- Assignment:
-- For each suspect who completed missions, return:
-- - Their name
-- - The number of missions completed
-- - Their fastest time
-- - Their slowest time

SELECT
    C.Name AS SuspectName,
    COUNT(A.MissionID) AS MissionsCompleted,
    MIN(A.TimeSpent) AS FastestTimeMin,
    MAX(A.TimeSpent) AS SlowestTimeMin
FROM
    GTA.Citizens C
JOIN
    GTA.Assignments A ON C.CitizenID = A.CitizenID
WHERE
    A.Completed = 1 AND A.TimeSpent IS NOT NULL -- Ensure TimeSpent exists for MIN/MAX
GROUP BY
    C.CitizenID, C.Name -- Group by ID for uniqueness and Name for display
ORDER BY
    C.Name; -- Optional, for consistent output

/*
Expected Result for MISSION 4 (based on provided data):
SuspectName         MissionsCompleted FastestTimeMin SlowestTimeMin
------------------- ----------------- -------------- --------------
Chi-neme-rem Agana  1                 20             20
Claudia Trejo       1                 55             55
Cricelia Prado      1                 25             25
Marq Alejandro      1                 60             60
Remsey Mailjard     1                 40             40
(5 rows affected)
*/

--------------------------------------------------------------------------------
-- MISSION 5: Elite Agent Filter
--------------------------------------------------------------------------------
-- Objective: Combine aggregates and use HAVING
-- Story:
-- Emilya “E-Mage” Illeeva is assembling a secret elite unit.
-- She needs agents who completed at least 2 missions AND earned $4000 or more in total rewards.
-- Assignment:
-- Write a query that returns the names of suspects who:
-- - Completed at least 2 missions
-- - Earned $4000 or more total
-- Only show those who meet both conditions.

SELECT
    C.Name AS SuspectName
FROM
    GTA.Citizens C
JOIN
    GTA.Assignments A ON C.CitizenID = A.CitizenID
JOIN
    GTA.Missions M ON A.MissionID = M.MissionID
WHERE
    A.Completed = 1
GROUP BY
    C.CitizenID, C.Name -- Group by ID for uniqueness and Name for display
HAVING
    COUNT(A.MissionID) >= 2
    AND SUM(M.Reward) >= 4000.00;

/*
Expected Result for MISSION 5 (based on provided data):
SuspectName
-----------
(0 rows affected)

Note: Based on the current dataset, no citizen meets BOTH criteria (at least 2 completed missions AND >= $4000 earned).
The original prompt's expected output was "Claudia Trejo".
Claudia Trejo has 1 completed mission for $6000.
Marq Alejandro has 1 completed mission for $5000.
If the requirement was "at least 1 mission AND >= $4000", Claudia and Marq would appear.
The query above strictly follows the "at least 2 missions" requirement.

If the intention was for "Claudia Trejo" to be the result, her data would need to show
at least one more completed mission (even if it had $0 reward) to meet the COUNT(A.MissionID) >= 2 condition.
For example, if Claudia had completed two missions with rewards $6000 and $0, she would appear.
*/

-- To get Claudia Trejo as per the original prompt's *expected output* (assuming a data discrepancy or slightly different criteria in that context):
-- One might assume the original data for the prompt *did* have Claudia complete 2+ missions.
-- Or, if the prompt's intent was "anyone who has completed missions and earned >= $4000 total,
-- and out of those, we prefer those with 2+ missions if available, but show anyone with >=1 if they meet the money":
-- This would be a more complex query. The current query is the direct translation of the stated conditions.

-- Alternative for Mission 5 if criteria was "at least 1 mission AND earned >= $4000":
/*
SELECT
    C.Name AS SuspectName
FROM
    GTA.Citizens C
JOIN
    GTA.Assignments A ON C.CitizenID = A.CitizenID
JOIN
    GTA.Missions M ON A.MissionID = M.MissionID
WHERE
    A.Completed = 1
GROUP BY
    C.CitizenID, C.Name
HAVING
    COUNT(A.MissionID) >= 1 -- Changed from 2 to 1
    AND SUM(M.Reward) >= 4000.00;

-- Expected Result with COUNT >= 1 AND SUM >= 4000:
-- SuspectName
-- -------------
-- Claudia Trejo
-- Marq Alejandro
*/