USE UniversityRecordsDB;
GO

-- =====================================================
-- 1. PRIMARY KEY VIOLATION
-- =====================================================

-- Expected error: Violation of PRIMARY KEY constraint.
-- Student ID 10042 already exists in dbo.Student.

BEGIN TRY
    INSERT INTO dbo.Student (
        student_id,
        first_name,
        last_name,
        email,
        date_of_birth,
        course_id,
        year_of_study
    )
    VALUES (
        10042,
        'Test',
        'Student',
        'test.pk@example.com',
        '2005-01-01',
        1,
        1
    );
END TRY
BEGIN CATCH
    SELECT
        'Test 1 - Primary Key' AS TestName,
        ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO


-- =====================================================
-- 2. UNIQUE CONSTRAINT VIOLATION
-- =====================================================

-- Expected error: Violation of UNIQUE KEY constraint.
-- The email already belongs to another student.

BEGIN TRY
    INSERT INTO dbo.Student (
        student_id,
        first_name,
        last_name,
        email,
        date_of_birth,
        course_id,
        year_of_study
    )
    VALUES (
        20001,
        'Test',
        'Student',
        'alex.morgan@example.com',
        '2005-01-01',
        1,
        1
    );
END TRY
BEGIN CATCH
    SELECT
        'Test 2 - Unique Email' AS TestName,
        ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO


-- =====================================================
-- 3. CHECK CONSTRAINT VIOLATION: INVALID STATUS
-- =====================================================

-- Expected error: The INSERT statement conflicted with the CHECK constraint.
-- 'Retired' is not an allowed student status.

BEGIN TRY
    INSERT INTO dbo.Student (
        student_id,
        first_name,
        last_name,
        email,
        date_of_birth,
        course_id,
        year_of_study,
        status
    )
    VALUES (
        20002,
        'Test',
        'Student',
        'test.status@example.com',
        '2005-01-01',
        1,
        1,
        'Retired'
    );
END TRY
BEGIN CATCH
    SELECT
        'Test 3 - Invalid Status' AS TestName,
        ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO


-- =====================================================
-- 4. FOREIGN KEY VIOLATION: INVALID COURSE
-- =====================================================

-- Expected error: The INSERT statement conflicted with the FOREIGN KEY constraint.
-- Course ID 9999 does not exist in dbo.Course.

BEGIN TRY
    INSERT INTO dbo.Student (
        student_id,
        first_name,
        last_name,
        email,
        date_of_birth,
        course_id,
        year_of_study
    )
    VALUES (
        20003,
        'Test',
        'Student',
        'test.course@example.com',
        '2005-01-01',
        9999,
        1
    );
END TRY
BEGIN CATCH
    SELECT
        'Test 4 - Invalid Course' AS TestName,
        ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO


-- =====================================================
-- 5. CHECK CONSTRAINT VIOLATION: INVALID MARK
-- =====================================================

-- Expected error: The INSERT statement conflicted with the CHECK constraint.
-- Marks must be between 0 and 100.

BEGIN TRY
    INSERT INTO dbo.Enrolment (
        student_id,
        module_id,
        mark
    )
    VALUES (
        10042,
        'CS101',
        150
    );
END TRY
BEGIN CATCH
    SELECT
        'Test 5 - Invalid Mark' AS TestName,
        ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO


-- =====================================================
-- 6. FOREIGN KEY VIOLATION: DELETE REFERENCED COURSE
-- =====================================================

-- Expected error: The DELETE statement conflicted with the REFERENCE constraint.
-- Course ID 1 still has students enrolled on it.

BEGIN TRY
    DELETE FROM dbo.Course
    WHERE course_id = 1;
END TRY
BEGIN CATCH
    SELECT
        'Test 6 - Delete Course With Students' AS TestName,
        ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO
