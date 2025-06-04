-- Instructie: Voer dit script uit in de context van je 'Courses' database,
-- of pas de databasenaam aan indien nodig.
-- USE [Courses];
-- GO

--------------------------------------------------------------------------------
-- Stap 0A: Verwijder bestaande tabellen in de juiste volgorde
-- (omgekeerde van creatie / afhankelijkheid, meest afhankelijke eerst)
--------------------------------------------------------------------------------

IF OBJECT_ID('GTA.CitizenFactionMembership', 'U') IS NOT NULL
    DROP TABLE GTA.CitizenFactionMembership;
PRINT 'Tabel GTA.CitizenFactionMembership verwijderd (indien aanwezig).';
GO

IF OBJECT_ID('GTA.CitizenWeapons', 'U') IS NOT NULL
    DROP TABLE GTA.CitizenWeapons;
PRINT 'Tabel GTA.CitizenWeapons verwijderd (indien aanwezig).';
GO

IF OBJECT_ID('GTA.Assignments', 'U') IS NOT NULL
    DROP TABLE GTA.Assignments;
PRINT 'Tabel GTA.Assignments verwijderd (indien aanwezig).';
GO

IF OBJECT_ID('GTA.Properties', 'U') IS NOT NULL
    DROP TABLE GTA.Properties;
PRINT 'Tabel GTA.Properties verwijderd (indien aanwezig).';
GO

IF OBJECT_ID('GTA.Vehicles', 'U') IS NOT NULL
    DROP TABLE GTA.Vehicles;
PRINT 'Tabel GTA.Vehicles verwijderd (indien aanwezig).';
GO

-- Factions en Weapons kunnen Foreign Keys hebben naar Citizens (LeaderID),
-- maar ze worden zelf ook gerefereerd. De volgorde hier is belangrijk.
-- Als Factions een LeaderID heeft die naar Citizens verwijst, moet Citizens bestaan.
-- We verwijderen Factions voor Citizens om cyclysiche afhankelijkheden bij verwijderen te voorkomen,
-- aangenomen dat ON DELETE SET NULL is gebruikt voor LeaderID.

IF OBJECT_ID('GTA.Factions', 'U') IS NOT NULL
    DROP TABLE GTA.Factions;
PRINT 'Tabel GTA.Factions verwijderd (indien aanwezig).';
GO

IF OBJECT_ID('GTA.Weapons', 'U') IS NOT NULL
    DROP TABLE GTA.Weapons;
PRINT 'Tabel GTA.Weapons verwijderd (indien aanwezig).';
GO

IF OBJECT_ID('GTA.Missions', 'U') IS NOT NULL
    DROP TABLE GTA.Missions;
PRINT 'Tabel GTA.Missions verwijderd (indien aanwezig).';
GO

IF OBJECT_ID('GTA.Citizens', 'U') IS NOT NULL
    DROP TABLE GTA.Citizens;
PRINT 'Tabel GTA.Citizens verwijderd (indien aanwezig).';
GO

--------------------------------------------------------------------------------
-- Stap 0B: Maak het schema aan als het nog niet bestaat
--------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'GTA')
BEGIN
    EXEC('CREATE SCHEMA GTA');
    PRINT 'Schema GTA aangemaakt.';
END
ELSE
BEGIN
    PRINT 'Schema GTA bestaat al.';
END
GO

--------------------------------------------------------------------------------
-- Stap 1: Creëer tabellen (basis tabellen eerst, dan die met FKs)
--------------------------------------------------------------------------------

-- 📁 1. GTA.Citizens
-- Bevat informatie over alle spelers/personages in het spel.
CREATE TABLE GTA.Citizens (
    CitizenID INT PRIMARY KEY,              -- Uniek ID voor elke speler (geen IDENTITY, wordt expliciet opgegeven)
    Name NVARCHAR(100) NOT NULL,            -- Volledige naam
    Alias NVARCHAR(100) NULL,               -- Spelersalias of codenaam
    Age INT NULL,                           -- Leeftijd
    Profession NVARCHAR(100) NULL,          -- Rol of beroep
    WantedLevel INT DEFAULT 0 NULL,         -- Hoe gezocht iemand is (0–5)
    CONSTRAINT CK_Citizens_WantedLevel CHECK (WantedLevel >= 0 AND WantedLevel <= 5)
);
PRINT 'Tabel GTA.Citizens aangemaakt.';
GO

-- 📁 2. GTA.Missions
-- Bevat alle missies beschikbaar in het spel.
CREATE TABLE GTA.Missions (
    MissionID INT PRIMARY KEY,              -- Uniek ID voor missie (geen IDENTITY, wordt expliciet opgegeven)
    Title NVARCHAR(100) NOT NULL,           -- Titel van de missie
    Difficulty NVARCHAR(20) NULL,           -- Moeilijkheidsgraad (Easy/Hard/etc.)
    Reward MONEY NULL,                      -- Beloning bij succesvolle voltooiing
    Location NVARCHAR(100) NULL             -- Locatie van de missie
);
PRINT 'Tabel GTA.Missions aangemaakt.';
GO

