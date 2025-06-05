-- =====================================================
-- Check Excel Sources and Data Structure
-- RUN ON: SorayiCarpets DATABASE (main source)
-- =====================================================

USE SorayiCarpets;
GO

PRINT 'CHECKING EXCEL SOURCES AND DATA STRUCTURE';
PRINT '=========================================';

-- Check all tables in the main database
PRINT '';
PRINT '1. ALL TABLES IN SorayiCarpets DATABASE:';
PRINT '========================================';
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_SCHEMA, TABLE_NAME;

-- Check production-related tables
PRINT '';
PRINT '2. PRODUCTION-RELATED TABLES:';
PRINT '=============================';
SELECT 
    TABLE_NAME,
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = t.TABLE_NAME) AS ColumnCount
FROM INFORMATION_SCHEMA.TABLES t
WHERE TABLE_NAME LIKE '%production%' 
   OR TABLE_NAME LIKE '%trend%'
   OR TABLE_NAME LIKE '%sales%'
   OR TABLE_NAME LIKE '%budget%'
   OR TABLE_NAME LIKE '%forecast%'
ORDER BY TABLE_NAME;

-- Get structure of main production table
PRINT '';
PRINT '3. MAIN PRODUCTION TABLE STRUCTURE:';
PRINT '===================================';
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_production_trend')
BEGIN
    PRINT 'Structure of tbl_production_trend:';
    SELECT 
        COLUMN_NAME,
        DATA_TYPE,
        CHARACTER_MAXIMUM_LENGTH,
        IS_NULLABLE
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'tbl_production_trend'
    ORDER BY ORDINAL_POSITION;
    
    PRINT '';
    PRINT 'Sample data from tbl_production_trend:';
    SELECT TOP 5 * FROM tbl_production_trend ORDER BY LoadDate DESC;
    
    PRINT '';
    PRINT 'Data summary:';
    SELECT 
        COUNT(*) AS TotalRecords,
        COUNT(DISTINCT PlantName) AS UniquePlants,
        COUNT(DISTINCT ProductName) AS UniqueProducts,
        COUNT(DISTINCT BusinessUnit) AS UniqueBusinessUnits,
        MIN(LoadDate) AS MinDate,
        MAX(LoadDate) AS MaxDate
    FROM tbl_production_trend;
END
ELSE
BEGIN
    PRINT 'tbl_production_trend not found in this database';
END

-- Check for other potential Excel import tables
PRINT '';
PRINT '4. OTHER POTENTIAL DATA TABLES:';
PRINT '===============================';

-- Check each table that might contain production data
DECLARE @TableName VARCHAR(100);
DECLARE @SQL NVARCHAR(MAX);
DECLARE table_cursor CURSOR FOR
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
  AND (TABLE_NAME LIKE '%tbl_%' 
       OR TABLE_NAME LIKE '%production%'
       OR TABLE_NAME LIKE '%sales%'
       OR TABLE_NAME LIKE '%budget%'
       OR TABLE_NAME LIKE '%forecast%'
       OR TABLE_NAME LIKE '%trend%')
ORDER BY TABLE_NAME;

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT '';
    PRINT 'Table: ' + @TableName;
    PRINT REPLICATE('-', LEN(@TableName) + 7);
    
    -- Get column structure
    SET @SQL = '
    SELECT 
        COLUMN_NAME,
        DATA_TYPE,
        IS_NULLABLE
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = ''' + @TableName + '''
    ORDER BY ORDINAL_POSITION;';
    
    EXEC sp_executesql @SQL;
    
    -- Get record count
    SET @SQL = 'SELECT COUNT(*) AS RecordCount FROM ' + @TableName;
    EXEC sp_executesql @SQL;
    
    -- Get sample data
    SET @SQL = 'SELECT TOP 2 * FROM ' + @TableName;
    BEGIN TRY
        EXEC sp_executesql @SQL;
    END TRY
    BEGIN CATCH
        PRINT 'Error sampling data: ' + ERROR_MESSAGE();
    END CATCH
    
    FETCH NEXT FROM table_cursor INTO @TableName;
END

CLOSE table_cursor;
DEALLOCATE table_cursor;

PRINT '';
PRINT 'EXCEL SOURCES CHECK COMPLETED!';
PRINT 'Please identify which tables will be used for Power BI.';