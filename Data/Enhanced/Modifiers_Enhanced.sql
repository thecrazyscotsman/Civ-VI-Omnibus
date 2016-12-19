INSERT INTO Types (Type, Kind)
	VALUES
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "KIND_ABILITY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT", "KIND_ABILITY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL", "KIND_ABILITY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH", "KIND_ABILITY");

INSERT INTO Tags (Tag, Vocabulary)
	VALUES
		("CLASS_MILITARY_ENGINEER", "ABILITY_CLASS");
		
INSERT INTO TypeTags (Type, Tag)
	VALUES
		("UNIT_MILITARY_ENGINEER", "CLASS_MILITARY_ENGINEER"),
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "CLASS_MILITARY_ENGINEER"),
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "CLASS_MELEE"),
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "CLASS_RANGED"),
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "CLASS_ANTI_CAVALRY"),
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "CLASS_MELEE_BERSERKER"),
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "CLASS_RECON"),
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "CLASS_REDCOAT"),
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "CLASS_NAGAO"),
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "CLASS_GARDE"),
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "CLASS_HOPLITE"),
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "CLASS_SAMURAI"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT", "CLASS_RECON"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT", "CLASS_MELEE"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT", "CLASS_RANGED"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT", "CLASS_ANTI_CAVALRY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT", "CLASS_SIEGE"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT", "CLASS_HEAVY_CAVALRY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT", "CLASS_HEAVY_CHARIOT"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT", "CLASS_LIGHT_CAVALRY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT", "CLASS_RANGED_CAVALRY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL", "CLASS_RECON"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL", "CLASS_MELEE"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL", "CLASS_RANGED"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL", "CLASS_ANTI_CAVALRY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL", "CLASS_SIEGE"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL", "CLASS_HEAVY_CAVALRY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL", "CLASS_HEAVY_CHARIOT"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL", "CLASS_LIGHT_CAVALRY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL", "CLASS_RANGED_CAVALRY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH", "CLASS_RECON"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH", "CLASS_MELEE"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH", "CLASS_RANGED"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH", "CLASS_ANTI_CAVALRY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH", "CLASS_SIEGE"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH", "CLASS_HEAVY_CAVALRY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH", "CLASS_HEAVY_CHARIOT"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH", "CLASS_LIGHT_CAVALRY"),
		("ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH", "CLASS_RANGED_CAVALRY");

/* CREATE MODIFIER GENERATOR FRAMEWORK -- DO NOT CHANGE */
--Temporary tables dropped at end
CREATE TABLE EnhancedModTempTable
	(
	ModifierId TEXT NOT NULL,
	RunOnce BOOLEAN NOT NULL DEFAULT 0,
	Permanent BOOLEAN NOT NULL DEFAULT 0,
	OwnerRequirementSetId TEXT,
	SubjectRequirementSetId TEXT,
	ModifierType TEXT NOT NULL,
	Name TEXT,
	Value TEXT,
	Extra TEXT,
	Name2 TEXT,
	Value2 TEXT,
	Extra2 TEXT,
	Name3 TEXT,
	Value3 TEXT,
	Extra3 TEXT,
	Name4 TEXT,
	Value4 TEXT,
	Extra4 TEXT,
	Name5 TEXT,
	Value5 TEXT,
	Extra5 TEXT,
	AttachedTo TEXT
	);

CREATE TABLE EnhancedReqTempTable
	(
	RequirementSetId TEXT,
	RequirementSetType TEXT,
	RequirementId TEXT,
	RequirementType TEXT,
	Inverse BOOLEAN NOT NULL DEFAULT 0,
	Name TEXT,
	Value TEXT,
	Extra TEXT,
	Name2 TEXT,
	Value2 TEXT,
	Extra2 TEXT
	);
/* END CREATE FRAMEWORK */

/* NEW UNIT ABILITIES */		
INSERT INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive)
	VALUES
		("ABILITY_TCS_ENABLE_CLIMB_CLIFFS", "LOC_ABILITY_TCS_ENABLE_CLIMB_CLIFFS_NAME", "LOC_ABILITY_TCS_ENABLE_CLIMB_CLIFFS_DESCRIPTION", 0),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT", "LOC_ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT_NAME", "LOC_ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT_DESCRIPTION", 0),
		("ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL", "LOC_ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL_NAME", "LOC_ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL_DESCRIPTION", 0),
		("ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH", "LOC_ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH_NAME", "LOC_ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH_DESCRIPTION", 0);