-- 📁 3. GTA.Weapons
-- Bevat informatie over alle wapens beschikbaar in het spel.
CREATE TABLE GTA.Weapons (
    WeaponID INT PRIMARY KEY IDENTITY(301,1), -- Uniek ID voor elk wapen (start bij 301, auto increment)
    Name NVARCHAR(100) NOT NULL,            -- Naam van het wapen
    Type NVARCHAR(50) NOT NULL,             -- Soort wapen (Handgun, Shotgun, etc.)
    DamagePerShot INT NULL,                 -- Schade per schot/slag
    Range INT NULL,                         -- Effectief bereik in meters
    FireRate DECIMAL(5,2) NULL,             -- Schoten per seconde
    MagazineCapacity INT NULL,              -- Maximale munitie in een magazijn
    Price MONEY NULL                        -- Aankoopprijs van het wapen
);
PRINT 'Tabel GTA.Weapons aangemaakt.';
GO

-- 📁 4. GTA.Factions
-- Bevat informatie over de verschillende bendes, organisaties of facties in het spel.
CREATE TABLE GTA.Factions (
    FactionID INT PRIMARY KEY IDENTITY(501,1), -- Uniek ID voor elke factie (start bij 501, auto increment)
    Name NVARCHAR(100) NOT NULL UNIQUE,     -- Naam van de factie
    LeaderID INT NULL,                      -- Verwijzing naar CitizenID van de leider
    PrimaryColor NVARCHAR(50) NULL,         -- Kleur geassocieerd met de factie
    Turf NVARCHAR(255) NULL,                -- Beschrijving van hun primaire territorium
    DefaultRelation NVARCHAR(50) DEFAULT 'Neutral', -- Standaard relatie (Hostile, Neutral, Allied)
    Description NVARCHAR(MAX) NULL,         -- Korte beschrijving of achtergrond
    CONSTRAINT FK_Factions_Leader FOREIGN KEY (LeaderID) REFERENCES GTA.Citizens(CitizenID) ON DELETE SET NULL, -- Als leider wordt verwijderd, wordt LeaderID NULL
    CONSTRAINT CK_Factions_DefaultRelation CHECK (DefaultRelation IN ('Hostile', 'Neutral', 'Allied'))
);
PRINT 'Tabel GTA.Factions aangemaakt.';
GO

-- 📁 5. GTA.Vehicles
-- Bevat voertuigen die eigendom zijn van spelers (soms gestolen).
CREATE TABLE GTA.Vehicles (
    VehicleID INT PRIMARY KEY,              -- Uniek ID voor elk voertuig (geen IDENTITY, wordt expliciet opgegeven)
    OwnerID INT NULL,                       -- Verwijzing naar Citizens
    Type NVARCHAR(50) NOT NULL,             -- Soort voertuig (Scooter, SUV, etc.)
    Brand NVARCHAR(50) NULL,                -- Merk van het voertuig
    Speed INT NULL,                         -- Maximale snelheid
    IsStolen BIT DEFAULT 0 NOT NULL,        -- 1 = gestolen, 0 = legaal bezit
    CONSTRAINT FK_Vehicles_Owner FOREIGN KEY (OwnerID) REFERENCES GTA.Citizens(CitizenID) ON DELETE SET NULL -- Als eigenaar wordt verwijderd, wordt OwnerID NULL
);
PRINT 'Tabel GTA.Vehicles aangemaakt.';
GO

-- 📁 6. GTA.Assignments
-- Koppelt burgers aan missies die ze uitvoeren of hebben uitgevoerd.
CREATE TABLE GTA.Assignments (
    AssignmentID INT PRIMARY KEY IDENTITY(1,1), -- Uniek ID voor de koppeling (auto increment)
    CitizenID INT NOT NULL,                 -- Verwijzing naar Citizens
    MissionID INT NOT NULL,                 -- Verwijzing naar Missions
    Completed BIT DEFAULT 0 NOT NULL,       -- 1 = voltooid, 0 = bezig/niet gehaald
    TimeSpent INT NULL,                     -- Tijdsduur in minuten (NULL = open)
    CONSTRAINT FK_Assignments_Citizen FOREIGN KEY (CitizenID) REFERENCES GTA.Citizens(CitizenID) ON DELETE CASCADE, -- Als burger wordt verwijderd, verwijder assignment
    CONSTRAINT FK_Assignments_Mission FOREIGN KEY (MissionID) REFERENCES GTA.Missions(MissionID) ON DELETE CASCADE, -- Als missie wordt verwijderd, verwijder assignment
    CONSTRAINT UQ_Assignments_CitizenMission UNIQUE (CitizenID, MissionID) -- Een burger kan een missie maar één keer toegewezen krijgen
);
PRINT 'Tabel GTA.Assignments aangemaakt.';
GO

