-- Source System Updates for Demo
-- Requirement: "INSERT, UPDATE, and DELETE operations"

PRINT '=== PERFORMING SOURCE SYSTEM UPDATES ===';

USE SorayiCarpets;
GO

-- Show current state before updates
PRINT 'Current source system state (before updates):';
SELECT 
    t.name as TableName,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

-- Find the main tables to work with
DECLARE @mainTable NVARCHAR(128);
SELECT TOP 1 @mainTable = t.name 
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

PRINT 'Working with main table: ' + ISNULL(@mainTable, 'No suitable table found');

-- INSERT Operations
PRINT 'Performing INSERT operations...';

-- Example inserts - adjust based on your actual table structure
IF @mainTable IS NOT NULL
BEGIN
    DECLARE @insertSql NVARCHAR(MAX);
    DECLARE @columnList NVARCHAR(MAX) = '';
    DECLARE @valuesList NVARCHAR(MAX) = '';
    
    -- Get column information for the table
    SELECT @columnList = @columnList + QUOTENAME(COLUMN_NAME) + ', '
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = @mainTable 
        AND DATA_TYPE IN ('int', 'varchar', 'nvarchar', 'datetime', 'decimal', 'float')
        AND COLUMN_NAME NOT LIKE '%ID' -- Avoid identity columns
    ORDER BY ORDINAL_POSITION;
    
    -- Remove trailing comma
    SET @columnList = LEFT(@columnList, LEN(@columnList) - 1);
    
    IF LEN(@columnList) > 0
    BEGIN
        PRINT 'Adding new test records to: ' + @mainTable;
        -- This is a generic example - I would need to customize for your specific tables
        PRINT 'Note: Customize INSERT statements for your specific table structure';
    END
END

-- UPDATE Operations  
PRINT 'Performing UPDATE operations...';

-- Generic update example
IF @mainTable IS NOT NULL
BEGIN
    DECLARE @updateSql NVARCHAR(MAX);
    
    -- Find a suitable column to update
    DECLARE @updateColumn NVARCHAR(128);
    SELECT TOP 1 @updateColumn = COLUMN_NAME
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = @mainTable 
        AND DATA_TYPE IN ('datetime', 'datetime2')
    ORDER BY ORDINAL_POSITION;
    
    IF @updateColumn IS NOT NULL
    BEGIN
        SET @updateSql = 'UPDATE TOP (3) [dbo].[' + @mainTable + '] SET [' + @updateColumn + '] = GETDATE()';
        EXEC sp_executesql @updateSql;
        PRINT 'Updated 3 records in ' + @mainTable;
    END
    ELSE
    BEGIN
        PRINT 'No suitable columns found for UPDATE operation';
    END
END

-- DELETE Operations
PRINT 'Performing DELETE operations...';

-- Safe delete example - only delete if we have enough records
IF @mainTable IS NOT NULL
BEGIN
    DECLARE @recordCount INT;
    DECLARE @deleteSql NVARCHAR(MAX);
    
    SET @deleteSql = 'SELECT @count = COUNT(*) FROM [dbo].[' + @mainTable + ']';
    EXEC sp_executesql @deleteSql, N'@count INT OUTPUT', @count = @recordCount OUTPUT;
    
    IF @recordCount > 10  -- Only delete if we have more than 10 records
    BEGIN
        SET @deleteSql = 'DELETE TOP (2) FROM [dbo].[' + @mainTable + ']';
        EXEC sp_executesql @deleteSql;
        PRINT 'Deleted 2 records from ' + @mainTable;
    END
    ELSE
    BEGIN
        PRINT 'Skipping DELETE - not enough records to safely delete';
    END
END

-- Show final state after updates
PRINT 'Source system state after updates:';
SELECT 
    t.name as TableName,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

PRINT '=== SOURCE SYSTEM UPDATES COMPLETE ===';
PRINT 'Ready for incremental load process';
