-- =====================================================
-- Check Actual Column Names in Source Tables
-- RUN THIS ON: SorayiCarpets_DWH DATABASE
-- =====================================================

USE SorayiCarpets_DWH;
GO

PRINT 'CHECKING ACTUAL COLUMN NAMES IN SOURCE TABLES';
PRINT '==============================================';

-- Check tbl_production_trend columns
PRINT '';
PRINT 'Columns in landing.tbl_production_trend:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'landing' 
AND TABLE_NAME = 'tbl_production_trend'
ORDER BY ORDINAL_POSITION;

-- Check tbl_prod_cur_lst_yr_compar columns  
PRINT '';
PRINT 'Columns in landing.tbl_prod_cur_lst_yr_compar:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'landing' 
AND TABLE_NAME = 'tbl_prod_cur_lst_yr_compar'
ORDER BY ORDINAL_POSITION;

-- Check tbl_inventory_plant_trend columns
PRINT '';
PRINT 'Columns in landing.tbl_inventory_plant_trend:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'landing' 
AND TABLE_NAME = 'tbl_inventory_plant_trend'
ORDER BY ORDINAL_POSITION;

-- Sample data from each table
PRINT '';
PRINT 'Sample data from tbl_production_trend:';
SELECT TOP 2 * FROM landing.tbl_production_trend;

PRINT '';
PRINT 'Sample data from tbl_prod_cur_lst_yr_compar:';
SELECT TOP 2 * FROM landing.tbl_prod_cur_lst_yr_compar;

PRINT '';
PRINT 'Sample data from tbl_inventory_plant_trend:';
SELECT TOP 2 * FROM landing.tbl_inventory_plant_trend;