-- 📁 7. GTA.CitizenWeapons
-- Koppelt burgers aan wapens die ze bezitten en hoe ze zijn uitgerust.
CREATE TABLE GTA.CitizenWeapons (
    CitizenWeaponID INT PRIMARY KEY IDENTITY(1,1), -- Uniek ID (auto increment)
    CitizenID INT NOT NULL,                 -- Verwijzing naar GTA.Citizens
    WeaponID INT NOT NULL,                  -- Verwijzing naar GTA.Weapons
    CurrentAmmoInMagazine INT NULL,         -- Huidige munitie in het magazijn
    TotalReserveAmmo INT NULL,              -- Totale reservemunitie
    AcquiredDateTime DATETIME DEFAULT GETDATE() NOT NULL, -- Datum en tijdstip van verkrijging
    IsEquipped BIT DEFAULT 0 NOT NULL,      -- 1 = momenteel geselecteerd/actief
    CONSTRAINT FK_CitizenWeapons_Citizen FOREIGN KEY (CitizenID) REFERENCES GTA.Citizens(CitizenID) ON DELETE CASCADE, -- Als burger wordt verwijderd, verwijder wapenbezit
    CONSTRAINT FK_CitizenWeapons_Weapon FOREIGN KEY (WeaponID) REFERENCES GTA.Weapons(WeaponID) ON DELETE CASCADE -- Als wapen (type) wordt verwijderd, verwijder wapenbezit
);
PRINT 'Tabel GTA.CitizenWeapons aangemaakt.';
GO

-- 📁 8. GTA.Properties
-- Bevat informatie over onroerend goed dat burgers kunnen bezitten.
CREATE TABLE GTA.Properties (
    PropertyID INT PRIMARY KEY IDENTITY(401,1), -- Uniek ID voor elk eigendom (start bij 401, auto increment)
    OwnerID INT NULL,                       -- Verwijzing naar GTA.Citizens (NULL indien niet in bezit)
    PropertyName NVARCHAR(150) NOT NULL,    -- Naam van het eigendom
    PropertyType NVARCHAR(50) NOT NULL,     -- Soort eigendom (Safehouse, Garage, Business)
    Location NVARCHAR(100) NOT NULL,        -- Adres of locatie van het eigendom
    PurchasePrice MONEY NULL,               -- Aankoopprijs
    MarketValue MONEY NULL,                 -- Huidige marktwaarde
    DailyIncome MONEY DEFAULT 0 NULL,       -- Dagelijkse inkomsten (voor bedrijven)
    GarageSlots INT DEFAULT 0 NULL,         -- Aantal parkeerplaatsen
    LastAccessed DATETIME NULL,             -- Wanneer voor het laatst bezocht/gebruikt
    CONSTRAINT FK_Properties_Owner FOREIGN KEY (OwnerID) REFERENCES GTA.Citizens(CitizenID) ON DELETE SET NULL -- Als eigenaar wordt verwijderd, wordt OwnerID NULL
);
PRINT 'Tabel GTA.Properties aangemaakt.';
GO

-- 📁 9. GTA.CitizenFactionMembership
-- Koppelt burgers aan facties en beschrijft hun relatie/status.
CREATE TABLE GTA.CitizenFactionMembership (
    MembershipID INT PRIMARY KEY IDENTITY(1,1), -- Uniek ID (auto increment)
    CitizenID INT NOT NULL,                 -- Verwijzing naar GTA.Citizens
    FactionID INT NOT NULL,                 -- Verwijzing naar GTA.Factions
    Rank NVARCHAR(50) NULL,                 -- Rang of rol binnen de factie
    JoinDate DATE NULL,                     -- Datum van toetreding
    PersonalReputation INT DEFAULT 0 NULL,  -- Persoonlijke reputatie (-100 tot 100)
    IsActive BIT DEFAULT 1 NOT NULL,        -- 1 = actief lid/relatie, 0 = inactief
    CONSTRAINT FK_Membership_Citizen FOREIGN KEY (CitizenID) REFERENCES GTA.Citizens(CitizenID) ON DELETE CASCADE, -- Als burger wordt verwijderd, verwijder lidmaatschap
    CONSTRAINT FK_Membership_Faction FOREIGN KEY (FactionID) REFERENCES GTA.Factions(FactionID) ON DELETE CASCADE, -- Als factie wordt verwijderd, verwijder lidmaatschap
    CONSTRAINT UQ_Membership_CitizenFaction UNIQUE (CitizenID, FactionID), -- Burger kan maar 1x (actief) lid zijn van een specifieke factie
    CONSTRAINT CK_Membership_PersonalReputation CHECK (PersonalReputation BETWEEN -100 AND 100)
);
PRINT 'Tabel GTA.CitizenFactionMembership aangemaakt.';
GO

--------------------------------------------------------------------------------
-- Script voltooid. Alle tabellen in schema GTA zijn gedefinieerd.
--------------------------------------------------------------------------------
PRINT 'Volledige GTA database structuur is (her)aangemaakt.';
GO

--------------------------------------------------------------------------------
-- INSERT STATEMENTS voor GTA Schema
-- Doel: Uitgebreide dataset die past bij de challenges en verdere analyse.
--------------------------------------------------------------------------------

