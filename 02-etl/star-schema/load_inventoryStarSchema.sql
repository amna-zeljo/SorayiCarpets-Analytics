USE SorayiCarpets_Star;
GO

-- Drop the procedure if it exists first
IF OBJECT_ID('dbo.LoadInventoryStarSchema', 'P') IS NOT NULL
    DROP PROCEDURE dbo.LoadInventoryStarSchema;
GO

-- Create the updated procedure
CREATE PROCEDURE dbo.LoadInventoryStarSchema
AS
BEGIN
    SET NOCOUNT ON;

    -- Clear tables before loading
    TRUNCATE TABLE inventory_star.FactInventory;
    DELETE FROM inventory_star.DimDate;
    DELETE FROM inventory_star.DimPlant;
    DELETE FROM inventory_star.DimProduct;
    DELETE FROM inventory_star.DimBusinessUnit;

    -- Load Date Dimension
    INSERT INTO inventory_star.DimDate (DateKey, CalendarDate, Year, Month, Day, Quarter)
    SELECT DISTINCT
        CONVERT(INT, FORMAT(TREND_DATE, 'yyyyMMdd')) AS DateKey,
        CAST(TREND_DATE AS DATE),
        YEAR(TREND_DATE),
        MONTH(TREND_DATE),
        DAY(TREND_DATE),
        DATEPART(QUARTER, TREND_DATE)
    FROM SorayiCarpets_DWH.import.tbl_inventory_plant_trend
    WHERE TREND_DATE IS NOT NULL;

    -- Load Plant Dimension
    INSERT INTO inventory_star.DimPlant (PlantCode, PlantName)
    SELECT DISTINCT
        ISNULL(PLANT_NAME, 'Unknown'),
        ISNULL(PLANT_NAME, 'Unknown Plant')
    FROM SorayiCarpets_DWH.import.tbl_inventory_plant_trend
    WHERE PLANT_NAME IS NOT NULL;

    -- Load Product Dimension
    INSERT INTO inventory_star.DimProduct (ProductCode, ProductName, ProductCategory)
    SELECT DISTINCT
        ISNULL(WAREHOUSE_CATGY_1, 'Unknown'),
        ISNULL(WAREHOUSE_CATGY_1, 'Unknown Product'),
        'Carpet'
    FROM SorayiCarpets_DWH.import.tbl_inventory_plant_trend;

    -- Load Business Unit Dimension (dummy field, we’ll reuse PLANT_NAME for now)
    INSERT INTO inventory_star.DimBusinessUnit (BusinessUnitCode, BusinessUnitName)
    SELECT DISTINCT
        ISNULL(PLANT_NAME, 'Unknown'),
        ISNULL(PLANT_NAME, 'Unknown Business Unit')
    FROM SorayiCarpets_DWH.import.tbl_inventory_plant_trend;

    -- Load Fact Table
    INSERT INTO inventory_star.FactInventory (
        DateKey, PlantKey, ProductKey, BusinessUnitKey, QuantityOnHand, UnitCost, TotalValue, InventoryTurnover
    )
    SELECT 
        d.DateKey,
        p.PlantKey,
        pr.ProductKey,
        bu.BusinessUnitKey,
        NULL, NULL,
        TRY_CAST(i.INVENTORY_VALUE AS DECIMAL(18,2)),
        NULL
    FROM SorayiCarpets_DWH.import.tbl_inventory_plant_trend i
    INNER JOIN inventory_star.DimDate d ON d.CalendarDate = i.TREND_DATE
    INNER JOIN inventory_star.DimPlant p ON p.PlantCode = ISNULL(i.PLANT_NAME, 'Unknown')
    INNER JOIN inventory_star.DimProduct pr ON pr.ProductCode = ISNULL(i.WAREHOUSE_CATGY_1, 'Unknown')
    INNER JOIN inventory_star.DimBusinessUnit bu ON bu.BusinessUnitCode = ISNULL(i.PLANT_NAME, 'Unknown');

    PRINT 'Inventory Star Schema loaded.';
END;
GO
