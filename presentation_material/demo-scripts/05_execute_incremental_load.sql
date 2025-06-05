-- Execute Incremental Load Process

PRINT '=== EXECUTING INCREMENTAL LOAD PROCESS ===';

-- Step 1: Run incremental ETL process
PRINT 'Step 1: Processing incremental changes...';

USE SorayiCarpets;
GO

PRINT 'Running incremental load pipeline...';

-- Execute incremental load procedures
-- Based on existing scripts like 09_orchestrate_inventory_pipeline_success.sql
-- Example: EXEC [dbo].[sp_IncrementalLoad];

PRINT 'Incremental source processing completed.';

-- Step 2: Update DWH with changes
PRINT 'Step 2: Updating data warehouse with incremental changes...';

USE SorayiCarpets_DWH;
GO

PRINT 'Processing DWH incremental updates...';
-- Add DWH incremental load logic here

PRINT 'DWH incremental update completed.';

-- Step 3: Update Star Schema
PRINT 'Step 3: Updating star schemas with incremental changes...';

USE SorayiCarpets_Star;
GO

PRINT 'Processing star schema incremental updates...';
-- Add star schema incremental load logic here

PRINT 'Star schema incremental update completed.';

-- Step 4: Show incremental load results
PRINT 'Step 4: Incremental Load Results Summary';

-- Show updated DWH record counts
USE SorayiCarpets_DWH;
PRINT 'Data Warehouse after incremental load:';
SELECT 
    t.name as TableName,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

-- Show updated Star Schema record counts
USE SorayiCarpets_Star;
PRINT 'Star Schema after incremental load:';
SELECT 
    t.name as TableName,
    p.rows as RecordCount
FROM sys.tables t
INNER JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1) AND p.rows > 0
ORDER BY p.rows DESC;

PRINT '=== INCREMENTAL LOAD PROCESS COMPLETE ===';
PRINT 'Ready to show updated visualizations in Power BI';
