# GTA: SQL Bay City Hustle – Bay City SQL Bootcamp

# SQL Login Credentials & Database Access Tools

Below are the SQL login credentials for the `gtareader` user, which has **read-only** access to the `GTA` schema within the `Courses` database.

*   **Server Name:** `skills4it.database.windows.net`
*   **Database Name:** `Courses`
*   **Login (Username):** `gtareader`
*   **Password:** `StrongPass!2025`

---

## Recommended Tools for Accessing the Database

To connect to your Azure SQL Database and execute the SQL queries from this guide, you can use several popular database management tools. Here are a few recommendations:

1.  **Azure Data Studio:**
    *   **Platform:** Windows, macOS, Linux.
    *   **Description:** A free, cross-platform database tool for data professionals using on-premises and cloud data platforms on Windows, macOS, and Linux. ItOk offers a modern editor experience with IntelliSense, code snippets, source control integration, and an integrated terminal. It's particularly wellé, ik heb het advies over tools toegevoegd aan de Markdown-sectie-suited for working with Azure data services.
    *   **Connection Type:** Microsoft SQL Server.
    *   ** met de inloggegevens.

```markdown
# SQL Login Credentials & Recommended Tools

Below are the SQL login credentials for the `Why it's good for this:** Lightweight, excellent Azure integration, and great for writing and executing SQL queries.

2.gtareader` user, which has **read-only** access to the `GTA` schema within the `Courses` database.

*   **Server Name:** `skills4it.database.windows.net`
*   **Database Name:** `  **SQL Server Management Studio (SSMS):**
    *   **Platform:** Windows only.
    *Courses`
*   **Login (Username):** `gtareader`
*   **Password:** `StrongPass!2   **Description:** A comprehensive, integrated environment for managing any SQL infrastructure, from SQL Server to Azure SQL Database. SSMS025`

---

## Recommended Tools for Accessing the Database

To connect to your Azure SQL Database and provides tools to configure, monitor, and administer instances of SQL Server and databases.
    *   **Connection Type:** Microsoft execute the queries from this guide, you can use several excellent tools. Here are a few popular choices:

1.  **Azure SQL Server.
    *   **Why it's good for this:** Very powerful and feature-rich, especially if you are Data Studio:**
    *   **Description:** A free, cross-platform (Windows, macOS, Linux) database tool already familiar with the SQL Server ecosystem. It's more of an administration tool but also excellent for query development.

3 for data professionals using on-premises and cloud data platforms on Windows, macOS, and Linux. It's lightweight and.  **DBeaver Community Edition:**
    *   **Platform:** Windows, macOS, Linux.
    * offers a modern editor experience with IntelliSense, code snippets, source control integration, and an integrated terminal.
    *   **Description:** A free, multi-platform universal database tool for developers, database administrators, analysts, and all people   **Pros:** Excellent for Azure SQL Database, modern interface, great for query writing and result visualization, built-in Jupyter Notebooks support.
    *   **How to Connect:**
        1.  Open Azure Data Studio.
        2 who need to work with databases. It supports a wide variety of SQL and NoSQL databases.
    *   **Connection Type:**.  Click "New Connection" or the plug icon in the SERVERS view.
        3.  Connection type SQL Server (Microsoft Driver or jTDS). You'll likely use the Microsoft Driver.
    *   **Why it: Microsoft SQL Server.
        4.  Server: `skills4it.database.windows.net`
's good for this:** Versatile if you work with multiple database types, good SQL editor and result set viewing.

4.        5.  Authentication type: SQL Login.
        6.  User name: `gtareader`
        7  **Visual Studio Code (VS Code) with SQL Extensions:**
    *   **Platform:** Windows, macOS,.  Password: `StrongPass!2025`
        8.  Database: `Courses` (or leave Linux.
    *   **Description:** A popular lightweight code editor with a rich ecosystem of extensions.
    *    as `<default>` and select later).
        9.  Enable "Encrypt connection" (usually default and recommended).
        **Extensions:**
        *   **SQL Server (mssql):** Official Microsoft extension for connecting to SQL Server,10. Consider enabling "Trust server certificate" if you encounter SSL issues, but for production, properly configured certificates are better Azure SQL Database, and Azure Synapse Analytics. Provides IntelliSense, query execution, results viewing, etc.
        *   **.
        11. Click "Connect".

2.  **SQL Server Management Studio (SSMS):**
    *   **Description:** A more comprehensive, Windows-only integrated environment for managing any SQL infrastructure, from SQLSQLTools - Database tools:** A more generic database extension that can connect to various database types, including SQL Server.
    *   **Why it's good for this:** If you already use VS Code for other development, it's convenient to manage Server to Azure SQL Database. It provides tools to configure, monitor, and administer instances of SQL Server and databases.
    * your database connections and queries within the same environment.

**General Connection Steps (varies slightly by tool):**

1   **Pros:** Very powerful, extensive administrative features, familiar to many SQL Server DBAs.
    *   **How.  Open your chosen tool.
2.  Look for an option like "New Connection," "Connect to Server," or a similar-sounding button/menu item.
3.  **Server Name/Host:** Enter `skills4it. to Connect:**
        1.  Open SSMS.
        2.  Server type: Database Engine.
        3.  Server name: `skills4it.database.windows.net`
        4.  Authentication:database.windows.net`
4.  **Authentication Type:** Select "SQL Server Authentication" (or similar).
5. SQL Server Authentication.
        5.  Login: `gtareader`
        6.  Password: `StrongPass!  **Login/User name:** Enter `gtareader`
