USE [SorayiCarpets]
GO
/****** Object:  Schema [import]    Script Date: 2025-06-05 8:20:37 PM ******/
CREATE SCHEMA [import]
GO
/****** Object:  Table [dbo].[tbl_gl_calendar$]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_gl_calendar$](
	[T$YEAR] [float] NULL,
	[T$PRNO] [float] NULL,
	[T$STDT] [datetime] NULL,
	[T$ENDT] [datetime] NULL,
	[T$DESC] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_inventory_plant_trend$]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_inventory_plant_trend$](
	[TREND_DATE] [datetime] NULL,
	[AS_OF_DATE] [datetime] NULL,
	[PERIOD_YEAR] [nvarchar](255) NULL,
	[WAREHOUSE_CATGY_1] [nvarchar](255) NULL,
	[PLANT_NAME] [nvarchar](255) NULL,
	[INVENTORY_VALUE] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_prod_cur_lst_yer_compar$]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_prod_cur_lst_yer_compar$](
	[AS_OF_DATE] [datetime] NULL,
	[BUSINESS_UNIT] [nvarchar](255) NULL,
	[PRODUCT_TYPE] [nvarchar](255) NULL,
	[CUR_BUDGET_QTY] [float] NULL,
	[CUR_ACTUAL_QTY] [float] NULL,
	[CUR_DIFF_QTY] [float] NULL,
	[CUR_BUDGET_VALUE] [float] NULL,
	[CUR_ACTUAL_VALUE] [float] NULL,
	[CUR_DIFF_VALUE] [float] NULL,
	[LST_BUDGET_QTY] [float] NULL,
	[LST_ACTUAL_QTY] [float] NULL,
	[LST_DIFF_QTY] [float] NULL,
	[LST_BUDGET_VALUE] [float] NULL,
	[LST_ACTUAL_VALUE] [float] NULL,
	[LST_DIFF_VALUE] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_production_trend$]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_production_trend$](
	[TREND_DATE] [datetime] NULL,
	[AS_OF_DATE] [datetime] NULL,
	[BUSINESS_UNIT] [nvarchar](255) NULL,
	[PRODUCT_GROUP] [nvarchar](255) NULL,
	[BUDGET_QUANTITY] [float] NULL,
	[ACTUAL_QUANTITY] [float] NULL,
	[VARIANCE_QUANTITY] [float] NULL,
	[VARIANCE_QTY_PERC] [float] NULL,
	[BUDGET_VALUE] [float] NULL,
	[ACTUAL_VALUE] [float] NULL,
	[VARIANCE_VALUE] [float] NULL,
	[VARIANCE_VAL_PERC] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sales_prod_calendar$]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sales_prod_calendar$](
	[TRANSACTION_DATE] [datetime] NULL,
	[WEEK_NUMBER] [float] NULL,
	[FISCAL_YEAR] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [import].[tbl_gl_calendar]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [import].[tbl_gl_calendar](
	[CalendarID] [int] IDENTITY(1,1) NOT NULL,
	[CalendarDate] [date] NULL,
	[Year] [int] NULL,
	[Quarter] [int] NULL,
	[Month] [int] NULL,
	[MonthName] [varchar](20) NULL,
	[Week] [int] NULL,
	[DayOfWeek] [int] NULL,
	[DayName] [varchar](20) NULL,
	[IsHoliday] [bit] NULL,
	[FiscalYear] [int] NULL,
	[FiscalQuarter] [int] NULL,
	[FiscalMonth] [int] NULL,
	[ImportDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CalendarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [import].[tbl_inventory_plant_trend]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [import].[tbl_inventory_plant_trend](
	[InventoryID] [int] IDENTITY(1,1) NOT NULL,
	[PlantCode] [varchar](10) NULL,
	[PlantName] [varchar](100) NULL,
	[WarehouseCode] [varchar](10) NULL,
	[WarehouseName] [varchar](100) NULL,
	[InventoryDate] [date] NULL,
	[ProductCode] [varchar](20) NULL,
	[ProductName] [varchar](100) NULL,
	[QuantityOnHand] [decimal](18, 2) NULL,
	[UnitValue] [decimal](18, 2) NULL,
	[TotalValue] [decimal](18, 2) NULL,
	[ImportDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [import].[tbl_kpi_summary]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [import].[tbl_kpi_summary](
	[KPIID] [int] IDENTITY(1,1) NOT NULL,
	[KPIDate] [date] NULL,
	[KPIName] [varchar](100) NULL,
	[KPIValue] [decimal](18, 2) NULL,
	[KPITarget] [decimal](18, 2) NULL,
	[KPIStatus] [varchar](20) NULL,
	[BusinessUnitCode] [varchar](10) NULL,
	[ImportDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[KPIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [import].[tbl_prod_budget_forecast]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [import].[tbl_prod_budget_forecast](
	[ForecastID] [int] IDENTITY(1,1) NOT NULL,
	[ForecastDate] [date] NULL,
	[BusinessUnitCode] [varchar](10) NULL,
	[BusinessUnitName] [varchar](100) NULL,
	[ProductTypeCode] [varchar](10) NULL,
	[ProductTypeName] [varchar](100) NULL,
	[BudgetAmount] [decimal](18, 2) NULL,
	[ForecastAmount] [decimal](18, 2) NULL,
	[ActualAmount] [decimal](18, 2) NULL,
	[ImportDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ForecastID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [import].[tbl_prod_cur_lst_yr_compar]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [import].[tbl_prod_cur_lst_yr_compar](
	[ComparisonID] [int] IDENTITY(1,1) NOT NULL,
	[ComparisonDate] [date] NULL,
	[BusinessUnitCode] [varchar](10) NULL,
	[BusinessUnitName] [varchar](100) NULL,
	[ProductTypeCode] [varchar](10) NULL,
	[ProductTypeName] [varchar](100) NULL,
	[CurrentYearProduction] [decimal](18, 2) NULL,
	[PreviousYearProduction] [decimal](18, 2) NULL,
	[YoYChange] [decimal](5, 2) NULL,
	[ImportDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ComparisonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [import].[tbl_production_trend]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [import].[tbl_production_trend](
	[ProductionID] [int] IDENTITY(1,1) NOT NULL,
	[ProductionDate] [date] NULL,
	[PlantCode] [varchar](10) NULL,
	[PlantName] [varchar](100) NULL,
	[BusinessUnitCode] [varchar](10) NULL,
	[BusinessUnitName] [varchar](100) NULL,
	[ProductTypeCode] [varchar](10) NULL,
	[ProductTypeName] [varchar](100) NULL,
	[PlannedProduction] [decimal](18, 2) NULL,
	[ActualProduction] [decimal](18, 2) NULL,
	[ProductionEfficiency] [decimal](5, 2) NULL,
	[ImportDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [import].[tbl_sales_prod_calendar]    Script Date: 2025-06-05 8:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [import].[tbl_sales_prod_calendar](
	[CalendarID] [int] IDENTITY(1,1) NOT NULL,
	[CalendarDate] [date] NULL,
	[BusinessUnitCode] [varchar](10) NULL,
	[BusinessUnitName] [varchar](100) NULL,
	[ProductTypeCode] [varchar](10) NULL,
	[ProductTypeName] [varchar](100) NULL,
	[PlannedProduction] [decimal](18, 2) NULL,
	[ActualProduction] [decimal](18, 2) NULL,
	[PlannedSales] [decimal](18, 2) NULL,
	[ActualSales] [decimal](18, 2) NULL,
	[ImportDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CalendarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [import].[tbl_gl_calendar] ADD  DEFAULT (getdate()) FOR [ImportDate]
GO
ALTER TABLE [import].[tbl_inventory_plant_trend] ADD  DEFAULT (getdate()) FOR [ImportDate]
GO
ALTER TABLE [import].[tbl_kpi_summary] ADD  DEFAULT (getdate()) FOR [ImportDate]
GO
ALTER TABLE [import].[tbl_prod_budget_forecast] ADD  DEFAULT (getdate()) FOR [ImportDate]
GO
ALTER TABLE [import].[tbl_prod_cur_lst_yr_compar] ADD  DEFAULT (getdate()) FOR [ImportDate]
GO
ALTER TABLE [import].[tbl_production_trend] ADD  DEFAULT (getdate()) FOR [ImportDate]
GO
ALTER TABLE [import].[tbl_sales_prod_calendar] ADD  DEFAULT (getdate()) FOR [ImportDate]
GO
