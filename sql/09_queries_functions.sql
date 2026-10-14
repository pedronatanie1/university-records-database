USE UniversityRecordsDB;
GO

-- =====================================================
-- 1. STRING FUNCTIONS
-- =====================================================

-- Display student names in uppercase and lowercase,
-- and combine first and last names into a full name.
SELECT
    student_id,
    UPPER(first_name) AS first_name_upper,
    LOWER(last_name) AS last_name_lower,
    CONCAT(first_name, ' ', last_name) AS full_name
FROM dbo.Student;


-- =====================================================
-- 2. STRING LENGTH
-- =====================================================

-- Display the length of each student's full name.
-- LEN() is the SQL Server equivalent of LENGTH() in many other engines.
SELECT
    student_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEN(CONCAT(first_name, ' ', last_name)) AS full_name_length
FROM dbo.Student;


-- =====================================================
-- 3. NULL HANDLING WITH COALESCE
-- =====================================================

-- Display recorded marks, replacing NULL with 0 for display only.
-- This does not update the stored database values.
SELECT
    student_id,
    module_id,
    mark AS recorded_mark,
    COALESCE(mark, 0) AS displayed_mark
FROM dbo.Enrolment;


-- =====================================================
-- 4. DATE FUNCTIONS: CALCULATE AGE
-- =====================================================

-- Calculate each student's age in completed years.
-- DATEDIFF counts year boundaries, so subtract one if their birthday
-- has not occurred yet this year.
SELECT
    student_id,
    first_name,
    last_name,
    date_of_birth,
    DATEDIFF(
        YEAR,
        date_of_birth,
        CAST(GETDATE() AS DATE)
    )
    - CASE
        WHEN DATEADD(
            YEAR,
            DATEDIFF(
                YEAR,
                date_of_birth,
                CAST(GETDATE() AS DATE)
            ),
            date_of_birth
        ) > CAST(GETDATE() AS DATE)
        THEN 1
        ELSE 0
      END AS age
FROM dbo.Student;
GO
