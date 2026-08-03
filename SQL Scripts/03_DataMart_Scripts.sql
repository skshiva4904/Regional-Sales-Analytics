--USE [master]
--GO

--/****** Object:  Database [DM_Sales_Analysis]    Script Date: 14-05-2024 16:50:54 ******/

--CREATE DATABASE [DM_Sales_Analysis]
-- CONTAINMENT = NONE
-- ON  PRIMARY 
--( NAME = N'DM_Sales_Analysis', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\DM_Sales_Analysis.mdf' , SIZE = 139264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
-- LOG ON 
--( NAME = N'DM_Sales_Analysis_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\DM_Sales_Analysis_log.ldf' , SIZE = 466944KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
-- WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET COMPATIBILITY_LEVEL = 160
--GO

--IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
--begin
--EXEC [DM_Sales_Analysis].[dbo].[sp_fulltext_database] @action = 'enable'
--end
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET ANSI_NULL_DEFAULT OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET ANSI_NULLS OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET ANSI_PADDING OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET ANSI_WARNINGS OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET ARITHABORT OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET AUTO_CLOSE OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET AUTO_SHRINK OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET AUTO_UPDATE_STATISTICS ON 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET CURSOR_CLOSE_ON_COMMIT OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET CURSOR_DEFAULT  GLOBAL 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET CONCAT_NULL_YIELDS_NULL OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET NUMERIC_ROUNDABORT OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET QUOTED_IDENTIFIER OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET RECURSIVE_TRIGGERS OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET  DISABLE_BROKER 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET DATE_CORRELATION_OPTIMIZATION OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET TRUSTWORTHY OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET ALLOW_SNAPSHOT_ISOLATION OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET PARAMETERIZATION SIMPLE 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET READ_COMMITTED_SNAPSHOT OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET HONOR_BROKER_PRIORITY OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET RECOVERY SIMPLE 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET  MULTI_USER 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET PAGE_VERIFY CHECKSUM  
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET DB_CHAINING OFF 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET TARGET_RECOVERY_TIME = 60 SECONDS 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET DELAYED_DURABILITY = DISABLED 
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET ACCELERATED_DATABASE_RECOVERY = OFF  
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET QUERY_STORE = ON
--GO

--ALTER DATABASE [DM_Sales_Analysis] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
--GO

--USE [DM_Sales_Analysis]
--GO


-- --------------------------------------------------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fact_Sales]') AND type in (N'U'))
DROP TABLE [dbo].[Fact_Sales]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIM_City]') AND type in (N'U'))
DROP TABLE [dbo].[DIM_City]
GO

CREATE TABLE [dbo].[DIM_City](
	[City_ID] [bigint] NOT NULL primary key,
	[City_Name] [nvarchar](150) NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[AreaCode] [nvarchar](150) NULL,
	[Population] [float] NULL,
	[Household_Income] [float] NULL,
	[Median_Income] [float] NULL,
	[Land_Area] [float] NULL,
	[Water_Area] [float] NULL,
	[Time_Zone] [nvarchar](50) NULL

) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIM_County]') AND type in (N'U'))
DROP TABLE [dbo].[DIM_County]
GO

