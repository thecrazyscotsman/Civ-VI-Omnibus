/*
	SQL Modifier Generator for Civilization VI
	Created by thecrazyscotsman (7 Dec 2016)
	
	This framework allows you to input all the relevant parts of a modifier and/or a requirement into a single line. The rest is automatically generated for you.
	
	EXAMPLE:
		INSERT INTO DefaultModTempTable (ModifierId, RunOnce, Permanent, OwnerRequirementSetId, SubjectRequirementSetId, ModifierType, Name, Value, Extra, Name2, Value2, Extra2, Name3, Value3, Extra3, AttachedTo)
			VALUES
				('MODIFIER_ADD_RICEFOOD', 0, 0, NULL, 'REQUIREMENT_PLOT_HAS_RICE', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'YieldType', 'YIELD_FOOD', NULL, 'Amount', 1, NULL, NULL, NULL, NULL, 'BUILDING_GRANARY');
		
		INSERT INTO DefaultReqTempTable (RequirementSetId, RequirementSetType, RequirementId, RequirementType, Inverse, Name, Value, Extra, Name2, Value2, Extra2)
			VALUES
				('REQUIREMENT_PLOT_HAS_RICE', 'REQUIREMENTSET_TEST_ALL', 'PLOT_HAS_RICE', 'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES', 0, 'ResourceType', 'RESOURCE_RICE', NULL, NULL, NULL, NULL);
	
	These inputs will generate and insert the correct rows on the Modifiers, ModifierArguments, Requirements, RequirementArguments, RequirementSetRequirements, and RequirementSets tables. It will also automatically attach the modifier to the Granary.
	
	Modifier attachments are automatically created (using the AttachedTo field), with the exception of these two:
		GreatPersonIndividualActionModifiers
		GreatPersonIndividualBirthModifiers
	In order to correctly generate the modifier attachment, the correct prefix must be used (i.e. BUILDING). Custom mod strings must go after the prefix (i.e. BUILDING_TCS_SALOON).	
*/

INSERT INTO Types (Type, Kind)
	VALUES
		("MODIFIER_ADJUST_CITY_UNIT_PRODUCTION", "KIND_MODIFIER"),
		("MODIFIER_SINGLE_CITY_TERRAIN_ADJACENCY", "KIND_MODIFIER"),
		("MODIFIER_SINGLE_CITY_ADJUST_BUILDING_PRODUCTION", "KIND_MODIFIER"),
		("MODIFIER_SINGLE_CITY_ADJUST_DISTRICT_PRODUCTION", "KIND_MODIFIER"),
		("MODIFIER_PLAYER_DISTRICTS_ADJUST_INFLUENCE_POINTS_PER_TURN", "KIND_MODIFIER"),
		("MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS", "KIND_MODIFIER");
	
/* NEW DYNAMIC MODIFIERS */
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType)
	VALUES
		("MODIFIER_ADJUST_CITY_UNIT_PRODUCTION", "COLLECTION_OWNER", "EFFECT_ADJUST_CITY_PRODUCTION_UNIT"),
		("MODIFIER_SINGLE_CITY_TERRAIN_ADJACENCY", "COLLECTION_OWNER", "EFFECT_TERRAIN_ADJACENCY"),
		("MODIFIER_SINGLE_CITY_ADJUST_BUILDING_PRODUCTION", "COLLECTION_OWNER", "EFFECT_ADJUST_CITY_PRODUCTION_BUILDING"),
		("MODIFIER_SINGLE_CITY_ADJUST_DISTRICT_PRODUCTION", "COLLECTION_OWNER", "EFFECT_ADJUST_CITY_PRODUCTION_DISTRICT"),
		("MODIFIER_PLAYER_DISTRICTS_ADJUST_INFLUENCE_POINTS_PER_TURN", "COLLECTION_PLAYER_DISTRICTS", "EFFECT_ADJUST_INFLUENCE_POINTS_PER_TURN"),
		("MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS", "COLLECTION_PLAYER_DISTRICTS", "EFFECT_ADJUST_DISTRICT_YIELD_BASED_ON_ADJACENCY_BONUS");
		
