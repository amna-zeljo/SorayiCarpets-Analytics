-- =====================================================
-- RUN THIS ON: SorayiCarpets_DWH DATABASE
-- Retry DWH Load (after fixing procedure)
-- =====================================================

USE SorayiCarpets_DWH;
GO

PRINT '========================================';
PRINT 'STEP 1: LOADING SOURCE -> DWH (RETRY)';
PRINT 'Database: SorayiCarpets_DWH';
PRINT '========================================';

BEGIN TRY
    -- Load inventory data
    PRINT 'Loading inventory data from SorayiCarpets...';
    EXEC dbo.LoadDataFromSource 'tbl_inventory_plant_trend', 'Initial';
    
    -- Load production data  
    PRINT 'Loading production data from SorayiCarpets...';
    EXEC dbo.LoadDataFromSource 'tbl_production_trend', 'Initial';
    
    -- Load comparison data
    PRINT 'Loading comparison data from SorayiCarpets...';
    EXEC dbo.LoadDataFromSource 'tbl_prod_cur_lst_yr_compar', 'Initial';
    
    PRINT '';
    PRINT 'DWH Load completed successfully!';
    
    -- Verify DWH data
    PRINT '';
    PRINT 'DWH Landing Tables Verification:';
    SELECT 'landing.tbl_inventory_plant_trend' AS TableName, COUNT(*) AS Records FROM landing.tbl_inventory_plant_trend
    UNION ALL
    SELECT 'landing.tbl_production_trend', COUNT(*) FROM landing.tbl_production_trend
    UNION ALL
    SELECT 'landing.tbl_prod_cur_lst_yr_compar', COUNT(*) FROM landing.tbl_prod_cur_lst_yr_compar;
    
    PRINT '';
    PRINT 'Archive Tables Verification:';
    SELECT 'archive.tbl_inventory_plant_trend' AS TableName, COUNT(*) AS Records FROM archive.tbl_inventory_plant_trend
    UNION ALL
    SELECT 'archive.tbl_production_trend', COUNT(*) FROM archive.tbl_production_trend
    UNION ALL
    SELECT 'archive.tbl_prod_cur_lst_yr_compar', COUNT(*) FROM archive.tbl_prod_cur_lst_yr_compar;
    
END TRY
BEGIN CATCH
    PRINT 'ERROR in DWH Load:';
    PRINT ERROR_MESSAGE();
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR);
END CATCH