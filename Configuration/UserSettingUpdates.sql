/* 
	USER SETTING UPDATES
*/

--RAGING BARBARIANS BEGIN
UPDATE GlobalParameters
SET Value = -20
WHERE Name = 'BARBARIAN_BOLDNESS_PER_CAMP_ATTACK'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 25
WHERE Name = 'BARBARIAN_BOLDNESS_PER_KILL'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = -2
WHERE Name = 'BARBARIAN_BOLDNESS_PER_SCOUT_LOST'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 5
WHERE Name = 'BARBARIAN_BOLDNESS_PER_TURN'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = -5
WHERE Name = 'BARBARIAN_BOLDNESS_PER_UNIT_LOST'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 6
WHERE Name = 'BARBARIAN_CAMP_COASTAL_SPAWN_ROLL'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 1
WHERE Name = 'BARBARIAN_CAMP_EXTRA_DISTANCE_PER_LOW_DIFFICULTY'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 33
WHERE Name = 'BARBARIAN_CAMP_FIRST_TURN_PERCENT_OF_TARGET_TO_ADD'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 5
WHERE Name = 'BARBARIAN_CAMP_MAX_PER_MAJOR_CIV'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 5
WHERE Name = 'BARBARIAN_CAMP_MINIMUM_DISTANCE_ANOTHER_CAMP'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 4
WHERE Name = 'BARBARIAN_CAMP_MINIMUM_DISTANCE_CITY'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 4
WHERE Name = 'BARBARIAN_CAMP_ODDS_OF_NEW_CAMP_SPAWNING'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 4
WHERE Name = 'BARBARIAN_NUM_RANDOM_UNIT_CHOICES'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 20
WHERE Name = 'BARBARIAN_RELEASE_VARIATION'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE GlobalParameters
SET Value = 75
WHERE Name = 'BARBARIAN_TECH_PERCENT'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE BarbarianTribes
SET PercentRangedUnits = 50, TurnsToWarriorSpawn = 10, RaidingBoldness = 10, CityAttackBoldness = 25
WHERE TribeType = 'TRIBE_NAVAL'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE BarbarianTribes
SET PercentRangedUnits = 30, TurnsToWarriorSpawn = 15, RaidingBoldness = 10, CityAttackBoldness = 20
WHERE TribeType = 'TRIBE_CAVALRY'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);

UPDATE BarbarianTribes
SET PercentRangedUnits = 35, TurnsToWarriorSpawn = 10, RaidingBoldness = 10, CityAttackBoldness = 20
WHERE TribeType = 'TRIBE_MELEE'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_RAGING_BARBARIANS' AND Toggle = 1);
--RAGING BARBARIANS END

--SMALLER EUREKAS BEGIN
UPDATE Boosts
SET Boost = 40
WHERE EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_SMALLER_EUREKAS' AND Toggle = 1);

UPDATE Boosts
SET Boost = 25
WHERE EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_SMALLER_EUREKAS' AND Toggle = 2);

UPDATE Boosts
SET Boost = 10
WHERE EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_SMALLER_EUREKAS' AND Toggle = 3);
--SMALLER EUREKAS END

--SETTLERS COST 2 POPULATION BEGIN
UPDATE Units
SET PopulationCost = 2
WHERE UnitType = 'UNIT_SETTLER'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_SETTLER_POPULATION' AND Toggle = 1);
--SETTLERS COST 2 POPULATION END

--INCREASE DISTANCE BETWEEN CITIES BEGIN
UPDATE GlobalParameters
SET Value = 4
WHERE Name = 'CITY_MIN_RANGE'
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_MIN_CITY_RANGE' AND Toggle = 1);

UPDATE Buildings
SET RegionalRange = RegionalRange + 1
WHERE RegionalRange > 0 
AND EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_MIN_CITY_RANGE' AND Toggle = 1);

UPDATE GlobalParameters SET Value = (SELECT Value FROM GlobalParameters WHERE Name = 'CITY_MIN_RANGE') + 7 
WHERE Name = 'RELIGION_SPREAD_ADJACENT_CITY_DISTANCE';

UPDATE GlobalParameters SET Value = (SELECT Value FROM GlobalParameters WHERE Name = 'CITY_MIN_RANGE') + 6 
WHERE Name = 'START_DISTANCE_MAJOR_CIVILIZATION';

UPDATE GlobalParameters SET Value = (SELECT Value FROM GlobalParameters WHERE Name = 'CITY_MIN_RANGE') + 2 
WHERE Name = 'START_DISTANCE_MINOR_CIVILIZATION';
--INCREASE DISTANCE BETWEEN CITIES END

--INCREASED UNIT MOVEMENT BEGIN
UPDATE Units
SET BaseMoves = BaseMoves + 1
WHERE EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_QUOS_ROCKETBOOTS' AND Toggle = 1);

UPDATE Units
SET BaseMoves = BaseMoves + 2
WHERE EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_QUOS_ROCKETBOOTS' AND Toggle = 2);
--INVREASED UNIT MOVEMENT END

