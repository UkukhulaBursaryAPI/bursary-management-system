-- Drop child tables first

-- Drop Student Bursary Documents table
DROP TABLE IF EXISTS [dbo].[StudentBursaryDocuments];

-- Drop Student Bursary Application table
DROP TABLE IF EXISTS [dbo].[StudentBursaryApplication];

-- Drop Yearly University Allocation table
DROP TABLE IF EXISTS [dbo].[YearlyUniversityAllocation];

-- Drop University Application table
DROP TABLE IF EXISTS [dbo].[UniversityApplication];

-- Drop BBD Administrator table
DROP TABLE IF EXISTS [dbo].[BBDAdministrator];

-- Drop Head of Department table
DROP TABLE IF EXISTS [dbo].[HeadOfDepartment];

-- Drop Student table
DROP TABLE IF EXISTS [dbo].[Student];

-- Drop University table
DROP TABLE IF EXISTS [dbo].[University];

-- Drop Department table
DROP TABLE IF EXISTS [dbo].[Department];

-- Drop User table
DROP TABLE IF EXISTS [dbo].[User];

-- Drop Race table
DROP TABLE IF EXISTS [dbo].[Race];

-- Drop Contact table
DROP TABLE IF EXISTS [dbo].[Contact];

-- Drop Application Status table
DROP TABLE IF EXISTS [dbo].[ApplicationStatus];

-- Drop Bursary Details table
DROP TABLE IF EXISTS [dbo].[YearlyBursaryDetails];

DROP PROCEDURE IF EXISTS [dbo].uspAddBBDAdmin
DROP PROCEDURE IF EXISTS [dbo].uspAddUniversity
DROP PROCEDURE IF EXISTS [dbo].uspAddHOD