-- V12__Create_login_procedures.sql

-- Stored Procedure to Get User by Email and Password
DELIMITER $$
CREATE PROCEDURE GetUserByEmail(
    IN inputEmail VARCHAR(255),
    IN inputPassword VARCHAR(255)
)
BEGIN
    SELECT userID, username, email 
    FROM Users
    WHERE email = inputEmail 
    AND password = inputPassword;
END $$
DELIMITER ;

-- Stored Procedure to Get User by Username and Password
DELIMITER $$
CREATE PROCEDURE GetUserByUsername(
    IN inputUsername VARCHAR(100),
    IN inputPassword VARCHAR(255)
)
BEGIN
    SELECT userID, username, email 
    FROM Users
    WHERE username = inputUsername 
    AND password = inputPassword;
END $$
DELIMITER ;

-- Stored Procedure to Create a New User
DELIMITER $$
CREATE PROCEDURE CreateUser(
    IN inputEmail VARCHAR(255),
    IN inputUsername VARCHAR(100),
    IN inputPassword VARCHAR(255)
)
BEGIN
    DECLARE userExists INT;

    -- Check if a user with the same email or username already exists
    SELECT COUNT(*) INTO userExists
    FROM Users
    WHERE email = inputEmail OR username = inputUsername;

    IF userExists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A user with the same email or username already exists.';
    ELSE
        -- Insert new user
        INSERT INTO Users (email, username, password)
        VALUES (inputEmail, inputUsername, inputPassword);

        -- Return the userID of the newly created user
        SELECT LAST_INSERT_ID() AS userID;
    END IF;
END $$
DELIMITER ;

-- Stored Procedure to Update a User's Email, Username, and Password
DELIMITER $$
CREATE PROCEDURE UpdateUser(
    IN inputUserID INT,
    IN newEmail VARCHAR(255),
    IN newUsername VARCHAR(100),
    IN newPassword VARCHAR(255)
)
BEGIN
    DECLARE userExists INT;

    -- Check if another user with the same email or username already exists
    SELECT COUNT(*) INTO userExists
    FROM Users
    WHERE (email = newEmail OR username = newUsername)
      AND userID != inputUserID;

    IF userExists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A user with the same email or username already exists.';
    ELSE
        -- Update user details
        UPDATE Users
        SET email = newEmail, username = newUsername, password = newPassword
        WHERE userID = inputUserID;
    END IF;
END $$
DELIMITER ;