-- Zorg ervoor dat de tabellen leeg zijn als je dit script herhaaldelijk uitvoert
-- na het CREATE script. Anders krijg je Primary Key violations.
-- Als je het CREATE script (met DROP TABLEs) al hebt gedraaid, is dit niet nodig.
/*
DELETE FROM GTA.CitizenFactionMembership;
DELETE FROM GTA.CitizenWeapons;
DELETE FROM GTA.Assignments;
DELETE FROM GTA.Properties;
DELETE FROM GTA.Vehicles;
DELETE FROM GTA.Factions;
DELETE FROM GTA.Weapons;
DELETE FROM GTA.Missions;
DELETE FROM GTA.Citizens;
PRINT 'Bestaande data uit GTA tabellen verwijderd (indien nodig).';
GO
*/

--------------------------------------------------------------------------------
-- Data voor GTA.Citizens
-- (Gebaseerd op de data voor de challenges + aanvullingen)
--------------------------------------------------------------------------------
PRINT 'Bezig met invoegen data in GTA.Citizens...';
-- Geen SET IDENTITY_INSERT nodig, CitizenID is geen IDENTITY
INSERT INTO GTA.Citizens (CitizenID, Name, Alias, Age, Profession, WantedLevel) VALUES
(1, 'Remsey Mailjard', 'The Architect', 33, 'Trainer & Fixer', 1),
(2, 'Chi-neme-rem Agana', 'Ghostface', 24, 'Surveillance Expert', 2),
(3, 'Kevin Gagante', 'Sunset Sniper', 25, 'Undercover Analyst', 0),
(4, 'Cricelia Prado', 'Ice Driver', 22, 'Escape Vehicle Pro', 1),
(5, 'Claudia Trejo', 'Codewitch', 23, 'Tech Operative', 0),
(6, 'Marq Alejandro', 'Firewall', 25, 'System Breaker', 2),
(7, 'Frederick Canning', 'Freddie Finesse', 24, 'Hustler', 3),
(8, 'Abe Ghani', 'Cipher King', 25, 'Intel Broker', 1),
(9, 'Abdulkadir Yanar', 'Yanar The Watcher', 30, 'Data Analyst', 0),
(10, 'Emilya Illeeva', 'E-Mage', 26, 'Cyber Strategist', 0),
(11, 'Hayat Khayotbek Azimov', 'Silent Bit', 23, 'Stealth Dev', 1),
(12, 'Jon Y', 'Blade Runner', 24, 'Script Specialist', 1),
(13, 'Jakeyl Millan', 'Beardstorm', 25, 'Recon Scout', 2),
(14, 'J Torres', 'Midnight Mapper', 28, 'Dark Web Mapper', 2),
(15, 'Jacob Ramos', 'Data Drifter', 22, 'Bike Messenger', 1),
(16, 'David Dorsey', 'Gridlock', 29, 'Traffic Jammer', 1),
(17, 'Mahmoud Boukhelkhal', 'Red B', 25, 'Gear Specialist', 0), -- Naam gecorrigeerd
(18, 'Jakari Wilson', 'Tiny Tank', 1, 'Future Boss Baby', 0),
(19, 'Jesse Hernandez', 'Just Jesse', 27, 'Fixer', 0),
(20, 'Amine', 'Silent AM', 28, 'Network Sleeper', 1),
-- Extra burgers voor meer variatie
(21, 'Lena Petrova', 'Viper', 29, 'Assassin', 4),
(22, 'Marcus "Mac" Chen', 'Technomancer', 35, 'Gadgeteer', 1),
(23, 'Sofia "Sol" Ramirez', 'Wheelwoman', 26, 'Pro Driver', 2),
(24, 'Viktor "The Vulture" Orlov', 'Arms Dealer', 45, 'Supplier', 5),
(25, 'Isabelle "Izzy" Moreau', 'Mastermind', 31, 'Heist Planner', 0),
(26, 'Rajesh "Raja" Kumar', 'The Voice', 38, 'Negotiator', 1),
(27, 'Kenji "Katana" Tanaka', 'Ronin', 33, 'Enforcer', 3),
(28, 'Daria "Domino" Volkova', 'Infiltrator', 27, 'Spy', 2),
(29, 'Omar "The Oracle" Hassan', 'Infochant', 40, 'Information Broker', 1),
(30, 'Nina "Nightshade" Kim', 'Shadow', 22, 'Stealth Operative', 0);
PRINT 'Data ingevoegd in GTA.Citizens.';
GO

--------------------------------------------------------------------------------
-- Data voor GTA.Missions
-- (Gebaseerd op de data voor de challenges + aanvullingen)
--------------------------------------------------------------------------------
PRINT 'Bezig met invoegen data in GTA.Missions...';
-- Geen SET IDENTITY_INSERT nodig, MissionID is geen IDENTITY
INSERT INTO GTA.Missions (MissionID, Title, Difficulty, Reward, Location) VALUES
(201, 'Bay Bridge Data Drop', 'Medium', 3000.00, 'Bay Bridge'),
(202, 'Pier 39 Network Heist', 'Hard', 5000.00, 'Fisherman''s Wharf'),
(203, 'Chinatown Chase', 'Easy', 1500.00, 'Chinatown'),
(204, 'Silicon Sweep', 'Medium', 3500.00, 'SoMa District'),
(205, 'Golden Gate Extraction', 'Hard', 6000.00, 'Golden Gate Park'),
-- Extra missies
(206, 'Alcatraz Infiltration', 'Very Hard', 10000.00, 'Alcatraz Island'),
(207, 'Lombard Street Getaway', 'Medium', 4000.00, 'Lombard Street'),
(208, 'Tech Startup Takedown', 'Hard', 7500.00, 'Financial District'),
(209, 'The Docks Deal', 'Easy', 2000.00, 'Port of Bay City'),
(210, 'Mayoral Candidate Escort', 'Medium', 3800.00, 'City Hall'),
(211, 'Museum Heist Prep', 'Hard', 5500.00, 'Bay City Museum of Art'),
(212, 'Rival Gang Disruption', 'Medium', 4200.00, 'The Mission District'),
(213, 'Secure the Server Farm', 'Very Hard', 12000.00, 'Silicon Valley Outpost'),
(214, 'Witness Protection Detail', 'Easy', 2500.00, 'Suburban Safehouse'),
(215, 'Smuggler''s Run Intercept', 'Hard', 6800.00, 'Coastal Highway');
PRINT 'Data ingevoegd in GTA.Missions.';
GO

--------------------------------------------------------------------------------
-- Data voor GTA.Weapons (WeaponID is IDENTITY, start bij 301)
--------------------------------------------------------------------------------
PRINT 'Bezig met invoegen data in GTA.Weapons...';
INSERT INTO GTA.Weapons (Name, Type, DamagePerShot, Range, FireRate, MagazineCapacity, Price) VALUES
('Pistol 9mm', 'Handgun', 25, 50, 5.0, 12, 500.00),             -- ID 301
('Combat Shotgun', 'Shotgun', 150, 30, 1.5, 8, 2500.00),        -- ID 302
('Assault Rifle', 'Rifle', 35, 100, 10.0, 30, 3200.00),         -- ID 303
('Sniper Rifle', 'Rifle', 150, 500, 0.5, 5, 10000.00),          -- ID 304
('Baseball Bat', 'Melee', 40, 2, NULL, NULL, 100.00),          -- ID 305
('Grenade', 'Throwable', 200, 20, NULL, NULL, 250.00),         -- ID 306
-- Extra wapens
('Heavy Pistol', 'Handgun', 40, 60, 3.0, 9, 1200.00),           -- ID 307
('SMG', 'Submachine Gun', 20, 70, 12.0, 30, 2800.00),           -- ID 308
('Carbine Rifle', 'Rifle', 40, 120, 8.0, 30, 4500.00),          -- ID 309
('Marksman Rifle', 'Rifle', 70, 300, 2.0, 10, 7000.00),         -- ID 310
('Knife', 'Melee', 30, 1, NULL, NULL, 50.00),                  -- ID 311
('Molotov Cocktail', 'Throwable', 50, 15, NULL, NULL, 150.00), -- ID 312 (DPS over time)
('Stun Gun', 'Special', 5, 10, 1.0, 1, 800.00),                -- ID 313 (low damage, incapacitates)
('RPG', 'Heavy', 500, 200, 0.2, 1, 25000.00),                  -- ID 314
('Micro SMG', 'Submachine Gun', 18, 40, 15.0, 20, 1500.00),     -- ID 315
('Pump Shotgun', 'Shotgun', 120, 25, 1.0, 6, 1800.00);         -- ID 316
PRINT 'Data ingevoegd in GTA.Weapons.';
GO

--------------------------------------------------------------------------------
-- Data voor GTA.Factions (FactionID is IDENTITY, start bij 501)
--------------------------------------------------------------------------------
PRINT 'Bezig met invoegen data in GTA.Factions...';
INSERT INTO GTA.Factions (Name, LeaderID, PrimaryColor, Turf, DefaultRelation, Description) VALUES
('The Vagos', 7, 'Yellow', 'Rancho, East LS', 'Hostile', 'A prominent Mexican street gang, known for drug trafficking and lowriders.'), -- ID 501 (Freddie Finesse)
('Ballas', 6, 'Purple', 'Grove Street, Davis', 'Hostile', 'An African-American street gang, bitter rivals of the Grove Street Families, involved in narcotics.'), -- ID 502 (Marq Alejandro)
('FIB Task Force', NULL, 'Dark Blue', 'Pillbox Hill FIB Building', 'Neutral', 'Federal Investigation Bureau special operations unit, often overzealous.'), -- ID 503
('The Lost MC', 13, 'Black', 'East Vinewood, Blaine County', 'Hostile', 'An outlaw motorcycle club, dealing in weapons and meth.'), -- ID 504 (Jakeyl Millan)
-- Extra facties
('Triads', 22, 'Red', 'Chinatown', 'Neutral', 'A Chinese crime syndicate, involved in gambling, extortion, and smuggling. Led by Mac Chen.'), -- ID 505
('Russian Mafia (Bratva)', 24, 'Maroon', 'Hove Beach (Bay City equivalent)', 'Hostile', 'Ruthless Russian organized crime group, led by Viktor Orlov.'), -- ID 506
('CyberSec Mercs', 10, 'Silver', 'Mobile, various tech hubs', 'Neutral', 'A group of elite hackers and tech specialists for hire, led by E-Mage.'), -- ID 507
('The Dockers Union', 16, 'Brown', 'Port of Bay City', 'Neutral', 'Powerful and corrupt union controlling the docks, led by David Dorsey.'), -- ID 508
('The Cleaners', 21, 'White', 'No fixed turf, operates discreetly', 'Hostile', 'A shadowy organization of assassins for hire, Lena Petrova is a high-ranking member.'), -- ID 509
('Street Racers Syndicate', 23, 'Neon Green', 'Underground race circuits city-wide', 'Neutral', 'Organized illegal street racing, Sol Ramirez is a known figure.'); -- ID 510
PRINT 'Data ingevoegd in GTA.Factions.';
GO

