-- Final CS 360 Requirements Check
USE SorayiCarpets_DWH;

SELECT 
    'Data Sources' AS Requirement, 
    CASE WHEN EXISTS (SELECT 1 FROM SorayiCarpets.import.tbl_inventory_plant_trend) 
         THEN 'COMPLETE' ELSE 'MISSING' END AS Status
UNION ALL
SELECT 'Data Warehousing', 
    CASE WHEN EXISTS (SELECT 1 FROM landing.tbl_inventory_plant_trend) 
         THEN 'COMPLETE' ELSE 'MISSING' END
UNION ALL  
SELECT 'Star Schema',
    CASE WHEN EXISTS (SELECT 1 FROM SorayiCarpets_Star.inventory_star.FactInventory)
         THEN 'COMPLETE' ELSE 'MISSING' END
UNION ALL
SELECT 'Orchestration',
    CASE WHEN EXISTS (SELECT 1 FROM sys.procedures WHERE name = 'MasterETLOrchestration')
         THEN 'COMPLETE' ELSE 'MISSING' END;