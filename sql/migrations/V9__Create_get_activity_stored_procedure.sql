-- Migration to create stored procedures for retrieving activities

-- Stored Procedure to Get All Activities by User ID
DELIMITER $$
CREATE PROCEDURE GetAllActivitiesByUserID(
    IN inputUserID INT
)
BEGIN
    SELECT *
    FROM PastActivities
    WHERE userID = inputUserID;
END $$
DELIMITER ;

-- Stored Procedure to Get a Specific Activity by User ID and Activity Name
DELIMITER $$
CREATE PROCEDURE GetActivityByUserIDAndName(
    IN inputUserID INT,
    IN inputActivityName VARCHAR(100)
)
BEGIN
    SELECT *
    FROM PastActivities
    WHERE userID = inputUserID
      AND activityName = inputActivityName
    LIMIT 1;
END $$
DELIMITER ;