--------------------------------------------------------------------------------
-- Data voor GTA.Vehicles
-- (Gebaseerd op de data voor de challenges + aanvullingen)
--------------------------------------------------------------------------------
PRINT 'Bezig met invoegen data in GTA.Vehicles...';
-- Geen SET IDENTITY_INSERT nodig, VehicleID is geen IDENTITY
INSERT INTO GTA.Vehicles (VehicleID, OwnerID, Type, Brand, Speed, IsStolen) VALUES
(101, 1, 'Motorcycle', 'ShadowRider', 110, 1),    -- Remsey
(102, 4, 'SUV', 'CyberCruzer', 85, 0),        -- Cricelia
(103, 6, 'Sedan', 'ByteMobile', 75, 0),         -- Marq
(104, 13, 'Scooter', 'Zoomie', 45, 1),         -- Jakeyl
(105, 15, 'Bike', 'Fixie', 35, 0),            -- Jacob
(106, 14, 'Van', 'StealthWagon', 60, 1),       -- J Torres
-- Extra voertuigen
(107, 21, 'Sports Car', 'Banshee', 150, 0),     -- Lena
(108, 22, 'Armored Van', 'Stockade', 70, 0),    -- Mac Chen
(109, 23, 'Tuner Car', 'Sultan RS', 140, 1),    -- Sol Ramirez (stolen for a race)
(110, 24, 'Luxury SUV', 'Patriot', 90, 0),      -- Viktor Orlov
(111, 25, 'Muscle Car', 'Dominator', 130, 0),   -- Isabelle Moreau
(112, 7, 'Lowrider', 'Manana', 80, 0),          -- Freddie Finesse
(113, 10, 'Electric Car', 'Volt', 100, 0),      -- Emilya Illeeva
(114, 27, 'Superbike', 'Akuma', 160, 1),        -- Kenji Tanaka
(115, 2, 'Sedan', 'Oracle', 120, 0),            -- Chi-neme-rem
(116, 5, 'Hatchback', 'Blista Kanjo', 95, 0),   -- Claudia Trejo
(117, 1, 'Sports Bike', 'PCJ-600', 145, 0),     -- Remsey (another one)
(118, NULL, 'Sedan', 'Taxi', 80, 0),            -- Unowned Taxi
(119, 29, 'Classic Car', 'Stinger GT', 125, 0), -- Omar Hassan
(120, 30, 'Motorcycle', 'Nightblade', 115, 1);   -- Nina Kim
PRINT 'Data ingevoegd in GTA.Vehicles.';
GO

--------------------------------------------------------------------------------
-- Data voor GTA.Assignments (AssignmentID is IDENTITY)
-- (Gebaseerd op de data voor de challenges + aanvullingen)
--------------------------------------------------------------------------------
PRINT 'Bezig met invoegen data in GTA.Assignments...';
INSERT INTO GTA.Assignments (CitizenID, MissionID, Completed, TimeSpent) VALUES
-- Challenge data
(1, 201, 1, 40),  -- Remsey, Bay Bridge Data Drop
(6, 202, 1, 60),  -- Marq, Pier 39 Network Heist
(4, 203, 1, 25),  -- Cricelia, Chinatown Chase
(13, 204, 0, NULL),-- Jakeyl, Silicon Sweep (niet voltooid)
(5, 205, 1, 55),  -- Claudia, Golden Gate Extraction
(7, 202, 0, NULL),-- Freddie, Pier 39 Network Heist (niet voltooid)
(2, 203, 1, 20),  -- Chi-neme-rem, Chinatown Chase
-- Extra assignments voor meer variatie en om Mission 5 mogelijk te maken
(1, 207, 1, 30),  -- Remsey, Lombard Street Getaway
(5, 206, 1, 120), -- Claudia, Alcatraz Infiltration (Nu heeft Claudia 2 missies, totaal >4k)
(10, 204, 1, 45), -- Emilya, Silicon Sweep
(10, 208, 1, 90), -- Emilya, Tech Startup Takedown (Nu heeft Emilya 2 missies, totaal >4k)
(21, 206, 1, 110),-- Lena, Alcatraz Infiltration
(21, 215, 1, 70), -- Lena, Smuggler's Run Intercept
(22, 208, 0, NULL),-- Mac, Tech Startup Takedown (niet voltooid)
(23, 207, 1, 28), -- Sol, Lombard Street Getaway
(24, 209, 1, 15), -- Viktor, The Docks Deal
(25, 211, 1, 150),-- Isabelle, Museum Heist Prep
(27, 212, 1, 50), -- Kenji, Rival Gang Disruption
(28, 201, 1, 35), -- Daria, Bay Bridge Data Drop
(30, 214, 1, 22), -- Nina, Witness Protection Detail
(7, 209, 1, 18),  -- Freddie, The Docks Deal (een voltooide missie)
(14, 213, 0, NULL),-- J Torres, Secure the Server Farm (niet voltooid)
(11, 204, 1, 50); -- Hayat, Silicon Sweep
PRINT 'Data ingevoegd in GTA.Assignments.';
GO