/* CREATE NEW MODIFIERS */
--INPUT MODIFIERS
INSERT INTO EnhancedModTempTable (ModifierId, RunOnce, Permanent, OwnerRequirementSetId, SubjectRequirementSetId, ModifierType, Name, Value, Extra, Name2, Value2, Extra2, Name3, Value3, Extra3, Name4, Value4, Extra4, Name5, Value5, Extra5, AttachedTo)
	VALUES
		("MILITARY_ENGINEER_BONUS_IGNORE_CLIFF_WALLS", 0, 0, NULL, "TCS_MILITARY_ENGINEER_ADJACENT", "MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_CLIFF_WALLS", "Ignore", "true", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "ABILITY_TCS_ENABLE_CLIMB_CLIFFS"),
		("DEFENSIVEIMPROVEMENT_BONUS_SIGHT", 0, 0, NULL, "IMPROVEMENT_IS_DEFENSIVE", "MODIFIER_PLAYER_UNIT_ADJUST_SIGHT", "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_SIGHT"),
		("DEFENSIVEIMPROVEMENT_BONUS_HEAL", 0, 0, NULL, "IMPROVEMENT_IS_DEFENSIVE", "MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN", "Amount", 5, NULL, "Type", "ALL", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "ABILITY_DEFENSIVE_IMPROVEMENT_BONUS_HEAL"),
		("DEFENSIVEIMPROVEMENT_REVEAL_STEALTH", 0, 0, NULL, "IMPROVEMENT_IS_DEFENSIVE", "MODIFIER_PLAYER_UNIT_ADJUST_SEE_HIDDEN", "SeeHidden", "true", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "ABILITY_DEFENSIVE_IMPROVEMENT_REVEAL_STEALTH");

--INPUT REQUIREMENTS
INSERT INTO EnhancedReqTempTable (RequirementSetId, RequirementSetType, RequirementId, RequirementType, Inverse, Name, Value, Extra, Name2, Value2, Extra2)
	VALUES
		("TCS_MILITARY_ENGINEER_ADJACENT", "REQUIREMENTSET_TEST_ALL", "TCS_REQUIRES_MILITARY_ENGINEER", "REQUIREMENT_PLOT_UNIT_TYPE_MATCHES", 0, "UnitType", "UNIT_MILITARY_ENGINEER", NULL, NULL, NULL, NULL),
		("IMPROVEMENT_IS_DEFENSIVE", "REQUIREMENTSET_TEST_ANY", "REQUIRES_FORT_IN_PLOT", "REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES", 0, "ImprovementType", "IMPROVEMENT_FORT", NULL, NULL, NULL, NULL),
		("IMPROVEMENT_IS_DEFENSIVE", "REQUIREMENTSET_TEST_ANY", "REQUIRES_ROMANFORT_IN_PLOT", "REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES", 0, "ImprovementType", "IMPROVEMENT_ROMAN_FORT", NULL, NULL, NULL, NULL),
		("IMPROVEMENT_IS_DEFENSIVE", "REQUIREMENTSET_TEST_ANY", "REQUIRES_GREATWALL_IN_PLOT", "REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES", 0, "ImprovementType", "IMPROVEMENT_GREAT_WALL", NULL, NULL, NULL, NULL);

/* MODIFIER AUTO-GENERATION -- DO NOT CHANGE ANYTHING BELOW HERE */
--MODIFIER INSERTS
--Populate Modifiers table
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId, RunOnce, Permanent)
	SELECT EnhancedModTempTable.ModifierId, EnhancedModTempTable.ModifierType, EnhancedModTempTable.OwnerRequirementSetId, EnhancedModTempTable.SubjectRequirementSetId, EnhancedModTempTable.RunOnce, EnhancedModTempTable.Permanent FROM EnhancedModTempTable;

--Populate ModifierArguments table first set
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT EnhancedModTempTable.ModifierId, EnhancedModTempTable.Name, EnhancedModTempTable.Value, EnhancedModTempTable.Extra FROM EnhancedModTempTable;

--Populate ModifierArguments table second set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT EnhancedModTempTable.ModifierId, EnhancedModTempTable.Name2, EnhancedModTempTable.Value2, EnhancedModTempTable.Extra2 FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.Name2 IS NOT NULL;

--Populate ModifierArguments table third set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT EnhancedModTempTable.ModifierId, EnhancedModTempTable.Name3, EnhancedModTempTable.Value3, EnhancedModTempTable.Extra3 FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.Name3 IS NOT NULL;

--Populate ModifierArguments table fourth set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT EnhancedModTempTable.ModifierId, EnhancedModTempTable.Name4, EnhancedModTempTable.Value4, EnhancedModTempTable.Extra4 FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.Name4 IS NOT NULL;

