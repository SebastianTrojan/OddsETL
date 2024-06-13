USE [Odds_poject]
GO

/****** Object:  Table [dbo].[DimDate]    Script Date: 13.06.2024 06:00:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DimDate](
	[DateID] [int] NOT NULL,
	[FullDate] [date] NULL,
	[Year] [int] NULL,
	[Quarter] [int] NULL,
	[Month] [int] NULL,
	[Day] [int] NULL,
	[Weekday] [int] NULL,
	[DayOfYear] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


DECLARE @TimeID INT;
SET @TimeID = 0;

DECLARE @StartDate DATE = '2019-01-01';
DECLARE @EndDate DATE = '2024-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    SET @TimeID = @TimeID + 1;

    INSERT INTO DimTime (TimeID, FullDate, Year, Quarter, Month, Day, Weekday, DayOfYear)
    VALUES (
        @TimeID,
        @StartDate,
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        MONTH(@StartDate),
        DAY(@StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATEPART(DAYOFYEAR, @StartDate)
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;


/****** Object:  Table [dbo].[FactPlayerAppearance]    Script Date: 13.06.2024 05:58:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FactPlayerAppearance](
	[PlayerAppearanceID] [int] IDENTITY(1,1) NOT NULL,
	[MatchID] [int] NOT NULL,
	[Position] [nvarchar](50) NOT NULL,
	[HomeTeam] [nvarchar](50) NOT NULL,
	[AwayTeam] [nvarchar](50) NOT NULL,
	[Goals] [int] NOT NULL,
	[Shots] [int] NOT NULL,
	[XG] [float] NOT NULL,
	[XA] [float] NOT NULL,
	[Assists] [int] NOT NULL,
	[KeyPasses] [int] NOT NULL,
	[NoPenaltyGoals] [int] NOT NULL,
	[XNPG] [float] NOT NULL,
	[XGChain] [float] NOT NULL,
	[XGBuildUp] [float] NOT NULL,
	[Time] [int] NOT NULL,
	[PlayerID] [int] NOT NULL,
	[DateID] [int] NOT NULL,
 CONSTRAINT [PK_FactPlayerAppearance] PRIMARY KEY CLUSTERED 
(
	[PlayerAppearanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FactPlayerAppearance]  WITH CHECK ADD  CONSTRAINT [FK_FactPlayerAppearance_DimDate] FOREIGN KEY([DateID])
REFERENCES [dbo].[DimDate] ([DateID])
GO

ALTER TABLE [dbo].[FactPlayerAppearance] CHECK CONSTRAINT [FK_FactPlayerAppearance_DimDate]
GO

ALTER TABLE [dbo].[FactPlayerAppearance]  WITH CHECK ADD  CONSTRAINT [FK_FactPlayerAppearance_DimPlayer] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[DimPlayer] ([PlayerID])
GO

ALTER TABLE [dbo].[FactPlayerAppearance] CHECK CONSTRAINT [FK_FactPlayerAppearance_DimPlayer]
GO

ALTER TABLE [dbo].[FactPlayerAppearance]  WITH CHECK ADD  CONSTRAINT [FK_FactPlayerAppearance_FactMatch] FOREIGN KEY([MatchID])
REFERENCES [dbo].[FactMatch] ([MatchID])
GO

ALTER TABLE [dbo].[FactPlayerAppearance] CHECK CONSTRAINT [FK_FactPlayerAppearance_FactMatch]
GO


/****** Object:  Table [dbo].[FactMatch]    Script Date: 13.06.2024 05:58:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FactMatch](
	[MatchID] [int] IDENTITY(1,1) NOT NULL,
	[Time] [time](7) NOT NULL,
	[MatchPlayed] [bit] NOT NULL,
	[Season] [nvarchar](9) NOT NULL,
	[HomeTeam] [nvarchar](50) NOT NULL,
	[AwayTeam] [nvarchar](50) NOT NULL,
	[HalfTimeResult] [nvarchar](50) NULL,
	[Result] [nvarchar](50) NULL,
	[HalfTimeHomeGoals] [int] NULL,
	[HalfTimeAwayGoals] [int] NULL,
	[HomeFouls] [int] NULL,
	[AwayFouls] [int] NULL,
	[HomeCorners] [int] NULL,
	[AwayCorners] [int] NULL,
	[HomeYellows] [int] NULL,
	[AwayYellows] [int] NULL,
	[AwayReds] [int] NULL,
	[HomeReds] [int] NULL,
	[OddHomeWin] [float] NULL,
	[OddUnder2_5Goals] [float] NULL,
	[OddOver2_5Goals] [float] NULL,
	[OddAwayWin] [float] NULL,
	[OddDraw] [float] NULL,
	[AwayXG] [float] NULL,
	[HomeXG] [float] NULL,
	[AwayDeep] [int] NULL,
	[HomeDeep] [int] NULL,
	[AwayShotsOnTarget] [int] NULL,
	[HomeShotsOnTarget] [int] NULL,
	[AwayShots] [int] NULL,
	[HomeShots] [int] NULL,
	[AwayGoals] [int] NULL,
	[HomeGoals] [int] NULL,
	[HomePPDA] [float] NULL,
	[AwayPPDA] [float] NULL,
	[AwayWinChances] [float] NULL,
	[DrawChances] [float] NULL,
	[HomeWinChances] [float] NULL,
	[League] [nvarchar](50) NOT NULL,
	[HomeWinOutcome] [bit] NULL,
	[DrawOutcome] [bit] NULL,
	[AwayWinOutcome] [bit] NULL,
	[Over2_5Outcome] [bit] NULL,
	[Under2_5Outcome] [bit] NULL,
	[DateID] [int] NOT NULL,
 CONSTRAINT [PK_FactMatch] PRIMARY KEY CLUSTERED 
(
	[MatchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FactMatch]  WITH CHECK ADD  CONSTRAINT [FK_FactMatch_DimDate] FOREIGN KEY([DateID])
REFERENCES [dbo].[DimDate] ([DateID])
GO

ALTER TABLE [dbo].[FactMatch] CHECK CONSTRAINT [FK_FactMatch_DimDate]
GO

/****** Object:  Table [dbo].[DimPlayer]    Script Date: 13.06.2024 05:58:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DimPlayer](
	[PlayerID] [int] IDENTITY(1,1) NOT NULL,
	[Season] [nvarchar](16) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Team] [nvarchar](50) NOT NULL,
	[ValidFromDate] [date] NOT NULL,
	[ValidToDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO