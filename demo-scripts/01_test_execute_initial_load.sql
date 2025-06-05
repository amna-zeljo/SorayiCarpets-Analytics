-- Simple Test Load - Just to verify the process works

PRINT '=== SIMPLE TEST LOAD ===';

-- Step 1: Check source system
USE SorayiCarpets;
GO

PRINT 'Checking source system...';
SELECT 
    t.name as SourceTable,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
ORDER BY t.name;

-- Step 2: Check if we have any data to work with
DECLARE @hasData BIT = 0;
IF EXISTS (
    SELECT 1 FROM sys.tables t
    INNER JOIN sys.partitions p ON t.object_id = p.object_id
    WHERE p.index_id IN (0,1) AND p.rows > 0
)
    SET @hasData = 1;

IF @hasData = 0
BEGIN
    PRINT 'No source data found. Creating sample data...';
    
    -- Create a simple test table if none exist
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TestProducts')
    BEGIN
        CREATE TABLE TestProducts (
            ID int IDENTITY(1,1) PRIMARY KEY,
            ProductName nvarchar(100),
            Category nvarchar(50),
            Price decimal(10,2),
            CreatedDate datetime DEFAULT GETDATE()
        );
        
        INSERT INTO TestProducts (ProductName, Category, Price)
        VALUES 
            ('Test Carpet 1', 'Traditional', 100.00),
            ('Test Carpet 2', 'Modern', 150.00),
            ('Test Carpet 3', 'Premium', 200.00);
            
        PRINT 'Created test data in source system';
    END
END

-- Step 3: Show what we have now
PRINT 'Current source system state:';
SELECT 
    t.name as TableName,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

-- Step 4: Test DWH connection
USE SorayiCarpets_DWH;
GO
PRINT 'DWH system ready';

-- Step 5: Test Star Schema connection
USE SorayiCarpets_Star;
GO
PRINT 'Star Schema system ready';

PRINT '=== SIMPLE TEST LOAD COMPLETE ===';
