-- Reset Demo Environment - Clear all data for presentation
-- Fixed version that handles foreign key constraints properly

PRINT '=== RESETTING DEMO ENVIRONMENT ===';
PRINT 'Clearing all data from warehouse and star schema...';

-- Reset Data Warehouse
USE SorayiCarpets_DWH;
GO

PRINT 'Clearing SorayiCarpets_DWH...';

-- Disable all foreign key constraints temporarily
EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";

-- Delete all data from all tables
EXEC sp_MSforeachtable "DELETE FROM ?";

-- Re-enable all foreign key constraints
EXEC sp_MSforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all";

PRINT 'Data Warehouse cleared.';

-- Reset Star Schema
USE SorayiCarpets_Star;
GO

PRINT 'Clearing SorayiCarpets_Star...';

-- Disable all foreign key constraints temporarily
EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";

-- Delete all data from all tables
EXEC sp_MSforeachtable "DELETE FROM ?";

-- Re-enable all foreign key constraints
EXEC sp_MSforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all";

PRINT 'Star Schema cleared.';

-- Verify everything is empty
PRINT 'Verification - Table record counts after reset:';

USE SorayiCarpets_DWH;
SELECT 
    'DWH' as DatabaseType,
    t.name as TableName,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
ORDER BY t.name;

USE SorayiCarpets_Star;
SELECT 
    'Star' as DatabaseType,
    t.name as TableName, 
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id  
WHERE p.index_id IN (0,1)
ORDER BY t.name;

PRINT '=== DEMO ENVIRONMENT RESET COMPLETE ===';
PRINT 'All tables should now show 0 records';
PRINT 'Ready to begin presentation demo!';
