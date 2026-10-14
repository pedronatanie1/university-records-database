USE UniversityRecordsDB;
GO

-- =====================================================
-- 1. CREATE AND TEST A SURNAME INDEX
-- =====================================================

-- Create a nonclustered index to support searches by student surname.
CREATE NONCLUSTERED INDEX IX_Student_LastName
ON dbo.Student (last_name);
GO

-- Example query that can benefit from the surname index.
SELECT
    student_id,
    first_name,
    last_name,
    email
FROM dbo.Student
WHERE last_name = 'Cooper';
GO


-- =====================================================
-- 2. SUCCESSFUL TRANSACTION
-- =====================================================

-- Enrol student 10050 in CS103 and CS104, then commit.
-- The seed data does not contain these enrolments.
-- The IF checks make the example safe to rerun.

BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Enrolment
        WHERE student_id = 10050
          AND module_id = 'CS103'
    )
    BEGIN
        INSERT INTO dbo.Enrolment (
            student_id,
            module_id
        )
        VALUES (
            10050,
            'CS103'
        );
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Enrolment
        WHERE student_id = 10050
          AND module_id = 'CS104'
    )
    BEGIN
        INSERT INTO dbo.Enrolment (
            student_id,
            module_id
        )
        VALUES (
            10050,
            'CS104'
        );
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
-- Expected result: two rows (CS103 and CS104) with NULL marks.
SELECT
    student_id,
    module_id,
    mark
FROM dbo.Enrolment
WHERE student_id = 10050
  AND module_id IN ('CS103', 'CS104');
GO


-- =====================================================
-- 3. FAILED TRANSACTION AND ROLLBACK
-- =====================================================

-- The second insert references a nonexistent module,
-- violating the foreign key constraint.
-- The first insert must also be rolled back.
-- Student 10051 is not enrolled in CS103 in the seed data.

BEGIN TRY
    BEGIN TRANSACTION;

    -- This insert is valid and succeeds inside the transaction.
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Enrolment
        WHERE student_id = 10051
          AND module_id = 'CS103'
    )
    BEGIN
        INSERT INTO dbo.Enrolment (
            student_id,
            module_id
        )
        VALUES (
            10051,
            'CS103'
        );
    END;

    -- Deliberately invalid module ID: expected to fail.
    INSERT INTO dbo.Enrolment (
        student_id,
        module_id
    )
    VALUES (
        10051,
        'INVALID'
    );

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
-- Expected result: no rows, including for CS103.

SELECT
    student_id,
    module_id,
    mark
FROM dbo.Enrolment
WHERE student_id = 10051
  AND module_id IN ('CS103', 'INVALID');
GO
