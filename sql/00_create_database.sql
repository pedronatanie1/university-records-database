USE master;
GO

-- Create the database only if it does not already exist.
IF DB_ID('UniversityRecordsDB') IS NULL
BEGIN
    CREATE DATABASE UniversityRecordsDB;
END;
GO
