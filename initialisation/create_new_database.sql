-----------------------------------------------------ApplicationStatusTable----------------
CREATE TABLE [dbo].[ApplicationStatus]
(
  [StatusID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  [Status] VARCHAR(10) NOT NULL
);
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


----------------------------------University----------------------------------------

CREATE TABLE [dbo].[University]
(
  [UniversityID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  [UniversityName] VARCHAR(100) UNIQUE NOT NULL,
  [UserID] INT NOT NULL,

);


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


------------------------------------University Application Table-------------------------------------





------------------------------------BursaryDetails