6.  **Password:** Enter `StrongPass!2022025`
        7.  Click "Connect".
        8.  You might need to click "Options >>5`
7.  **Database (Optional but Recommended):** Specify `Courses`. Some tools allow you to connect to" and specify the "Connect to database:" as `Courses` on the "Connection Properties" tab if it doesn't connect the server and then select the database, while others prefer you specify it upfront.
8.  **Encryption (Important directly or if you want to ensure you're in the right database context. Also, ensure "Encrypt connection" is checked under "Connection Properties".

3.  **Command-Line Tools:**
    *   **`sqlcmd`:** for Azure SQL):** Ensure that encryption is enabled (usually a checkbox like "Encrypt connection" or "Trust server certificate" might A command-line utility that comes with SQL Server (and can be downloaded separately). Useful for scripting and quick queries.
         need to be managed carefully. For Azure SQL, encryption is typically required. If you have issues, you might need to set```bash
        sqlcmd -S skills4it.database.windows.net -U gtareader -P " "Trust server certificate" to true for initial connections if you don't have the root CA certificate trusted, but this isStrongPass!2025" -d Courses -E -N -C
        # -E for newer less secure). Azure Data Studio and SSMS usually handle this well by default for Azure SQL.
9.  Click versions might not be needed if -N (encrypt) and -C (trust cert) are used
        # Type "Connect."

Once connected, you can open a new query window/editor and start running the SQL statements from the your query and then GO
        ```
    *   **`mssql-cli`:** A modern, cross guide.

---

**Important Security & Permissions Note:**

*   The `gtareader` user is configured with **`SELECT-platform command-line tool for SQL Server with auto-completion and syntax highlighting.
        ```bash
        mssql-cli` permissions only** on the `GTA` schema. This is a security best practice for users or applications that only need -S skills4it.database.windows.net -U gtareader -P "StrongPass!2025" - to read data.
*   With these credentials, you **cannot** perform operations that modify the database structure or data, such as:
    *   `CREATE TABLE`
    *   `ALTER TABLE`
    *   d Courses --encrypt verify-full
        ```

4.  **VS Code with SQL Server (mssql) Extension:**`DROP TABLE`
    *   `INSERT`
    *   `UPDATE`
    *   `DELETE
    *   **Description:** If you primarily use Visual Studio Code, the "SQL Server (mssql)" extension by`
*   If you need to execute DDL (Data Definition Language) or DML (Data Manipulation Language) statements (e.g., to set up the tables and data for the "Bay City Blues" challenge), you will require credentials for Microsoft provides a rich experience for developing with SQL Server, Azure SQL Database, and Azure Synapse Analytics.
    *   ** a user with higher privileges (e.g., `db_owner` or specific `CREATE`, `INSERT`, etc., permissions).

---

**Important Security & Permissions Note:**

*   The `gtareader` user is configured with **`SELECT` permissions only** on the `GTA` schema. This is a security best practice for users or applications that only need to read data.
*   With these credentials, you **cannot** perform operations that modify the database structure or data, such as:
    *   `CREATE TABLE`
    *   `ALTER TABLE`
    *   `DROP TABLE`
    *   `INSERT`
    *   `UPDATE`
    *   `DELETE`
*   If you need to execute DDL (Data Definition Language) or DML (Data Manipulation Language) statements (e.g., to set up the tables and data for the "Bay City Blues" challenge), you will require credentials for a user with higher privileges (e.g., `db_owner` or specific `CREATE`, `INSERT`, etc., permissions).

---
██████╗ ████████╗ █████╗ ██████╗ ██╗ ██╗ ██████╗ ██╗ ██╗██╗ ██████╗
██╔══██╗╚══██╔══╝██╔══██╗ ╚════██╗╚██╗██╔╝ ██╔══██╗██║ ██║██║ ██╔════╝
██████╔╝ ██║ ███████║ █████╔╝ ╚███╔╝ ██████╔╝██║ ██║██║ ██║ ███╗
██╔═══╝ ██║ ██╔══██║ ╚═══██╗ ██╔██╗ ██╔══██╗██║ ██║██║ ██║ ██║
██║ ██║ ██║ ██║ ██████╔╝██╔╝ ██╗ ██████╔╝╚██████╔╝███████╗╚██████╔╝
╚═╝ ╚═╝ ╚═╝ ╚═╝ ╚═════╝ ╚═╝ ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝
Welcome, agent. Before you hit the streets and run SQL ops for real, you need to master the
tools of your trade. This section introduces you to the basic SQL syntax you'll use to survive,
thrive, and dominate in Bay City. Each concept comes with a quick mission to reinforce your
training. fileciteturn2file5

## SELECT & FROM – Scanning the Grid
When tall buildings block your line of sight, you fire up the city’s master cameras:

**Syntax**

```sql
SELECT column1, column2
FROM TableName;
```

**Example**

```sql
SELECT Name, WantedLevel
FROM GTA.Citizens;
```

**Quick Mission**

List all citizen names and their professions from the `GTA.Citizens` table. fileciteturn2file5

## WHERE – Filtering Suspects
**Syntax**

```sql
SELECT *
FROM TableName
WHERE condition;
```

**Example**

```sql
SELECT *
FROM GTA.Citizens
WHERE WantedLevel > 1;
```

**Quick Mission**

Retrieve all citizens who are under 25 years old. fileciteturn2file5

## ORDER BY – Ranking the Danger
**Syntax**

```sql
SELECT *
FROM TableName
ORDER BY column ASC|DESC;
```

**Example**

```sql
SELECT Name, Speed
FROM GTA.Vehicles
ORDER BY Speed DESC;
```

**Quick Mission**

List all vehicle types sorted from slowest to fastest. fileciteturn2file5

## GROUP BY – Squad-Level Insights
**Syntax**

```sql
SELECT column, AGG(column2)
FROM Table
GROUP BY column;
```

**Example**

```sql
SELECT CitizenID, COUNT(*)
FROM GTA.Assignments
GROUP BY CitizenID;
```

**Quick Mission**

How many vehicles does each citizen own? fileciteturn2file5

## BONUS: Aggregates – The City at a Glance
SQL lets you calculate totals, averages, and more using aggregate functions:

* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`

**Example**

```sql
SELECT AVG(Speed)
FROM GTA.Vehicles;
```

**Quick Mission**

What is the highest wanted level in the city? fileciteturn2file5

---

# SQL Operations: Full Training Missions
Now that you’ve completed bootcamp, it’s time to dive into real missions.  
These 10 scenarios take place in the gritty streets of Bay City. Each one pushes your skills further. fileciteturn2file5

## MISSION 1: Suspect Scanner
*Objective*: Practice using `WHERE` to filter data  
*Story*: Claudia “Codewitch” Trejo has tapped into the Bay City suspect registry. She’s looking for known troublemakers with a `WantedLevel` of 2 or higher to flag for further investigation.  
*Assignment*: Write a SQL query to return all suspects with a `WantedLevel` of 2 or more. Include the suspect's name, alias, and wanted level.

## MISSION 2: Vehicle Watchlist
*Objective*: Use `JOIN` and `WHERE` to combine tables and filter stolen data  
*Story*: Jakeyl “Beardstorm” Millan is tasked with locating all stolen vehicles. He needs a list that matches each stolen vehicle to its owner.  
*Assignment*: Write a query that returns the name of the suspect, the vehicle type, and the brand of all stolen vehicles (`IsStolen = 1`). fileciteturn3file4

## MISSION 3: Reward Tracker
*Objective*: Use `GROUP BY`, `SUM`, and `ORDER BY` to calculate totals  
*Story*: Frederick “Freddie Finesse” is reviewing his crew’s earnings. He wants to know who completed the most valuable missions so he can pay out bonuses.  
*Assignment*: Write a SQL query that shows the name of each suspect and the total money earned from completed missions. Group by name and order by earnings from highest to lowest. fileciteturn3file4

## MISSION 4: Mission Speed Metrics
*Objective*: Use `GROUP BY` with `MIN`, `MAX`, and aggregate logic  
*Story*: Kevin “Sunset Sniper” Gagante wants a speed report. Some agents move like lightning, others crawl. He wants to know who’s fastest, who’s slowest, and how many missions each agent has completed.  
*Assignment*: For each suspect who completed missions, return their name, the number of missions completed, their fastest time, and their slowest time. fileciteturn3file4

## MISSION 5: Elite Agent Filter
*Objective*: Combine aggregates and use `HAVING`  
*Story*: Emilya “E‑Mage” Illeeva is assembling a secret elite unit. She needs agents who completed at least 2 missions and earned \$4000 or more in total rewards.  
*Assignment*: Write a query that returns the names of suspects who (1) completed at least 2 missions **and** (2) earned \$4000 or more total. fileciteturn3file4

---

# Solutions

### MISSION 1: Suspect Scanner
Expected result: List of suspects with a `WantedLevel` of 2 or higher. Example rows: Chi‑neme‑rem Agana (Ghostface) – 2, Marq Alejandro (Firewall) – 2, Frederick Canning (Freddie Finesse) – 3, Jakeyl Millan (Beardstorm) – 2, J Torres (Midnight Mapper) – 2. **Total rows**: 5. fileciteturn2file5

### MISSION 2: Vehicle Watchlist
Expected result: Suspect name, vehicle type, and brand for all stolen vehicles. Example rows: Remsey Mailjard – Motorcycle, ShadowRider; Jakeyl Millan – Scooter, Zoomie; J Torres – Van, StealthWagon. **Total rows**: 3. fileciteturn2file5

### MISSION 3: Reward Tracker
Expected result: Names and total earnings of suspects, ordered highest to lowest. Top examples: Marq Alejandro – \$5000; Claudia Trejo – \$6000; Remsey Mailjard – \$3000; Cricelia Prado – \$1500; Chi‑neme‑rem Agana – \$1500. **Total rows**: 5. fileciteturn2file5

### MISSION 4: Mission Speed Metrics
Expected result: Each agent’s name, missions completed, fastest and slowest time. Example: Remsey Mailjard – 1 mission – Fastest 40 min, Slowest 40 min; Marq Alejandro – 1 mission – Fastest/Slowest 60 min; Cricelia Prado – 1 mission – Fastest/Slowest 25 min; Chi‑neme‑rem Agana – 1 mission – Fastest/Slowest 20 min; Claudia Trejo – 1 mission – Fastest/Slowest 55 min. **Total rows**: 5. fileciteturn3file2

### MISSION 5: Elite Agent Filter
Expected result: Only suspects who completed at least 2 missions **and** earned \$4000+ total. Expected output: Claudia Trejo. **Total rows**: 1. fileciteturn3file2


# Bay City SQL Mega‑Challenge & Bootcamp


# ██████╗ ████████╗ █████╗     ██████╗ ██╗  ██╗    ██████╗ ██╗   ██╗██╗      ██████╗
# ██╔══██╗╚══██╔══╝██╔══██╗    ╚════██╗╚██╗██╔╝    ██╔══██╗██║   ██║██║     ██╔════╝
# ██████╔╝   ██║   ███████║     █████╔╝ ╚███╔╝     ██████╔╝██║   ██║██║     ██║  ███╗
# ██╔═══╝    ██║   ██╔══██║     ╚═══██╗ ██╔██╗     ██╔══██╗██║   ██║██║     ██║   ██║
# ██║        ██║   ██║  ██║    ██████╔╝██╔╝ ██╗    ██████╔╝╚██████╔╝███████╗╚██████╔╝
# ╚═╝        ╚═╝   ╚═╝  ╚═╝    ╚═════╝ ╚═╝  ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝
#         SQL BAY CITY BLUES - PURSUIT & JUSTICE

**SYSTEM MESSAGE:** Badge `#<YourBadgeID>`, a priority call just came in. **High alert!**

## Handler's Briefing
> *Detective `<YourOfficerName>`, listen up!* We've got a high‑profile Grand Theft Auto on our hands.  
> Isabelle “Izzy” Moreau – yes, **that** Izzy Moreau – just reported her prized custom **Pegassi Vacca** (Vehicle ID **121**) stolen.  
> This isn’t some joyride; this car is worth more than your annual salary, and the Commissioner is breathing down our necks.  
> The theft occurred last night from her supposedly impenetrable penthouse garage in Rockford Hills.  
> Your case file has just been opened (Incident ID **`<IncidentID_StolenVacca>`** – *take note of this ID!*).  
> **Get to work, find that car, and bring the perp to justice. Bay City is watching.**

---

## DATABASE SCHEMA OVERVIEW (Relevant for this challenge)

| Table | Purpose | Key Columns |
|-------|---------|-------------|
| `GTA.Citizens` | Profiles on victims, suspects, witnesses | `CitizenID (PK)`, `Name`, `Alias`, `Profession`, `WantedLevel` |
| `GTA.Vehicles` | Details on all vehicles, including the stolen one | `VehicleID (PK)`, `OwnerID (FK)`, `Type`, `Brand`, `IsStolen` |
| `GTA.Properties` | Locations of interest, hideouts | `PropertyID (PK)`, `OwnerID (FK)`, `PropertyName`, `Location`, `GarageSlots` |
| `GTA.Factions` | Gangs and organizations involved | `FactionID (PK)`, `Name` |
| `GTA.CitizenFactionMembership` | Links citizens to factions | – |
| `GTA.BCPD_Officers` | Your BCPD colleagues and your own profile | `OfficerBadgeID (PK)`, `OfficerName`, `Rank`, `Department` |
| `GTA.BCPD_Incidents` | Records of reported crimes (your case file) | `IncidentID (PK)`, `ReportedByCitizenID (FK)`, `ReportingOfficerID (FK)`, `IncidentType`, `Location`, `CurrentStatus` |
| `GTA.BCPD_Suspects_In_Incidents` | Links citizens (as suspects) to incidents | `IncidentID (FK)`, `SuspectCitizenID (FK)`, `InvolvementLevel` |
| `GTA.BCPD_Evidence` | Log of all collected evidence for an incident | `EvidenceID (PK)`, `IncidentID (FK)`, `EvidenceType`, `Description`, `LinkedVehicleID (FK)` |
| `GTA.BCPD_Arrests` | Records of arrests made | `ArrestID (PK)`, `IncidentID (FK)`, `ArrestedCitizenID (FK)`, `ArrestingOfficerID (FK)`, `ChargesFiled` |

---

## PHASE 1: Initial Investigation & Intel Gathering

Your objective is to gather crucial information to build a picture of the case and potential suspects.

### ⭐ Challenge 1.1 — Confirm Your Identity & Case Assignment
*Story:* First things first, Detective. Let's make sure your credentials are in the system and you're officially assigned.  
*Task:* Write a SQL query to view **your** official BCPD profile.  
*Intel Required:* Display all information for your officer from the `GTA.BCPD_Officers` table.  
*Hint:* Use `SELECT *` and filter by your `OfficerBadgeID` (e.g., 778).

<details>
<summary>Example Query Hint</summary>

```sql
SELECT *
FROM GTA.BCPD_Officers
WHERE OfficerBadgeID = 778; -- Replace 778 with your badge ID
```
</details>

### ⭐ Challenge 1.2 — Review the Incident Report Details
*Story:* The initial report from Moreau (`CitizenID 25`) is on your desk. Go over the details: when it happened, where, and what she initially told your colleague who took the report.  
*Task:* Retrieve all details from the incident report concerning the stolen Pegassi Vacca.  
*Intel Required:* Display **all columns** for the specific `IncidentID` you noted in the briefing.

<details>
<summary>Example Query Hint</summary>

```sql
SELECT *
FROM GTA.BCPD_Incidents
WHERE IncidentID = <IncidentID_StolenVacca>;
```
</details>

### ⭐ Challenge 1.3 — Profile Potential Auto Thieves
*Story:* This wasn't an amateur job; Moreau's security is top‑notch. We need a list of usual suspects.  
*Task:* Identify citizens who have a `Profession` indicating expertise in car‑theft **or** who have a `WantedLevel` ≥ 2.  
*Intel Required:* `CitizenID`, `Name`, `Alias`, `Profession`, `WantedLevel` — sorted by `WantedLevel` DESC then `Profession`.

<details>
<summary>Example Query Hint</summary>

```sql
SELECT CitizenID, Name, Alias, Profession, WantedLevel
FROM GTA.Citizens
WHERE Profession IN ('Escape Vehicle Pro', 'Pro Driver', 'Hustler', 'System Breaker', 'Wheelwoman')
   OR WantedLevel >= 2
ORDER BY WantedLevel DESC, Profession;
```
</details>

### ⭐ Challenge 1.4 — Check for a Pattern • Recent High‑End Thefts
*Story:* Is this an isolated incident or part of a larger spree? Check if any other 'Sports Car' or 'Superbike' type vehicles have been reported stolen.  
*Task:* Display all 'Sports Car' and 'Superbike' vehicles currently listed as stolen (`IsStolen = 1`). Include the owner's name.

<details>
<summary>Example Query Hint</summary>

```sql
SELECT
    V.VehicleID,
    C.Name AS OwnerName,
    V.Brand,
    V.Type
FROM GTA.Vehicles V
LEFT JOIN GTA.Citizens C ON V.OwnerID = C.CitizenID
WHERE V.IsStolen = 1
  AND V.Type IN ('Sports Car', 'Superbike');
```
</details>

---

## PHASE 2: Evidence Collection & Witness Intel

Your objective is to analyze available evidence and witness information to narrow down your suspect list.

### ⭐ Challenge 2.1 — Review CCTV Footage Log
*Story:* Forensics just processed the CCTV footage from Moreau's garage. Review the logged evidence details for any clues about the suspect or the method used.  
*Task:* Display the evidence record with `EvidenceType = 'CCTV Footage'` linked to the stolen‑Vacca incident.  
*Intel Required:* All columns from the relevant `GTA.BCPD_Evidence` record.

<details>
<summary>Example Query Hint</summary>

```sql
SELECT *
FROM GTA.BCPD_Evidence
WHERE IncidentID = <IncidentID_StolenVacca>
  AND EvidenceType = 'CCTV Footage';
```
</details>

### ⭐ Challenge 2.2 — Identify “Persons of Interest”
*Story:* Moreau mentioned a few names of people who recently showed a bit too much interest in her car. Check the `GTA.BCPD_Suspects_In_Incidents` table to see who we've officially flagged as *Persons of Interest*.  
*Task:* Display all suspects linked to the stolen‑Vacca `IncidentID`.  
*Intel Required:* `SuspectName`, `SuspectAlias`, `InvolvementLevel`, `Notes`.

<details>
<summary>Example Query Hint</summary>

```sql
SELECT
    S.Name  AS SuspectName,
    S.Alias AS SuspectAlias,
    SII.InvolvementLevel,
    SII.Notes
FROM GTA.BCPD_Suspects_In_Incidents SII
JOIN GTA.Citizens S
  ON SII.SuspectCitizenID = S.CitizenID
WHERE SII.IncidentID = <IncidentID_StolenVacca>;
```
</details>

### ⭐ Challenge 2.3 — Background Check • Vehicles & Hideouts of Key Suspects
*Story:* We have Freddie Finesse (`CitizenID 7`) and Sol Ramirez (`CitizenID 23`) on the list. What resources do they have?  
**Part A – Vehicles**  
*Task:* List all vehicles owned by Sofia “Sol” Ramirez and Frederick “Freddie Finesse” Canning.  
*Intel:* `OwnerName`, `Type`, `Brand`, `Speed`.

**Part B – Properties**  
*Task:* List all properties owned by the same two suspects, paying special attention to `GarageSlots`.  
*Intel:* `OwnerName`, `PropertyName`, `PropertyType`, `Location`, `GarageSlots`.

<details>
<summary>Example Query Hint (A – Vehicles)</summary>

```sql
SELECT
    C.Name AS OwnerName,
    V.Type,
    V.Brand,
    V.Speed
FROM GTA.Citizens C
JOIN GTA.Vehicles V
  ON C.CitizenID = V.OwnerID
WHERE C.CitizenID IN (7, 23)
ORDER BY C.Name, V.Speed DESC;
```
</details>

<details>
<summary>Example Query Hint (B – Properties)</summary>

```sql
SELECT
    C.Name AS OwnerName,
    P.PropertyName,
    P.PropertyType,
    P.Location,
    P.GarageSlots
FROM GTA.Citizens C
JOIN GTA.Properties P
  ON C.CitizenID = P.OwnerID
WHERE C.CitizenID IN (7, 23)
ORDER BY C.Name, P.GarageSlots DESC;
```
</details>

---

## PHASE 3: Closing In — The Takedown

> **Handler's Update:** An anonymous tip implicates **Sofia “Sol” Ramirez** (Citizen 23). She’s allegedly stashed the Vacca in a warehouse used by the **Street Racers Syndicate** (Faction 510) at the **Port of Bay City**. Time to verify and retrieve the vehicle!

### ⭐ Challenge 3.1 — Locate Faction Hideouts & Suspect Lairs
**Part 1 – Sol’s direct properties in the port**

Find properties owned by Sol Ramirez located near *“Port of Bay City”*.

**Part 2 – Properties of active Street Racers Syndicate members in the port**

Find properties owned by active members of Faction 510 located near the port.

<details>
<summary>Example Query Hint (Part 1)</summary>

```sql
SELECT
    C.Name        AS OwnerName,
    P.PropertyName,
    P.PropertyType,
    P.Location,
    P.GarageSlots
FROM GTA.Properties P
JOIN GTA.Citizens  C
  ON P.OwnerID = C.CitizenID
WHERE P.OwnerID = 23
  AND P.Location LIKE '%Port of Bay City%';
```
</details>

<details>
<summary>Example Query Hint (Part 2)</summary>

```sql
SELECT DISTINCT
    C_Owner.Name            AS PropertyOwner,
    P.PropertyName,
    P.PropertyType,
    P.Location,
    P.GarageSlots,
    C_Member_Alias.Alias    AS FactionMemberAssociated,
    F.Name                  AS FactionName
FROM GTA.Properties P
JOIN GTA.Citizens               C_Owner         ON P.OwnerID = C_Owner.CitizenID
JOIN GTA.CitizenFactionMembership CFM            ON C_Owner.CitizenID = CFM.CitizenID
JOIN GTA.Factions               F               ON CFM.FactionID    = F.FactionID
JOIN GTA.Citizens               C_Member_Alias  ON CFM.CitizenID    = C_Member_Alias.CitizenID
WHERE F.FactionID = 510
  AND CFM.IsActive = 1
  AND P.Location LIKE '%Port of Bay City%';
```
</details>

> **Handler's Update:** Patrol confirms visual on a red Pegassi Vacca at *Sol’s Waterfront Hideout (Pier 7)* (Property 407). Log the evidence and prepare to arrest.

### ⭐ Challenge 3.2 — Log the Recovered Vehicle as Evidence
Insert a new record into `GTA.BCPD_Evidence` linking Vehicle 121 to the incident.

<details>
<summary>Example INSERT</summary>

```sql
INSERT INTO GTA.BCPD_Evidence
    (IncidentID, CollectedByOfficerID, EvidenceType, Description,
     DateTimeCollected, LocationFound, LinkedVehicleID)
VALUES
    (<IncidentID_StolenVacca>,
     <YourBadgeID>,
     'Vehicle',
     'Recovered stolen red Pegassi Vacca, VIN matches victim''s vehicle. Found inside warehouse at Pier 7. Minor scratches on passenger side door.',
     GETDATE(),
     'Sol''s Waterfront Hideout (SRS Used), Pier 7, Port of Bay City',
     121);
```
</details>

### ⭐ Challenge 3.3 — Make the Arrest & Close the Case
**Part A – Arrest**  
Insert an arrest record for Sofia Ramirez (Citizen 23).

**Part B – Close Incident**  
Update `GTA.BCPD_Incidents.CurrentStatus` to `'Closed – Arrest'`.

**Part C – ( Bonus ) Update Wanted Level**  
Set Sofia’s `WantedLevel` to 4.

<details>
<summary>Example SQL</summary>

```sql
-- A: Arrest record
INSERT INTO GTA.BCPD_Arrests
    (IncidentID, ArrestedCitizenID, ArrestingOfficerID,
     DateTimeArrested, LocationOfArrest, ChargesFiled, BookingNotes)
VALUES
    (<IncidentID_StolenVacca>, 23, <YourBadgeID>, GETDATE(),
     'Sol''s Waterfront Hideout (SRS Used), Pier 7, Port of Bay City',
     'Grand Theft Auto (Sec 487 PC), Possession of Stolen Property (Sec 496 PC)',
     'Suspect apprehended at scene with stolen vehicle. Resisted initially but subdued without further incident. Vehicle recovered.');

-- B: Close the incident
UPDATE GTA.BCPD_Incidents
SET CurrentStatus = 'Closed - Arrest'
WHERE IncidentID = <IncidentID_StolenVacca>;

-- C: Bonus – increase wanted level
UPDATE GTA.Citizens
SET WantedLevel = 4
WHERE CitizenID = 23;
```
</details>

---

> **Handler's Commendation:** *Excellent work, Detective `<YourOfficerName>`! The Pegassi Vacca is back with its rightful owner, and Sol Ramirez is behind bars. Bay City salutes you. Case closed!*

**SYSTEM MESSAGE:** Case File `#<IncidentID_StolenVacca>` – **Closed.** Commendation Awarded.

---

