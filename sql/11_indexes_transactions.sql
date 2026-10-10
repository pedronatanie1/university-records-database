USE UniversityRecordsDB;
GO

-- 1. Create an index to support searches by student surname.
CREATE NONCLUSTERED INDEX IX_Student_LastName
ON Student (last_name);
GO

-- Example query that can benefit from the surname index.
SELECT
    student_id,
    first_name,
    last_name,
    email
FROM Student
WHERE last_name = 'Cooper';
GO


-- 2. Successful transaction: insert two enrolments and commit.
-- These enrolments use existing students and modules.
-- The IF checks make this example safer to rerun.

BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS
    (
        SELECT 1
        FROM Enrolment
        WHERE student_id = 10042
          AND module_id = 'CS101'
    )
    BEGIN
        INSERT INTO Enrolment (student_id, module_id)
        VALUES (10042, 'CS101');
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM Enrolment
        WHERE student_id = 10042
          AND module_id = 'CS102'
    )
    BEGIN
        INSERT INTO Enrolment (student_id, module_id)
        VALUES (10042, 'CS102');
    END;

    COMMIT TRANSACTION;

    PRINT 'Successful transaction committed.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT 'Successful transaction example failed.';
    THROW;
END CATCH;
GO


-- 3. Failed transaction: the second insert references
-- a module that does not exist, violating the foreign key.
-- The first insert must also be rolled back.

BEGIN TRY
    BEGIN TRANSACTION;

    -- This insert should succeed if the enrolment does not exist.
    IF NOT EXISTS
    (
        SELECT 1
        FROM Enrolment
        WHERE student_id = 10042
          AND module_id = 'CS103'
    )
    BEGIN
        INSERT INTO Enrolment (student_id, module_id)
        VALUES (10042, 'CS103');
    END;

    -- Deliberately invalid module ID: expected to fail.
    INSERT INTO Enrolment (student_id, module_id)
    VALUES (10042, 'INVALID');

    -- Reached only if the preceding statements succeed.
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    PRINT 'Expected failure caught; transaction rolled back.';
    PRINT ERROR_MESSAGE();
END CATCH;
GO

-- Verify that the first insert from the failed transaction
-- did not remain in the database.
SELECT
    student_id,
    module_id,
    mark
FROM Enrolment
WHERE student_id = 10042
  AND module_id IN ('CS103', 'INVALID');
GO
