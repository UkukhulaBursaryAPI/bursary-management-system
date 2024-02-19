--USE master
--GO
--CREATE DATABASE Ukukhula
--GO

--USE Ukukhula
--GO

-----------------------------------------------------ApplicationStatusTable----------------
CREATE TABLE [dbo].[ApplicationStatus]
(
  [StatusID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  [Status] VARCHAR(10) NOT NULL
);
GO

INSERT INTO [dbo].[ApplicationStatus] (Status) VALUES ('Pending'),('Accepted'),('Rejected')
GO
------------------Contact table-------------------------
CREATE TABLE [dbo].[Contact]
(
  [ContactID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  [ContactNumber] CHAR(10) NOT NULL,
  [Email] VARCHAR(100) NOT NULL
);
GO

--------------------Race Table-----------------------------
CREATE TABLE [dbo].[Race]
(
  [RaceID] INT IDENTITY(1,1) NOT NULL,
  [RaceName] VARCHAR(10) NOT NULL,
  CONSTRAINT [PK_Race]
    PRIMARY KEY CLUSTERED (RaceID ASC)
)
GO
INSERT INTO dbo.[Race]([RaceName]) VALUES ('African'),('Indian'),('Colored')
GO

-----------------------------User Table-----------------------------------
CREATE TABLE [dbo].[User]
(
  [UserID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL ,
  [FirstName] VARCHAR(50) NOT NULL,
  [LastName] VARCHAR(120) NOT NULL,
  [IDNumber] CHAR(13) UNIQUE NOT NULL,
  [ContactID] INT NOT NULL,
)
GO


ALTER TABLE [dbo].[User]
ADD CONSTRAINT FK_Contact FOREIGN KEY([ContactID]) REFERENCES [dbo].[Contact]
GO

----------------------------------Department----------------------------------------
CREATE TABLE [dbo].[Department]
(
  [DepartmentID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  [DepartmentName] VARCHAR(100) NOT NULL
)
GO

INSERT INTO [dbo].[Department] VALUES ('ComputerScience'),('GameDevelopment'),('Engineering')
GO


----------------------------------University----------------------------------------

CREATE TABLE [dbo].[University]
(
  [UniversityID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  [UniversityName] VARCHAR(100) UNIQUE NOT NULL,
  [UserID] INT NOT NULL,

);
GO

ALTER TABLE [dbo].[University]
 ADD CONSTRAINT [FK_USER_UNIVERSITY] FOREIGN KEY([UserID]) REFERENCES [dbo].[User]([UserID])
GO


------------------------------Student Table-----------------------------------------------

CREATE TABLE [dbo].[Student]
(
  [StudentID] INT IDENTITY(1,1)  PRIMARY KEY NOT NULL,
  [UserID] INT UNIQUE NOT NULL,
  [RaceID] INT NOT NULL,
  [CourseOfStudy] VARCHAR(250) NOT NULL, 
  [UniversityID] INT NOT NULL,
  [DepartmentID] INT NOT NULL
)
GO

ALTER TABLE [dbo].[Student]
ADD CONSTRAINT [F_KUserID] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User]
GO

ALTER TABLE [dbo].[Student]
ADD CONSTRAINT [F_KRace] FOREIGN KEY ([RaceID]) REFERENCES [dbo].[Race]
GO

ALTER TABLE [dbo].[Student]
ADD CONSTRAINT [F_KDepartmentID] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Department]
GO

---------------------------------------------BBDAdministrator----------------------------
CREATE TABLE [dbo].[BBDAdministrator]
(
  [AdministratorID] INT  IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [UserID] INT UNIQUE NOT NULL
)
GO

ALTER TABLE [dbo].[BBDAdministrator]
ADD CONSTRAINT UQ_AdminID UNIQUE(UserID)
GO

ALTER TABLE [dbo].[BBDAdministrator]
ADD CONSTRAINT [FK_UserID] FOREIGN KEY([UserID]) REFERENCES [dbo].[User]
GO



------------------------------------HeadOfDepartment---------------------------------------
CREATE TABLE [dbo].[HeadOfDepartment]
(
  [HeadOfDepartmentID] INT IDENTITY NOT NULL PRIMARY KEY,
  [DepartmentID] INT NOT NULL,
  [UniversityID] INT NOT NULL,
  [UserID] INT NOT NULL UNIQUE
)
GO

ALTER TABLE [dbo].[HeadOfDepartment]
  ADD CONSTRAINT [FK_HeadOfDepartment_Department_DepartmentID] 
      FOREIGN KEY ([DepartmentID]) 
      REFERENCES [dbo].[Department]([DepartmentID])
GO

ALTER TABLE [dbo].[HeadOfDepartment]
    ADD CONSTRAINT [FK_HeadOfDepartment_University_UniversityID]
      FOREIGN KEY ([UniversityID])
      REFERENCES [dbo].[University]([UniversityID])
GO

ALTER TABLE [dbo].[HeadOfDepartment]
    ADD  CONSTRAINT [FK_HeadOfDepartment_User_UserID]
      FOREIGN KEY ([UserID])
      REFERENCES [dbo].[User]([UserID])
GO

------------------------------------BursaryDetails Table----------------------------------
CREATE TABLE [dbo].[YearlyBursaryDetails]
(
  [BursaryDetailsID] INT IDENTITY(2022,1) NOT NULL PRIMARY KEY,
  [YearBudget] MONEY NOT NULL,
  [CapAmountPerStudent] MONEY NOT NULL
);
GO

------------------------------------University Application Table-------------------------------------
CREATE TABLE [dbo].[UniversityApplication]
(
  [UniversityApplicationID]  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  [UniversityID] INT NOT NULL,
  [Motivation] TEXT NOT NULL,
  [StatusID] INT NOT NULL DEFAULT 2,
  [ReviewerComment] TEXT NOT NULL DEFAULT 'N/A',
  [ApplicationDate] DATE NOT NULL DEFAULT GETDATE(),
)
GO

ALTER TABLE [dbo].[UniversityApplication]
ADD CONSTRAINT [FK_UniversityID] FOREIGN KEY([UniversityID]) REFERENCES [dbo].[University]
GO

ALTER TABLE [dbo].[UniversityApplication]
ADD CONSTRAINT [FK_StatusID] FOREIGN KEY([StatusID]) REFERENCES [dbo].[ApplicationStatus]
GO
------------------------------------Yearly University Allocation------------------------------

CREATE TABLE [dbo].[YearlyUniversityAllocation]
(
  [AllocationID] INT IDENTITY NOT NULL PRIMARY KEY,
  [UniversityID] INT NOT NULL,
  [AllocatedAmount] MONEY NOT NULL,
  [BursaryDetailsID] INT NOT NULL,

);
GO

ALTER TABLE [dbo].[YearlyUniversityAllocation]
  ADD CONSTRAINT [FK_YearlyUniversityAllocation_University_UniversityID]
      FOREIGN KEY ([UniversityID])
      REFERENCES [dbo].[University]([UniversityID])
GO


ALTER TABLE [dbo].[YearlyUniversityAllocation]
  ADD CONSTRAINT [FK__University_BursaryDetails]
      FOREIGN KEY ([BursaryDetailsID])
      REFERENCES [dbo].[YearlyBursaryDetails]([BursaryDetailsID])
GO

-- ALTER TABLE [dbo].[YearlyUniversityAllocation]
--     ADD CONSTRAINT [CHK_YearlyUniversityAllocation_AllocatedAmount]
--         CHECK ([dbo].[udfTotalYearlyUniversityAmountAllocated](GETDATE()) + [AllocatedAmount] <= [dbo].[udfTotalAmountForYear] (Year([DateAllocated])))
-- GO


---------------------------------------Student Bursary Application----------------------------------
CREATE TABLE [dbo].[StudentBursaryApplication]
(
  [ApplicationID] INT IDENTITY NOT NULL PRIMARY KEY,
  [ApplicationMotivation] TEXT NOT NULL,
  [ApplicationRejectionReason] TEXT NOT NULL DEFAULT 'N/A',
  [BursaryAmount] MONEY NOT NULL,
  [StudentID] INT NOT NULL UNIQUE,
  [AverageMark] INT NOT NULL,
  [BursaryDetailsID] INT NOT NULL,
  [HeadOfDepartmentID] INT NOT NULL,
  [StatusID] INT NOT NULL,
  [ApplicationDate] DATE NOT NULL DEFAULT GETDATE()
)
GO


ALTER TABLE [dbo].[StudentBursaryApplication]
  ADD CONSTRAINT [FK_StudentID_Application] FOREIGN KEY([StudentID]) REFERENCES [dbo].[Student](StudentID)
GO


ALTER TABLE [dbo].[StudentBursaryApplication]
  ADD CONSTRAINT [FK_BursaryDetailsID_Application] FOREIGN KEY([BursaryDetailsID]) REFERENCES [dbo].[YearlyBursaryDetails](BursaryDetailsID)
GO

GO
ALTER TABLE [dbo].[StudentBursaryApplication]
  ADD CONSTRAINT [FK_HeadOfDepartmentID_Application] FOREIGN KEY([HeadOfDepartmentID]) REFERENCES [dbo].[HeadOfDepartment](HeadOfDepartmentID)
GO

ALTER TABLE [dbo].[StudentBursaryApplication]
  ADD CONSTRAINT [FK_StatusID_Application] FOREIGN KEY([StatusID]) REFERENCES [dbo].[ApplicationStatus](StatusID)
GO




------------------------------------------------------Student Documents Table-------------------------
CREATE TABLE [dbo].[StudentBursaryDocuments]
(
  [StudentDocumentID] INT IDENTITY NOT NULL PRIMARY KEY,
  [IdCopy] VARCHAR(1000) NOT NULL,
  [Transcript] VARCHAR(1000) NOT NULL,
  [CurriculumVitae] VARCHAR(1000) NOT NULL,
  [StudentID] INT NOT NULL UNIQUE
)
GO

ALTER TABLE [dbo].[StudentBursaryDocuments]
  ADD CONSTRAINT [FK_StudentBursaryDocuments_StudentID]
      FOREIGN KEY ([StudentID])
      REFERENCES [dbo].[Student]([StudentID])
GO


--------------------------Create all the required tables--------------------------------------------------


SELECT * FROM [dbo].ApplicationStatus
SELECT * FROM [dbo].[Contact]
SELECT * FROM [dbo].[Race]
SELECT * FROM [dbo].[User]
SELECT * FROM [dbo].[Department]
SELECT * FROM [dbo].[University]
SELECT * FROM [dbo].[Student]
SELECT * FROM [dbo].[BBDAdministrator]
SELECT * FROM [dbo].[HeadOfDepartment]
SELECT * FROM [dbo].[YearlyBursaryDetails]
SELECT * FROM [dbo].[UniversityApplication]
SELECT * FROM [dbo].[YearlyUniversityAllocation]
SELECT * FROM [dbo].[StudentBursaryApplication]
INNER JOIN [dbo].Student ON [dbo].[StudentBursaryApplication].StudentID = [dbo].Student.StudentID
INNER JOIN [dbo].University ON [dbo].Student.UniversityID = [dbo].University.UniversityID
SELECT * FROM [dbo].[StudentBursaryDocuments]

--INSERT INTO [dbo].[StudentBursaryApplication] (ApplicationMotivation,ApplicationRejectionReason,BursaryAmount,StudentID,AverageMark,BursaryDetailsID,HeadOfDepartmentID,StatusID,ApplicationDate) 
--VALUES ('FEES MUST FALL','APPLICATION APPROVED',125000,29,80,2024,1,2,'2024-01-24')



 