/* CREATE FRAMEWORK -- DO NOT CHANGE */
--Temporary tables dropped at end
CREATE TABLE DefaultModTempTable
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

CREATE TABLE DefaultReqTempTable
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
	
/* BEGIN MOD INPUTS */
--INPUT NEW MODIFIERS
INSERT INTO DefaultModTempTable (ModifierId, RunOnce, Permanent, OwnerRequirementSetId, SubjectRequirementSetId, ModifierType, Name, Value, Extra, Name2, Value2, Extra2, Name3, Value3, Extra3, Name4, Value4, Extra4, Name5, Value5, Extra5, AttachedTo)
	VALUES
		--Update Barracks production bonus to unit-only
		("BARRACKS_UNITPRODUCTION", 0, 0, NULL, "DISTRICT_IS_ENCAMPMENT", "MODIFIER_ADJUST_CITY_UNIT_PRODUCTION", "Amount", 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_BARRACKS"),
		
		--Update Stable production bonus to unit-only
		("STABLE_UNITPRODUCTION", 0, 0, NULL, "DISTRICT_IS_ENCAMPMENT", "MODIFIER_ADJUST_CITY_UNIT_PRODUCTION", "Amount", 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_STABLE"),
		
		--Update Armory production bonus to unit-only
		("ARMORY_UNITPRODUCTION", 0, 0, NULL, "DISTRICT_IS_ENCAMPMENT", "MODIFIER_ADJUST_CITY_UNIT_PRODUCTION", "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_ARMORY"),
		
		--Update Military Academy production bonus to unit-only
		("MILITARYACADEMY_UNITPRODUCTION", 0, 0, NULL, "DISTRICT_IS_ENCAMPMENT", "MODIFIER_ADJUST_CITY_UNIT_PRODUCTION", "Amount", 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_MILITARY_ACADEMY"),
		
		--Update Egypt's Iteru ability
		('TRAIT_FLOODPLAINS_VALID_AQUEDUCT', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_VALID_FEATURES_DISTRICTS', 'DistrictType', 'DISTRICT_AQUEDUCT', NULL, 'FeatureType', 'FEATURE_FLOODPLAINS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TRAIT_CIVILIZATION_ITERU'),
		('TRAIT_FLOODPLAINS_VALID_NEIGHBORHOOD', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_VALID_FEATURES_DISTRICTS', 'DistrictType', 'DISTRICT_NEIGHBORHOOD', NULL, 'FeatureType', 'FEATURE_FLOODPLAINS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TRAIT_CIVILIZATION_ITERU'),
		('TRAIT_FLOODPLAINS_VALID_AERODROME', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_VALID_FEATURES_DISTRICTS', 'DistrictType', 'DISTRICT_AERODROME', NULL, 'FeatureType', 'FEATURE_FLOODPLAINS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TRAIT_CIVILIZATION_ITERU'),
		
		--Update Rationalism policy
		('RATIONALISM_LIBRARYSCIENCE', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_SCIENCE', NULL, 'Amount', 3, NULL, 'BuildingType', 'BUILDING_LIBRARY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_RATIONALISM'),
		('RATIONALISM_UNIVERSITYSCIENCE', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_SCIENCE', NULL, 'Amount', 3, NULL, 'BuildingType', 'BUILDING_UNIVERSITY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_RATIONALISM'),
		('RATIONALISM_RESEARCHLABSCIENCE', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_SCIENCE', NULL, 'Amount', 3, NULL, 'BuildingType', 'BUILDING_RESEARCH_LAB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_RATIONALISM'),
		
		--Update Free Market policy
		('FREEMARKET_MARKETGOLD', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_GOLD', NULL, 'Amount', 4, NULL, 'BuildingType', 'BUILDING_MARKET', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_FREE_MARKET'),
		('FREEMARKET_BANKGOLD', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_GOLD', NULL, 'Amount', 4, NULL, 'BuildingType', 'BUILDING_BANK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_FREE_MARKET'),
		('FREEMARKET_STOCKEXCHANGEGOLD', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_GOLD', NULL, 'Amount', 4, NULL, 'BuildingType', 'BUILDING_STOCK_EXCHANGE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_FREE_MARKET'),
		
		--Update Grand Opera policy
		('GRANDOPERA_AMPTHITHEATERCULTURE', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_CULTURE', NULL, 'Amount', 3, NULL, 'BuildingType', 'BUILDING_AMPHITHEATER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_GRAND_OPERA'),
		('GRANDOPERA_MUSEUMARTIFACTCULTURE', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_CULTURE', NULL, 'Amount', 3, NULL, 'BuildingType', 'BUILDING_MUSEUM_ARTIFACT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_GRAND_OPERA'),
		('GRANDOPERA_MUSEUMARTCULTURE', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_CULTURE', NULL, 'Amount', 3, NULL, 'BuildingType', 'BUILDING_MUSEUM_ART', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_GRAND_OPERA'),
		('GRANDOPERA_BROADCASTCENTERCULTURE', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_CULTURE', NULL, 'Amount', 3, NULL, 'BuildingType', 'BUILDING_BROADCAST_CENTER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_GRAND_OPERA'),
		
		--Update Economic Union policy
		('ECONOMICUNION_HARBORFOOD', 0, 0, NULL, 'DISTRICT_IS_HARBOR', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER', 'YieldType', 'YIELD_FOOD', NULL, 'Amount', 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_ECONOMIC_UNION'),
		
		--Update Naval Infrastructure policy
		('NAVALINFRASTRUCTURE_HARBORFOOD', 0, 0, NULL, 'DISTRICT_IS_HARBOR', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER', 'YieldType', 'YIELD_FOOD', NULL, 'Amount', 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_NAVAL_INFRASTRUCTURE');

--INPUT REQUIREMENTS
/*
INSERT INTO DefaultReqTempTable (RequirementSetId, RequirementSetType, RequirementId, RequirementType, Inverse, Name, Value, Extra, Name2, Value2, Extra2)
	VALUES
		--('RequirementSetId', 'RequirementSetType', 'RequirementId', 'RequirementType', 0, 'Name', 'Value', 'Extra', 'Name2', 'Value2', 'Extra2');
*/
		
/* END MOD INPUTS */	
	
/* DO NOT CHANGE ANYTHING BELOW HERE */
--MODIFIER INSERTS
--Populate Modifiers table
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId, RunOnce, Permanent)
	SELECT DefaultModTempTable.ModifierId, DefaultModTempTable.ModifierType, DefaultModTempTable.OwnerRequirementSetId, DefaultModTempTable.SubjectRequirementSetId, DefaultModTempTable.RunOnce, DefaultModTempTable.Permanent FROM DefaultModTempTable;

--Populate ModifierArguments table first set
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT DefaultModTempTable.ModifierId, DefaultModTempTable.Name, DefaultModTempTable.Value, DefaultModTempTable.Extra FROM DefaultModTempTable;

--Populate ModifierArguments table second set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT DefaultModTempTable.ModifierId, DefaultModTempTable.Name2, DefaultModTempTable.Value2, DefaultModTempTable.Extra2 FROM DefaultModTempTable
	WHERE DefaultModTempTable.Name2 IS NOT NULL;

--Populate ModifierArguments table third set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT DefaultModTempTable.ModifierId, DefaultModTempTable.Name3, DefaultModTempTable.Value3, DefaultModTempTable.Extra3 FROM DefaultModTempTable
	WHERE DefaultModTempTable.Name3 IS NOT NULL;	

--Populate ModifierArguments table fourth set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT DefaultModTempTable.ModifierId, DefaultModTempTable.Name4, DefaultModTempTable.Value4, DefaultModTempTable.Extra4 FROM DefaultModTempTable
	WHERE DefaultModTempTable.Name4 IS NOT NULL;

--Populate ModifierArguments table fifth set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT DefaultModTempTable.ModifierId, DefaultModTempTable.Name5, DefaultModTempTable.Value5, DefaultModTempTable.Extra5 FROM DefaultModTempTable
	WHERE DefaultModTempTable.Name5 IS NOT NULL;	
	
--REQUIREMENT INSERTS
--Populate Requirements table
INSERT INTO Requirements (RequirementId, RequirementType, Inverse)
	SELECT DefaultReqTempTable.RequirementId, DefaultReqTempTable.RequirementType, DefaultReqTempTable.Inverse FROM DefaultReqTempTable;

--Populate RequirementArguments table first set
INSERT INTO RequirementArguments (RequirementId, Name, Value, Extra)
	SELECT DefaultReqTempTable.RequirementId, DefaultReqTempTable.Name, DefaultReqTempTable.Value, DefaultReqTempTable.Extra FROM DefaultReqTempTable
	WHERE DefaultReqTempTable.Name IS NOT NULL;

--Populate RequirementArguments table second set
INSERT INTO RequirementArguments (RequirementId, Name, Value, Extra)
	SELECT DefaultReqTempTable.RequirementId, DefaultReqTempTable.Name2, DefaultReqTempTable.Value2, DefaultReqTempTable.Extra2 FROM DefaultReqTempTable
	WHERE DefaultReqTempTable.Name2 IS NOT NULL;

--Populate RequirementSetRequirements table
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	SELECT DefaultReqTempTable.RequirementSetId, DefaultReqTempTable.RequirementId FROM DefaultReqTempTable;

--Populate RequirementSets table with only unique values	
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	SELECT DISTINCT DefaultReqTempTable.RequirementSetId, DefaultReqTempTable.RequirementSetType FROM DefaultReqTempTable;

--ATTACH MODIFIERS
--Attach Belief modifiers		
INSERT INTO BeliefModifiers (BeliefType, ModifierID)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'BELIEF%';
--Attach Building modifiers
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'BUILDING%';	
--Attach Civic modifiers
INSERT INTO CivicModifiers (CivicType, ModifierId)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'CIVIC%';	
--Attach District modifiers
INSERT INTO DistrictModifiers (DistrictType, ModifierId)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'DISTRICT%';	
--Attach Government modifiers
INSERT INTO GovernmentModifiers (GovernmentType, ModifierId)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'GOVERNMENT%';	
--Attach Improvement modifiers
INSERT INTO ImprovementModifiers (ImprovementType, ModifierId)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'IMPROVEMENT%';	
--Attach Policy modifiers
INSERT INTO PolicyModifiers (PolicyType, ModifierId)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'POLICY%';		
--Attach Project completion modifiers	
INSERT INTO ProjectCompletionModifiers (ProjectType, ModifierId)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'PROJECT%';	
--Attach Technology modifiers
INSERT INTO TechnologyModifiers (TechnologyType, ModifierId)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'TECH%';	
--Attach Unit Ability modifiers
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'ABILITY%';	
--Attach Unit Promotion modifiers
INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'PROMOTION%';	
--Attach Civilization Trait modifiers
INSERT INTO TraitModifiers (TraitType, ModifierId)
	SELECT DefaultModTempTable.AttachedTo, DefaultModTempTable.ModifierId FROM DefaultModTempTable
	WHERE DefaultModTempTable.AttachedTo LIKE 'TRAIT%';	
	
--DROP TABLES
DROP TABLE DefaultModTempTable;
DROP TABLE DefaultReqTempTable;
