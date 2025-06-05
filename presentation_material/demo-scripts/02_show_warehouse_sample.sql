-- Show Sample Data from Archive/Warehouse
-- Requirement: "Sample data from one table in archive/warehouse"

PRINT '=== WAREHOUSE SAMPLE DATA ===';

USE SorayiCarpets_DWH;
GO

-- Show available tables first
PRINT 'Available tables in Data Warehouse:';
SELECT 
    t.name as TableName,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

-- Show sample from largest table (adjust table name based on structure)
PRINT 'Sample data from main warehouse table:';

-- Try to find and sample from main tables
DECLARE @tableName NVARCHAR(128);
DECLARE @sql NVARCHAR(MAX);

-- Get the table with most records
SELECT TOP 1 @tableName = t.name
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

IF @tableName IS NOT NULL
BEGIN
    SET @sql = 'SELECT TOP 10 * FROM [dbo].[' + @tableName + '] ORDER BY 1';
    PRINT 'Showing sample from table: ' + @tableName;
    EXEC sp_executesql @sql;
END

-- Show data distribution summary
PRINT 'Data warehouse summary:';
SELECT 
    COUNT(*) as TotalTables,
    SUM(p.rows) as TotalRecords
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1);

PRINT '=== WAREHOUSE SAMPLE DATA COMPLETE ===';
