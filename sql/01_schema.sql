USE UniversityRecordsDB;
GO

-- Drop existing tables in dependency order.
DROP TABLE IF EXISTS dbo.Enrolment;
DROP TABLE IF EXISTS dbo.Student;
DROP TABLE IF EXISTS dbo.Module;
DROP TABLE IF EXISTS dbo.Course;
GO

-- =====================================================
-- 1. COURSE
-- =====================================================

CREATE TABLE dbo.Course (
    course_id INT NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    duration_years INT NOT NULL,

    CONSTRAINT PK_Course
        PRIMARY KEY (course_id),

    CONSTRAINT UQ_Course_CourseName
        UNIQUE (course_name),

    CONSTRAINT CK_Course_DurationYears
        CHECK (duration_years BETWEEN 1 AND 6)
);
GO

-- =====================================================
-- 2. STUDENT
-- =====================================================

CREATE TABLE dbo.Student (
    student_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    course_id INT NOT NULL,
    year_of_study INT NOT NULL,
    status VARCHAR(20) NOT NULL
        CONSTRAINT DF_Student_Status DEFAULT 'Active',

    CONSTRAINT PK_Student
        PRIMARY KEY (student_id),

    CONSTRAINT UQ_Student_Email
        UNIQUE (email),

    CONSTRAINT CK_Student_YearOfStudy
        CHECK (year_of_study >= 1),

    CONSTRAINT CK_Student_Status
        CHECK (
            status IN ('Active', 'Suspended', 'Graduated', 'Withdrawn')
        ),

    CONSTRAINT FK_Student_Course
        FOREIGN KEY (course_id)
        REFERENCES dbo.Course (course_id)
);
GO

-- =====================================================
-- 3. MODULE
-- =====================================================

CREATE TABLE dbo.Module (
    module_id VARCHAR(10) NOT NULL,
    module_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,

    CONSTRAINT PK_Module
        PRIMARY KEY (module_id),

    CONSTRAINT CK_Module_Credits
        CHECK (credits > 0)
);
GO

-- =====================================================
-- 4. ENROLMENT
-- =====================================================

CREATE TABLE dbo.Enrolment (
    student_id INT NOT NULL,
    module_id VARCHAR(10) NOT NULL,
    mark INT NULL,

    CONSTRAINT PK_Enrolment
        PRIMARY KEY (student_id, module_id),

    CONSTRAINT CK_Enrolment_Mark
        CHECK (mark BETWEEN 0 AND 100),

    CONSTRAINT FK_Enrolment_Student
        FOREIGN KEY (student_id)
        REFERENCES dbo.Student (student_id),

    CONSTRAINT FK_Enrolment_Module
        FOREIGN KEY (module_id)
        REFERENCES dbo.Module (module_id)
);
GO
