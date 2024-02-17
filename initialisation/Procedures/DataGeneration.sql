 
 DECLARE @Counter INT
SET @Counter = 1


WHILE @Counter <= 50
BEGIN
    -- Generate random first and last names
    DECLARE @FirstName VARCHAR(50)
    DECLARE @LastName VARCHAR(120)
     SET @FirstName = (
        SELECT TOP 1 FirstName
        FROM (
            VALUES ('Themba'), ('Sipho'), ('Lungelo'), ('Mbali'), ('Nomusa'), ('Naledi'), ('Thando'), ('Bongani'), ('Nandi'), ('Sibusiso')
        ) AS FN(FirstName)
        ORDER BY NEWID()
    );

    SET @LastName = (
        SELECT TOP 1 LastName
        FROM (
            VALUES ('Mthembu'), ('Van Wyk'), ('Singh'), ('Petersen'), ('Molefe'), ('Johnson'), ('Jacobs'), ('Smith'), ('Mkhize'), ('Abrahams')
        ) AS LN(LastName)
        ORDER BY NEWID()
    );

    -- Generate random phone number and email
    DECLARE @ContactNumber CHAR(10)
    DECLARE @Email VARCHAR(100)
    SET @ContactNumber = '0' + RIGHT('000000000' + CAST(CAST(RAND() * 1000000000 AS INT) AS VARCHAR(10)), 9) -- Generate 10 digit phone number starting with 0
    SET @Email = @FirstName + '.' + @LastName + '@gmail.com'

    -- Insert into dbo.Contact table
    INSERT INTO [dbo].[Contact] (ContactNumber, Email)
    VALUES (@ContactNumber, @Email)

    -- Get the generated Contact's ID
    DECLARE @ContactID INT
    SET @ContactID = SCOPE_IDENTITY()

    -- Generate random South African ID number
DECLARE @IDNumber CHAR(13)
DECLARE @DOB DATE

SET @DOB = DATEADD(YEAR, -1 * RAND() * (2006 - 1990), CAST('2006-01-01' AS DATE)) 

-- Generate a random number within a suitable range
DECLARE @RandomNumber INT
SET @RandomNumber = ABS(CHECKSUM(NEWID())) % 100000

SET @IDNumber = CONVERT(CHAR(2), YEAR(@DOB) % 100) 
                + RIGHT('0' + CONVERT(VARCHAR(2), MONTH(@DOB)), 2) 
                + RIGHT('0' + CONVERT(VARCHAR(2), DAY(@DOB)), 2) 
                + RIGHT('00000' + CONVERT(VARCHAR(5), @RandomNumber), 5)


    -- Insert into dbo.User table
    DECLARE @InsertID INT

-- Check if the table is empty
IF NOT EXISTS (SELECT 1 FROM [dbo].[User])
BEGIN
    -- Table is empty, insert 1
    SET @InsertID = 1
END
ELSE
BEGIN
    -- Table is not empty, insert using SCOPE_IDENTITY()
    SET @InsertID = SCOPE_IDENTITY()
END
    INSERT INTO [dbo].[User] (FirstName, LastName, IDNumber,ContactID)
    VALUES (@FirstName, @LastName, @IDNumber,SCOPE_IDENTITY())

    -- Get the generated User's ID
    DECLARE @UserID INT
    SET @UserID = SCOPE_IDENTITY()

    

    -- Update the User row with the ContactID
    UPDATE [dbo].[User]
    SET ContactID = @ContactID
    WHERE UserID = @UserID

    SET @Counter = @Counter + 1
END

 INSERT INTO [dbo].[University] ([UniversityName],[UserID])
  VALUES
  ('University of Cape Town',1),
  ('University of the Witwatersrand',2),
  ('University of Pretoria',3),
  ('Universiteit Stellenbosch',4),
  ('University of KwaZulu-Natal',5),
  ('Rhodes University',6),
  ('University of Johannesburg',7),
  ('University of the Western Cape',8),
  ('North-West University',9),
  ('University of the Free State',10),
  ('Nelson Mandela University',11),
  ('Cape Peninsula University of Technology',12),
  ('Durban University of Technology',13),
  ('Tshwane University of Technology',14),
  ('University of Fort Hare',15);

  INSERT INTO [dbo].[YearlyBursaryDetails]([YearBudget],[CapAmountPerStudent]) VALUES (3000000,125000)
  INSERT INTO [dbo].[YearlyBursaryDetails]([YearBudget],[CapAmountPerStudent]) VALUES (3000000,125000)
  INSERT INTO [dbo].[YearlyBursaryDetails]([YearBudget],[CapAmountPerStudent]) VALUES (3000000,125000)

DECLARE @Counter2 INT
SET @Counter2 = 16


WHILE @Counter2 <= 50
BEGIN

DECLARE @RaceID int
DECLARE @CourseOfStudy VARCHAR(50)
DECLARE @UniversityID int
DECLARE @DepartmentID int

SET @RaceID = FLOOR(RAND() * 3) + 1; 
SELECT TOP 1 @CourseOfStudy = CourseName
FROM (
    VALUES 
        ('Computer Science'),
        ('Software Engineering'),
        ('Information Technology'),
        ('Engineering'),
        ('Data Science')
) AS Courses(CourseName)
ORDER BY NEWID()
SET @UniversityID = FLOOR(RAND() * 16) + 1; 
SET @DepartmentID = FLOOR(RAND() * 3) + 1; 


 INSERT INTO [dbo].[Student]([UserID],[RaceID],[CourseOfStudy],[UniversityID],[DepartmentID]) VALUES (@Counter2,@RaceID,@CourseOfStudy,@UniversityID,@DepartmentID)

 SET @Counter2 = @Counter2 + 1
END

