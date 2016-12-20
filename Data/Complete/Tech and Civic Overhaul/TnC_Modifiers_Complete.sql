/*
	SQL Modifier Generator for Civilization VI
	Created by thecrazyscotsman (7 Dec 2016)
	
	This framework allows you to input all the relevant parts of a modifier and/or a requirement into a single line. The rest is automatically generated for you.
	
	EXAMPLE:
		INSERT INTO ModTempTable (ModifierId, RunOnce, Permanent, OwnerRequirementSetId, SubjectRequirementSetId, ModifierType, Name, Value, Extra, Name2, Value2, Extra2, Name3, Value3, Extra3, AttachedTo)
			VALUES
				("MODIFIER_ADD_RICEFOOD", 0, 0, NULL, "REQUIREMENT_PLOT_HAS_RICE", "MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD", "YieldType", "YIELD_FOOD", NULL, "Amount", 1, NULL, NULL, NULL, NULL, "BUILDING_GRANARY");
		
		INSERT INTO ReqTempTable (RequirementSetId, RequirementSetType, RequirementId, RequirementType, Inverse, Name, Value, Extra, Name2, Value2, Extra2)
			VALUES
				("REQUIREMENT_PLOT_HAS_RICE", "REQUIREMENTSET_TEST_ALL", "PLOT_HAS_RICE", "REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES", 0, "ResourceType", "RESOURCE_RICE", NULL, NULL, NULL, NULL);
	
	These inputs will generate and insert the correct rows on the Modifiers, ModifierArguments, Requirements, RequirementArguments, RequirementSetRequirements, and RequirementSets tables. It will also automatically attach the modifier to the Granary.
	
	Modifier attachments are automatically created (using the AttachedTo field), with the exception of these two:
		GreatPersonIndividualActionModifiers
		GreatPersonIndividualBirthModifiers
	In order to correctly generate the modifier attachment, the correct prefix must be used (i.e. BUILDING). Custom mod strings must go after the prefix (i.e. BUILDING_TCS_SALOON).	
*/

/* NEW TYPES AND TYPETAGS */
INSERT INTO Types (Type, Kind)
	VALUES
		("ABILITY_ANCESTRAL_LANDS", "KIND_ABILITY"),
		("ABILITY_FREEDOM_FIGHTERS", "KIND_ABILITY"),
		("ABILITY_STRONG_SCOUT", "KIND_ABILITY"),
		("ABILITY_STRATEGOS_BONUS_EXPERIENCE", "KIND_ABILITY"),
		("ABILITY_DEVOTION_SPREADCHARGES", "KIND_ABILITY");

INSERT INTO TypeTags (Type, Tag)
	VALUES
		("ABILITY_STRONG_SCOUT", "CLASS_RECON"),
		("ABILITY_ANCESTRAL_LANDS", "CLASS_ANTI_CAVALRY"),
		("ABILITY_ANCESTRAL_LANDS", "CLASS_MELEE"),
		("ABILITY_ANCESTRAL_LANDS", "CLASS_RECON"),
		("ABILITY_FREEDOM_FIGHTERS", "CLASS_RECON"),
		("ABILITY_FREEDOM_FIGHTERS", "CLASS_ANTI_CAVALRY"),
		("ABILITY_FREEDOM_FIGHTERS", "CLASS_LIGHT_CAVALRY"),
		("ABILITY_FREEDOM_FIGHTERS", "CLASS_HEAVY_CAVALRY"),
		("ABILITY_FREEDOM_FIGHTERS", "CLASS_MELEE"),
		("ABILITY_FREEDOM_FIGHTERS", "CLASS_RANGED"),
		("ABILITY_FREEDOM_FIGHTERS", "CLASS_RANGED_CAVALRY"),
		("ABILITY_FREEDOM_FIGHTERS", "CLASS_HEAVY_CHARIOT"),
		("ABILITY_FREEDOM_FIGHTERS", "CLASS_LIGHT_CHARIOT"),
		("ABILITY_STRATEGOS_BONUS_EXPERIENCE", "CLASS_RECON"),
		("ABILITY_STRATEGOS_BONUS_EXPERIENCE", "CLASS_ANTI_CAVALRY"),
		("ABILITY_STRATEGOS_BONUS_EXPERIENCE", "CLASS_LIGHT_CAVALRY"),
		("ABILITY_STRATEGOS_BONUS_EXPERIENCE", "CLASS_HEAVY_CAVALRY"),
		("ABILITY_STRATEGOS_BONUS_EXPERIENCE", "CLASS_MELEE"),
		("ABILITY_STRATEGOS_BONUS_EXPERIENCE", "CLASS_RANGED"),
		("ABILITY_STRATEGOS_BONUS_EXPERIENCE", "CLASS_RANGED_CAVALRY"),
		("ABILITY_STRATEGOS_BONUS_EXPERIENCE", "CLASS_HEAVY_CHARIOT"),
		("ABILITY_STRATEGOS_BONUS_EXPERIENCE", "CLASS_LIGHT_CHARIOT"),
		("ABILITY_DEVOTION_SPREADCHARGES", "CLASS_RELIGIOUS"),
		("ABILITY_DEVOTION_SPREADCHARGES", "CLASS_INQUISITOR"),
		("ABILITY_DEVOTION_SPREADCHARGES", "CLASS_MISSIONARY");

