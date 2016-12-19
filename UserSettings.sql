---------------------------------------------------------------------
/* 
	
	USER SETTINGS
	-------------------
	Omnibus_UserSettings 
	by thecrazyscotsman

*/
---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Omnibus_UserSettings
	(
	Setting TEXT DEFAULT NULL,
	Toggle INTEGER DEFAULT 0
	);

---------------------------------------------------------------------
/*

	SETTINGS:
	-- Raging Barbarians
	-- Reduce Eureka Bonuses
	-- Increase Settler Population Cost
	-- Increase Distance Between Cities
	-- Increase All Unit Movement
	-- Aqueduct +Food to Adjacent Tiles (planned)

*/	
---------------------------------------------------------------------
INSERT INTO Omnibus_UserSettings
	VALUES
		--Enables raging barbarians in all rulesets
			-- 0 = Disabled (Default)
			-- 1 = Enabled
		('TCS_RAGING_BARBARIANS',				0), 
		
		--Reduces Eureka bonuses in all rulesets
			-- 0 = Disabled (Default)
			-- 1 = Eurekas reduced to 40%
			-- 2 = Eurekas reduced to 25%
			-- 3 = Eurekas reduced to 10%
		('TCS_SMALLER_EUREKAS',					0),
		
		--Increases Settler population cost to 2 in all rulesets
			-- 0 = Disabled (Default)
			-- 1 = Enabled
		('TCS_SETTLER_POPULATION',				0),
		
		--Increase distance between cities in all rulesets
			-- 0 = Disabled (Default)
			-- 1 = Increase city distance to 4
		('TCS_MIN_CITY_RANGE',						0),
		
		--Increases all unit movement in all rulesets
			-- 0 = Disabled (Default)
			-- 1 = All movement increased by 1
			-- 2 = All movement increased by 2
		('TCS_QUOS_ROCKETBOOTS',				0);