CREATE TABLE [dbo].[DIM_County](
	[County_ID] [bigint] NOT NULL primary key,
	[County_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIM_Customer]') AND type in (N'U'))
DROP TABLE [dbo].[DIM_Customer]
GO
CREATE TABLE [dbo].[DIM_Customer](
	[Customer_ID] [bigint] NOT NULL primary key,
	[Customer_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIM_Product]') AND type in (N'U'))
DROP TABLE [dbo].[DIM_Product]
GO

CREATE TABLE [dbo].[DIM_Product](
	[Product_ID] [bigint] NOT NULL primary key,
	[Product_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIM_Region]') AND type in (N'U'))
DROP TABLE [dbo].[DIM_Region]
GO

CREATE TABLE [dbo].[DIM_Region](
	[Region_ID] [bigint] NOT NULL primary key,
	[Region_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIM_Sales_Channel]') AND type in (N'U'))
DROP TABLE [dbo].[DIM_Sales_Channel]
GO

CREATE TABLE [dbo].[DIM_Sales_Channel](
	[Sales_Channel_ID] [bigint] NOT NULL primary key,
	[Sales_Channel_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIM_Sales_Region]') AND type in (N'U'))
DROP TABLE [dbo].[DIM_Sales_Region]
GO

CREATE TABLE [dbo].[DIM_Sales_Region](
	[Sales_Region_ID] [bigint] NOT NULL primary key,
	[Sales_Region_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIM_Sales_Team]') AND type in (N'U'))
DROP TABLE [dbo].[DIM_Sales_Team]
GO

CREATE TABLE [dbo].[DIM_Sales_Team](
	[Sales_Team_ID] [bigint] NOT NULL primary key,
	[Sales_Team_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIM_State]') AND type in (N'U'))
DROP TABLE [dbo].[DIM_State]
GO

CREATE TABLE [dbo].[DIM_State](
	[State_Code] [nvarchar](50) NOT NULL primary key,
	[State_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIM_Type]') AND type in (N'U'))
DROP TABLE [dbo].[DIM_Type]
GO

CREATE TABLE [dbo].[DIM_Type](
	[Type_ID] [bigint] NOT NULL primary key,
	[Type_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIM_Warehouse]') AND type in (N'U'))
DROP TABLE [dbo].[DIM_Warehouse]
GO

CREATE TABLE [dbo].[DIM_Warehouse](
	[Warehouse_ID] [bigint] NOT NULL primary key,
	[Warehouse_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Fact_Sales](
	[ID] [bigint] IDENTITY(1,1) NOT NULL primary key,
	City_ID bigint not null constraint FK_City_ID FOREIGN KEY (City_ID) references dbo.DIM_City (City_ID),
	County_ID bigint not null constraint FK_County_ID FOREIGN KEY (County_ID) references dbo.DIM_County (County_ID),
	Customer_ID bigint not null constraint FK_Customer_ID FOREIGN KEY (Customer_ID) references dbo.DIM_Customer (Customer_ID),
	Product_ID bigint not null constraint FK_Product_ID FOREIGN KEY (Product_ID) references dbo.DIM_Product (Product_ID),
	Region_ID bigint not null constraint FK_Region_ID FOREIGN KEY (Region_ID) references dbo.DIM_Region (Region_ID),
	Sales_Region_ID bigint not null constraint FK_Sales_Region_ID FOREIGN KEY (Sales_Region_ID) references dbo.DIM_Sales_Region (Sales_Region_ID),
	Sales_Channel_ID bigint not null constraint FK_Sales_Channel_ID FOREIGN KEY (Sales_Channel_ID) references dbo.DIM_Sales_Channel (Sales_Channel_ID),
	Sales_Team_ID bigint not null constraint FK_Sales_Team_ID FOREIGN KEY (Sales_Team_ID) references dbo.DIM_Sales_Team (Sales_Team_ID),
	State_Code nvarchar(50) not null constraint FK_State_Code FOREIGN KEY (State_Code) references dbo.DIM_State (State_Code),
	[Type_ID] bigint not null constraint FK_Type_ID FOREIGN KEY ([Type_ID]) references dbo.DIM_Type ([Type_ID]),
	Warehouse_ID bigint not null constraint FK_Warehouse_ID FOREIGN KEY (Warehouse_ID) references dbo.DIM_Warehouse (Warehouse_ID),
	[OrderNumber] [nvarchar](50) NOT NULL,
	[ProcuredDate] [date] NOT NULL,
	[OrderDate] [date] NOT NULL,
	[ShipDate] [date] NOT NULL,
	[DeliveryDate] [date] NOT NULL,
	[CurrencyCode] [nvarchar](50) NOT NULL,
	[Order_Quantity] [tinyint] NOT NULL,
	[Discount_Applied] [float] NOT NULL,
	[Unit_Price] [float] NOT NULL,
	[Unit_Cost] [float] NOT NULL
) ON [PRIMARY]
GO


Insert into DM_Sales_Analysis.dbo.DIM_City (City_ID,City_Name,Latitude,Longitude,AreaCode,Population,Household_Income,Median_Income,Land_Area,Water_Area,Time_Zone)  Select City_ID,City_Name,Latitude,Longitude,AreaCode,Population,Household_Income,Median_Income,Land_Area,Water_Area,Time_Zone From STG_Sales_Analysis.dbo.STG_City  GO  
Insert into DM_Sales_Analysis.dbo.DIM_County (County_ID,County_Name)  Select County_ID,County_Name From STG_Sales_Analysis.dbo.STG_County  GO  
Insert into DM_Sales_Analysis.dbo.DIM_Customer (Customer_ID,Customer_Name)  Select Customer_ID,Customer_Name From STG_Sales_Analysis.dbo.STG_Customer  GO  
Insert into DM_Sales_Analysis.dbo.DIM_Product (Product_ID,Product_Name)  Select Product_ID,Product_Name From STG_Sales_Analysis.dbo.STG_Product  GO  
Insert into DM_Sales_Analysis.dbo.DIM_Region (Region_ID,Region_Name)  Select Region_ID,Region_Name From STG_Sales_Analysis.dbo.STG_Region  GO  
Insert into DM_Sales_Analysis.dbo.DIM_Sales_Channel (Sales_Channel_ID,Sales_Channel_Name)  Select Sales_Channel_ID,Sales_Channel_Name From STG_Sales_Analysis.dbo.STG_Sales_Channel  GO  
Insert into DM_Sales_Analysis.dbo.DIM_Sales_Region (Sales_Region_ID,Sales_Region_Name)  Select Sales_Region_ID,Sales_Region_Name From STG_Sales_Analysis.dbo.STG_Sales_Region  GO  
Insert into DM_Sales_Analysis.dbo.DIM_Sales_Team (Sales_Team_ID,Sales_Team_Name)  Select Sales_Team_ID,Sales_Team_Name From STG_Sales_Analysis.dbo.STG_Sales_Team  GO  
Insert into DM_Sales_Analysis.dbo.DIM_State (State_Code,State_Name)  Select State_Code,State_Name From STG_Sales_Analysis.dbo.STG_State  GO  
Insert into DM_Sales_Analysis.dbo.DIM_Type (Type_ID,Type_Name)  Select Type_ID,Type_Name From STG_Sales_Analysis.dbo.STG_Type  GO  
Insert into DM_Sales_Analysis.dbo.DIM_Warehouse (Warehouse_ID,Warehouse_Name)  Select Warehouse_ID,Warehouse_Name From STG_Sales_Analysis.dbo.STG_Warehouse  GO  

Insert into dbo.Fact_Sales (
City_ID ,County_ID ,Customer_ID ,Product_ID ,Region_ID ,Sales_Region_ID ,Sales_Channel_ID ,Sales_Team_ID ,State_Code ,[Type_ID]
,Warehouse_ID ,OrderNumber ,ProcuredDate ,OrderDate ,ShipDate ,DeliveryDate ,CurrencyCode ,Order_Quantity ,Discount_Applied
,Unit_Price ,Unit_Cost
)
select
	CT.City_ID
	,CNT.County_ID
	,CST.Customer_ID
	,PRD.Product_ID
	,RGN.Region_ID
	,SR.Sales_Region_ID
	,SC.Sales_Channel_ID
	,ST.Sales_Team_ID
	,STT.State_Code
	,Tp.[Type_ID]
	,WR.Warehouse_ID
	,[OrderNumber]
	,[ProcuredDate] 
	,[OrderDate] 
	,[ShipDate] 
	,[DeliveryDate] 
	,[CurrencyCode]
	,[Order_Quantity] 
	,[Discount_Applied] 
	,[Unit_Price]
	,[Unit_Cost]
from STG_Sales_Analysis.dbo.Regional_Sales_Data Sales
inner join dbo.DIM_City CT on sales.CityName = CT.City_Name
inner join dbo.DIM_County CNT on sales.County = CNT.County_Name
inner join dbo.DIM_Customer CST on sales.Customer_Name = CST.Customer_Name
inner join dbo.DIM_Product PRD on sales.Product_Name = PRD.Product_Name
inner join dbo.DIM_Region RGN on sales.Region = RGN.Region_Name
inner join dbo.DIM_Sales_Channel SC on sales.Sales_Channel = SC.Sales_Channel_Name
inner join dbo.DIM_Sales_Region SR on Sales.Sales_Region = SR.Sales_Region_Name
inner join dbo.DIM_Sales_Team ST on Sales.Sales_Team_Name2 = ST.Sales_Team_Name
inner join dbo.DIM_State STT on Sales.State = STT.State_Name
inner join dbo.DIM_Type TP on Sales.[Type] = Tp.[Type_Name] 
inner join dbo.DIM_Warehouse WR on Sales.WarehouseCode = WR.Warehouse_Name