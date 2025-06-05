-- Show Updated Data After Incremental Load
-- Final demonstration of the complete pipeline

PRINT '=== FINAL DATA STATE AFTER COMPLETE PIPELINE ===';

-- Show final state of all databases
PRINT 'Final state - Source System:';
USE SorayiCarpets;
SELECT 
    'Source' as DatabaseType,
    t.name as TableName,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

PRINT 'Final state - Data Warehouse:';
USE SorayiCarpets_DWH;
SELECT 
    'DWH' as DatabaseType,
    t.name as TableName,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

PRINT 'Final state - Star Schema:';
USE SorayiCarpets_Star;
SELECT 
    'Star' as DatabaseType,
    t.name as TableName,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

-- Show a sample of the final processed data from star schema
PRINT 'Sample of final processed data:';

DECLARE @sampleTable NVARCHAR(128);
DECLARE @sql NVARCHAR(MAX);

-- Get the largest table from star schema for sample
SELECT TOP 1 @sampleTable = t.name
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

IF @sampleTable IS NOT NULL
BEGIN
    SET @sql = 'SELECT TOP 5 * FROM [dbo].[' + @sampleTable + ']';
    PRINT 'Final sample from: ' + @sampleTable;
    EXEC sp_executesql @sql;
END

-- Show pipeline completion summary
PRINT 'Pipeline Completion Summary:';
SELECT 
    'Complete Pipeline' as ProcessType,
    'SUCCESS' as Status,
    GETDATE() as CompletionTime;

PRINT '=== COMPLETE PIPELINE DEMONSTRATION FINISHED ===';
PRINT 'Now ready to show updated Power BI visualizations!';
PRINT 'Demo presentation complete - all requirements demonstrated!';
