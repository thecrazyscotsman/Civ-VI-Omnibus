--TYPES, TAGS, TYPETAGS
INSERT INTO Types (Type, Kind)
	VALUES
		("ABILITY_TCS_NAVAL_RAIDER_ENTER_FOREIGN_LANDS", "KIND_ABILITY");

INSERT INTO TypeTags (Type, Tag)
	VALUES
		("ABILITY_TCS_NAVAL_RAIDER_ENTER_FOREIGN_LANDS", "CLASS_NAVAL_RAIDER");

--UNIT ABILITIES
INSERT INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive)
	VALUES
		("ABILITY_TCS_NAVAL_RAIDER_ENTER_FOREIGN_LANDS", "LOC_ABILITY_TCS_NAVAL_RAIDER_ENTER_FOREIGN_LANDS_NAME", "LOC_ABILITY_TCS_NAVAL_RAIDER_ENTER_FOREIGN_LANDS_DESCRIPTION", 0);		

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
	VALUES
		("ABILITY_TCS_NAVAL_RAIDER_ENTER_FOREIGN_LANDS", "MOD_ENTER_FOREIGN_LANDS");
		
--UNITS
--Recon units get free level when created	
UPDATE Units 
	SET InitialLevel = 2 
	WHERE (UnitType = "UNIT_SCOUT") OR (UnitType = "UNIT_RANGER");
	
UPDATE Units
	SET Cost = 140, BuildCharges = 4
	WHERE UnitType = "UNIT_MILITARY_ENGINEER";
	
UPDATE Units
	SET PrereqDistrict = NULL
	WHERE UnitType = "UNIT_BIPLANE";

UPDATE Units
	SET PrereqDistrict = NULL
	WHERE UnitType = "UNIT_FIGHTER";

UPDATE Units
	SET PrereqDistrict = NULL
	WHERE UnitType = "UNIT_AMERICAN_P51";

UPDATE Units
	SET PrereqDistrict = NULL
	WHERE UnitType = "UNIT_JET_FIGHTER";	

--UNIT CAPTURES
--Settler becomes builder on capture
UPDATE UnitCaptures
	SET BecomesUnitType = "UNIT_BUILDER"
	WHERE CapturedUnitType = "UNIT_SETTLER";