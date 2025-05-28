-- =====================================================
-- Check Star Schema Table Structures
-- RUN THIS ON: SorayiCarpets_Star DATABASE
-- =====================================================

USE SorayiCarpets_Star;
GO

PRINT 'CHECKING STAR SCHEMA TABLE STRUCTURES';
PRINT '=====================================';

-- Check Production Star Schema
PRINT '';
PRINT 'production_star.DimDate columns:';
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'DimDate'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'production_star.DimPlant columns:';
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'DimPlant'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'production_star.DimProduct columns:';
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'DimProduct'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'production_star.DimBusinessUnit columns:';
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'DimBusinessUnit'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'production_star.FactProduction columns:';
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'production_star' AND TABLE_NAME = 'FactProduction'
ORDER BY ORDINAL_POSITION;