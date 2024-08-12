-- V5__Create_gremlin_management_stored_procedures.sql

-- Stored Procedure to edit a gremlin's attributes
CREATE PROCEDURE EditGremlin(
    IN inputGremlinID INT,
    IN inputName VARCHAR(50),
    IN inputActivityName VARCHAR(100),
    IN inputKindOfGremlin SMALLINT,
    IN inputIntensity INT,
    IN inputDateOfBirth DATETIME,
    IN inputLastFedDate DATETIME
)
BEGIN
    UPDATE Gremlins
    SET 
        name = inputName,
        activityName = inputActivityName,
        kindOfGremlin = inputKindOfGremlin,
        intensity = inputIntensity,
        dateOfBirth = inputDateOfBirth,
        lastFedDate = inputLastFedDate
    WHERE gremlinID = inputGremlinID;
    
    SELECT * FROM Gremlins WHERE gremlinID = inputGremlinID;
END;

-- Stored Procedure to add a new gremlin
CREATE PROCEDURE AddNewGremlin(
    IN inputUserID INT,
    IN inputGremlinID INT,
    IN inputName VARCHAR(50),
    IN inputActivityName VARCHAR(100),
    IN inputKindOfGremlin SMALLINT,
    IN inputIntensity INT,
    IN inputDateOfBirth DATETIME,
    IN inputLastFedDate DATETIME
)
BEGIN
    -- Insert into Gremlins table
    INSERT INTO Gremlins (
        name, activityName, kindOfGremlin, intensity, dateOfBirth, lastFedDate
    ) VALUES (
        inputName, inputActivityName, inputKindOfGremlin, inputIntensity, inputDateOfBirth, inputLastFedDate
    );

    -- Get the last inserted gremlin ID
    SET @newGremlinID = LAST_INSERT_ID();

    -- Insert into CurrentGremlins table
    INSERT INTO CurrentGremlins (userID, gremlinID)
    VALUES (inputUserID, @newGremlinID);

    -- Return the newly created gremlin
    SELECT * FROM Gremlins WHERE gremlinID = @newGremlinID;
END;

-- Stored Procedure to delete a gremlin
CREATE PROCEDURE DeleteGremlin(IN inputGremlinID INT)
BEGIN
    -- Delete from CurrentGremlins
    DELETE FROM CurrentGremlins WHERE gremlinID = inputGremlinID;

    -- Delete from OldGremlins
    DELETE FROM OldGremlins WHERE gremlinID = inputGremlinID;

    -- Delete the gremlin from Gremlins table
    DELETE FROM Gremlins WHERE gremlinID = inputGremlinID;
END;
