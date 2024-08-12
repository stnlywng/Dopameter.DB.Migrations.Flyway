-- V6__Create_get_gremlin_by_gremlinID.sql

DELIMITER $$

-- Stored Procedure to get a gremlin by gremlinID
CREATE PROCEDURE GetGremlinByID(IN inputGremlinID INT)
BEGIN
    SELECT *
    FROM Gremlins
    WHERE gremlinID = inputGremlinID;
END $$

DELIMITER ;
