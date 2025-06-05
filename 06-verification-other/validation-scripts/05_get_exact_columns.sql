-- =====================================================
-- Get Exact Column Names from All Tables
-- RUN THIS ON BOTH DATABASES (script switches automatically)
-- =====================================================

-- First check DWH source tables
USE SorayiCarpets_DWH;
GO

PRINT 'SOURCE TABLE COLUMNS:';
PRINT '====================';

PRINT 'tbl_production_trend:';
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'landing' AND TABLE_NAME = 'tbl_production_trend'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'tbl_prod_cur_lst_yr_compar:';
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'landing' AND TABLE_NAME = 'tbl_prod_cur_lst_yr_compar'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'tbl_inventory_plant_trend:';
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'landing' AND TABLE_NAME = 'tbl_inventory_plant_trend'
ORDER BY ORDINAL_POSITION;

-- Now check star schema tables
USE SorayiCarpets_Star;
GO

PRINT '';
PRINT 'STAR SCHEMA TABLE COLUMNS:';
PRINT '==========================';

PRINT 'production_star.DimDate:';
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'DimDate'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'production_star.FactProduction:';
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'FactProduction'
ORDER BY ORDINAL_POSITION;

-- Sample data to see actual values
PRINT '';
PRINT 'SAMPLE DATA:';
PRINT '============';

USE SorayiCarpets_DWH;
PRINT 'Sample from tbl_production_trend:';
SELECT TOP 1 * FROM landing.tbl_production_trend;