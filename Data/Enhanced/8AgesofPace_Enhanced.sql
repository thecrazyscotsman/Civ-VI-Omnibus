/*
    Created by Olleus for 8 Ages of Pace (23 Oct 2016) for v1.0.0.26
	original idea by alpaca and Gedemon
	expanded to include civics and scale great people up at the same rate

	Redone for v1.1 using a temporary table. Makes it easier to change all the values at once
*/
 
-- Temporary table, drop at the end
-- Increase is a percentage
CREATE TABLE EraIncreases
	(
	EraType TEXT NOT NULL,
	Increase INT
	);

-- This master table controls the increase of techs, civics and GPs simultaneously
INSERT INTO EraIncreases
	VALUES	("ERA_ANCIENT",0),
			("ERA_CLASSICAL", 25),
			("ERA_MEDIEVAL", 50),
			("ERA_RENAISSANCE", 80),
			("ERA_INDUSTRIAL", 120),
			("ERA_MODERN", 170),
			("ERA_ATOMIC", 230),
			("ERA_INFORMATION", 300);


-- Technology cost
UPDATE Technologies
	SET Cost = ROUND(Cost + Cost*(SELECT EraIncreases.Increase
		FROM EraIncreases 
		WHERE EraIncreases.EraType = Technologies.EraType)/100);

-- Civics cost
UPDATE Civics
	SET Cost = ROUND(Cost + Cost*(SELECT EraIncreases.Increase
		FROM EraIncreases 
		WHERE EraIncreases.EraType = Civics.EraType)/100);

-- Great People Cost
-- Based on feedback, increase is half of the values above
UPDATE Eras
	SET GreatPersonBaseCost = ROUND(GreatPersonBaseCost + GreatPersonBaseCost*(SELECT EraIncreases.Increase
		FROM EraIncreases 
		WHERE EraIncreases.EraType = Eras.EraType)/200);

-- Increase the one off science/culture given by great people
-- This is complicated because the effects of GP is not defined uniquely per great person
-- and the table structure is very strange indeed.
-- Therefore have to look up each effect and see whether it needs to be boosted,
-- and then check which great person first calls it to know how much to boost it by.
-- (NB: this means that if several great people have the same ability, it will be scaled up according
-- to the first era it is used. Not that this happen anyway in vanilla)

-- Create a temporary table of which Modifiers to be scaled are called in which era
WITH ModIncreases AS
(
	SELECT Mods1.ModifierId, EraIncreases.Increase FROM ModifierArguments AS Mods1, EraIncreases
	INNER JOIN ModifierArguments AS Mods2,
			   GreatPersonIndividualActionModifiers AS GPMods,
			   GreatPersonIndividuals AS GPs
	ON Mods1.ModifierId = Mods2.ModifierId
	AND Mods1.Type = "ScaleByGameSpeed"
	AND Mods2.Name = "YieldType"
	AND (Mods2.Value = "YIELD_SCIENCE" OR Mods2.Value = "YIELD_CULTURE")
	AND GPMods.ModifierID = Mods1.ModifierID
	AND GPMods.GreatPersonIndividualType = GPs.GreatPersonIndividualType
	AND EraIncreases.EraType = GPs.EraType
)

-- Update the modifiers if they are in the table above by the lowest amount listed above
UPDATE ModifierArguments
	SET Value = ROUND(Value + Value*(SELECT MIN(ModIncreases.Increase) 
					FROM ModIncreases
					WHERE ModIncreases.ModifierId = ModifierArguments.ModifierID)/100)
	WHERE EXISTS ( SELECT *
				FROM ModIncreases
				WHERE ModIncreases.ModifierId = ModifierArguments.ModifierID)
	AND ModifierArguments.Name = "Amount";

-- Drop the temporary table created at the start
DROP TABLE EraIncreases;