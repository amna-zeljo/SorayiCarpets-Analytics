-- =====================================================
-- Discover Actual Production Schema Structure
-- RUN ON: SorayiCarpets_Star DATABASE
-- =====================================================

USE SorayiCarpets_Star;
GO

PRINT 'DISCOVERING ACTUAL PRODUCTION SCHEMA STRUCTURE';
PRINT '==============================================';

-- Check what schemas exist
PRINT '';
PRINT '1. AVAILABLE SCHEMAS:';
PRINT '====================';
SELECT name AS SchemaName
FROM sys.schemas 
WHERE name LIKE '%production%' OR name LIKE '%star%'
ORDER BY name;

-- Check what tables exist in production_star schema
PRINT '';
PRINT '2. TABLES IN PRODUCTION_STAR SCHEMA:';
PRINT '====================================';
SELECT 
    TABLE_NAME,
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'production_star'
ORDER BY TABLE_NAME;

-- Get detailed structure of each table
PRINT '';
PRINT '3. DETAILED TABLE STRUCTURES:';
PRINT '=============================';

-- Check each table individually
DECLARE @TableName VARCHAR(100);
DECLARE table_cursor CURSOR FOR
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'production_star'
ORDER BY TABLE_NAME;

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT '';
    PRINT 'Table: production_star.' + @TableName;
    PRINT REPLICATE('-', LEN(@TableName) + 25);
    
    DECLARE @SQL NVARCHAR(MAX) = '
    SELECT 
        COLUMN_NAME,
        DATA_TYPE,
        CHARACTER_MAXIMUM_LENGTH,
        IS_NULLABLE,
        COLUMN_DEFAULT
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_SCHEMA = ''production_star'' 
      AND TABLE_NAME = ''' + @TableName + '''
    ORDER BY ORDINAL_POSITION;';
    
    EXEC sp_executesql @SQL;
    
    FETCH NEXT FROM table_cursor INTO @TableName;
END

CLOSE table_cursor;
DEALLOCATE table_cursor;

-- Check what data exists
PRINT '';
PRINT '4. DATA SAMPLE FROM EACH TABLE:';
PRINT '===============================';

-- Sample data from each table
DECLARE sample_cursor CURSOR FOR
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'production_star'
ORDER BY TABLE_NAME;

OPEN sample_cursor;
FETCH NEXT FROM sample_cursor INTO @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT '';
    PRINT 'Sample data from: production_star.' + @TableName;
    PRINT REPLICATE('-', LEN(@TableName) + 30);
    
    DECLARE @SampleSQL NVARCHAR(MAX) = '
    SELECT TOP 3 * FROM production_star.' + @TableName + ';';
    
    BEGIN TRY
        EXEC sp_executesql @SampleSQL;
    END TRY
    BEGIN CATCH
        PRINT 'Error sampling data from ' + @TableName + ': ' + ERROR_MESSAGE();
    END CATCH
    
    FETCH NEXT FROM sample_cursor INTO @TableName;
END

CLOSE sample_cursor;
DEALLOCATE sample_cursor;

-- Check source data structure
PRINT '';
PRINT '5. SOURCE DATA STRUCTURE:';
PRINT '=========================';

PRINT 'Source table: SorayiCarpets_DWH.landing.tbl_production_trend';
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM SorayiCarpets_DWH.INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'landing' 
  AND TABLE_NAME = 'tbl_production_trend'
ORDER BY ORDINAL_POSITION;

PRINT '';
PRINT 'Sample source data:';
SELECT TOP 5 * 
FROM SorayiCarpets_DWH.landing.tbl_production_trend
ORDER BY LoadDate DESC;

-- Check what Excel files/tables are available for Power BI
PRINT '';
PRINT '6. AVAILABLE TABLES FOR POWER BI:';
PRINT '=================================';

-- Check all tables in the main database
PRINT 'Tables in SorayiCarpets database:';
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM SorayiCarpets.INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_SCHEMA, TABLE_NAME;

-- Check for any Excel-related tables
PRINT '';
PRINT 'Looking for Excel-related tables:';
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME
FROM SorayiCarpets.INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME LIKE '%excel%' 
   OR TABLE_NAME LIKE '%import%'
   OR TABLE_NAME LIKE '%production%'
   OR TABLE_NAME LIKE '%trend%'
ORDER BY TABLE_SCHEMA, TABLE_NAME;

PRINT '';
PRINT 'DISCOVERY COMPLETED!';
PRINT 'Please review the actual structure above to proceed correctly.';