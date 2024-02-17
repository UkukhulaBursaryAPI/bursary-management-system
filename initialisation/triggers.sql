CREATE TRIGGER [dbo].no_more_inserts_departments
ON [dbo].Department
AFTER INSERT
AS
BEGIN
  IF (SELECT COUNT(*) FROM [dbo].Department) > 3
  BEGIN
    ROLLBACK TRANSACTION
    RAISERROR ('You cannot insert into Departments table.', 16, 1);
  END
END
GO

CREATE TRIGGER [dbo].no_more_inserts_AppStatus
ON [dbo].ApplicationStatus
AFTER INSERT
AS
BEGIN
  IF (SELECT COUNT(*) FROM [dbo].ApplicationStatus) > 3
  BEGIN
    ROLLBACK TRANSACTION
    RAISERROR ('You cannot insert into Application Status table.', 16, 1);
  END
END
GO

CREATE TRIGGER [dbo].no_more_inserts_Race
ON [dbo].[Race]
AFTER INSERT
AS
BEGIN
  IF (SELECT COUNT(*) FROM [dbo].[Race]) > 3
  BEGIN
    ROLLBACK TRANSACTION
    RAISERROR ('You cannot insert into race table.', 16, 1);
  END
END
GO