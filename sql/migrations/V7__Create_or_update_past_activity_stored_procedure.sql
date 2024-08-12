-- V7__Create_or_update_past_activity_stored_procedure.sql

DELIMITER $$

-- Stored Procedure to create or update a PastActivity
CREATE PROCEDURE CreateOrUpdatePastActivity(
    IN inputUserID INT,
    IN inputActivityName VARCHAR(100),
    IN inputKindOfGremlin SMALLINT,
    IN inputIntensity INT
)
BEGIN
    -- Check if the PastActivity already exists
    IF EXISTS (
        SELECT 1 FROM PastActivities 
        WHERE userID = inputUserID AND activityName = inputActivityName
    ) THEN
        -- If it exists, update it
        UPDATE PastActivities
        SET 
            kindOfGremlin = inputKindOfGremlin,
            intensity = inputIntensity
        WHERE userID = inputUserID AND activityName = inputActivityName;
    ELSE
        -- If it doesn't exist, create a new entry
        INSERT INTO PastActivities (
            userID, activityName, kindOfGremlin, intensity
        ) VALUES (
            inputUserID, inputActivityName, inputKindOfGremlin, inputIntensity
        );
    END IF;
END $$

DELIMITER ;
