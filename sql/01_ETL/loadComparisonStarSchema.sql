USE SorayiCarpets_Star;
GO

ALTER PROCEDURE dbo.LoadComparisonStarSchema
AS
BEGIN
    SET NOCOUNT ON;

    -- Clear existing data
    TRUNCATE TABLE comparison_star.FactProductionComparison;
    DELETE FROM comparison_star.DimDate;
    DELETE FROM comparison_star.DimPlant;
    DELETE FROM comparison_star.DimProduct;
    DELETE FROM comparison_star.DimProductType;
    DELETE FROM comparison_star.DimBusinessUnit;
    DELETE FROM comparison_star.DimPeriod;

    -- Load Date Dimension
    INSERT INTO comparison_star.DimDate (DateKey, CalendarDate, Year, Month, Day, Quarter)
    SELECT DISTINCT
        CONVERT(INT, FORMAT(ProductionDate, 'yyyyMMdd')),
        CAST(ProductionDate AS DATE),
        YEAR(ProductionDate),
        MONTH(ProductionDate),
        DAY(ProductionDate),
        DATEPART(QUARTER, ProductionDate)
    FROM import.tbl_production_trend
    WHERE ProductionDate IS NOT NULL;

    -- Load Plant Dimension
    INSERT INTO comparison_star.DimPlant (PlantCode, PlantName)
    SELECT DISTINCT
        ISNULL(PlantCode, 'UNK'),
        ISNULL(PlantName, 'Unknown')
    FROM import.tbl_production_trend;

    -- Load Product Dimension
    INSERT INTO comparison_star.DimProduct (ProductCode, ProductName, ProductCategory, ProductType)
    SELECT DISTINCT
        ISNULL(ProductTypeCode, 'UNK'),
        ISNULL(ProductTypeName, 'Unknown'),
        'Standard',
        ISNULL(ProductTypeCode, 'UNK')
    FROM import.tbl_production_trend;

    -- Load Product Type Dimension
    INSERT INTO comparison_star.DimProductType (ProductTypeCode, ProductTypeName, ProductCategory, IsActive, EffectiveDate, EndDate)
    SELECT DISTINCT
        ISNULL(ProductTypeCode, 'UNK'),
        ISNULL(ProductTypeName, 'Unknown'),
        'Standard',
        1,
        GETDATE(),
        NULL
    FROM import.tbl_production_trend;

    -- Load Business Unit Dimension
    INSERT INTO comparison_star.DimBusinessUnit (BusinessUnitCode, BusinessUnitName, Department)
    SELECT DISTINCT
        ISNULL(BusinessUnitCode, 'UNK'),
        ISNULL(BusinessUnitName, 'Unknown'),
        'Operations'
    FROM import.tbl_production_trend;

    -- Load Period Dimension
    INSERT INTO comparison_star.DimPeriod (Year, Month, Quarter)
    SELECT DISTINCT
        YEAR(ProductionDate),
        MONTH(ProductionDate),
        DATEPART(QUARTER, ProductionDate)
    FROM import.tbl_production_trend;

    -- Load Fact Table
    INSERT INTO comparison_star.FactProductionComparison (
        DateKey, PlantKey, ProductKey, ProductTypeKey, BusinessUnitKey,
        CurrentYearProduction, PreviousYearProduction, YoYChange, YoYPercentChange
    )
    SELECT
        d.DateKey,
        p.PlantKey,
        pr.ProductKey,
        pt.ProductTypeKey,
        bu.BusinessUnitKey,
        TRY_CAST(f.PlannedProduction AS DECIMAL(18,2)),
        TRY_CAST(f.ActualProduction AS DECIMAL(18,2)),
        TRY_CAST(f.PlannedProduction - f.ActualProduction AS DECIMAL(18,2)),
        CASE 
            WHEN f.ActualProduction = 0 THEN NULL
            ELSE TRY_CAST((f.PlannedProduction - f.ActualProduction) * 100.0 / f.ActualProduction AS DECIMAL(5,2))
        END
    FROM import.tbl_production_trend f
    INNER JOIN comparison_star.DimDate d ON d.CalendarDate = f.ProductionDate
    INNER JOIN comparison_star.DimPlant p ON p.PlantCode = f.PlantCode
    INNER JOIN comparison_star.DimProduct pr ON pr.ProductCode = f.ProductTypeCode
    INNER JOIN comparison_star.DimProductType pt ON pt.ProductTypeCode = f.ProductTypeCode
    INNER JOIN comparison_star.DimBusinessUnit bu ON bu.BusinessUnitCode = f.BusinessUnitCode;

    PRINT 'Comparison Star Schema loaded successfully.';
END;
GO
