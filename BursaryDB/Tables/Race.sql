CREATE TABLE [dbo].[Race]
(
  [RaceID] INT IDENTITY(1,1) NOT NULL,
  [RaceName] VARCHAR(20) NOT NULL,
  CONSTRAINT [PK_Race]
    PRIMARY KEY CLUSTERED (RaceID ASC)
)