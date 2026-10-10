USE UniversityRecordsDB;
GO

-- 1. Primary key violation
-- Expected error: Violation of PRIMARY KEY constraint.
-- Student ID 10042 already exists in dbo.Student.

BEGIN TRY
    INSERT INTO Student
        (student_id, first_name, last_name, email, date_of_birth,
         course_id, year_of_study)
    VALUES
        (10042, 'Test', 'Student', 'test.pk@example.com',
         '2005-01-01', 1, 1);
END TRY
BEGIN CATCH
    SELECT 'Test 1 - Primary Key' AS TestName,
           ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO


-- 2. Unique constraint violation
-- Expected error: Violation of UNIQUE KEY constraint.
-- The same email is used for two different student IDs.

BEGIN TRY
    INSERT INTO Student
        (student_id, first_name, last_name, email, date_of_birth,
         course_id, year_of_study)
    VALUES
        (20001, 'Test', 'Student', 'alex.morgan@example.com',
         '2005-01-01', 1, 1);
END TRY
BEGIN CATCH
    SELECT 'Test 2 - Unique Email' AS TestName,
           ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO


-- 3. CHECK constraint violation
-- Expected error: The INSERT statement conflicted with the CHECK constraint.
-- 'Retired' is not an allowed student status.

BEGIN TRY
    INSERT INTO Student
        (student_id, first_name, last_name, email, date_of_birth,
         course_id, year_of_study, status)
    VALUES
        (20002, 'Test', 'Student', 'test.status@example.com',
         '2005-01-01', 1, 1, 'Retired');
END TRY
BEGIN CATCH
    SELECT 'Test 3 - Invalid Status' AS TestName,
           ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO


-- 4. Foreign key violation
-- Expected error: The INSERT statement conflicted with the FOREIGN KEY constraint.
-- Course ID 9999 does not exist in dbo.Course.

BEGIN TRY
    INSERT INTO Student
        (student_id, first_name, last_name, email, date_of_birth,
         course_id, year_of_study)
    VALUES
        (20003, 'Test', 'Student', 'test.course@example.com',
         '2005-01-01', 9999, 1);
END TRY
BEGIN CATCH
    SELECT 'Test 4 - Invalid Course' AS TestName,
           ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO


-- 5. CHECK constraint violation
-- Expected error: The INSERT statement conflicted with the CHECK constraint.
-- Marks must be between 0 and 100.

BEGIN TRY
    INSERT INTO Enrolment (student_id, module_id, mark)
    VALUES (10042, 'CS101', 150);
END TRY
BEGIN CATCH
    SELECT 'Test 5 - Invalid Mark' AS TestName,
           ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO


-- 6. Foreign key violation
-- Expected error: The DELETE statement conflicted with the REFERENCE constraint.
-- Course ID 1 still has students enrolled on it.

BEGIN TRY
    DELETE FROM Course
    WHERE course_id = 1;
END TRY
BEGIN CATCH
    SELECT 'Test 6 - Delete Course With Students' AS TestName,
           ERROR_MESSAGE() AS ExpectedError;
END CATCH;
GO