/* CREATE MODIFIER GENERATOR FRAMEWORK -- DO NOT CHANGE */
--Temporary tables dropped at end
CREATE TABLE ModTempTable
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

CREATE TABLE ReqTempTable
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
		("ABILITY_STRONG_SCOUT", "LOC_ABILITY_STRONG_SCOUT_NAME", "LOC_ABILITY_STRONG_SCOUT_DESCRIPTION", 1),
		("ABILITY_ANCESTRAL_LANDS", "LOC_ABILITY_ANCESTRAL_LANDS_NAME", "LOC_ABILITY_ANCESTRAL_LANDS_DESCRIPTION", 1),
		("ABILITY_FREEDOM_FIGHTERS", "LOC_ABILITY_FREEDOM_FIGHTERS_NAME", "LOC_ABILITY_FREEDOM_FIGHTERS_DESCRIPTION", 1),
		("ABILITY_STRATEGOS_BONUS_EXPERIENCE", "LOC_ABILITY_STRATEGOS_BONUS_EXPERIENCE_NAME", "LOC_ABILITY_STRATEGOS_BONUS_EXPERIENCE_DESCRIPTION", 1),
		("ABILITY_DEVOTION_SPREADCHARGES", "LOC_ABILITY_DEVOTION_SPREADCHARGES_NAME", "LOC_ABILITY_DEVOTION_SPREADCHARGES_DESCRIPTION", 1);
		
/* CREATE NEW MODIFIERS */
--INPUT MODIFIERS
INSERT INTO ModTempTable (ModifierId, RunOnce, Permanent, OwnerRequirementSetId, SubjectRequirementSetId, ModifierType, Name, Value, Extra, Name2, Value2, Extra2, Name3, Value3, Extra3, Name4, Value4, Extra4, Name5, Value5, Extra5, AttachedTo)
	VALUES
		--BUILDING MODIFIERS
		--Arsenal
		("ARSENAL_UNITPRODUCTION", 0, 0, NULL, "DISTRICT_IS_ENCAMPMENT", "MODIFIER_ADJUST_CITY_UNIT_PRODUCTION", "Amount", 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_ARSENAL"),
		--Apothecary
		("APOTHECARY_ADDGROWTH", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_CITY_GROWTH", "Amount", 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_APOTHECARY"),
		--Aquafarms
		("AQUAFARMS_ADDGROWTH", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_CITY_GROWTH", "Amount", 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_AQUAFARMS"),	
		--Basilica
		("BASILICA_FAITHMODIFIER", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER", "YieldType", "YIELD_FAITH", NULL, "Amount", 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_BASILICA"),
		--Brickyard
		("BRICKYARD_BUILDINGPRODUCTION", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_BUILDING_PRODUCTION", "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_BRICKYARD"),	
		("BRICKYARD_DISTRICTPRODUCTION", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_DISTRICT_PRODUCTION", "Amount", 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_BRICKYARD"),
		("BRICKYARD_ADDPRODUCTION_QUARRIES", 0, 0, NULL, "IMPROVEMENT_IS_QUARRY", "MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD", "YieldType", "YIELD_PRODUCTION", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_BRICKYARD"),
		--Brickworks
		("BRICKWORKS_BUILDINGPRODUCTION", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_BUILDING_PRODUCTION", "Amount", 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_BRICKWORKS"),	
		("BRICKWORKS_DISTRICTPRODUCTION", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_DISTRICT_PRODUCTION", "Amount", 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_BRICKWORKS"),
		--Caravansary
		("CARAVANSARY_TRADEROUTE_INTERNATIONALBONUSRESOURCEGOLD", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITY_TRADE_ROUTE_YIELD_PER_LOCAL_BONUS_RESOURCE_FOR_DOMESTIC", "YieldType", "YIELD_GOLD", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_CARAVANSARY"),
		--Electronics Factory
		("ELECTRONICSFACTORY_TNC_CULTURE", 0, 1, NULL, "HAS_TECH_ELECTRONICS", "MODIFIER_BUILDING_YIELD_CHANGE", "BuildingType", "BUILDING_ELECTRONICS_FACTORY", NULL, "Amount", 4, NULL, "YieldType", "YIELD_CULTURE", NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_ELECTRONICS_FACTORY"),
		--Foundry
		("FOUNDRY_ADDGOLD_MINES", 0, 0, NULL, "IMPROVEMENT_IS_MINE", "MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD", "YieldType", "YIELD_GOLD", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_FOUNDRY"),
		("FOUNDRY_ADDGOLD_QUARRY", 0, 0, NULL, "IMPROVEMENT_IS_QUARRY", "MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD", "YieldType", "YIELD_GOLD", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_FOUNDRY"),
		--Gristmill
		("GRISTMILL_ADJACENCYBONUS_FOOD", 0, 0, NULL, NULL, "MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS", "YieldTypeToMirror", "YIELD_PRODUCTION", NULL, "YieldTypeToGrant", "YIELD_FOOD", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_GRISTMILL"),
		--Guild Hall
		("GUILDHALL_ADDGOLD_PLANTATIONS", 0, 0, NULL, "IMPROVEMENT_IS_PLANTATION", "MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD", "YieldType", "YIELD_GOLD", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_GUILD_HALL"),
		("GUILDHALL_ADDPRODUCTION_PLANTATIONS", 0, 0, NULL, "IMPROVEMENT_IS_PLANTATION", "MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD", "YieldType", "YIELD_PRODUCTION", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_GUILD_HALL"),
		--Grocer
		("GROCER_ADDFOOD_FARMS", 0, 0, NULL, "IMPROVEMENT_IS_FARM", "MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD", "YieldType", "YIELD_FOOD", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_GROCER"),
		--Hospital
		("HOSPITAL_ADDGROWTH", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_CITY_GROWTH", "Amount", 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_HOSPITAL"),
		--Kiln
		("KILN_BUILDINGPRODUCTION", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_BUILDING_PRODUCTION", "Amount", 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_KILN"),	
		("KILN_DISTRICTPRODUCTION", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_DISTRICT_PRODUCTION", "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_KILN"),		
		--Military Base
		("MILITARYBASE_UNITPRODUCTION", 0, 0, NULL, "DISTRICT_IS_ENCAMPMENT", "MODIFIER_ADJUST_CITY_UNIT_PRODUCTION", "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_MILITARY_BASE"),
		--Observatory
		("OBSERVATORY_GRASSMOUNTAIN_SCIENCEADJACENCY", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_TERRAIN_ADJACENCY", "DistrictType", "DISTRICT_CAMPUS", NULL, "TerrainType", "TERRAIN_GRASS_MOUNTAIN", NULL, "YieldType", "YIELD_SCIENCE", NULL, "Amount", 1, NULL, "Description", "LOC_OBSERVATORY_MOUNTAIN_SCIENCE", NULL, "BUILDING_OBSERVATORY"),
		("OBSERVATORY_PLAINSMOUNTAIN_SCIENCEADJACENCY", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_TERRAIN_ADJACENCY", "DistrictType", "DISTRICT_CAMPUS", NULL, "TerrainType", "TERRAIN_PLAINS_MOUNTAIN", NULL, "YieldType", "YIELD_SCIENCE", NULL, "Amount", 1, NULL, "Description", "LOC_OBSERVATORY_MOUNTAIN_SCIENCE", NULL, "BUILDING_OBSERVATORY"),
		("OBSERVATORY_DESERTMOUNTAIN_SCIENCEADJACENCY", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_TERRAIN_ADJACENCY", "DistrictType", "DISTRICT_CAMPUS", NULL, "TerrainType", "TERRAIN_DESERT_MOUNTAIN", NULL, "YieldType", "YIELD_SCIENCE", NULL, "Amount", 1, NULL, "Description", "LOC_OBSERVATORY_MOUNTAIN_SCIENCE", NULL, "BUILDING_OBSERVATORY"),
		("OBSERVATORY_TUNDRAMOUNTAIN_SCIENCEADJACENCY", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_TERRAIN_ADJACENCY", "DistrictType", "DISTRICT_CAMPUS", NULL, "TerrainType", "TERRAIN_TUNDRA_MOUNTAIN", NULL, "YieldType", "YIELD_SCIENCE", NULL, "Amount", 1, NULL, "Description", "LOC_OBSERVATORY_MOUNTAIN_SCIENCE", NULL, "BUILDING_OBSERVATORY"),
		("OBSERVATORY_SNOWMOUNTAIN_SCIENCEADJACENCY", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_TERRAIN_ADJACENCY", "DistrictType", "DISTRICT_CAMPUS", NULL, "TerrainType", "TERRAIN_SNOW_MOUNTAIN", NULL, "YieldType", "YIELD_SCIENCE", NULL, "Amount", 1, NULL, "Description", "LOC_OBSERVATORY_MOUNTAIN_SCIENCE", NULL, "BUILDING_OBSERVATORY"),	
		--Printer
		("PRINTER_WRITINGSCIENCE", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_GREATWORK_YIELD", "GreatWorkObjectType", "GREATWORKOBJECT_WRITING", NULL, "YieldType", "YIELD_SCIENCE", NULL, "YieldChange", 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_PRINTER"),	
		--Reliquary
		("RELIQUARY_RELICGOLD", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_GREATWORK_YIELD", "GreatWorkObjectType", "GREATWORKOBJECT_RELIC", NULL, "YieldType", "YIELD_GOLD", NULL, "YieldChange", 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_RELIQUARY"),
		("RELIQUARY_RELICCULTURE", 0, 0, NULL, NULL, "MODIFIER_SINGLE_CITY_ADJUST_GREATWORK_YIELD", "GreatWorkObjectType", "GREATWORKOBJECT_RELIC", NULL, "YieldType", "YIELD_CULTURE", NULL, "YieldChange", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_RELIQUARY"),
		--Supermarket
		("SUPERMARKET_ADDFOOD_FARMS", 0, 0, NULL, "IMPROVEMENT_IS_FARM", "MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD", "YieldType", "YIELD_FOOD", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "BUILDING_SUPERMARKET"),
		
		--TECHNOLOGY MODIFIERS
		--Internet
		("INTERNET_ADD_DIPLO_VISIBILITY", 0, 0, NULL, NULL, "MODIFIER_PLAYER_ADD_DIPLO_VISIBILITY", "Amount", 1, NULL, "Source", "SOURCE_TECH", NULL, "SourceType", "DIPLO_SOURCE_ALL_NAMES", NULL, NULL, NULL, NULL, NULL, NULL, NULL, "TECH_INTERNET"),
		
		--POLICY MODIFIERS
		--Ancestral Homeland
		("ANCESTRALHOMELAND_FRIENDLY_COMBAT", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNIT_ADJUST_FRIENDLY_TERRITORY_COMBAT", "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "ABILITY_ANCESTRAL_LANDS"),
		("ANCESTRALHOMELAND_FRIENDLY_COMBAT_BUFF", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNITS_GRANT_ABILITY", "AbilityType", "ABILITY_ANCESTRAL_LANDS", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_ANCESTRAL_HOMELAND"),
		--Devotion
		("DEVOTION_SPREADCHARGES", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNIT_ADJUST_SPREAD_CHARGES", "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "ABILITY_DEVOTION_SPREADCHARGES"),
		("DEVOTION_SPREADCHARGES_BUFF", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNITS_GRANT_ABILITY", "AbilityType", "ABILITY_DEVOTION_SPREADCHARGES", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_DEVOTION"),		
		--God King
		("GOD_KING_AMENITIES", 0, 0, NULL, "CITY_IS_CAPITAL", "MODIFIER_PLAYER_CITIES_ADJUST_POLICY_AMENITY", "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_GOD_KING"),
		--Frescoes
		("FRESCOES_GREATWORK_PORTRAIT", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD", "GreatWorkObjectType", "GREATWORKOBJECT_PORTRAIT", NULL, "YieldType", "YIELD_CULTURE", NULL, "YieldChange", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_FRESCOES"),
		("FRESCOES_GREATWORK_RELIGIOUS", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD", "GreatWorkObjectType", "GREATWORKOBJECT_RELIGIOUS", NULL, "YieldType", "YIELD_CULTURE", NULL, "YieldChange", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_FRESCOES"),
		("FRESCOES_GREATWORK_LANDSCAPE", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD", "GreatWorkObjectType", "GREATWORKOBJECT_LANDSCAPE", NULL, "YieldType", "YIELD_CULTURE", NULL, "YieldChange", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_FRESCOES"),
		--Freedom Fighters
		("FREEDOMFIGHTERS_FRIENDLY_COMBAT", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNIT_ADJUST_FRIENDLY_TERRITORY_COMBAT", "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "ABILITY_FREEDOM_FIGHTERS"),
		("FREEDOMFIGHTERS_FRIENDLY_COMBAT_BUFF", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNITS_GRANT_ABILITY", "AbilityType", "ABILITY_FREEDOM_FIGHTERS", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_FREEDOM_FIGHTERS"),
		--Free Market (new buildings)
		('FREEMARKET_CARAVANSARYGOLD', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_GOLD', NULL, 'Amount', 4, NULL, 'BuildingType', 'BUILDING_CARAVANSARY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_FREE_MARKET'),
		('FREEMARKET_GUILDHALLGOLD', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_GOLD', NULL, 'Amount', 4, NULL, 'BuildingType', 'BUILDING_GUILD_HALL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_FREE_MARKET'),		
		--Grand Opera  (new buildings)
		('GRANDOPERA_OPERAHOUSECULTURE', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_CULTURE', NULL, 'Amount', 3, NULL, 'BuildingType', 'BUILDING_OPERA_HOUSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_GRAND_OPERA'),	
		--Imaginariums
		("IMAGINARIUMS_AMENITIES", 0, 0, NULL, "CITY_HAS_RESEARCHLAB", "MODIFIER_PLAYER_CITIES_ADJUST_POLICY_AMENITY", "Amount", 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_IMAGINARIUMS"),		
		--Inspiration
		("INSPIRATION_SHRINE_SCIENCE_MODIFIER", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE", "BuildingType", "BUILDING_SHRINE", NULL, "YieldType", "YIELD_SCIENCE", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_INSPIRATION"),
		--Insulae
		("INSULAE_AQUEDUCT_AMENITY_MODIFIER", 0, 0, NULL, "DISTRICT_IS_AQUEDUCT", "MODIFIER_PLAYER_CITIES_ADJUST_POLICY_AMENITY", "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_INSULAE"),
		("INSULAE_AQUEDUCT_HOUSING_MODIFIER", 0, 0, NULL, "DISTRICT_IS_AQUEDUCT", "MODIFIER_PLAYER_CITIES_ADJUST_POLICY_HOUSING", "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_INSULAE"),
		--Invention
		("INVENTION_WORKSHOPT_SCIENCE_MODIFIER", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE", "BuildingType", "BUILDING_WORKSHOP", NULL, "YieldType", "YIELD_SCIENCE", NULL, "Amount", 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_INVENTION"),
		--Laissez Faire
		("LAISSEZ_FAIRE_TRADEROUTEGOLD", 0, 0, NULL, NULL, "MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD", "YieldType", "YIELD_GOLD", NULL, "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_LAISSEZ_FAIRE"),
		--Land Surveyors
		("LAND_SURVEYORS_CITY_GROWTH_MODIFIER", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_CITY_GROWTH", "Amount", 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_LAND_SURVEYORS"),
		--Liberalism
		("LIBERALISM_TOURISM_MODIFIER", 0, 0, NULL, NULL, "MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_TOURISM_MODIFIER", "Amount", 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_LIBERALISM"),
		--Limes
		("LIMES_RANGEDSTRIKE", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_RANGED_STRIKE", "Amount", 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_LIMES"),
		--Literary Tradition
		("LITERARYTRADITION_GREATWORK_WRITING", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD", "GreatWorkObjectType", "GREATWORKOBJECT_WRITING", NULL, "YieldType", "YIELD_CULTURE", NULL, "YieldChange", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_LITERARY_TRADITION"),
		--Martial Law
		("MARTIALLAW_AMENITYBONUS", 0, 0, NULL, "CITY_HAS_GARRISON_UNIT_REQUIERMENT", "MODIFIER_PLAYER_CITIES_ADJUST_POLICY_AMENITY", "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_MARTIAL_LAW"),
		--Medina Quarter
		("MEDINAQUARTER_OUTERDEFENSE", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_OUTER_DEFENSE", "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_MEDINA_QUARTER"),
		--Meritocracy
		("MERITOCRACY_CULTURE", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_CHANGE", "YieldType", "YIELD_CULTURE", NULL, "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_MERITOCRACY"),
		("MERITOCRACY_SCIENCE", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_CHANGE", "YieldType", "YIELD_SCIENCE", NULL, "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_MERITOCRACY"),
		("MERITOCRACY_PRODUCTION", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_CHANGE", "YieldType", "YIELD_PRODUCTION", NULL, "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_MERITOCRACY"),		
		--Military Research
		("MILITARYRESEARCH_MILITARY_ACADEMY_SCIENCE_PERCENT", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_MODIFIER", "BuildingType", "BUILDING_MILITARY_ACADEMY", NULL, "YieldType", "YIELD_SCIENCE", NULL, "Amount", 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_MILITARY_RESEARCH"),
		("MILITARYRESEARCH_SEAPORT_SCIENCE_PERCENT", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_MODIFIER", "BuildingType", "BUILDING_SEAPORT", NULL, "YieldType", "YIELD_SCIENCE", NULL, "Amount", 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_MILITARY_RESEARCH"),
		--Patronage
		("PATRONAGE_THEATER_PRODUCTIONADJACENCY", 0, 0, NULL, "DISTRICT_IS_THEATER", "MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS", "YieldTypeToMirror", "YIELD_CULTURE", NULL, "YieldTypeToGrant", "YIELD_PRODUCTION", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_PATRONAGE"),		
		--Political Science
		("POLITICALSCIENCE_THEATER_INFLUENCE", 0, 0, NULL, "DISTRICT_IS_THEATER", "MODIFIER_PLAYER_DISTRICTS_ADJUST_INFLUENCE_POINTS_PER_TURN", "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_POLITICAL_SCIENCE"),	
		("POLITICALSCIENCE_CAMPUS_INFLUENCE", 0, 0, NULL, "DISTRICT_IS_CAMPUS", "MODIFIER_PLAYER_DISTRICTS_ADJUST_INFLUENCE_POINTS_PER_TURN", "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_POLITICAL_SCIENCE"),		
		--Prototyping
		("PROTOTYPING_CAMPUS_PRODUCTIONADJACENCY", 0, 0, NULL, "DISTRICT_IS_CAMPUS", "MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS", "YieldTypeToMirror", "YIELD_SCIENCE", NULL, "YieldTypeToGrant", "YIELD_PRODUCTION", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_PROTOTYPING"),	
		--Rationalism (new buildings)
		('RATIONALISM_OBSERVATORYSCIENCE', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_SCIENCE', NULL, 'Amount', 3, NULL, 'BuildingType', 'BUILDING_OBSERVATORY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_RATIONALISM'),
		('RATIONALISM_PRINTERSCIENCE', 0, 0, NULL, NULL, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'YieldType', 'YIELD_SCIENCE', NULL, 'Amount', 3, NULL, 'BuildingType', 'BUILDING_PRINTER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'POLICY_RATIONALISM'),		
		--Retainers
		("RETAINER_GOLDBONUS", 0, 0, NULL, "CITY_HAS_GARRISON_UNIT_REQUIERMENT", "MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE", "YieldType", "YIELD_GOLD", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_MARTIAL_LAW"),
		--Navigation
		("NAVIGATION_NAVALMOVEMENT", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNITS_ADJUST_SEA_MOVEMENT", "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_NAVIGATION"),
		--Nobel Prize
		("NOBELPRIZE_RESEARCH_LAB_SCIENCE_PERCENT", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_MODIFIER", "BuildingType", "BUILDING_RESEARCH_LAB", NULL, "YieldType", "YIELD_SCIENCE", NULL, "Amount", 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_NOBEL_PRIZE"),
		--Raid
		("RAID_MOVEMENTBONUS_MELEE", 0, 0, NULL, "UNIT_IS_RAIDER", "MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT", "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_RAID"),
		--Resource Management
		("RESOURCEMANAGEMENT_FREEHORSE", 0, 0, NULL, NULL, "MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT", "ResourceType", "RESOURCE_HORSES", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_RESOURCE_MANAGEMENT"),
		("RESOURCEMANAGEMENT_FREEIRON", 0, 0, "HAS_TECH_BRONZE_WORKING", NULL, "MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT", "ResourceType", "RESOURCE_IRON", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_RESOURCE_MANAGEMENT"),
		("RESOURCEMANAGEMENT_FREENITER", 0, 0, "HAS_TECH_INVENTION", NULL, "MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT", "ResourceType", "RESOURCE_NITER", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_RESOURCE_MANAGEMENT"),
		("RESOURCEMANAGEMENT_FREECOAL", 0, 0, "HAS_TECH_STEAM_POWER", NULL, "MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT", "ResourceType", "RESOURCE_COAL", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_RESOURCE_MANAGEMENT"),
		("RESOURCEMANAGEMENT_FREEOIL", 0, 0, "HAS_TECH_COMBUSTION", NULL, "MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT", "ResourceType", "RESOURCE_OIL", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_RESOURCE_MANAGEMENT"),
		("RESOURCEMANAGEMENT_FREEALUMINUM", 0, 0, "HAS_TECH_ADVANCED_FLIGHT", NULL, "MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT", "ResourceType", "RESOURCE_ALUMINUM", NULL, "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_RESOURCE_MANAGEMENT"),
		--Strategos
		("STRATEGOS_UNITEXPERIENCE", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER", "Amount", 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "ABILITY_STRATEGOS_BONUS_EXPERIENCE"),
		("STRATEGOS_UNITEXPERIENCE_BUFF", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNITS_GRANT_ABILITY", "AbilityType", "ABILITY_STRATEGOS_BONUS_EXPERIENCE", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_STRATEGOS"),
		--Military Organization
		("MILITARYORGANIZATION_UNITEXPERIENCE_BUFF", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNITS_GRANT_ABILITY", "AbilityType", "ABILITY_STRATEGOS_BONUS_EXPERIENCE", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_MILITARY_ORGANIZATION"),
		--Survey
		("SURVEY_SCOUTSTRENGTH", 0, 0, NULL, NULL, "MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH", "Amount", 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "ABILITY_STRONG_SCOUT"),
		("SURVEY_SCOUTSTRENGTH_BUFF", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNITS_GRANT_ABILITY", "AbilityType", "ABILITY_STRONG_SCOUT", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_SURVEY"),
		--Symphonies
		("SYMPHONIES_GREATWORK_MUSIC", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD", "GreatWorkObjectType", "GREATWORKOBJECT_MUSIC", NULL, "YieldType", "YIELD_CULTURE", NULL, "YieldChange", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_SYMPHONIES"),
		--Total War
		("TOTALWAR_WARWEARINESS", 0, 0, NULL, NULL, "MODIFIER_PLAYER_ADJUST_WAR_WEARINESS", "Amount", -25, NULL, "Overall", "true", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_TOTAL_WAR"),
		--Traveling Merchants
		("TRAVELINGMERCHANTS_TRADEROUTEGOLD", 0, 0, NULL, NULL, "MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD", "YieldType", "YIELD_GOLD", NULL, "Amount", 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_TRAVELING_MERCHANTS"),
		--Urban Planning
		("URBANPLANNING_HOUSING", 0, 0, NULL, NULL, "MODIFIER_PLAYER_CITIES_ADJUST_POLICY_HOUSING", "Amount", 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_URBAN_PLANNING"),
		--Veterancy
		("VETERANCY_NEUTRALHEALING", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN", "Amount", 5, NULL, "Type", "NEUTRAL", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_VETERANCY"),
		("VETERANCY_ENEMYHEALING", 0, 0, NULL, NULL, "MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN", "Amount", 10, NULL, "Type", "ENEMY", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, "POLICY_VETERANCY");

--MODIFIER STRINGS
INSERT INTO ModifierStrings (ModifierId, Context, Text)
	VALUES
		("ANCESTRALHOMELAND_FRIENDLY_COMBAT", "Preview", "LOC_ABILITY_ANCESTRAL_LANDS_DESCRIPTION"),
		("FREEDOMFIGHTERS_FRIENDLY_COMBAT", "Preview", "LOC_ABILITY_FREEDOM_FIGHTERS_DESCRIPTION"),
		("SURVEY_SCOUTSTRENGTH", "Preview", "LOC_ABILITY_STRONG_SCOUT_DESCRIPTION");
		
--INPUT REQUIREMENTS
INSERT INTO ReqTempTable (RequirementSetId, RequirementSetType, RequirementId, RequirementType, Inverse, Name, Value, Extra, Name2, Value2, Extra2)
	VALUES		
		("HAS_EQUALORLESSTHAN_4CITIES", "REQUIREMENTSET_TEST_ALL", "REQUIRES_EQUALORLESSTHAN_4CITIES", "REQUIREMENT_COLLECTION_COUNT_GREATERTHAN", 1, "CollectionType", "COLLECTION_PLAYER_CITIES", NULL, "Count", 4, NULL), --the inverse requirementtype is actually less than or equal to instead of just less than
		("HAS_GREATERTHAN_4CITIES", "REQUIREMENTSET_TEST_ALL", "REQUIRES_GREATERTHAN_4CITIES", "REQUIREMENT_COLLECTION_COUNT_GREATERTHAN", 0, "CollectionType", "COLLECTION_PLAYER_CITIES", NULL, "Count", 4, NULL),
		
		("CITY_HAS_RESEARCHLAB", "REQUIREMENTSET_TEST_ALL", "REQUIRES_CITY_HAS_RESEARCHLAB", "REQUIREMENT_CITY_HAS_BUILDING", 0, "BuildingType", "BUILDING_RESEARCH_LAB", NULL, NULL, NULL, NULL),
		("CITY_IS_CAPITAL", "REQUIREMENTSET_TEST_ALL", "REQUIRES_CITY_IS_CAPITAL", "REQUIREMENT_CITY_HAS_BUILDING", 0, "BuildingType", "BUILDING_PALACE", NULL, NULL, NULL, NULL),
		("DISTRICT_IS_AQUEDUCT", "REQUIREMENTSET_TEST_ANY", "REQUIRES_DISTRICT_IS_AQUEDUCT", "REQUIREMENT_DISTRICT_TYPE_MATCHES", 0, "DistrictType", "DISTRICT_AQUEDUCT", NULL, NULL, NULL, NULL),
		("DISTRICT_IS_AQUEDUCT", "REQUIREMENTSET_TEST_ANY", "REQUIRES_DISTRICT_IS_BATH", "REQUIREMENT_DISTRICT_TYPE_MATCHES", 0, "DistrictType", "DISTRICT_BATH", NULL, NULL, NULL, NULL),
		("HAS_TECH_ELECTRONICS", "REQUIREMENTSET_TEST_ALL", "REQUIRES_HAS_TECH_ELECTRONICS", "REQUIREMENT_PLAYER_HAS_TECHNOLOGY", 0, "TechnologyType", "TECH_ELECTRONICS", NULL, NULL, NULL, NULL),
		("HAS_TECH_ANIMAL_HUSBANDRY", "REQUIREMENTSET_TEST_ALL", "REQUIRES_HAS_TECH_ANIMAL_HUSBANDRY", "REQUIREMENT_PLAYER_HAS_TECHNOLOGY", 0, "TechnologyType", "TECH_ANIMAL_HUSBANDRY", NULL, NULL, NULL, NULL),
		("HAS_TECH_BRONZE_WORKING", "REQUIREMENTSET_TEST_ALL", "REQUIRES_HAS_TECH_BRONZE_WORKING", "REQUIREMENT_PLAYER_HAS_TECHNOLOGY", 0, "TechnologyType", "TECH_BRONZE_WORKING", NULL, NULL, NULL, NULL),
		("HAS_TECH_INVENTION", "REQUIREMENTSET_TEST_ALL", "REQUIRES_HAS_TECH_INVENTION", "REQUIREMENT_PLAYER_HAS_TECHNOLOGY", 0, "TechnologyType", "TECH_INVENTION", NULL, NULL, NULL, NULL),
		("HAS_TECH_STEAM_POWER", "REQUIREMENTSET_TEST_ALL", "REQUIRES_HAS_TECH_STEAM_POWER", "REQUIREMENT_PLAYER_HAS_TECHNOLOGY", 0, "TechnologyType", "TECH_STEAM_POWER", NULL, NULL, NULL, NULL),
		("HAS_TECH_COMBUSTION", "REQUIREMENTSET_TEST_ALL", "REQUIRES_HAS_TECH_COMBUSTION", "REQUIREMENT_PLAYER_HAS_TECHNOLOGY", 0, "TechnologyType", "TECH_COMBUSTION", NULL, NULL, NULL, NULL),
		("HAS_TECH_ADVANCED_FLIGHT", "REQUIREMENTSET_TEST_ALL", "REQUIRES_HAS_TECH_ADVANCED_FLIGHT", "REQUIREMENT_PLAYER_HAS_TECHNOLOGY", 0, "TechnologyType", "TECH_ADVANCED_FLIGHT", NULL, NULL, NULL, NULL),
		("IMPROVEMENT_IS_FARM", "REQUIREMENTSET_TEST_ALL", "REQUIRES_IMPROVEMENT_IS_FARM", "REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES", 0, "ImprovementType", "IMPROVEMENT_FARM", NULL, NULL, NULL, NULL),
		("IMPROVEMENT_IS_PLANTATION", "REQUIREMENTSET_TEST_ALL", "REQUIRES_IMPROVEMENT_IS_PLANTATION", "REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES", 0, "ImprovementType", "IMPROVEMENT_PLANTATION", NULL, NULL, NULL, NULL),
		("IMPROVEMENT_IS_MINE", "REQUIREMENTSET_TEST_ALL", "REQUIRES_IMPROVEMENT_IS_MINE", "REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES", 0, "ImprovementType", "IMPROVEMENT_MINE", NULL, NULL, NULL, NULL),
		("IMPROVEMENT_IS_QUARRY", "REQUIREMENTSET_TEST_ALL", "REQUIRES_IMPROVEMENT_IS_QUARRY", "REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES", 0, "ImprovementType", "IMPROVEMENT_QUARRY", NULL, NULL, NULL, NULL),
		("UNIT_IS_RAIDER", "REQUIREMENTSET_TEST_ANY", "REQUIRES_UNIT_IS_MELEE", "REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES", 0, "UnitPromotionClass", "PROMOTION_CLASS_MELEE", NULL, NULL, NULL, NULL),	
		("UNIT_IS_RAIDER", "REQUIREMENTSET_TEST_ANY", "REQUIRES_UNIT_IS_ANTICAVALRY", "REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES", 0, "UnitPromotionClass", "PROMOTION_CLASS_ANTI_CAVALRY", NULL, NULL, NULL, NULL);

/* MODIFIER AUTO-GENERATION -- DO NOT CHANGE ANYTHING BELOW HERE */
--MODIFIER INSERTS
--Populate Modifiers table
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId, RunOnce, Permanent)
	SELECT ModTempTable.ModifierId, ModTempTable.ModifierType, ModTempTable.OwnerRequirementSetId, ModTempTable.SubjectRequirementSetId, ModTempTable.RunOnce, ModTempTable.Permanent FROM ModTempTable;

--Populate ModifierArguments table first set
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT ModTempTable.ModifierId, ModTempTable.Name, ModTempTable.Value, ModTempTable.Extra FROM ModTempTable;

--Populate ModifierArguments table second set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT ModTempTable.ModifierId, ModTempTable.Name2, ModTempTable.Value2, ModTempTable.Extra2 FROM ModTempTable
	WHERE ModTempTable.Name2 IS NOT NULL;

--Populate ModifierArguments table third set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT ModTempTable.ModifierId, ModTempTable.Name3, ModTempTable.Value3, ModTempTable.Extra3 FROM ModTempTable
	WHERE ModTempTable.Name3 IS NOT NULL;

--Populate ModifierArguments table fourth set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT ModTempTable.ModifierId, ModTempTable.Name4, ModTempTable.Value4, ModTempTable.Extra4 FROM ModTempTable
	WHERE ModTempTable.Name4 IS NOT NULL;

--Populate ModifierArguments table fifth set	
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra)
	SELECT ModTempTable.ModifierId, ModTempTable.Name5, ModTempTable.Value5, ModTempTable.Extra5 FROM ModTempTable
	WHERE ModTempTable.Name5 IS NOT NULL;	
	
--REQUIREMENT INSERTS
--Populate Requirements table
INSERT INTO Requirements (RequirementId, RequirementType, Inverse)
	SELECT ReqTempTable.RequirementId, ReqTempTable.RequirementType, ReqTempTable.Inverse FROM ReqTempTable;

--Populate RequirementArguments table first set
INSERT INTO RequirementArguments (RequirementId, Name, Value, Extra)
	SELECT ReqTempTable.RequirementId, ReqTempTable.Name, ReqTempTable.Value, ReqTempTable.Extra FROM ReqTempTable
	WHERE ReqTempTable.Name IS NOT NULL;

--Populate RequirementArguments table second set
INSERT INTO RequirementArguments (RequirementId, Name, Value, Extra)
	SELECT ReqTempTable.RequirementId, ReqTempTable.Name2, ReqTempTable.Value2, ReqTempTable.Extra2 FROM ReqTempTable
	WHERE ReqTempTable.Name2 IS NOT NULL;

--Populate RequirementSetRequirements table
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	SELECT ReqTempTable.RequirementSetId, ReqTempTable.RequirementId FROM ReqTempTable;

--Populate RequirementSets table with only unique values	
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	SELECT DISTINCT ReqTempTable.RequirementSetId, ReqTempTable.RequirementSetType FROM ReqTempTable;

--ATTACH MODIFIERS
--Attach Building modifiers
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
	SELECT ModTempTable.AttachedTo, ModTempTable.ModifierId FROM ModTempTable
	WHERE ModTempTable.AttachedTo LIKE 'BUILDING%';	
--Attach Civic modifiers
INSERT INTO CivicModifiers (CivicType, ModifierId)
	SELECT ModTempTable.AttachedTo, ModTempTable.ModifierId FROM ModTempTable
	WHERE ModTempTable.AttachedTo LIKE 'CIVIC%';	
--Attach Policy modifiers
INSERT INTO PolicyModifiers (PolicyType, ModifierId)
	SELECT ModTempTable.AttachedTo, ModTempTable.ModifierId FROM ModTempTable
	WHERE ModTempTable.AttachedTo LIKE 'POLICY%';		
--Attach Technology modifiers
INSERT INTO TechnologyModifiers (TechnologyType, ModifierId)
	SELECT ModTempTable.AttachedTo, ModTempTable.ModifierId FROM ModTempTable
	WHERE ModTempTable.AttachedTo LIKE 'TECH%';	
--Attach Unit Ability modifiers
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
	SELECT ModTempTable.AttachedTo, ModTempTable.ModifierId FROM ModTempTable
	WHERE ModTempTable.AttachedTo LIKE 'ABILITY%';	
	
--DROP TABLES
DROP TABLE ModTempTable;
DROP TABLE ReqTempTable;	