--Populate ModifierArguments table fifth set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT EnhancedModTempTable.ModifierId, EnhancedModTempTable.Name5, EnhancedModTempTable.Value5, EnhancedModTempTable.Extra5 FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.Name5 IS NOT NULL;	
	
--REQUIREMENT INSERTS
--Populate Requirements table
INSERT INTO Requirements (RequirementId, RequirementType, Inverse)
	SELECT EnhancedReqTempTable.RequirementId, EnhancedReqTempTable.RequirementType, EnhancedReqTempTable.Inverse FROM EnhancedReqTempTable;

--Populate RequirementArguments table first set
INSERT INTO RequirementArguments (RequirementId, Name, Value, Extra)
	SELECT EnhancedReqTempTable.RequirementId, EnhancedReqTempTable.Name, EnhancedReqTempTable.Value, EnhancedReqTempTable.Extra FROM EnhancedReqTempTable
	WHERE EnhancedReqTempTable.Name IS NOT NULL;

--Populate RequirementArguments table second set
INSERT INTO RequirementArguments (RequirementId, Name, Value, Extra)
	SELECT EnhancedReqTempTable.RequirementId, EnhancedReqTempTable.Name2, EnhancedReqTempTable.Value2, EnhancedReqTempTable.Extra2 FROM EnhancedReqTempTable
	WHERE EnhancedReqTempTable.Name2 IS NOT NULL;

--Populate RequirementSetRequirements table
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	SELECT EnhancedReqTempTable.RequirementSetId, EnhancedReqTempTable.RequirementId FROM EnhancedReqTempTable;

--Populate RequirementSets table with only unique values	
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	SELECT DISTINCT EnhancedReqTempTable.RequirementSetId, EnhancedReqTempTable.RequirementSetType FROM EnhancedReqTempTable;

--ATTACH MODIFIERS
--Attach Belief modifiers		
INSERT INTO BeliefModifiers (BeliefType, ModifierID)
	SELECT EnhancedModTempTable.AttachedTo, EnhancedModTempTable.ModifierId FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.AttachedTo LIKE 'BELIEF%';
--Attach Building modifiers
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
	SELECT EnhancedModTempTable.AttachedTo, EnhancedModTempTable.ModifierId FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.AttachedTo LIKE 'BUILDING%';	
--Attach Civic modifiers
INSERT INTO CivicModifiers (CivicType, ModifierId)
	SELECT EnhancedModTempTable.AttachedTo, EnhancedModTempTable.ModifierId FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.AttachedTo LIKE 'CIVIC%';	
--Attach District modifiers
INSERT INTO DistrictModifiers (DistrictType, ModifierId)
	SELECT EnhancedModTempTable.AttachedTo, EnhancedModTempTable.ModifierId FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.AttachedTo LIKE 'DISTRICT%';	
--Attach Government modifiers
INSERT INTO GovernmentModifiers (GovernmentType, ModifierId)
	SELECT EnhancedModTempTable.AttachedTo, EnhancedModTempTable.ModifierId FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.AttachedTo LIKE 'GOVERNMENT%';	
--Attach Improvement modifiers
INSERT INTO ImprovementModifiers (ImprovementType, ModifierId)
	SELECT EnhancedModTempTable.AttachedTo, EnhancedModTempTable.ModifierId FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.AttachedTo LIKE 'IMPROVEMENT%';	
--Attach Policy modifiers
INSERT INTO PolicyModifiers (PolicyType, ModifierId)
	SELECT EnhancedModTempTable.AttachedTo, EnhancedModTempTable.ModifierId FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.AttachedTo LIKE 'POLICY%';		
--Attach Project completion modifiers	
INSERT INTO ProjectCompletionModifiers (ProjectType, ModifierId)
	SELECT EnhancedModTempTable.AttachedTo, EnhancedModTempTable.ModifierId FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.AttachedTo LIKE 'PROJECT%';	
--Attach Technology modifiers
INSERT INTO TechnologyModifiers (TechnologyType, ModifierId)
	SELECT EnhancedModTempTable.AttachedTo, EnhancedModTempTable.ModifierId FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.AttachedTo LIKE 'TECH%';	
--Attach Unit Ability modifiers
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
	SELECT EnhancedModTempTable.AttachedTo, EnhancedModTempTable.ModifierId FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.AttachedTo LIKE 'ABILITY%';	
--Attach Unit Promotion modifiers
INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId)
	SELECT EnhancedModTempTable.AttachedTo, EnhancedModTempTable.ModifierId FROM EnhancedModTempTable
	WHERE EnhancedModTempTable.AttachedTo LIKE 'PROMOTION%';	
	
--DROP TABLES
DROP TABLE EnhancedModTempTable;
DROP TABLE EnhancedReqTempTable;