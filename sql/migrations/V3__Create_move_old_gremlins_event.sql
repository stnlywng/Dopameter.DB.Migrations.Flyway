-- V3__Create_move_old_gremlins_event.sql

-- Ensure the event scheduler is turned on
SET GLOBAL event_scheduler = ON;

-- Create the event to move old gremlins from CurrentGremlins to OldGremlins
CREATE EVENT IF NOT EXISTS MoveOldGremlins
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    -- Insert gremlins that need to be moved into OldGremlins
    INSERT INTO OldGremlins (userID, gremlinID)
    SELECT cg.userID, cg.gremlinID
    FROM CurrentGremlins cg
    JOIN Gremlins g ON cg.gremlinID = g.gremlinID
    WHERE g.lastFedDate < NOW() - INTERVAL 4 WEEK;

    -- Delete the moved gremlins from CurrentGremlins
    DELETE FROM CurrentGremlins
    WHERE gremlinID IN (
        SELECT gremlinID
        FROM Gremlins
        WHERE lastFedDate < NOW() - INTERVAL 4 WEEK
    );
END;
