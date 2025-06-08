ALTER PROCEDURE [dbo].[LoadInventoryStarSchema]
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
        CONVERT(INT, FORMAT(InventoryDate, 'yyyyMMdd')) AS DateKey,
        CAST(InventoryDate AS DATE),
        YEAR(InventoryDate),
        MONTH(InventoryDate),
        DAY(InventoryDate),
        DATEPART(QUARTER, InventoryDate)
    FROM SorayiCarpets_DWH.landing.tbl_inventory_plant_trend
    WHERE InventoryDate IS NOT NULL;

    -- Load Plant Dimension
    INSERT INTO inventory_star.DimPlant (PlantCode, PlantName)
    SELECT DISTINCT
        ISNULL(PlantCode, 'Unknown'),
        ISNULL(PlantName, 'Unknown Plant')
    FROM SorayiCarpets_DWH.landing.tbl_inventory_plant_trend
    WHERE PlantCode IS NOT NULL;

    -- Load Product Dimension
    INSERT INTO inventory_star.DimProduct (ProductCode, ProductName, ProductCategory)
    SELECT DISTINCT
        ISNULL(ProductCode, 'Unknown'),
        ISNULL(ProductName, 'Unknown Product'),
        'Carpet'
    FROM SorayiCarpets_DWH.landing.tbl_inventory_plant_trend;

    -- Load Business Unit Dimension
    INSERT INTO inventory_star.DimBusinessUnit (BusinessUnitCode, BusinessUnitName)
    SELECT DISTINCT
        ISNULL(WarehouseCode, 'Unknown'),
        ISNULL(WarehouseName, 'Unknown BU')
    FROM SorayiCarpets_DWH.landing.tbl_inventory_plant_trend;

    -- Load Fact Table
    INSERT INTO inventory_star.FactInventory (
        DateKey, PlantKey, ProductKey, BusinessUnitKey, QuantityOnHand, UnitCost, TotalValue, InventoryTurnover
    )
    SELECT 
        d.DateKey,
        p.PlantKey,
        pr.ProductKey,
        bu.BusinessUnitKey,
        i.QuantityOnHand,
        i.UnitValue,
        i.TotalValue,
        NULL
    FROM SorayiCarpets_DWH.landing.tbl_inventory_plant_trend i
    INNER JOIN inventory_star.DimDate d ON d.CalendarDate = i.InventoryDate
    INNER JOIN inventory_star.DimPlant p ON p.PlantCode = ISNULL(i.PlantCode, 'Unknown')
    INNER JOIN inventory_star.DimProduct pr ON pr.ProductCode = ISNULL(i.ProductCode, 'Unknown')
    INNER JOIN inventory_star.DimBusinessUnit bu ON bu.BusinessUnitCode = ISNULL(i.WarehouseCode, 'Unknown');

    PRINT 'Inventory Star Schema loaded.';
END;
