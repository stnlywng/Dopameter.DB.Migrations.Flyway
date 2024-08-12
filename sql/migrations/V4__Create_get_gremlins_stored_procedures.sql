-- V4__Create_get_gremlins_stored_procedures.sql
DELIMITER $$

-- Stored Procedure to get gremlins for a specific userID from CurrentGremlins
CREATE PROCEDURE GetCurrentGremlinsByUserID(IN inputUserID INT)
BEGIN
    SELECT g.*
    FROM Gremlins g
    JOIN CurrentGremlins cg ON g.gremlinID = cg.gremlinID
    WHERE cg.userID = inputUserID;
END $$

-- Stored Procedure to get gremlins for a specific userID from OldGremlins
CREATE PROCEDURE GetOldGremlinsByUserID(IN inputUserID INT)
BEGIN
    SELECT g.*
    FROM Gremlins g
    JOIN OldGremlins og ON g.gremlinID = og.gremlinID
    WHERE og.userID = inputUserID;
END $$

DELIMITER ;
