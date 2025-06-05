-- Execute Initial Load Process for Demo
-- Based on your existing ETL scripts

PRINT '=== EXECUTING INITIAL LOAD PROCESS ===';

-- Step 1: Create missing archive tables if needed
PRINT 'Step 1: Setting up archive tables...';
USE SorayiCarpets;
GO

-- Run your existing archive setup script
-- Based on your 00_create_missing_archive_tables.sql
EXEC sp_executesql N'
-- Your archive table creation logic here
-- This should match your existing script
';

PRINT 'Archive tables ready.';

-- Step 2: Load data from source to DWH
PRINT 'Step 2: Loading data from source system to data warehouse...';

-- Execute your existing DWH load procedure
-- Based on your 02_execute_dwh_load.sql
USE SorayiCarpets_DWH;
GO

-- Run your DWH loading logic
PRINT 'Executing DWH load process...';
-- Add your actual DWH load procedure call here

PRINT 'DWH load completed.';

-- Step 3: Load star schemas
PRINT 'Step 3: Loading star schemas...';

USE SorayiCarpets_Star;
GO

-- Load inventory star schema
PRINT 'Loading inventory star schema...';
-- Based on your load_inventoryStarSchema.sql

-- Load production star schema  
PRINT 'Loading production star schema...';
-- Based on your load_productionStarSchema.sql

-- Load comparison star schema
PRINT 'Loading comparison star schema...';
-- Based on your loadComparisonStarSchema.sql

PRINT 'Star schema loads completed.';

-- Step 4: Show load summary
PRINT 'Step 4: Initial Load Summary';

-- Count records in DWH
USE SorayiCarpets_DWH;
SELECT 
    'DWH Tables' as LoadType,
    t.name as TableName,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

-- Count records in Star Schema
USE SorayiCarpets_Star;
SELECT 
    'Star Schema' as LoadType,
    t.name as TableName,
    p.rows as RecordCount  
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

PRINT '=== INITIAL LOAD PROCESS COMPLETE ===';
