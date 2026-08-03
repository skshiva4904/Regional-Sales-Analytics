--/* First Run this script to create database
--dont forget to change the path for Database File Name and Log File Name
--*/

--USE [master]
--GO

--/****** Object:  Database [STG_Sales_Analysis]    Script Date: 15-05-2024 07:00:36 ******/

--CREATE DATABASE [STG_Sales_Analysis]
-- CONTAINMENT = NONE
-- ON  PRIMARY 
--( NAME = N'STG_Sales_Analysis', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\STG_Sales_Analysis.mdf' , SIZE = 1515520KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
-- LOG ON 
--( NAME = N'STG_Sales_Analysis_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\STG_Sales_Analysis_log.ldf' , SIZE = 2039808KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
-- WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
--GO

--IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
--begin
--EXEC [STG_Sales_Analysis].[dbo].[sp_fulltext_database] @action = 'enable'
--end
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET ANSI_NULL_DEFAULT OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET ANSI_NULLS OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET ANSI_PADDING OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET ANSI_WARNINGS OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET ARITHABORT OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET AUTO_CLOSE OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET AUTO_SHRINK OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET AUTO_UPDATE_STATISTICS ON 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET CURSOR_CLOSE_ON_COMMIT OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET CURSOR_DEFAULT  GLOBAL 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET CONCAT_NULL_YIELDS_NULL OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET NUMERIC_ROUNDABORT OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET QUOTED_IDENTIFIER OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET RECURSIVE_TRIGGERS OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET  DISABLE_BROKER 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET DATE_CORRELATION_OPTIMIZATION OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET TRUSTWORTHY OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET ALLOW_SNAPSHOT_ISOLATION OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET PARAMETERIZATION SIMPLE 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET READ_COMMITTED_SNAPSHOT OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET HONOR_BROKER_PRIORITY OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET RECOVERY SIMPLE 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET  MULTI_USER 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET PAGE_VERIFY CHECKSUM  
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET DB_CHAINING OFF 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET TARGET_RECOVERY_TIME = 60 SECONDS 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET DELAYED_DURABILITY = DISABLED 
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET ACCELERATED_DATABASE_RECOVERY = OFF  
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET QUERY_STORE = ON
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
--GO

--ALTER DATABASE [STG_Sales_Analysis] SET  READ_WRITE 
--GO


/* Once database is create commentout above script
Then Import the data from CSV File
Un comment below Script
*/

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

USE [STG_Sales_Analysis]
GO

/****** Object:  Table [dbo].[STG_Profit_Center]    Script Date: 14-05-2024 14:59:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STG_City]') AND type in (N'U'))
DROP TABLE [dbo].[STG_City]
GO

CREATE TABLE [dbo].[STG_City](
	[City_ID] [bigint] IDENTITY(1,1) NOT NULL primary key,
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STG_County]') AND type in (N'U'))
DROP TABLE [dbo].[STG_County]
GO

CREATE TABLE [dbo].[STG_County](
	[County_ID] [bigint] IDENTITY(1,1) NOT NULL primary key,
	[County_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STG_Customer]') AND type in (N'U'))
DROP TABLE [dbo].[STG_Customer]
GO
CREATE TABLE [dbo].[STG_Customer](
	[Customer_ID] [bigint] IDENTITY(1,1) NOT NULL primary key,
	[Customer_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STG_Product]') AND type in (N'U'))
DROP TABLE [dbo].[STG_Product]
GO

CREATE TABLE [dbo].[STG_Product](
	[Product_ID] [bigint] IDENTITY(1,1) NOT NULL primary key,
	[Product_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STG_Region]') AND type in (N'U'))
DROP TABLE [dbo].[STG_Region]
GO

CREATE TABLE [dbo].[STG_Region](
	[Region_ID] [bigint] IDENTITY(1,1) NOT NULL primary key,
	[Region_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STG_Sales_Channel]') AND type in (N'U'))
DROP TABLE [dbo].[STG_Sales_Channel]
GO

CREATE TABLE [dbo].[STG_Sales_Channel](
	[Sales_Channel_ID] [bigint] IDENTITY(1,1) NOT NULL primary key,
	[Sales_Channel_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STG_Sales_Region]') AND type in (N'U'))
DROP TABLE [dbo].[STG_Sales_Region]
GO

CREATE TABLE [dbo].[STG_Sales_Region](
	[Sales_Region_ID] [bigint] IDENTITY(1,1) NOT NULL primary key,
	[Sales_Region_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STG_Sales_Team]') AND type in (N'U'))
DROP TABLE [dbo].[STG_Sales_Team]
GO

CREATE TABLE [dbo].[STG_Sales_Team](
	[Sales_Team_ID] [bigint] IDENTITY(1,1) NOT NULL primary key,
	[Sales_Team_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STG_State]') AND type in (N'U'))
DROP TABLE [dbo].[STG_State]
GO

CREATE TABLE [dbo].[STG_State](
	[State_Code] [nvarchar](50) NOT NULL primary key,
	[State_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STG_Type]') AND type in (N'U'))
DROP TABLE [dbo].[STG_Type]
GO

CREATE TABLE [dbo].[STG_Type](
	[Type_ID] [bigint] IDENTITY(1,1) NOT NULL primary key,
	[Type_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STG_Warehouse]') AND type in (N'U'))
DROP TABLE [dbo].[STG_Warehouse]
GO

CREATE TABLE [dbo].[STG_Warehouse](
	[Warehouse_ID] [bigint] IDENTITY(1,1) NOT NULL primary key,
	[Warehouse_Name] [nvarchar](150) NULL
) ON [PRIMARY]
GO


insert into dbo.STG_City ([City_Name],Latitude,Longitude,AreaCode,[Population],[Household_Income],[Median_Income],[Land_Area],[Water_Area],[Time_Zone])  
select distinct [CityName],Latitude,Longitude,AreaCode,[Population],[Household_Income],[Median_Income],[Land_Area],[Water_Area],[Time_Zone] from dbo.Regional_Sales_Data
GO

Insert into [dbo].[STG_County] (County_Name) select distinct county from dbo.Regional_Sales_Data
Go
Insert into [dbo].[STG_Customer] ([Customer_Name]) select distinct Customer_Name from dbo.Regional_Sales_Data
Go
Insert into [dbo].[STG_Product] ([Product_Name]) select distinct Product_Name from dbo.Regional_Sales_Data
Go
Insert into [dbo].[STG_Region] ([Region_Name]) select distinct Region from dbo.Regional_Sales_Data
Go
Insert into [dbo].[STG_Sales_Channel] ([Sales_Channel_Name]) select distinct Sales_Channel from dbo.Regional_Sales_Data
Go
Insert into [dbo].[STG_Sales_Region] ([Sales_Region_Name]) select distinct Sales_Region from dbo.Regional_Sales_Data
Go
Insert into [dbo].[STG_Sales_Team] ([Sales_Team_Name]) select distinct Sales_Team_Name2 from dbo.Regional_Sales_Data
Go
Insert into [dbo].[STG_State] (State_Code,State_Name) select distinct State_Code,State from dbo.Regional_Sales_Data
Go
Insert into [dbo].[STG_Type] (Type_Name) select distinct [Type] from dbo.Regional_Sales_Data
Go
Insert into [dbo].[STG_Warehouse] (Warehouse_Name) select distinct WarehouseCode from dbo.Regional_Sales_Data
Go
