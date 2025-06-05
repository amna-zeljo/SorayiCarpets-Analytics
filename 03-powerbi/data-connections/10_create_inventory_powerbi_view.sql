USE SorayiCarpets_Star;
GO

-- Updated view to include ALL 5 tables from your final schema
CREATE OR ALTER VIEW dbo.vw_PowerBI_Inventory_Complete
AS
SELECT 
    -- Date fields
    d.CalendarDate,
    d.Year,
    d.Month,
    d.Quarter,
    d.MonthName,
    d.DayName,
    
    -- Plant information
    p.PlantCode,
    p.PlantName,
    p.Location AS PlantLocation,
    p.Region AS PlantRegion,
    
    -- Product information  
    pr.ProductCode,
    pr.ProductName,
    pr.ProductCategory,
    pr.ProductType,
    
    -- Business Unit information
    bu.BusinessUnitCode,
    bu.BusinessUnitName,
    bu.Department,
    
    -- Inventory measures
    f.QuantityOnHand,
    f.UnitCost,
    f.TotalValue,
    f.InventoryTurnover,
    
    -- Calculated fields
    CASE 
        WHEN f.TotalValue > 1000000 THEN 'High Value'
        WHEN f.TotalValue > 500000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS ValueCategory
    
FROM inventory_star.FactInventory f
INNER JOIN inventory_star.DimDate d ON f.DateKey = d.DateKey
INNER JOIN inventory_star.DimPlant p ON f.PlantKey = p.PlantKey
INNER JOIN inventory_star.DimProduct pr ON f.ProductKey = pr.ProductKey
INNER JOIN inventory_star.DimBusinessUnit bu ON f.BusinessUnitKey = bu.BusinessUnitKey;
GO

PRINT 'Complete inventory Power BI view created successfully!';