--------------------------------------------------------------------------------
-- Data voor GTA.CitizenWeapons (CitizenWeaponID is IDENTITY)
-- WeaponIDs: 301 (Pistol 9mm), 302 (Combat Shotgun), 303 (Assault Rifle), 304 (Sniper),
-- 305 (Bat), 306 (Grenade), 307 (Heavy Pistol), 308 (SMG), 309 (Carbine), etc.
--------------------------------------------------------------------------------
PRINT 'Bezig met invoegen data in GTA.CitizenWeapons...';
INSERT INTO GTA.CitizenWeapons (CitizenID, WeaponID, CurrentAmmoInMagazine, TotalReserveAmmo, IsEquipped, AcquiredDateTime) VALUES
-- Challenge-gerelateerde data (als voorbeeld)
(1, 301, 12, 48, 1, GETDATE()-10),  -- Remsey met Pistol 9mm
(1, 303, 25, 90, 0, GETDATE()-9),   -- Remsey ook een Assault Rifle
(4, 302, 8, 16, 1, GETDATE()-8),   -- Cricelia met Combat Shotgun
(7, 305, NULL, NULL, 1, GETDATE()-7),-- Freddie met Baseball Bat
(13, 304, 5, 10, 0, GETDATE()-6),  -- Jakeyl met Sniper Rifle
-- Uitgebreide data
(2, 313, 1, 5, 1, GETDATE()-5),    -- Chi-neme-rem met Stun Gun
(5, 308, 30, 120, 1, GETDATE()-4), -- Claudia met SMG
(6, 309, 30, 90, 1, GETDATE()-3),  -- Marq met Carbine Rifle
(10, 307, 9, 36, 1, GETDATE()-2),  -- Emilya met Heavy Pistol
(14, 303, 15, 60, 0, GETDATE()-1),  -- J Torres met Assault Rifle
(21, 304, 5, 15, 1, GETDATE()-15), -- Lena met Sniper Rifle
(21, 311, NULL, NULL, 0, GETDATE()-14),-- Lena ook een Knife
(22, 314, 1, 2, 0, GETDATE()-13),  -- Mac Chen met RPG (niet uitgerust)
(23, 301, 10, 30, 1, GETDATE()-12), -- Sol Ramirez met Pistol 9mm
(24, 302, 6, 24, 1, GETDATE()-11), -- Viktor Orlov met Combat Shotgun
(24, 309, 28, 112, 0, GETDATE()-10),-- Viktor ook Carbine Rifle
(27, 310, 10, 20, 1, GETDATE()-9), -- Kenji Tanaka met Marksman Rifle (Katana is geen wapen in deze tabel)
(28, 315, 20, 80, 1, GETDATE()-8), -- Daria Volkova met Micro SMG
(30, 311, NULL, NULL, 1, GETDATE()-7); -- Nina Kim met Knife
PRINT 'Data ingevoegd in GTA.CitizenWeapons.';
GO

