--Update new tech/civic boosts to reflect UserSettings
UPDATE Boosts
SET Boost = 40
WHERE EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_SMALLER_EUREKAS' AND Toggle = 1);

UPDATE Boosts
SET Boost = 25
WHERE EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_SMALLER_EUREKAS' AND Toggle = 2);

UPDATE Boosts
SET Boost = 10
WHERE EXISTS (SELECT * FROM Omnibus_UserSettings WHERE Setting = 'TCS_SMALLER_EUREKAS' AND Toggle = 3);