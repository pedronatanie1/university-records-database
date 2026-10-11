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


-- 2. Successful transaction: enrol student 10050 in two modules and commit.
-- In the seed data student 10050 is only enrolled in CS101 and CS102, so both
-- of these inserts really happen. The IF checks make the example safe to rerun.

BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS
    (
        SELECT 1
        FROM Enrolment
        WHERE student_id = 10050
          AND module_id = 'CS103'
    )
    BEGIN
        INSERT INTO Enrolment (student_id, module_id)
        VALUES (10050, 'CS103');
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM Enrolment
        WHERE student_id = 10050
          AND module_id = 'CS104'
    )
    BEGIN
        INSERT INTO Enrolment (student_id, module_id)
        VALUES (10050, 'CS104');
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

-- Verify that both new enrolments were saved.
-- Expected result: two rows (CS103 and CS104) with a NULL mark.
SELECT
    student_id,
    module_id,
    mark
FROM Enrolment
WHERE student_id = 10050
  AND module_id IN ('CS103', 'CS104');
GO


-- 3. Failed transaction: the second insert references
-- a module that does not exist, violating the foreign key.
-- The first insert must also be rolled back.
-- In the seed data student 10051 is not enrolled in CS103, so the first
-- insert is a valid new row that would be saved if the transaction committed.

BEGIN TRY
    BEGIN TRANSACTION;

    -- This insert is valid, so it succeeds inside the transaction.
    IF NOT EXISTS
    (
        SELECT 1
        FROM Enrolment
        WHERE student_id = 10051
          AND module_id = 'CS103'
    )
    BEGIN
        INSERT INTO Enrolment (student_id, module_id)
        VALUES (10051, 'CS103');
    END;

    -- Deliberately invalid module ID: expected to fail.
    INSERT INTO Enrolment (student_id, module_id)
    VALUES (10051, 'INVALID');

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
-- Expected result: no rows. The valid CS103 insert was rolled back too.

SELECT
    student_id,
    module_id,
    mark
FROM Enrolment
WHERE student_id = 10042
  AND module_id IN ('CS103', 'INVALID');
GO
