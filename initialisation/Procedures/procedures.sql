CREATE PROCEDURE [dbo].uspAddBBDAdmin
@ContactNumber CHAR(10),
@Email VARCHAR(100),
@FirstName VARCHAR(50),
@LastName VARCHAR(120),
@IDNumber CHAR(13)
AS
BEGIN
DECLARE @ContactID int;
DECLARE @UserID int;

INSERT INTO [dbo].[Contact] (ContactNumber,Email) VALUES (@ContactNumber,@Email);

SET @ContactID = SCOPE_IDENTITY(); 

INSERT INTO [dbo].[User](FirstName,LastName,IDNumber,ContactID) VALUES (@FirstName,@LastName,@IDNumber,@ContactID);

SET @UserID = SCOPE_IDENTITY();

INSERT INTO [dbo].[BBDAdministrator](UserID) VALUES (@UserID);


END
GO




CREATE PROCEDURE [dbo].uspAddUniversity
@ContactNumber CHAR(10),
@Email VARCHAR(100),
@FirstName VARCHAR(50),
@LastName VARCHAR(120),
@UniversityName VARCHAR(100),
@IDNumber CHAR(13)
AS
BEGIN
DECLARE @ContactID int;
DECLARE @UserID int;

INSERT INTO [dbo].[Contact] (ContactNumber,Email) VALUES (@ContactNumber,@Email);

SET @ContactID = SCOPE_IDENTITY(); 

INSERT INTO [dbo].[User](FirstName,LastName,IDNumber,ContactID) VALUES (@FirstName,@LastName,@IDNumber,@ContactID);

SET @UserID = SCOPE_IDENTITY();

INSERT INTO [dbo].[University](UserID,UniversityName) VALUES (@UserID,@UniversityName);
END
GO


CREATE PROCEDURE [dbo].uspAddHOD
@ContactNumber CHAR(10),
@Email VARCHAR(100),
@FirstName VARCHAR(50),
@LastName VARCHAR(120),
@DepartmentID INT,
@UniversityID INT,
@IDNumber CHAR(13)
AS

BEGIN
DECLARE @ContactID int;
DECLARE @UserID int;

INSERT INTO [dbo].[Contact] (ContactNumber,Email) VALUES (@ContactNumber,@Email);

SET @ContactID = SCOPE_IDENTITY(); 

INSERT INTO [dbo].[User](FirstName,LastName,IDNumber,ContactID) VALUES (@FirstName,@LastName,@IDNumber,@ContactID);

SET @UserID = SCOPE_IDENTITY();

INSERT INTO [dbo].[HeadOfDepartment](DepartmentID,UniversityID,UserID) VALUES (@DepartmentID,@UniversityID,@UserID);
END
GO


EXEC [dbo].uspAddBBDAdmin '0610277058','test@works.com', 'Mxolisi','Sibaya','9912235120089'
GO
EXEC [dbo].uspAddUniversity '0610277066','test2@works.com', 'Mxolisii','Sibayay','University Of Impilo','8912235120089'
GO

EXEC [dbo].uspAddHOD '0857812809','test3@gmail.com','Msholissi','Sibiz',3,1,'0512315521081'
GO