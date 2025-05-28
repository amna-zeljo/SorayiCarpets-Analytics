USE SorayiCarpets_Star;
GO

ALTER PROCEDURE dbo.LoadProductionStarSchema
AS
BEGIN
    SET NOCOUNT ON;

    -- Clear existing data
    TRUNCATE TABLE production_star.FactProduction;
    DELETE FROM production_star.DimDate;
    DELETE FROM production_star.DimPlant;
    DELETE FROM production_star.DimProduct;
    DELETE FROM production_star.DimBusinessUnit;

    -- Load DimDate
    INSERT INTO production_star.DimDate (DateKey, CalendarDate, Year, Month, Day, Quarter)
    SELECT DISTINCT
        CONVERT(INT, FORMAT(ProductionDate, 'yyyyMMdd')) AS DateKey,
        CAST(ProductionDate AS DATE),
        YEAR(ProductionDate),
        MONTH(ProductionDate),
        DAY(ProductionDate),
        DATEPART(QUARTER, ProductionDate)
    FROM import.tbl_production_trend
    WHERE ProductionDate IS NOT NULL;

    -- Load DimPlant
    INSERT INTO production_star.DimPlant (PlantCode, PlantName)
    SELECT DISTINCT
        ISNULL(PlantCode, 'Unknown'),
        ISNULL(PlantName, 'Unknown')
    FROM import.tbl_production_trend;

    -- Load DimProduct
    INSERT INTO production_star.DimProduct (ProductCode, ProductName, ProductCategory, ProductType)
    SELECT DISTINCT
        ISNULL(ProductTypeCode, 'UNKNOWN'),
        ISNULL(ProductTypeName, 'Unknown'),
        'Standard',
        ISNULL(ProductTypeName, 'Unknown')
    FROM import.tbl_production_trend;

    -- Load DimBusinessUnit
    INSERT INTO production_star.DimBusinessUnit (BusinessUnitCode, BusinessUnitName)
    SELECT DISTINCT
        ISNULL(BusinessUnitCode, 'UNK'),
        ISNULL(BusinessUnitName, 'Unknown')
    FROM import.tbl_production_trend;

    -- Load FactProduction
    INSERT INTO production_star.FactProduction (
        DateKey, PlantKey, ProductKey, BusinessUnitKey,
        ProductionQuantity, ProductionCost, ProductionEfficiency, QualityScore
    )
    SELECT
        d.DateKey,
        p.PlantKey,
        pr.ProductKey,
        bu.BusinessUnitKey,
        TRY_CAST(f.PlannedProduction AS DECIMAL(18,2)),
        TRY_CAST(f.ProductionCost AS DECIMAL(18,2)),
        TRY_CAST(f.ProductionEfficiency AS DECIMAL(18,2)),
        NULL
    FROM import.tbl_production_trend f
    INNER JOIN production_star.DimDate d ON d.CalendarDate = f.ProductionDate
    INNER JOIN production_star.DimPlant p ON p.PlantCode = f.PlantCode
    INNER JOIN production_star.DimProduct pr ON pr.ProductCode = f.ProductTypeCode
    INNER JOIN production_star.DimBusinessUnit bu ON bu.BusinessUnitCode = f.BusinessUnitCode;

    PRINT 'Production Star Schema loaded successfully.';
END;
GO
