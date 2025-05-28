-- =====================================================
-- Inventory Pipeline Orchestration (FIXED)
-- SAVE AS: etl/orchestrate_inventory_pipeline_fixed.sql
-- RUN ON: SorayiCarpets_DWH
-- FOCUS: Inventory Star Schema Only
-- =====================================================

USE SorayiCarpets_DWH;
GO

PRINT '========================================';
PRINT 'SORAYICARPETS INVENTORY ETL ORCHESTRATION';
PRINT 'Focus: Inventory Star Schema Only';
PRINT '========================================';

DECLARE @StartTime DATETIME = GETDATE();
DECLARE @ETLLoadID INT;

BEGIN TRY
    -- Log orchestration start (shorter LoadType)
    INSERT INTO dbo.ETLLoadLog (LoadType, SourceSystem, LoadStatus)
    VALUES ('Inventory_ETL', 'Pipeline', 'In Progress');
    SET @ETLLoadID = SCOPE_IDENTITY();
    
    PRINT 'Orchestration ID: ' + CAST(@ETLLoadID AS VARCHAR);
    PRINT '';
    
    -- PHASE 1: Load Inventory Data to DWH
    PRINT 'PHASE 1: Loading Inventory Data to Data Warehouse...';
    EXEC dbo.LoadDataFromSource 'tbl_inventory_plant_trend', 'Initial';
    
    -- PHASE 2: Load Inventory Star Schema
    PRINT 'PHASE 2: Loading Inventory Star Schema...';
    EXEC SorayiCarpets_Star.dbo.LoadInventoryStarSchema;
    
    -- Complete orchestration
    UPDATE dbo.ETLLoadLog
    SET LoadEndTime = GETDATE(), LoadStatus = 'Completed'
    WHERE ETLLoadID = @ETLLoadID;
    
    PRINT '';
    PRINT '========================================';
    PRINT 'INVENTORY ETL ORCHESTRATION COMPLETED!';
    PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @StartTime, GETDATE()) AS VARCHAR) + ' seconds';
    PRINT '========================================';
    
    -- Show results
    PRINT '';
    PRINT 'INVENTORY DATA SUMMARY:';
    SELECT 'DWH Landing' AS Location, COUNT(*) AS Records FROM landing.tbl_inventory_plant_trend
    UNION ALL
    SELECT 'Star Schema', COUNT(*) FROM SorayiCarpets_Star.inventory_star.FactInventory;
    
END TRY
BEGIN CATCH
    -- Log error
    UPDATE dbo.ETLLoadLog
    SET LoadEndTime = GETDATE(), LoadStatus = 'Failed', ErrorMessage = ERROR_MESSAGE()
    WHERE ETLLoadID = @ETLLoadID;
    
    PRINT 'ERROR in Inventory Orchestration: ' + ERROR_MESSAGE();
    THROW;
END CATCH