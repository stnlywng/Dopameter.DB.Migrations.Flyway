-- V2__Create_tables.sql

CREATE TABLE Gremlins (
    gremlinID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    activityName VARCHAR(100) NOT NULL,
    kindOfGremlin SMALLINT NOT NULL,
    intensity INT NOT NULL CHECK (intensity BETWEEN 1 AND 1000),
    dateOfBirth DATETIME NOT NULL,
    lastFedDate DATETIME NOT NULL
);

CREATE TABLE CurrentGremlins (
    userID INT NOT NULL,
    gremlinID INT NOT NULL,
    PRIMARY KEY (userID, gremlinID),
    FOREIGN KEY (gremlinID) REFERENCES Gremlins(gremlinID)
);

CREATE TABLE OldGremlins (
    userID INT NOT NULL,
    gremlinID INT NOT NULL,
    PRIMARY KEY (userID, gremlinID),
    FOREIGN KEY (gremlinID) REFERENCES Gremlins(gremlinID)
);

CREATE TABLE PastActivities (
    activityName VARCHAR(100) NOT NULL,
    userID INT NOT NULL,
    kindOfGremlin SMALLINT NOT NULL,
    intensity INT NOT NULL CHECK (intensity BETWEEN 1 AND 1000),
    PRIMARY KEY (activityName, userID)
);
