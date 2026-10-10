USE UniversityRecordsDB;
GO

DROP TABLE IF EXISTS Enrolment;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Module;
DROP TABLE IF EXISTS Course;

CREATE TABLE Course (
	course_id INT PRIMARY KEY,
	course_name VARCHAR(100) NOT NULL UNIQUE,
	department VARCHAR(100) NOT NULL,
	duration_years int NOT NULL 
		CHECK (duration_years BETWEEN 1 AND 6)
);

CREATE TABLE Student (
	student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    course_id INT NOT NULL,
    year_of_study INT NOT NULL
        CHECK (year_of_study >= 1),
    status VARCHAR(20) NOT NULL DEFAULT 'Active'
        CHECK (status IN
            ('Active', 'Suspended', 'Graduated', 'Withdrawn')),
    FOREIGN KEY (course_id)
        REFERENCES Course (course_id)
);

CREATE TABLE Module (
    module_id VARCHAR(10) PRIMARY KEY,
    module_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL
        CHECK (credits > 0)
);

CREATE TABLE Enrolment (
    student_id INT NOT NULL,
    module_id VARCHAR(10) NOT NULL,
    mark INT NULL
        CHECK (mark BETWEEN 0 AND 100),
    PRIMARY KEY(student_id, module_id),
    FOREIGN KEY (student_id)
        REFERENCES Student (student_id),
    FOREIGN KEY (module_id)
        REFERENCES Module (module_id)
);
