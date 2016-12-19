--UPDATE EXISTING MODIFIERS
DELETE FROM PolicyModifiers WHERE PolicyType = 'POLICY_RATIONALISM'
	OR PolicyType = 'POLICY_FREE_MARKET'
	OR PolicyType = 'POLICY_GRAND_OPERA';

UPDATE ModifierArguments
	SET Value = 50
	WHERE ModifierId = 'AESTHETICS_DISTRICTCULTURE' AND Name = 'Amount';
	
UPDATE ModifierArguments
	SET Value = 50
	WHERE ModifierId = 'CRAFTSMEN_DISTRICTPRODUCTION' AND Name = 'Amount';
	
UPDATE ModifierArguments
	SET Value = 50
	WHERE ModifierId = 'ECONOMICUNION_COMMERCIALGOLD' AND Name = 'Amount';
	
UPDATE ModifierArguments
	SET Value = 50
	WHERE ModifierId = 'FIVEYEARPLAN_DISTRICTSCIENCE' AND Name = 'Amount';
	
UPDATE ModifierArguments
	SET Value = 50
	WHERE ModifierId = 'FIVEYEARPLAN_DISTRICTPRODUCTION' AND Name = 'Amount';
	
UPDATE ModifierArguments
	SET Value = 50
	WHERE ModifierId = 'NATURALPHILOSOPHY_DISTRICTSCIENCE' AND Name = 'Amount';
	
UPDATE ModifierArguments
	SET Value = 50
	WHERE ModifierId = 'SPORTSMEDIA_DISTRICTCULTURE' AND Name = 'Amount';
	
UPDATE ModifierArguments
	SET Value = 50
	WHERE ModifierId = 'TOWNCHARTERS_DISTRICTGOLD' AND Name = 'Amount';