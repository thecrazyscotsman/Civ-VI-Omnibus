--Reduce Kumasi's culture bonus to trade routes
UPDATE ModifierArguments
	SET Value = 1
	WHERE ModifierId = "MINOR_CIV_KUMASI_CULTURE_TRADE_ROUTE_YIELD_BONUS" AND Name = "Amount";

--Reduce Nan Madol's culture bonus to coastal districts
UPDATE ModifierArguments
	SET Value = 1
	WHERE ModifierId = "MINOR_CIV_NAN_MADOL_DISTRICTS_CULTURE_BONUS" AND Name = "Amount";