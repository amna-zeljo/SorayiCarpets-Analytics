-- =====================================================
-- RUN THIS ON: SorayiCarpets_DWH DATABASE
-- Create Missing Archive Tables
-- =====================================================

USE SorayiCarpets_DWH;
GO

PRINT 'Creating missing archive tables...';
PRINT 'Database: SorayiCarpets_DWH';

-- Create archive.tbl_inventory_plant_trend
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[archive].[tbl_inventory_plant_trend]') AND type in (N'U'))
BEGIN
    CREATE TABLE [archive].[tbl_inventory_plant_trend](
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
        [ETLLoadID] [int] NULL,
        [LoadDate] [datetime] NULL,
        [ArchiveDate] [datetime] DEFAULT GETDATE(),
    PRIMARY KEY CLUSTERED ([InventoryID] ASC)
    );
    PRINT 'Created archive.tbl_inventory_plant_trend';
END
ELSE
    PRINT 'archive.tbl_inventory_plant_trend already exists';

-- Create archive.tbl_production_trend
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[archive].[tbl_production_trend]') AND type in (N'U'))
BEGIN
    CREATE TABLE [archive].[tbl_production_trend](
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
        [ETLLoadID] [int] NULL,
        [LoadDate] [datetime] NULL,
        [ArchiveDate] [datetime] DEFAULT GETDATE(),
    PRIMARY KEY CLUSTERED ([ProductionID] ASC)
    );
    PRINT 'Created archive.tbl_production_trend';
END
ELSE
    PRINT 'archive.tbl_production_trend already exists';

-- Create archive.tbl_prod_cur_lst_yr_compar
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[archive].[tbl_prod_cur_lst_yr_compar]') AND type in (N'U'))
BEGIN
    CREATE TABLE [archive].[tbl_prod_cur_lst_yr_compar](
        [ComparisonID] [int] IDENTITY(1,1) NOT NULL,
        [ComparisonDate] [date] NULL,
        [BusinessUnitCode] [varchar](10) NULL,
        [BusinessUnitName] [varchar](100) NULL,
        [ProductTypeCode] [varchar](10) NULL,
        [ProductTypeName] [varchar](100) NULL,
        [CurrentYearProduction] [decimal](18, 2) NULL,
        [PreviousYearProduction] [decimal](18, 2) NULL,
        [YoYChange] [decimal](5, 2) NULL,
        [ETLLoadID] [int] NULL,
        [LoadDate] [datetime] NULL,
        [ArchiveDate] [datetime] DEFAULT GETDATE(),
    PRIMARY KEY CLUSTERED ([ComparisonID] ASC)
    );
    PRINT 'Created archive.tbl_prod_cur_lst_yr_compar';
END
ELSE
    PRINT 'archive.tbl_prod_cur_lst_yr_compar already exists';

-- Create archive.tbl_gl_calendar
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[archive].[tbl_gl_calendar]') AND type in (N'U'))
BEGIN
    CREATE TABLE [archive].[tbl_gl_calendar](
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
        [ETLLoadID] [int] NULL,
        [LoadDate] [datetime] NULL,
        [ArchiveDate] [datetime] DEFAULT GETDATE(),
    PRIMARY KEY CLUSTERED ([CalendarID] ASC)
    );
    PRINT 'Created archive.tbl_gl_calendar';
END
ELSE
    PRINT 'archive.tbl_gl_calendar already exists';

-- Create archive.tbl_sales_prod_calendar
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[archive].[tbl_sales_prod_calendar]') AND type in (N'U'))
BEGIN
    CREATE TABLE [archive].[tbl_sales_prod_calendar](
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
        [ETLLoadID] [int] NULL,
        [LoadDate] [datetime] NULL,
        [ArchiveDate] [datetime] DEFAULT GETDATE(),
    PRIMARY KEY CLUSTERED ([CalendarID] ASC)
    );
    PRINT 'Created archive.tbl_sales_prod_calendar';
END
ELSE
    PRINT 'archive.tbl_sales_prod_calendar already exists';

PRINT '';
PRINT 'All archive tables created successfully!';
PRINT 'Ready to proceed with ETL load.';