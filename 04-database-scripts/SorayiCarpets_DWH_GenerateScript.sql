USE [SorayiCarpets_DWH]
GO
/****** Object:  Schema [archive]    Script Date: 2025-06-05 8:29:16 PM ******/
CREATE SCHEMA [archive]
GO
/****** Object:  Schema [excel]    Script Date: 2025-06-05 8:29:16 PM ******/
CREATE SCHEMA [excel]
GO
/****** Object:  Schema [import]    Script Date: 2025-06-05 8:29:16 PM ******/
CREATE SCHEMA [import]
GO
/****** Object:  Schema [landing]    Script Date: 2025-06-05 8:29:16 PM ******/
CREATE SCHEMA [landing]
GO
/****** Object:  Table [archive].[tbl_gl_calendar]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[ArchiveDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CalendarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [archive].[tbl_inventory_plant_trend]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[ArchiveDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [archive].[tbl_prod_cur_lst_yr_compar]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[ArchiveDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ComparisonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [archive].[tbl_production_trend]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[ArchiveDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [archive].[tbl_sales_prod_calendar]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[ArchiveDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CalendarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ETLLoadLog]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETLLoadLog](
	[ETLLoadID] [int] IDENTITY(1,1) NOT NULL,
	[LoadStartTime] [datetime] NULL,
	[LoadEndTime] [datetime] NULL,
	[LoadType] [varchar](20) NOT NULL,
	[SourceSystem] [varchar](50) NOT NULL,
	[LoadStatus] [varchar](20) NULL,
	[RowsProcessed] [int] NULL,
	[ErrorMessage] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ETLLoadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_prod_cur_lst_yer_compar$]    Script Date: 2025-06-05 8:29:16 PM ******/
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
/****** Object:  Table [import].[tbl_gl_calendar]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [import].[tbl_gl_calendar](
	[T$YEAR] [float] NULL,
	[T$PRNO] [float] NULL,
	[T$STDT] [datetime] NULL,
	[T$ENDT] [datetime] NULL,
	[T$DESC] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [import].[tbl_inventory_plant_trend]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [import].[tbl_inventory_plant_trend](
	[TREND_DATE] [datetime] NULL,
	[AS_OF_DATE] [datetime] NULL,
	[PERIOD_YEAR] [nvarchar](255) NULL,
	[WAREHOUSE_CATGY_1] [nvarchar](255) NULL,
	[PLANT_NAME] [nvarchar](255) NULL,
	[INVENTORY_VALUE] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [import].[tbl_production_trend]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [import].[tbl_production_trend](
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
/****** Object:  Table [import].[tbl_sales_prod_calendar]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [import].[tbl_sales_prod_calendar](
	[TRANSACTION_DATE] [datetime] NULL,
	[WEEK_NUMBER] [float] NULL,
	[FISCAL_YEAR] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [landing].[tbl_gl_calendar]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [landing].[tbl_gl_calendar](
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
PRIMARY KEY CLUSTERED 
(
	[CalendarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [landing].[tbl_inventory_plant_trend]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [landing].[tbl_inventory_plant_trend](
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
PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [landing].[tbl_prod_cur_lst_yr_compar]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [landing].[tbl_prod_cur_lst_yr_compar](
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
PRIMARY KEY CLUSTERED 
(
	[ComparisonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [landing].[tbl_production_trend]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [landing].[tbl_production_trend](
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
PRIMARY KEY CLUSTERED 
(
	[ProductionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [landing].[tbl_sales_prod_calendar]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [landing].[tbl_sales_prod_calendar](
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
PRIMARY KEY CLUSTERED 
(
	[CalendarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [archive].[tbl_gl_calendar] ADD  DEFAULT (getdate()) FOR [ArchiveDate]
GO
ALTER TABLE [archive].[tbl_inventory_plant_trend] ADD  DEFAULT (getdate()) FOR [ArchiveDate]
GO
ALTER TABLE [archive].[tbl_prod_cur_lst_yr_compar] ADD  DEFAULT (getdate()) FOR [ArchiveDate]
GO
ALTER TABLE [archive].[tbl_production_trend] ADD  DEFAULT (getdate()) FOR [ArchiveDate]
GO
ALTER TABLE [archive].[tbl_sales_prod_calendar] ADD  DEFAULT (getdate()) FOR [ArchiveDate]
GO
ALTER TABLE [dbo].[ETLLoadLog] ADD  DEFAULT (getdate()) FOR [LoadStartTime]
GO
ALTER TABLE [dbo].[ETLLoadLog] ADD  DEFAULT ('In Progress') FOR [LoadStatus]
GO
ALTER TABLE [dbo].[ETLLoadLog] ADD  DEFAULT ((0)) FOR [RowsProcessed]
GO
ALTER TABLE [landing].[tbl_gl_calendar] ADD  DEFAULT (getdate()) FOR [LoadDate]
GO
ALTER TABLE [landing].[tbl_inventory_plant_trend] ADD  DEFAULT (getdate()) FOR [LoadDate]
GO
ALTER TABLE [landing].[tbl_prod_cur_lst_yr_compar] ADD  DEFAULT (getdate()) FOR [LoadDate]
GO
ALTER TABLE [landing].[tbl_production_trend] ADD  DEFAULT (getdate()) FOR [LoadDate]
GO
ALTER TABLE [landing].[tbl_sales_prod_calendar] ADD  DEFAULT (getdate()) FOR [LoadDate]
GO
/****** Object:  StoredProcedure [dbo].[LoadDataFromSource]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LoadDataFromSource]
    @SourceTable VARCHAR(100),
    @LoadType VARCHAR(20) = 'Initial'
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ETLLoadID INT;
    DECLARE @RowCount INT = 0;
    
    BEGIN TRY
        -- Start a new ETL load
        INSERT INTO dbo.ETLLoadLog (LoadType, SourceSystem, LoadStatus)
        VALUES (@LoadType, 'SorayiCarpets', 'In Progress');
        SET @ETLLoadID = SCOPE_IDENTITY();
        
        PRINT 'Starting load for table: ' + @SourceTable;
        PRINT 'Load Type: ' + @LoadType;
        PRINT 'ETL Load ID: ' + CAST(@ETLLoadID AS VARCHAR(10));
        
        -- Load tbl_inventory_plant_trend
        IF @SourceTable = 'tbl_inventory_plant_trend'
        BEGIN
            IF @LoadType = 'Initial'
                TRUNCATE TABLE landing.tbl_inventory_plant_trend;
                
            -- Insert without specifying identity column
            INSERT INTO landing.tbl_inventory_plant_trend (
                PlantCode, PlantName, WarehouseCode, WarehouseName, InventoryDate,
                ProductCode, ProductName, QuantityOnHand, UnitValue, TotalValue, ETLLoadID
            )
            SELECT 
                ISNULL(PlantCode, 'UNK'),
                ISNULL(PlantName, 'Unknown'),
                ISNULL(WarehouseCode, 'UNK'),
                ISNULL(WarehouseName, 'Unknown'),
                ISNULL(InventoryDate, GETDATE()),
                ISNULL(ProductCode, 'UNK'),
                ISNULL(ProductName, 'Unknown'),
                ISNULL(QuantityOnHand, 0),
                ISNULL(UnitValue, 0),
                ISNULL(TotalValue, 0),
                @ETLLoadID
            FROM SorayiCarpets.import.tbl_inventory_plant_trend
            WHERE (@LoadType = 'Initial') OR 
                  (@LoadType = 'Incremental' AND ImportDate > 
                   ISNULL((SELECT MAX(LoadDate) FROM landing.tbl_inventory_plant_trend), '1900-01-01'));
            
            SET @RowCount = @@ROWCOUNT;
            PRINT 'Loaded ' + CAST(@RowCount AS VARCHAR(10)) + ' inventory records to landing';
            
            -- Archive the data (without identity column)
            INSERT INTO archive.tbl_inventory_plant_trend (
                PlantCode, PlantName, WarehouseCode, WarehouseName, InventoryDate,
                ProductCode, ProductName, QuantityOnHand, UnitValue, TotalValue, ETLLoadID, LoadDate
            )
            SELECT 
                PlantCode, PlantName, WarehouseCode, WarehouseName, InventoryDate,
                ProductCode, ProductName, QuantityOnHand, UnitValue, TotalValue, ETLLoadID, LoadDate
            FROM landing.tbl_inventory_plant_trend
            WHERE ETLLoadID = @ETLLoadID;
            
            PRINT 'Archived ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' inventory records';
        END
        
        -- Load tbl_production_trend
        ELSE IF @SourceTable = 'tbl_production_trend'
        BEGIN
            IF @LoadType = 'Initial'
                TRUNCATE TABLE landing.tbl_production_trend;
                
            INSERT INTO landing.tbl_production_trend (
                ProductionDate, PlantCode, PlantName, BusinessUnitCode, BusinessUnitName,
                ProductTypeCode, ProductTypeName, PlannedProduction, ActualProduction, 
                ProductionEfficiency, ETLLoadID
            )
            SELECT 
                ISNULL(ProductionDate, GETDATE()),
                ISNULL(PlantCode, 'UNK'),
                ISNULL(PlantName, 'Unknown'),
                ISNULL(BusinessUnitCode, 'UNK'),
                ISNULL(BusinessUnitName, 'Unknown'),
                ISNULL(ProductTypeCode, 'UNK'),
                ISNULL(ProductTypeName, 'Unknown'),
                ISNULL(PlannedProduction, 0),
                ISNULL(ActualProduction, 0),
                ISNULL(ProductionEfficiency, 0),
                @ETLLoadID
            FROM SorayiCarpets.import.tbl_production_trend
            WHERE (@LoadType = 'Initial') OR 
                  (@LoadType = 'Incremental' AND ImportDate > 
                   ISNULL((SELECT MAX(LoadDate) FROM landing.tbl_production_trend), '1900-01-01'));
            
            SET @RowCount = @@ROWCOUNT;
            PRINT 'Loaded ' + CAST(@RowCount AS VARCHAR(10)) + ' production records to landing';
            
            -- Archive the data
            INSERT INTO archive.tbl_production_trend (
                ProductionDate, PlantCode, PlantName, BusinessUnitCode, BusinessUnitName,
                ProductTypeCode, ProductTypeName, PlannedProduction, ActualProduction, 
                ProductionEfficiency, ETLLoadID, LoadDate
            )
            SELECT 
                ProductionDate, PlantCode, PlantName, BusinessUnitCode, BusinessUnitName,
                ProductTypeCode, ProductTypeName, PlannedProduction, ActualProduction, 
                ProductionEfficiency, ETLLoadID, LoadDate
            FROM landing.tbl_production_trend
            WHERE ETLLoadID = @ETLLoadID;
            
            PRINT 'Archived ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' production records';
        END
        
        -- Load tbl_prod_cur_lst_yr_compar
        ELSE IF @SourceTable = 'tbl_prod_cur_lst_yr_compar'
        BEGIN
            IF @LoadType = 'Initial'
                TRUNCATE TABLE landing.tbl_prod_cur_lst_yr_compar;
                
            INSERT INTO landing.tbl_prod_cur_lst_yr_compar (
                ComparisonDate, BusinessUnitCode, BusinessUnitName, ProductTypeCode, ProductTypeName,
                CurrentYearProduction, PreviousYearProduction, YoYChange, ETLLoadID
            )
            SELECT 
                ISNULL(ComparisonDate, GETDATE()),
                ISNULL(BusinessUnitCode, 'UNK'),
                ISNULL(BusinessUnitName, 'Unknown'),
                ISNULL(ProductTypeCode, 'UNK'),
                ISNULL(ProductTypeName, 'Unknown'),
                ISNULL(CurrentYearProduction, 0),
                ISNULL(PreviousYearProduction, 0),
                ISNULL(YoYChange, 0),
                @ETLLoadID
            FROM SorayiCarpets.import.tbl_prod_cur_lst_yr_compar
            WHERE (@LoadType = 'Initial') OR 
                  (@LoadType = 'Incremental' AND ImportDate > 
                   ISNULL((SELECT MAX(LoadDate) FROM landing.tbl_prod_cur_lst_yr_compar), '1900-01-01'));
            
            SET @RowCount = @@ROWCOUNT;
            PRINT 'Loaded ' + CAST(@RowCount AS VARCHAR(10)) + ' comparison records to landing';
            
            -- Archive the data
            INSERT INTO archive.tbl_prod_cur_lst_yr_compar (
                ComparisonDate, BusinessUnitCode, BusinessUnitName, ProductTypeCode, ProductTypeName,
                CurrentYearProduction, PreviousYearProduction, YoYChange, ETLLoadID, LoadDate
            )
            SELECT 
                ComparisonDate, BusinessUnitCode, BusinessUnitName, ProductTypeCode, ProductTypeName,
                CurrentYearProduction, PreviousYearProduction, YoYChange, ETLLoadID, LoadDate
            FROM landing.tbl_prod_cur_lst_yr_compar
            WHERE ETLLoadID = @ETLLoadID;
            
            PRINT 'Archived ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' comparison records';
        END
        
        -- Update ETL log
        UPDATE dbo.ETLLoadLog
        SET 
            LoadEndTime = GETDATE(),
            LoadStatus = 'Completed',
            RowsProcessed = @RowCount
        WHERE ETLLoadID = @ETLLoadID;
        
        PRINT 'ETL Load completed successfully for ' + @SourceTable;
        
    END TRY
    BEGIN CATCH
        -- Update ETL log with error
        UPDATE dbo.ETLLoadLog
        SET 
            LoadEndTime = GETDATE(),
            LoadStatus = 'Failed',
            ErrorMessage = ERROR_MESSAGE()
        WHERE ETLLoadID = @ETLLoadID;
        
        PRINT 'Error in ETL Load: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[MasterETLOrchestration]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create Master Orchestration Procedure
CREATE   PROCEDURE [dbo].[MasterETLOrchestration]
    @LoadType VARCHAR(20) = 'Initial'
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @StartTime DATETIME = GETDATE();
    DECLARE @ETLLoadID INT;
    
    BEGIN TRY
        -- Log start
        INSERT INTO dbo.ETLLoadLog (LoadType, SourceSystem, LoadStatus)
        VALUES ('Master_' + @LoadType, 'Orchestration', 'In Progress');
        SET @ETLLoadID = SCOPE_IDENTITY();
        
        PRINT 'MASTER ETL ORCHESTRATION STARTED - Load Type: ' + @LoadType;
        
        -- PHASE 1: Load DWH from Source
        PRINT 'PHASE 1: Loading Data Warehouse...';
        EXEC dbo.LoadDataFromSource 'tbl_inventory_plant_trend', @LoadType;
        EXEC dbo.LoadDataFromSource 'tbl_production_trend', @LoadType;
        EXEC dbo.LoadDataFromSource 'tbl_prod_cur_lst_yr_compar', @LoadType;
        
        -- PHASE 2: Load Star Schema
        PRINT 'PHASE 2: Loading Star Schema...';
        EXEC SorayiCarpets_Star.dbo.LoadInventoryStarSchema;
        EXEC SorayiCarpets_Star.dbo.LoadProductionStarSchema;
        EXEC SorayiCarpets_Star.dbo.LoadComparisonStarSchema;
        
        -- Complete
        UPDATE dbo.ETLLoadLog
        SET LoadEndTime = GETDATE(), LoadStatus = 'Completed'
        WHERE ETLLoadID = @ETLLoadID;
        
        PRINT 'MASTER ETL ORCHESTRATION COMPLETED SUCCESSFULLY!';
        
    END TRY
    BEGIN CATCH
        UPDATE dbo.ETLLoadLog
        SET LoadEndTime = GETDATE(), LoadStatus = 'Failed', ErrorMessage = ERROR_MESSAGE()
        WHERE ETLLoadID = @ETLLoadID;
        
        PRINT 'ERROR: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[PopulateDimDate]    Script Date: 2025-06-05 8:29:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Procedure to populate DimDate
CREATE PROCEDURE [dbo].[PopulateDimDate]
    @StartDate DATE = '2023-01-01',
    @EndDate DATE = '2026-12-31'
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @CurrentDate DATE = @StartDate;
    
    -- Start a new ETL load
    DECLARE @ETLLoadID INT;
    INSERT INTO dbo.ETLLoadLog (LoadType, SourceSystem)
    VALUES ('Initial', 'Calendar Generator');
    SET @ETLLoadID = SCOPE_IDENTITY();
    
    -- Clear existing data in landing
    TRUNCATE TABLE landing.tbl_gl_calendar;
    
    WHILE @CurrentDate <= @EndDate
    BEGIN
        INSERT INTO landing.tbl_gl_calendar (
            CalendarDate, Year, Quarter, Month, MonthName, 
            Week, DayOfWeek, DayName, IsHoliday, 
            FiscalYear, FiscalQuarter, FiscalMonth, ETLLoadID
        )
        SELECT 
            @CurrentDate AS CalendarDate,
            YEAR(@CurrentDate) AS Year,
            DATEPART(QUARTER, @CurrentDate) AS Quarter,
            MONTH(@CurrentDate) AS Month,
            DATENAME(MONTH, @CurrentDate) AS MonthName,
            DATEPART(WEEK, @CurrentDate) AS Week,
            DATEPART(WEEKDAY, @CurrentDate) AS DayOfWeek,
            DATENAME(WEEKDAY, @CurrentDate) AS DayName,
            CASE WHEN DATEPART(WEEKDAY, @CurrentDate) IN (1, 7) THEN 1 ELSE 0 END AS IsHoliday,
            YEAR(@CurrentDate) AS FiscalYear, -- Assuming fiscal years align with calendar years
            DATEPART(QUARTER, @CurrentDate) AS FiscalQuarter, -- Assuming fiscal quarters align with calendar quarters
            MONTH(@CurrentDate) AS FiscalMonth, -- Assuming fiscal months align with calendar months
            @ETLLoadID;
            
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END;
    
    -- Archive the data
    INSERT INTO archive.tbl_gl_calendar (
        CalendarID, CalendarDate, Year, Quarter, Month, MonthName, 
        Week, DayOfWeek, DayName, IsHoliday, 
        FiscalYear, FiscalQuarter, FiscalMonth, ETLLoadID, LoadDate
    )
    SELECT 
        CalendarID, CalendarDate, Year, Quarter, Month, MonthName, 
        Week, DayOfWeek, DayName, IsHoliday, 
        FiscalYear, FiscalQuarter, FiscalMonth, ETLLoadID, LoadDate
    FROM landing.tbl_gl_calendar;
    
    -- Update ETL log
    UPDATE dbo.ETLLoadLog
    SET 
        LoadEndTime = GETDATE(),
        LoadStatus = 'Completed',
        RowsProcessed = @@ROWCOUNT
    WHERE ETLLoadID = @ETLLoadID;
    
    -- Now populate the star schema DimDate
    EXEC SorayiCarpets_Star.dbo.PopulateDimDateFromDWH @ETLLoadID;
END;
GO
