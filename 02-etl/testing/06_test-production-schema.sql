-- =====================================================
-- Test Production Star Schema Structure
-- SAVE TO: C:\SorayiCarpets\verification\test-production-schema.sql
-- RUN ON: SorayiCarpets_Star DATABASE
-- =====================================================

USE SorayiCarpets_Star;
GO

PRINT 'TESTING PRODUCTION STAR SCHEMA STRUCTURE';
PRINT '=========================================';

-- Check what columns actually exist in each table
PRINT '';
PRINT 'DimDate columns:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'DimDate'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'DimPlant columns:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'DimPlant'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'DimProductType columns:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'DimProductType'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'DimBusinessUnit columns:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'DimBusinessUnit'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'FactProduction columns:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'FactProduction'
ORDER BY ORDINAL_POSITION;

-- Check source data columns
PRINT '';
PRINT 'Source table (tbl_production_trend) columns:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'landing' AND TABLE_NAME = 'tbl_production_trend'
ORDER BY ORDINAL_POSITION;

-- Sample source data
PRINT '';
PRINT 'Sample source data:';
SELECT TOP 3 * FROM SorayiCarpets_DWH.landing.tbl_production_trend;