--------------------------------------------------------------------------------
-- Data voor GTA.Properties (PropertyID is IDENTITY, start bij 401)
--------------------------------------------------------------------------------
PRINT 'Bezig met invoegen data in GTA.Properties...';
INSERT INTO GTA.Properties (OwnerID, PropertyName, PropertyType, Location, PurchasePrice, MarketValue, DailyIncome, GarageSlots, LastAccessed) VALUES
-- Challenge-gerelateerde data (als voorbeeld)
(1, 'The Architect''s Loft', 'Safehouse', 'Downtown Vinewood', 250000, 275000, 0, 2, GETDATE()-5),   -- Remsey
(6, 'Firewall''s Hideout', 'Garage', 'Strawberry', 75000, 80000, 0, 6, GETDATE()-4),       -- Marq
(14, 'Midnight Mappers HQ', 'Office', 'Del Perro Pier', 500000, 550000, 1000, 0, GETDATE()-3), -- J Torres
(NULL, 'Abandoned Warehouse', 'Warehouse', 'Port of LS', 0, 150000, 0, 0, NULL),
(5, 'Codewitch''s Server Farm', 'Business', 'La Mesa', 800000, 950000, 5000, 1, GETDATE()-2),-- Claudia
-- Uitgebreide data
(7, 'Freddie''s Pad', 'Safehouse', 'East LS Apartment', 120000, 130000, 0, 1, GETDATE()-10),
(10, 'E-Mage''s Penthouse', 'Luxury Apartment', 'Rockford Hills', 1500000, 1650000, 0, 3, GETDATE()-9),
(13, 'Beardstorm''s Bunker', 'Safehouse', 'Blaine County Trailer', 50000, 55000, 0, 2, GETDATE()-8),
(21, 'Viper''s Nest', 'Luxury Apartment', 'West Vinewood Heights', 1200000, 1350000, 0, 2, GETDATE()-7),
(24, 'Orlov''s Import/Export Garage', 'Business', 'Elysian Island Docks', 750000, 820000, 6000, 10, GETDATE()-6),
(25, 'The Planning Room', 'Office', 'Pillbox Hill Skyscraper', 600000, 680000, 1500, 0, GETDATE()-5),
(27, 'Tanaka Dojo', 'Safehouse', 'Little Seoul', 200000, 220000, 0, 1, GETDATE()-4),
(NULL, 'Derelict Motel', 'Safehouse', 'Sandy Shores', 25000, 20000, 0, 1, NULL),
(2, 'Ghostface''s Lookout', 'Apartment', 'Vespucci Canals', 300000, 310000, 0, 1, GETDATE()-3),
(16, 'Gridlock''s Garage & Chop Shop', 'Business', 'La Puerta Industrial', 400000, 450000, 3500, 8, GETDATE()-2);
PRINT 'Data ingevoegd in GTA.Properties.';
GO

--------------------------------------------------------------------------------
-- Data voor GTA.CitizenFactionMembership (MembershipID is IDENTITY)
-- FactionIDs: 501 (Vagos), 502 (Ballas), 503 (FIB), 504 (Lost MC),
-- 505 (Triads), 506 (Bratva), 507 (CyberSec), 508 (Dockers), 509 (Cleaners), 510 (Racers)
--------------------------------------------------------------------------------
PRINT 'Bezig met invoegen data in GTA.CitizenFactionMembership...';
INSERT INTO GTA.CitizenFactionMembership (CitizenID, FactionID, Rank, JoinDate, PersonalReputation, IsActive) VALUES
-- Challenge-gerelateerde data (als voorbeeld)
(7, 501, 'El Jefe', '2022-01-15', 90, 1),      -- Freddie is leider Vagos
(6, 502, 'OG', '2021-05-10', 85, 1),          -- Marq is OG Ballas
(13, 504, 'President', '2020-03-01', 95, 1),   -- Jakeyl is President Lost MC
(2, 503, 'Informant', '2023-06-01', 20, 1),   -- Chi-neme-rem is informant voor FIB
(3, 503, 'Analyst', '2023-02-20', 15, 1),     -- Kevin is analist voor FIB
(1, 502, 'Associate', '2023-11-01', -10, 1),  -- Remsey is geassocieerd met Ballas (slechte repu)
-- Uitgebreide data
(21, 509, 'Senior Agent', '2022-08-10', 70, 1), -- Lena, The Cleaners
(22, 505, 'Dragon Head Advisor', '2021-12-05', 80, 1), -- Mac Chen, Triads (LeaderID in Factions tabel)
(23, 510, 'Lead Driver', '2023-01-20', 60, 1), -- Sol Ramirez, Street Racers
(24, 506, 'Pakhan (Godfather)', '2019-07-01', 98, 1), -- Viktor Orlov, Bratva (LeaderID in Factions tabel)
(27, 505, 'Enforcer', '2022-04-11', 50, 1),    -- Kenji Tanaka, Triads
(28, 506, 'Operative', '2023-03-03', 30, 1),   -- Daria Volkova, Bratva (infiltrating or member)
(10, 507, 'Lead Operator', '2020-01-01', 88, 1),-- Emilya, CyberSec Mercs (LeaderID in Factions)
(11, 507, 'Junior Operator', '2022-06-15', 40, 1),-- Hayat, CyberSec Mercs
(16, 508, 'Union Boss', '2018-05-20', 75, 1),  -- David Dorsey, Dockers Union (LeaderID in Factions)
(15, 508, 'Docker', '2023-09-01', 10, 1),     -- Jacob Ramos, Dockers Union
(4, 510, 'Prospect', '2023-10-05', 5, 1),      -- Cricelia, Street Racers
(19, 501, 'Soldado', '2023-07-10', 25, 1),    -- Jesse Hernandez, Vagos
(20, 503, 'Asset', '2023-08-15', -5, 1);       -- Amine, FIB (reluctant asset)
PRINT 'Data ingevoegd in GTA.CitizenFactionMembership.';
GO

PRINT 'Alle uitgebreide data is ingevoegd in het GTA schema!';
GO