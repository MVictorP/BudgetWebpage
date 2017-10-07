USE [master]
GO
/****** Object:  Database [CapstoneDB]    Script Date: 10/6/2017 5:20:26 PM ******/
CREATE DATABASE [CapstoneDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CapstoneTest', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\CapstoneTest.mdf' , SIZE = 9216KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CapstoneTest_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\CapstoneTest_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CapstoneDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CapstoneDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CapstoneDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CapstoneDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CapstoneDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CapstoneDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CapstoneDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CapstoneDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CapstoneDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CapstoneDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CapstoneDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CapstoneDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CapstoneDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CapstoneDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CapstoneDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CapstoneDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CapstoneDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CapstoneDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CapstoneDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CapstoneDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CapstoneDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CapstoneDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CapstoneDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CapstoneDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CapstoneDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CapstoneDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CapstoneDB] SET  MULTI_USER 
GO
ALTER DATABASE [CapstoneDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CapstoneDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CapstoneDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CapstoneDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [CapstoneDB]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 10/6/2017 5:20:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Account_Number] [nvarchar](255) NOT NULL,
	[Customer_ID] [int] NOT NULL,
	[Account_Type] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Account_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Budget]    Script Date: 10/6/2017 5:20:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Budget](
	[Budget_ID] [int] IDENTITY(1,1) NOT NULL,
	[Customer_ID] [int] NULL,
	[Budget_Name] [nvarchar](255) NULL,
	[Budget_Amount] [decimal](18, 4) NULL,
	[Budget_Category] [nvarchar](255) NULL,
	[Month_Interval] [int] NULL,
	[Start_Date] [date] NULL,
 CONSTRAINT [PK_Budget] PRIMARY KEY CLUSTERED 
(
	[Budget_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/6/2017 5:20:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Customer_ID] [int] NOT NULL,
	[First_Name] [nvarchar](50) NOT NULL,
	[Last_Name] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 10/6/2017 5:20:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[Transaction_ID] [int] IDENTITY(1,1) NOT NULL,
	[Account_Type] [nvarchar](255) NOT NULL,
	[Account_Number] [nvarchar](255) NOT NULL,
	[Processing_Date] [date] NOT NULL,
	[Transaction_Type] [nvarchar](255) NOT NULL,
	[Amount] [decimal](18, 4) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[Category] [nvarchar](255) NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[Transaction_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Account] ([Account_Number], [Customer_ID], [Account_Type]) VALUES (N'211111110', 1, N'Checking')
INSERT [dbo].[Account] ([Account_Number], [Customer_ID], [Account_Type]) VALUES (N'3011111130', 1, N'Savings')
INSERT [dbo].[Account] ([Account_Number], [Customer_ID], [Account_Type]) VALUES (N'3111 3450 2930 9203', 1, N'Credit Card')
INSERT [dbo].[Account] ([Account_Number], [Customer_ID], [Account_Type]) VALUES (N'411111111', 2, N'Checking')
INSERT [dbo].[Account] ([Account_Number], [Customer_ID], [Account_Type]) VALUES (N'8222222228', 2, N'Savings')
SET IDENTITY_INSERT [dbo].[Budget] ON 

INSERT [dbo].[Budget] ([Budget_ID], [Customer_ID], [Budget_Name], [Budget_Amount], [Budget_Category], [Month_Interval], [Start_Date]) VALUES (1, 1, N'custA goal1 required', CAST(50.0000 AS Decimal(18, 4)), N'savings', 1, CAST(0x0C3C0B00 AS Date))
INSERT [dbo].[Budget] ([Budget_ID], [Customer_ID], [Budget_Name], [Budget_Amount], [Budget_Category], [Month_Interval], [Start_Date]) VALUES (2, 2, N'custB goal1 required', CAST(1000.0000 AS Decimal(18, 4)), N'savings', 6, CAST(0x0C3C0B00 AS Date))
INSERT [dbo].[Budget] ([Budget_ID], [Customer_ID], [Budget_Name], [Budget_Amount], [Budget_Category], [Month_Interval], [Start_Date]) VALUES (3, 1, N'custA goal2 test', CAST(100.0000 AS Decimal(18, 4)), N'checking', 3, CAST(0x0C3C0B00 AS Date))
INSERT [dbo].[Budget] ([Budget_ID], [Customer_ID], [Budget_Name], [Budget_Amount], [Budget_Category], [Month_Interval], [Start_Date]) VALUES (6, 1, N'test test test', CAST(100.0000 AS Decimal(18, 4)), N'test', 4, CAST(0x5C3D0B00 AS Date))
SET IDENTITY_INSERT [dbo].[Budget] OFF
INSERT [dbo].[Customer] ([Customer_ID], [First_Name], [Last_Name], [Username], [Password]) VALUES (1, N'Dave', N'Smith', N'smith', N'smith')
INSERT [dbo].[Customer] ([Customer_ID], [First_Name], [Last_Name], [Username], [Password]) VALUES (2, N'Jen', N'Davis', N'davis', N'davis')
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (1, N'Checking', N'211111110', CAST(0x0C3C0B00 AS Date), N'CR', CAST(239.0000 AS Decimal(18, 4)), N'Account Open Deposit', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (2, N'Checking', N'211111110', CAST(0x0D3C0B00 AS Date), N'DR', CAST(-2.0000 AS Decimal(18, 4)), N'Starbucks', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (3, N'Checking', N'211111110', CAST(0x0F3C0B00 AS Date), N'CR', CAST(800.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (4, N'Checking', N'211111110', CAST(0x123C0B00 AS Date), N'DR', CAST(-8.0000 AS Decimal(18, 4)), N'Chipotle', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (5, N'Checking', N'211111110', CAST(0x143C0B00 AS Date), N'DR', CAST(-10.0000 AS Decimal(18, 4)), N'ATM', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (6, N'Checking', N'211111110', CAST(0x153C0B00 AS Date), N'DR', CAST(-32.0000 AS Decimal(18, 4)), N'Hoolihans', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (7, N'Checking', N'211111110', CAST(0x153C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'KCPL', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (8, N'Checking', N'211111110', CAST(0x153C0B00 AS Date), N'DR', CAST(-190.0000 AS Decimal(18, 4)), N'Google Fiber', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (9, N'Checking', N'211111110', CAST(0x1A3C0B00 AS Date), N'DR', CAST(-9.9900 AS Decimal(18, 4)), N'Netflix', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (10, N'Checking', N'211111110', CAST(0x1A3C0B00 AS Date), N'DR', CAST(-350.0000 AS Decimal(18, 4)), N'Rent', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (11, N'Checking', N'211111110', CAST(0x1B3C0B00 AS Date), N'DR', CAST(-2.0000 AS Decimal(18, 4)), N'Starbucks', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (12, N'Checking', N'211111110', CAST(0x1D3C0B00 AS Date), N'CR', CAST(750.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (13, N'Checking', N'211111110', CAST(0x1D3C0B00 AS Date), N'DR', CAST(-620.0000 AS Decimal(18, 4)), N'Commerce Bank Credit Card payment', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (14, N'Checking', N'211111110', CAST(0x1E3C0B00 AS Date), N'DR', CAST(-150.0000 AS Decimal(18, 4)), N'McFaddens', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (15, N'Checking', N'211111110', CAST(0x213C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'Price Chopper', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (16, N'Checking', N'211111110', CAST(0x223C0B00 AS Date), N'CR', CAST(50.0000 AS Decimal(18, 4)), N'Check from friend', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (17, N'Checking', N'211111110', CAST(0x2B3C0B00 AS Date), N'CR', CAST(800.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (18, N'Checking', N'211111110', CAST(0x2B3C0B00 AS Date), N'DR', CAST(-9.0000 AS Decimal(18, 4)), N'Hyvee', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (19, N'Checking', N'211111110', CAST(0x353C0B00 AS Date), N'DR', CAST(-14.0000 AS Decimal(18, 4)), N'McFaddens', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (20, N'Checking', N'211111110', CAST(0x363C0B00 AS Date), N'DR', CAST(-32.0000 AS Decimal(18, 4)), N'Target', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (21, N'Checking', N'211111110', CAST(0x363C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'KCPL', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (22, N'Checking', N'211111110', CAST(0x393C0B00 AS Date), N'CR', CAST(750.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (23, N'Checking', N'211111110', CAST(0x3B3C0B00 AS Date), N'DR', CAST(-190.0000 AS Decimal(18, 4)), N'Google Fiber', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (24, N'Checking', N'211111110', CAST(0x3B3C0B00 AS Date), N'DR', CAST(-9.9900 AS Decimal(18, 4)), N'Netflix', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (25, N'Checking', N'211111110', CAST(0x3B3C0B00 AS Date), N'DR', CAST(-350.0000 AS Decimal(18, 4)), N'Rent', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (26, N'Checking', N'211111110', CAST(0x3F3C0B00 AS Date), N'DR', CAST(-6.5000 AS Decimal(18, 4)), N'Neo''s', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (27, N'Checking', N'211111110', CAST(0x3F3C0B00 AS Date), N'DR', CAST(-230.0000 AS Decimal(18, 4)), N'Commerce Bank Credit Card payment', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (28, N'Checking', N'211111110', CAST(0x3F3C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'Best Buy', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (29, N'Checking', N'211111110', CAST(0x3F3C0B00 AS Date), N'DR', CAST(-300.0000 AS Decimal(18, 4)), N'Pottery Barn', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (30, N'Checking', N'211111110', CAST(0x433C0B00 AS Date), N'DR', CAST(-23.0000 AS Decimal(18, 4)), N'The Loft', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (31, N'Checking', N'211111110', CAST(0x433C0B00 AS Date), N'DR', CAST(-45.0000 AS Decimal(18, 4)), N'Dave and Busters', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (32, N'Checking', N'211111110', CAST(0x433C0B00 AS Date), N'DR', CAST(-35.0000 AS Decimal(18, 4)), N'Bowling', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (33, N'Checking', N'211111110', CAST(0x473C0B00 AS Date), N'CR', CAST(800.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (34, N'Checking', N'211111110', CAST(0x483C0B00 AS Date), N'DR', CAST(-210.0000 AS Decimal(18, 4)), N'McFaddens', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (35, N'Checking', N'211111110', CAST(0x483C0B00 AS Date), N'DR', CAST(-18.0000 AS Decimal(18, 4)), N'Taco Bell', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (36, N'Checking', N'211111110', CAST(0x483C0B00 AS Date), N'DR', CAST(-45.0000 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (37, N'Checking', N'211111110', CAST(0x4A3C0B00 AS Date), N'DR', CAST(-130.0000 AS Decimal(18, 4)), N'KCPL', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (38, N'Checking', N'211111110', CAST(0x4A3C0B00 AS Date), N'DR', CAST(-185.0000 AS Decimal(18, 4)), N'Google Fiber', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (39, N'Checking', N'211111110', CAST(0x4C3C0B00 AS Date), N'DR', CAST(-7.9900 AS Decimal(18, 4)), N'Netflix', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (40, N'Checking', N'211111110', CAST(0x4C3C0B00 AS Date), N'DR', CAST(-56.0000 AS Decimal(18, 4)), N'Price Chopper', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (41, N'Checking', N'211111110', CAST(0x4E3C0B00 AS Date), N'DR', CAST(-43.0000 AS Decimal(18, 4)), N'Price Chopper', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (42, N'Checking', N'211111110', CAST(0x4F3C0B00 AS Date), N'DR', CAST(-98.0000 AS Decimal(18, 4)), N'Target', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (43, N'Checking', N'211111110', CAST(0x513C0B00 AS Date), N'DR', CAST(-13.0000 AS Decimal(18, 4)), N'Jose Peppers', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (44, N'Checking', N'211111110', CAST(0x523C0B00 AS Date), N'DR', CAST(-9.0000 AS Decimal(18, 4)), N'Starbucks', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (45, N'Checking', N'211111110', CAST(0x543C0B00 AS Date), N'DR', CAST(-350.0000 AS Decimal(18, 4)), N'Rent', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (46, N'Checking', N'211111110', CAST(0x543C0B00 AS Date), N'DR', CAST(-3.5000 AS Decimal(18, 4)), N'Redbox', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (47, N'Checking', N'211111110', CAST(0x543C0B00 AS Date), N'DR', CAST(-301.0000 AS Decimal(18, 4)), N'Bank of America Credit Card payment', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (48, N'Checking', N'211111110', CAST(0x553C0B00 AS Date), N'CR', CAST(730.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (49, N'Checking', N'211111110', CAST(0x563C0B00 AS Date), N'DR', CAST(-232.6800 AS Decimal(18, 4)), N'Target', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (50, N'Checking', N'211111110', CAST(0x563C0B00 AS Date), N'DR', CAST(-18.5000 AS Decimal(18, 4)), N'Best Buy', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (51, N'Checking', N'211111110', CAST(0x583C0B00 AS Date), N'DR', CAST(-120.0000 AS Decimal(18, 4)), N'Nationwide', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (52, N'Checking', N'211111110', CAST(0x593C0B00 AS Date), N'DR', CAST(-50.0000 AS Decimal(18, 4)), N'KC Police - Speeding Ticket', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (53, N'Checking', N'211111110', CAST(0x593C0B00 AS Date), N'DR', CAST(-50.0000 AS Decimal(18, 4)), N'Uber', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (54, N'Checking', N'211111110', CAST(0x593C0B00 AS Date), N'DR', CAST(-9.2000 AS Decimal(18, 4)), N'Manny''s', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (55, N'Checking', N'211111110', CAST(0x5B3C0B00 AS Date), N'DR', CAST(-24.7500 AS Decimal(18, 4)), N'Toys R Us', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (56, N'Checking', N'211111110', CAST(0x5B3C0B00 AS Date), N'DR', CAST(-3.5000 AS Decimal(18, 4)), N'Scooters', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (57, N'Checking', N'211111110', CAST(0x5C3C0B00 AS Date), N'DR', CAST(-36.0000 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (58, N'Checking', N'211111110', CAST(0x5C3C0B00 AS Date), N'DR', CAST(-32.0000 AS Decimal(18, 4)), N'Price Chopper', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (59, N'Checking', N'211111110', CAST(0x5D3C0B00 AS Date), N'DR', CAST(-48.1200 AS Decimal(18, 4)), N'Home Depot', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (60, N'Checking', N'211111110', CAST(0x5E3C0B00 AS Date), N'DR', CAST(-4.2000 AS Decimal(18, 4)), N'Burger King', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (61, N'Checking', N'211111110', CAST(0x5E3C0B00 AS Date), N'DR', CAST(-45.0000 AS Decimal(18, 4)), N'Jiffy Lube', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (62, N'Checking', N'211111110', CAST(0x5E3C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'Doctor visit', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (63, N'Checking', N'211111110', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-36.0000 AS Decimal(18, 4)), N'CVS', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (64, N'Checking', N'211111110', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-29.0000 AS Decimal(18, 4)), N'Price Chopper', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (65, N'Checking', N'211111110', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-200.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (66, N'Checking', N'211111110', CAST(0x5F3C0B00 AS Date), N'CR', CAST(150.0000 AS Decimal(18, 4)), N'Christmas Check from Grandma', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (67, N'Checking', N'211111110', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-250.0000 AS Decimal(18, 4)), N'Student loans', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (68, N'Checking', N'211111110', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-75.0000 AS Decimal(18, 4)), N'Ford Service', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (69, N'Checking', N'211111110', CAST(0x633C0B00 AS Date), N'DR', CAST(-36.0000 AS Decimal(18, 4)), N'Hallmark', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (70, N'Checking', N'211111110', CAST(0x633C0B00 AS Date), N'DR', CAST(-22.0000 AS Decimal(18, 4)), N'CVS', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (71, N'Checking', N'211111110', CAST(0x633C0B00 AS Date), N'CR', CAST(810.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (72, N'Checking', N'211111110', CAST(0x663C0B00 AS Date), N'DR', CAST(-180.0000 AS Decimal(18, 4)), N'Pottery Barn', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (73, N'Checking', N'211111110', CAST(0x663C0B00 AS Date), N'DR', CAST(-46.0000 AS Decimal(18, 4)), N'Cheesecake Factory', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (74, N'Checking', N'211111110', CAST(0x663C0B00 AS Date), N'DR', CAST(-8.0000 AS Decimal(18, 4)), N'Starbucks', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (75, N'Credit Card', N'3111 3450 2930 9203', CAST(0x0C3C0B00 AS Date), N'CR', CAST(500.0000 AS Decimal(18, 4)), N'Account Open Deposit', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (76, N'Credit Card', N'3111 3450 2930 9203', CAST(0x293C0B00 AS Date), N'DR', CAST(-4.6000 AS Decimal(18, 4)), N'McDonalds', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (77, N'Credit Card', N'3111 3450 2930 9203', CAST(0x2B3C0B00 AS Date), N'DR', CAST(-23.4500 AS Decimal(18, 4)), N'Target', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (78, N'Credit Card', N'3111 3450 2930 9203', CAST(0x2B3C0B00 AS Date), N'DR', CAST(-40.0000 AS Decimal(18, 4)), N'Michaels', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (79, N'Credit Card', N'3111 3450 2930 9203', CAST(0x2F3C0B00 AS Date), N'DR', CAST(-6.7000 AS Decimal(18, 4)), N'Hyvee', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (80, N'Credit Card', N'3111 3450 2930 9203', CAST(0x2F3C0B00 AS Date), N'DR', CAST(-8.9000 AS Decimal(18, 4)), N'Panda Express', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (81, N'Credit Card', N'3111 3450 2930 9203', CAST(0x383C0B00 AS Date), N'DR', CAST(-12.3000 AS Decimal(18, 4)), N'Chipotle', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (82, N'Credit Card', N'3111 3450 2930 9203', CAST(0x393C0B00 AS Date), N'DR', CAST(-7.6000 AS Decimal(18, 4)), N'CVS', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (83, N'Credit Card', N'3111 3450 2930 9203', CAST(0x393C0B00 AS Date), N'DR', CAST(-6.5000 AS Decimal(18, 4)), N'Bolings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (84, N'Credit Card', N'3111 3450 2930 9203', CAST(0x453C0B00 AS Date), N'DR', CAST(-5.4000 AS Decimal(18, 4)), N'Taco Bell', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (85, N'Credit Card', N'3111 3450 2930 9203', CAST(0x453C0B00 AS Date), N'DR', CAST(-23.0000 AS Decimal(18, 4)), N'Margaritas', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (86, N'Credit Card', N'3111 3450 2930 9203', CAST(0x463C0B00 AS Date), N'DR', CAST(-10.0000 AS Decimal(18, 4)), N'Hoolihans', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (87, N'Credit Card', N'3111 3450 2930 9203', CAST(0x463C0B00 AS Date), N'DR', CAST(-12.3500 AS Decimal(18, 4)), N'Gordon Biersch', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (88, N'Credit Card', N'3111 3450 2930 9203', CAST(0x4D3C0B00 AS Date), N'DR', CAST(-11.3400 AS Decimal(18, 4)), N'Forever 21', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (89, N'Credit Card', N'3111 3450 2930 9203', CAST(0x4D3C0B00 AS Date), N'DR', CAST(-16.3400 AS Decimal(18, 4)), N'Lids', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (90, N'Credit Card', N'3111 3450 2930 9203', CAST(0x4D3C0B00 AS Date), N'DR', CAST(-8.9300 AS Decimal(18, 4)), N'Starbucks', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (91, N'Credit Card', N'3111 3450 2930 9203', CAST(0x4D3C0B00 AS Date), N'DR', CAST(-7.4500 AS Decimal(18, 4)), N'Dairy Queen', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (92, N'Credit Card', N'3111 3450 2930 9203', CAST(0x4E3C0B00 AS Date), N'DR', CAST(-9.1200 AS Decimal(18, 4)), N'Mini Golf', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (93, N'Credit Card', N'3111 3450 2930 9203', CAST(0x593C0B00 AS Date), N'DR', CAST(-16.4500 AS Decimal(18, 4)), N'Home Depot', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (94, N'Credit Card', N'3111 3450 2930 9203', CAST(0x593C0B00 AS Date), N'DR', CAST(-17.0900 AS Decimal(18, 4)), N'Walmart ', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (95, N'Credit Card', N'3111 3450 2930 9203', CAST(0x5A3C0B00 AS Date), N'DR', CAST(-10.0000 AS Decimal(18, 4)), N'Quick Trip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (96, N'Credit Card', N'3111 3450 2930 9203', CAST(0x5A3C0B00 AS Date), N'DR', CAST(-34.0000 AS Decimal(18, 4)), N'Quick Trip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (97, N'Credit Card', N'3111 3450 2930 9203', CAST(0x5B3C0B00 AS Date), N'DR', CAST(-12.4300 AS Decimal(18, 4)), N'Wings Café', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (98, N'Credit Card', N'3111 3450 2930 9203', CAST(0x5C3C0B00 AS Date), N'DR', CAST(-9.0000 AS Decimal(18, 4)), N'Chipotle', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (99, N'Credit Card', N'3111 3450 2930 9203', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-43.7800 AS Decimal(18, 4)), N'Bristol', N'None')
GO
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (100, N'Credit Card', N'3111 3450 2930 9203', CAST(0x603C0B00 AS Date), N'DR', CAST(-67.0000 AS Decimal(18, 4)), N'Tanners', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (101, N'Credit Card', N'3111 3450 2930 9203', CAST(0x603C0B00 AS Date), N'DR', CAST(-12.4500 AS Decimal(18, 4)), N'Kwik Shop', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (102, N'Credit Card', N'3111 3450 2930 9203', CAST(0x573C0B00 AS Date), N'DR', CAST(-8.0000 AS Decimal(18, 4)), N'Burger King', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (103, N'Credit Card', N'3111 3450 2930 9203', CAST(0x623C0B00 AS Date), N'DR', CAST(-5.0000 AS Decimal(18, 4)), N'Dollar Store', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (104, N'Credit Card', N'3111 3450 2930 9203', CAST(0x633C0B00 AS Date), N'DR', CAST(-4.5600 AS Decimal(18, 4)), N'Quick Trip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (105, N'Savings', N'3011111130', CAST(0x0C3C0B00 AS Date), N'CR', CAST(872.0000 AS Decimal(18, 4)), N'Account Open Deposit', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (106, N'Savings', N'3011111130', CAST(0x123C0B00 AS Date), N'CR', CAST(100.0000 AS Decimal(18, 4)), N'Refund check ', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (107, N'Savings', N'3011111130', CAST(0x803D0B00 AS Date), N'CR', CAST(150.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (108, N'Savings', N'3011111130', CAST(0x293C0B00 AS Date), N'CR', CAST(0.0200 AS Decimal(18, 4)), N'Interest', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (109, N'Savings', N'3011111130', CAST(0x393C0B00 AS Date), N'CR', CAST(150.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (110, N'Savings', N'3011111130', CAST(0xA83D0B00 AS Date), N'DR', CAST(-492.0000 AS Decimal(18, 4)), N'Property taxes', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (111, N'Savings', N'3011111130', CAST(0x483C0B00 AS Date), N'CR', CAST(0.0400 AS Decimal(18, 4)), N'Interest', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (112, N'Savings', N'3011111130', CAST(0x553C0B00 AS Date), N'CR', CAST(150.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (113, N'Checking', N'411111111', CAST(0x0C3C0B00 AS Date), N'CR', CAST(5340.2800 AS Decimal(18, 4)), N'Account Open Deposit', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (114, N'Checking', N'411111111', CAST(0x0D3C0B00 AS Date), N'DR', CAST(-200.0000 AS Decimal(18, 4)), N'Verizon', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (115, N'Checking', N'411111111', CAST(0x0D3C0B00 AS Date), N'DR', CAST(-18.2400 AS Decimal(18, 4)), N'Panda Express', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (116, N'Checking', N'411111111', CAST(0x0D3C0B00 AS Date), N'DR', CAST(-64.0300 AS Decimal(18, 4)), N'CVS', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (117, N'Checking', N'411111111', CAST(0x0D3C0B00 AS Date), N'DR', CAST(-122.0800 AS Decimal(18, 4)), N'Maurices', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (118, N'Checking', N'411111111', CAST(0x0D3C0B00 AS Date), N'DR', CAST(-26.1100 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (119, N'Checking', N'411111111', CAST(0x0F3C0B00 AS Date), N'DR', CAST(-24.6900 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (120, N'Checking', N'411111111', CAST(0x123C0B00 AS Date), N'DR', CAST(-14.4700 AS Decimal(18, 4)), N'KFC', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (121, N'Checking', N'411111111', CAST(0x123C0B00 AS Date), N'DR', CAST(-9.0000 AS Decimal(18, 4)), N'Car wash', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (122, N'Checking', N'411111111', CAST(0x123C0B00 AS Date), N'DR', CAST(-38.0800 AS Decimal(18, 4)), N'Dollar General', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (123, N'Checking', N'411111111', CAST(0x123C0B00 AS Date), N'DR', CAST(-75.0000 AS Decimal(18, 4)), N'Price Chopper', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (124, N'Checking', N'411111111', CAST(0x133C0B00 AS Date), N'DR', CAST(-85.2500 AS Decimal(18, 4)), N'Bank of America Credit Card Payment', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (125, N'Checking', N'411111111', CAST(0x143C0B00 AS Date), N'DR', CAST(-125.0000 AS Decimal(18, 4)), N'Doctor', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (126, N'Checking', N'411111111', CAST(0x143C0B00 AS Date), N'DR', CAST(-35.8000 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (127, N'Checking', N'411111111', CAST(0x143C0B00 AS Date), N'DR', CAST(-24.4000 AS Decimal(18, 4)), N'Red Robin', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (128, N'Checking', N'411111111', CAST(0x193C0B00 AS Date), N'DR', CAST(-45.0000 AS Decimal(18, 4)), N'Doctor', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (129, N'Checking', N'411111111', CAST(0x193C0B00 AS Date), N'DR', CAST(-10.6500 AS Decimal(18, 4)), N'Starbucks', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (130, N'Checking', N'411111111', CAST(0x1A3C0B00 AS Date), N'CR', CAST(2000.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (131, N'Checking', N'411111111', CAST(0x1A3C0B00 AS Date), N'DR', CAST(-139.7200 AS Decimal(18, 4)), N'AT&T', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (132, N'Checking', N'411111111', CAST(0x1B3C0B00 AS Date), N'DR', CAST(-200.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (133, N'Checking', N'411111111', CAST(0x1B3C0B00 AS Date), N'DR', CAST(-200.0000 AS Decimal(18, 4)), N'Transfer to another bank', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (134, N'Checking', N'411111111', CAST(0x1B3C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'Best Buy', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (135, N'Checking', N'411111111', CAST(0x1B3C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'Target', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (136, N'Checking', N'411111111', CAST(0x1B3C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (137, N'Checking', N'411111111', CAST(0x1B3C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'Amazon', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (138, N'Checking', N'411111111', CAST(0x1B3C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'KCPL', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (139, N'Checking', N'411111111', CAST(0x1C3C0B00 AS Date), N'DR', CAST(-23.5500 AS Decimal(18, 4)), N'Bristol', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (140, N'Checking', N'411111111', CAST(0x1D3C0B00 AS Date), N'DR', CAST(-80.0000 AS Decimal(18, 4)), N'CVS', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (141, N'Checking', N'411111111', CAST(0x1D3C0B00 AS Date), N'DR', CAST(-300.0000 AS Decimal(18, 4)), N'Rent', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (142, N'Checking', N'411111111', CAST(0x1D3C0B00 AS Date), N'DR', CAST(-125.0000 AS Decimal(18, 4)), N'Airline ticket', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (143, N'Checking', N'411111111', CAST(0x1D3C0B00 AS Date), N'DR', CAST(-97.6900 AS Decimal(18, 4)), N'Maurices', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (144, N'Checking', N'411111111', CAST(0x203C0B00 AS Date), N'DR', CAST(-41.0400 AS Decimal(18, 4)), N'Price Chopper', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (145, N'Checking', N'411111111', CAST(0x203C0B00 AS Date), N'DR', CAST(-86.0000 AS Decimal(18, 4)), N'Home Depot', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (146, N'Checking', N'411111111', CAST(0x203C0B00 AS Date), N'DR', CAST(-63.5500 AS Decimal(18, 4)), N'Bristol', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (147, N'Checking', N'411111111', CAST(0x203C0B00 AS Date), N'DR', CAST(-494.0800 AS Decimal(18, 4)), N'Nebraska Furniture Mart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (148, N'Checking', N'411111111', CAST(0x203C0B00 AS Date), N'DR', CAST(-328.4300 AS Decimal(18, 4)), N'State Farm', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (149, N'Checking', N'411111111', CAST(0x213C0B00 AS Date), N'DR', CAST(-164.2100 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (150, N'Checking', N'411111111', CAST(0x223C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'Doctor', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (151, N'Checking', N'411111111', CAST(0x223C0B00 AS Date), N'DR', CAST(-32.2300 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (152, N'Checking', N'411111111', CAST(0x243C0B00 AS Date), N'DR', CAST(-30.0000 AS Decimal(18, 4)), N'ATM', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (153, N'Checking', N'411111111', CAST(0x243C0B00 AS Date), N'DR', CAST(-21.5200 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (154, N'Checking', N'411111111', CAST(0x273C0B00 AS Date), N'DR', CAST(-72.2100 AS Decimal(18, 4)), N'Price Chopper', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (155, N'Checking', N'411111111', CAST(0x273C0B00 AS Date), N'DR', CAST(-88.2500 AS Decimal(18, 4)), N'Hobby Lobby', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (156, N'Checking', N'411111111', CAST(0x273C0B00 AS Date), N'DR', CAST(-42.5100 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (157, N'Checking', N'411111111', CAST(0x283C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (158, N'Checking', N'411111111', CAST(0x283C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'Check to sister', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (159, N'Checking', N'411111111', CAST(0x283C0B00 AS Date), N'DR', CAST(-36.0000 AS Decimal(18, 4)), N'Brew Top', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (160, N'Checking', N'411111111', CAST(0x293C0B00 AS Date), N'CR', CAST(2000.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (161, N'Checking', N'411111111', CAST(0x293C0B00 AS Date), N'DR', CAST(-300.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (162, N'Checking', N'411111111', CAST(0x293C0B00 AS Date), N'DR', CAST(-157.9900 AS Decimal(18, 4)), N'Verizon', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (163, N'Checking', N'411111111', CAST(0x293C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'AT&T', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (164, N'Checking', N'411111111', CAST(0x293C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'KCPL', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (165, N'Checking', N'411111111', CAST(0x293C0B00 AS Date), N'DR', CAST(-4.0000 AS Decimal(18, 4)), N'Starbucks', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (166, N'Checking', N'411111111', CAST(0x2A3C0B00 AS Date), N'DR', CAST(-80.6800 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (167, N'Checking', N'411111111', CAST(0x2B3C0B00 AS Date), N'CR', CAST(600.0000 AS Decimal(18, 4)), N'Check from grandma', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (168, N'Checking', N'411111111', CAST(0x2B3C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (169, N'Checking', N'411111111', CAST(0x2B3C0B00 AS Date), N'DR', CAST(-138.3000 AS Decimal(18, 4)), N'Petsmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (170, N'Checking', N'411111111', CAST(0x2B3C0B00 AS Date), N'DR', CAST(-40.0000 AS Decimal(18, 4)), N'ATM', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (171, N'Checking', N'411111111', CAST(0x2E3C0B00 AS Date), N'DR', CAST(-110.0000 AS Decimal(18, 4)), N'Lucky''s', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (172, N'Checking', N'411111111', CAST(0x2E3C0B00 AS Date), N'DR', CAST(-24.5300 AS Decimal(18, 4)), N'Denny''s  ', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (173, N'Checking', N'411111111', CAST(0x2F3C0B00 AS Date), N'DR', CAST(-150.0000 AS Decimal(18, 4)), N'ATM', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (174, N'Checking', N'411111111', CAST(0x303C0B00 AS Date), N'DR', CAST(-19.2700 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (175, N'Checking', N'411111111', CAST(0x323C0B00 AS Date), N'DR', CAST(-13.9000 AS Decimal(18, 4)), N'Starbucks', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (176, N'Checking', N'411111111', CAST(0x323C0B00 AS Date), N'DR', CAST(-55.4500 AS Decimal(18, 4)), N'Sears', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (177, N'Checking', N'411111111', CAST(0x353C0B00 AS Date), N'DR', CAST(-50.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (178, N'Checking', N'411111111', CAST(0x353C0B00 AS Date), N'DR', CAST(-20.7800 AS Decimal(18, 4)), N'Jiffy Lube', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (179, N'Checking', N'411111111', CAST(0x353C0B00 AS Date), N'DR', CAST(-57.6500 AS Decimal(18, 4)), N'O''Charley''s', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (180, N'Checking', N'411111111', CAST(0x353C0B00 AS Date), N'DR', CAST(-145.7300 AS Decimal(18, 4)), N'Famous Footwear', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (181, N'Checking', N'411111111', CAST(0x353C0B00 AS Date), N'DR', CAST(-86.6700 AS Decimal(18, 4)), N'Target', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (182, N'Checking', N'411111111', CAST(0x353C0B00 AS Date), N'DR', CAST(-48.0000 AS Decimal(18, 4)), N'Pizza Hut ', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (183, N'Checking', N'411111111', CAST(0x353C0B00 AS Date), N'DR', CAST(-191.8600 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (184, N'Checking', N'411111111', CAST(0x363C0B00 AS Date), N'DR', CAST(-22.7800 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (185, N'Checking', N'411111111', CAST(0x383C0B00 AS Date), N'CR', CAST(2000.0000 AS Decimal(18, 4)), N'Payday', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (186, N'Checking', N'411111111', CAST(0x383C0B00 AS Date), N'CR', CAST(1500.0000 AS Decimal(18, 4)), N'Bonus', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (187, N'Checking', N'411111111', CAST(0x393C0B00 AS Date), N'DR', CAST(-300.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (188, N'Checking', N'411111111', CAST(0x393C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'Best Buy', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (189, N'Checking', N'411111111', CAST(0x393C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'Target', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (190, N'Checking', N'411111111', CAST(0x393C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (191, N'Checking', N'411111111', CAST(0x393C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'CVS', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (192, N'Checking', N'411111111', CAST(0x393C0B00 AS Date), N'DR', CAST(-200.0000 AS Decimal(18, 4)), N'ATM', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (193, N'Checking', N'411111111', CAST(0x393C0B00 AS Date), N'DR', CAST(-150.0000 AS Decimal(18, 4)), N'Amazon', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (194, N'Checking', N'411111111', CAST(0x393C0B00 AS Date), N'DR', CAST(-142.8700 AS Decimal(18, 4)), N'Verizon', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (195, N'Checking', N'411111111', CAST(0x393C0B00 AS Date), N'DR', CAST(-133.3500 AS Decimal(18, 4)), N'Toys R Us', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (196, N'Checking', N'411111111', CAST(0x393C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'Maurices', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (197, N'Checking', N'411111111', CAST(0x3C3C0B00 AS Date), N'DR', CAST(-13.9800 AS Decimal(18, 4)), N'Panera Bread', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (198, N'Checking', N'411111111', CAST(0x3C3C0B00 AS Date), N'DR', CAST(-57.0000 AS Decimal(18, 4)), N'Buffalo Wild Wings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (199, N'Checking', N'411111111', CAST(0x3C3C0B00 AS Date), N'DR', CAST(-205.4700 AS Decimal(18, 4)), N'Walmart', N'None')
GO
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (200, N'Checking', N'411111111', CAST(0x3C3C0B00 AS Date), N'DR', CAST(-156.2700 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (201, N'Checking', N'411111111', CAST(0x3D3C0B00 AS Date), N'DR', CAST(-10.8400 AS Decimal(18, 4)), N'Joy Wok', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (202, N'Checking', N'411111111', CAST(0x3E3C0B00 AS Date), N'DR', CAST(-125.0600 AS Decimal(18, 4)), N'Taxes', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (203, N'Checking', N'411111111', CAST(0x3E3C0B00 AS Date), N'DR', CAST(-30.0000 AS Decimal(18, 4)), N'Doctor', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (204, N'Checking', N'411111111', CAST(0x3E3C0B00 AS Date), N'DR', CAST(-328.4300 AS Decimal(18, 4)), N'State Farm', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (205, N'Checking', N'411111111', CAST(0x403C0B00 AS Date), N'DR', CAST(-350.0000 AS Decimal(18, 4)), N'Rent', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (206, N'Checking', N'411111111', CAST(0x403C0B00 AS Date), N'DR', CAST(-159.0000 AS Decimal(18, 4)), N'KCPL', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (207, N'Checking', N'411111111', CAST(0x443C0B00 AS Date), N'DR', CAST(-24.5200 AS Decimal(18, 4)), N'7 Eleven', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (208, N'Checking', N'411111111', CAST(0x443C0B00 AS Date), N'DR', CAST(-27.7700 AS Decimal(18, 4)), N'Hyvee', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (209, N'Checking', N'411111111', CAST(0x463C0B00 AS Date), N'DR', CAST(-128.5600 AS Decimal(18, 4)), N'Price Chopper', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (210, N'Checking', N'411111111', CAST(0x463C0B00 AS Date), N'DR', CAST(-150.0000 AS Decimal(18, 4)), N'ATM', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (211, N'Checking', N'411111111', CAST(0x473C0B00 AS Date), N'CR', CAST(2000.0000 AS Decimal(18, 4)), N'Payday', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (212, N'Checking', N'411111111', CAST(0x473C0B00 AS Date), N'DR', CAST(-2.9500 AS Decimal(18, 4)), N'Red box', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (213, N'Checking', N'411111111', CAST(0x473C0B00 AS Date), N'DR', CAST(-41.1800 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (214, N'Checking', N'411111111', CAST(0x473C0B00 AS Date), N'DR', CAST(-109.3500 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (215, N'Checking', N'411111111', CAST(0x473C0B00 AS Date), N'DR', CAST(-217.0000 AS Decimal(18, 4)), N'BoA Credit Card payment', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (216, N'Checking', N'411111111', CAST(0x473C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (217, N'Checking', N'411111111', CAST(0x473C0B00 AS Date), N'DR', CAST(-5.9500 AS Decimal(18, 4)), N'Maurices', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (218, N'Checking', N'411111111', CAST(0x4B3C0B00 AS Date), N'DR', CAST(-40.0000 AS Decimal(18, 4)), N'ATM', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (219, N'Checking', N'411111111', CAST(0x4B3C0B00 AS Date), N'DR', CAST(-70.0000 AS Decimal(18, 4)), N'Dave and Busters', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (220, N'Checking', N'411111111', CAST(0x4B3C0B00 AS Date), N'DR', CAST(-47.0600 AS Decimal(18, 4)), N'Pizza Ranch', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (221, N'Checking', N'411111111', CAST(0x4B3C0B00 AS Date), N'DR', CAST(-163.1000 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (222, N'Checking', N'411111111', CAST(0x4C3C0B00 AS Date), N'DR', CAST(-22.0100 AS Decimal(18, 4)), N'Olive Garden', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (223, N'Checking', N'411111111', CAST(0x4C3C0B00 AS Date), N'DR', CAST(-34.8600 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (224, N'Checking', N'411111111', CAST(0x4D3C0B00 AS Date), N'DR', CAST(-150.0000 AS Decimal(18, 4)), N'Check to sister', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (225, N'Checking', N'411111111', CAST(0x4D3C0B00 AS Date), N'DR', CAST(-10.0000 AS Decimal(18, 4)), N'Doctor', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (226, N'Checking', N'411111111', CAST(0x4D3C0B00 AS Date), N'DR', CAST(-10.0000 AS Decimal(18, 4)), N'MOD Pizza', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (227, N'Checking', N'411111111', CAST(0x4D3C0B00 AS Date), N'DR', CAST(-10.0000 AS Decimal(18, 4)), N'Best Buy', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (228, N'Checking', N'411111111', CAST(0x4D3C0B00 AS Date), N'DR', CAST(-10.0000 AS Decimal(18, 4)), N'Target', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (229, N'Checking', N'411111111', CAST(0x513C0B00 AS Date), N'DR', CAST(-23.5200 AS Decimal(18, 4)), N'O''Reilly''s', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (230, N'Checking', N'411111111', CAST(0x513C0B00 AS Date), N'DR', CAST(-118.2500 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (231, N'Checking', N'411111111', CAST(0x543C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (232, N'Checking', N'411111111', CAST(0x543C0B00 AS Date), N'DR', CAST(-45.7400 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (233, N'Checking', N'411111111', CAST(0x553C0B00 AS Date), N'CR', CAST(2000.0000 AS Decimal(18, 4)), N'Payroll', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (234, N'Checking', N'411111111', CAST(0x553C0B00 AS Date), N'DR', CAST(-50.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (235, N'Checking', N'411111111', CAST(0x553C0B00 AS Date), N'DR', CAST(-136.8900 AS Decimal(18, 4)), N'Verizon', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (236, N'Checking', N'411111111', CAST(0x593C0B00 AS Date), N'DR', CAST(-100.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (237, N'Checking', N'411111111', CAST(0x593C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'Bravos', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (238, N'Checking', N'411111111', CAST(0x593C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'Starbucks gift card', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (239, N'Checking', N'411111111', CAST(0x593C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'ATM', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (240, N'Checking', N'411111111', CAST(0x593C0B00 AS Date), N'DR', CAST(-25.0000 AS Decimal(18, 4)), N'Check to brother', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (241, N'Checking', N'411111111', CAST(0x593C0B00 AS Date), N'DR', CAST(-24.2200 AS Decimal(18, 4)), N'Laser Rock', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (242, N'Checking', N'411111111', CAST(0x593C0B00 AS Date), N'DR', CAST(-102.8700 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (243, N'Checking', N'411111111', CAST(0x593C0B00 AS Date), N'DR', CAST(-57.3200 AS Decimal(18, 4)), N'Tanners', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (244, N'Checking', N'411111111', CAST(0x593C0B00 AS Date), N'DR', CAST(-36.0000 AS Decimal(18, 4)), N'Price Chopper', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (245, N'Checking', N'411111111', CAST(0x5A3C0B00 AS Date), N'DR', CAST(-54.0000 AS Decimal(18, 4)), N'Bristol', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (246, N'Checking', N'411111111', CAST(0x5B3C0B00 AS Date), N'DR', CAST(-328.4300 AS Decimal(18, 4)), N'State Farm', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (247, N'Checking', N'411111111', CAST(0x5B3C0B00 AS Date), N'DR', CAST(-5.0000 AS Decimal(18, 4)), N'Payment to friend', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (248, N'Checking', N'411111111', CAST(0x5C3C0B00 AS Date), N'DR', CAST(-26.4900 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (249, N'Checking', N'411111111', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-5.0000 AS Decimal(18, 4)), N'KFC', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (250, N'Checking', N'411111111', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-55.0000 AS Decimal(18, 4)), N'Doctor', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (251, N'Checking', N'411111111', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-172.2500 AS Decimal(18, 4)), N'Best Buy', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (252, N'Checking', N'411111111', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-52.0000 AS Decimal(18, 4)), N'Pizza Hut ', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (253, N'Checking', N'411111111', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-60.3800 AS Decimal(18, 4)), N'Red Lobster', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (254, N'Checking', N'411111111', CAST(0x5F3C0B00 AS Date), N'DR', CAST(-58.5500 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (255, N'Checking', N'411111111', CAST(0x613C0B00 AS Date), N'DR', CAST(-72.5200 AS Decimal(18, 4)), N'Walmart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (256, N'Checking', N'411111111', CAST(0x623C0B00 AS Date), N'DR', CAST(-64.0000 AS Decimal(18, 4)), N'Home Depot', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (257, N'Checking', N'411111111', CAST(0x633C0B00 AS Date), N'DR', CAST(-2000.0000 AS Decimal(18, 4)), N'Payday', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (258, N'Checking', N'411111111', CAST(0x633C0B00 AS Date), N'DR', CAST(-150.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (259, N'Checking', N'411111111', CAST(0x633C0B00 AS Date), N'CR', CAST(200.0000 AS Decimal(18, 4)), N'Check from mom', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (260, N'Checking', N'411111111', CAST(0x633C0B00 AS Date), N'CR', CAST(75.0000 AS Decimal(18, 4)), N'Cash deposit', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (261, N'Checking', N'411111111', CAST(0x633C0B00 AS Date), N'DR', CAST(-29.1000 AS Decimal(18, 4)), N'QuikTrip', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (262, N'Checking', N'411111111', CAST(0x633C0B00 AS Date), N'CR', CAST(100.0000 AS Decimal(18, 4)), N'Transfer to Savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (263, N'Checking', N'411111111', CAST(0x633C0B00 AS Date), N'DR', CAST(-150.0000 AS Decimal(18, 4)), N'Nebraska Furniture Mart', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (264, N'Savings', N'8222222228', CAST(0x0C3C0B00 AS Date), N'CR', CAST(0.0000 AS Decimal(18, 4)), N'Account Open Deposit', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (265, N'Savings', N'8222222228', CAST(0x0C3C0B00 AS Date), N'CR', CAST(25.0000 AS Decimal(18, 4)), N'Cash Deposit', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (266, N'Savings', N'8222222228', CAST(0x1B3C0B00 AS Date), N'CR', CAST(200.0000 AS Decimal(18, 4)), N'Transfer from savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (267, N'Savings', N'8222222228', CAST(0x1B3C0B00 AS Date), N'CR', CAST(25.0000 AS Decimal(18, 4)), N'Cash Deposit', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (268, N'Savings', N'8222222228', CAST(0x283C0B00 AS Date), N'CR', CAST(100.0000 AS Decimal(18, 4)), N'Transfer from savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (269, N'Savings', N'8222222228', CAST(0x293C0B00 AS Date), N'CR', CAST(300.0000 AS Decimal(18, 4)), N'Transfer from savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (270, N'Savings', N'8222222228', CAST(0x293C0B00 AS Date), N'CR', CAST(0.0200 AS Decimal(18, 4)), N'Interest', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (271, N'Savings', N'8222222228', CAST(0x2B3C0B00 AS Date), N'CR', CAST(100.0000 AS Decimal(18, 4)), N'Transfer from savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (272, N'Savings', N'8222222228', CAST(0x353C0B00 AS Date), N'CR', CAST(50.0000 AS Decimal(18, 4)), N'Transfer from savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (273, N'Savings', N'8222222228', CAST(0x393C0B00 AS Date), N'CR', CAST(300.0000 AS Decimal(18, 4)), N'Transfer from savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (274, N'Savings', N'8222222228', CAST(0x473C0B00 AS Date), N'CR', CAST(100.0000 AS Decimal(18, 4)), N'Transfer from savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (275, N'Savings', N'8222222228', CAST(0x473C0B00 AS Date), N'CR', CAST(0.0200 AS Decimal(18, 4)), N'Interest', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (276, N'Savings', N'8222222228', CAST(0x483C0B00 AS Date), N'DR', CAST(-379.0000 AS Decimal(18, 4)), N'O''Reilly''s', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (277, N'Savings', N'8222222228', CAST(0x4D3C0B00 AS Date), N'CR', CAST(10.0000 AS Decimal(18, 4)), N'Check deposit', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (278, N'Savings', N'8222222228', CAST(0x553C0B00 AS Date), N'CR', CAST(50.0000 AS Decimal(18, 4)), N'Transfer from savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (279, N'Savings', N'8222222228', CAST(0x593C0B00 AS Date), N'CR', CAST(100.0000 AS Decimal(18, 4)), N'Transfer from savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (280, N'Savings', N'8222222228', CAST(0x633C0B00 AS Date), N'CR', CAST(150.0000 AS Decimal(18, 4)), N'Transfer from savings', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (281, N'Savings', N'8222222228', CAST(0x633C0B00 AS Date), N'CR', CAST(0.0200 AS Decimal(18, 4)), N'Interest', N'None')
INSERT [dbo].[Transaction] ([Transaction_ID], [Account_Type], [Account_Number], [Processing_Date], [Transaction_Type], [Amount], [Description], [Category]) VALUES (282, N'Savings', N'8222222228', CAST(0x633C0B00 AS Date), N'CR', CAST(100.0000 AS Decimal(18, 4)), N'Transfer from savings', N'None')
SET IDENTITY_INSERT [dbo].[Transaction] OFF
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Customer] FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customer] ([Customer_ID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Customer]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Customer] FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customer] ([Customer_ID])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Customer]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Account] FOREIGN KEY([Account_Number])
REFERENCES [dbo].[Account] ([Account_Number])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Account]
GO
USE [master]
GO
ALTER DATABASE [CapstoneDB] SET  READ_WRITE 
GO
