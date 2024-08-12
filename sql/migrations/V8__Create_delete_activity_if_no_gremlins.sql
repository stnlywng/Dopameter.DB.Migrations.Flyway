-- V8__Create_delete_activity_if_no_gremlins.sql

DELIMITER $$

CREATE PROCEDURE DeleteActivityIfNoGremlins(
    IN inputUserID INT,
    IN inputActivityName VARCHAR(100)
)
BEGIN
    -- Check if there are any gremlins associated with the userID and activityName
    IF NOT EXISTS (
        SELECT 1
        FROM Gremlins g
        JOIN CurrentGremlins cg ON g.gremlinID = cg.gremlinID
        WHERE cg.userID = inputUserID AND g.activityName = inputActivityName
        UNION
        SELECT 1
        FROM Gremlins g
        JOIN OldGremlins og ON g.gremlinID = og.gremlinID
        WHERE og.userID = inputUserID AND g.activityName = inputActivityName
    ) THEN
        -- If no gremlins are associated with the userID and activityName, delete from PastActivities
        DELETE FROM PastActivities
        WHERE userID = inputUserID AND activityName = inputActivityName;
    END IF;
END $$

DELIMITER ;
