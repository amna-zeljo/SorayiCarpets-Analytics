-- =====================================================
-- RUN THIS ON: SorayiCarpets_DWH DATABASE
-- Fix LoadDataFromSource Procedure
-- =====================================================

USE SorayiCarpets_DWH;
GO

-- Drop and recreate the procedure with proper column handling
DROP PROCEDURE IF EXISTS [dbo].[LoadDataFromSource];
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

PRINT 'LoadDataFromSource procedure fixed and recreated!';