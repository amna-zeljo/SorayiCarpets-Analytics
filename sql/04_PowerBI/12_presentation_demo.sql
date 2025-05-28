-- =====================================================
-- CS 360 PRESENTATION DEMO
-- Run this during presentation
-- =====================================================

-- STEP 1: Show empty state
USE SorayiCarpets_Star;
SELECT 'Before ETL' AS Status, COUNT(*) AS Records FROM inventory_star.FactInventory;

-- STEP 2: Run your orchestration (the one that works!)
USE SorayiCarpets_DWH;
-- Execute your working orchestration script

-- STEP 3: Show results
USE SorayiCarpets_Star;
SELECT 'After ETL' AS Status, COUNT(*) AS Records FROM inventory_star.FactInventory;

-- STEP 4: Show Power BI data
SELECT TOP 5 * FROM inventory_star.FactInventory;