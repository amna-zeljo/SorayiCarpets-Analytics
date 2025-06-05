-- Show Star Schema Data
-- Requirement: "Data in one fact table and one dimension table"

PRINT '=== STAR SCHEMA SAMPLE DATA ===';

USE SorayiCarpets_Star;
GO

-- Show available tables
PRINT 'Available tables in Star Schema:';
SELECT 
    t.name as TableName,
    p.rows as RecordCount,
    CASE 
        WHEN t.name LIKE 'Fact%' THEN 'Fact Table'
        WHEN t.name LIKE 'Dim%' THEN 'Dimension Table'
        ELSE 'Other'
    END as TableType
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY TableType, p.rows DESC;

-- Show sample from fact table
DECLARE @factTable NVARCHAR(128);
DECLARE @dimTable NVARCHAR(128);
DECLARE @sql NVARCHAR(MAX);

-- Get a fact table
SELECT TOP 1 @factTable = t.name
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0 AND t.name LIKE 'Fact%'
ORDER BY p.rows DESC;

-- Get a dimension table
SELECT TOP 1 @dimTable = t.name  
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0 AND t.name LIKE 'Dim%'
ORDER BY p.rows DESC;

-- Show fact table sample
IF @factTable IS NOT NULL
BEGIN
    PRINT 'Sample data from Fact Table: ' + @factTable;
    SET @sql = 'SELECT TOP 10 * FROM [dbo].[' + @factTable + '] ORDER BY 1';
    EXEC sp_executesql @sql;
END

-- Show dimension table sample
IF @dimTable IS NOT NULL  
BEGIN
    PRINT 'Sample data from Dimension Table: ' + @dimTable;
    SET @sql = 'SELECT TOP 10 * FROM [dbo].[' + @dimTable + '] ORDER BY 1';
    EXEC sp_executesql @sql;
END

-- Show star schema summary
PRINT 'Star Schema Summary:';
SELECT 
    CASE 
        WHEN t.name LIKE 'Fact%' THEN 'Fact Tables'
        WHEN t.name LIKE 'Dim%' THEN 'Dimension Tables'
        ELSE 'Other Tables'
    END as TableType,
    COUNT(*) as TableCount,
    SUM(p.rows) as TotalRecords
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
GROUP BY CASE 
    WHEN t.name LIKE 'Fact%' THEN 'Fact Tables'
    WHEN t.name LIKE 'Dim%' THEN 'Dimension Tables'
    ELSE 'Other Tables'
END;

PRINT '=== STAR SCHEMA SAMPLE DATA COMPLETE ===';
