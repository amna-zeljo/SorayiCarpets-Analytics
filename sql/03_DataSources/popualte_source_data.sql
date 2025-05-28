-- =====================================================
-- POPULATE SOURCE DATA - SorayiCarpets Database
-- Fix for empty source tables causing schema load issues
-- =====================================================

USE SorayiCarpets;
GO

-- Clear existing data first
DELETE FROM import.tbl_gl_calendar;
DELETE FROM import.tbl_inventory_plant_trend;
DELETE FROM import.tbl_production_trend;
DELETE FROM import.tbl_prod_cur_lst_yr_compar;
DELETE FROM import.tbl_sales_prod_calendar;
DELETE FROM import.tbl_kpi_summary;
DELETE FROM import.tbl_prod_budget_forecast;

-- 1. Calendar Data (Table 1 from SSMS)
INSERT INTO import.tbl_gl_calendar (CalendarDate, Year, Quarter, Month, MonthName, Week, DayOfWeek, DayName, IsHoliday, FiscalYear, FiscalQuarter, FiscalMonth)
VALUES 
('2024-01-01', 2024, 1, 1, 'January', 1, 2, 'Monday', 0, 2024, 1, 1),
('2024-01-02', 2024, 1, 1, 'January', 1, 3, 'Tuesday', 0, 2024, 1, 1),
('2024-01-03', 2024, 1, 1, 'January', 1, 4, 'Wednesday', 0, 2024, 1, 1),
('2024-01-04', 2024, 1, 1, 'January', 1, 5, 'Thursday', 0, 2024, 1, 1),
('2024-01-05', 2024, 1, 1, 'January', 1, 6, 'Friday', 0, 2024, 1, 1);

-- 2. Inventory Plant Trend (Table 2 from SSMS)
INSERT INTO import.tbl_inventory_plant_trend (PlantCode, PlantName, WarehouseCode, WarehouseName, InventoryDate, ProductCode, ProductName, QuantityOnHand, UnitValue, TotalValue)
VALUES 
('P001', 'Main Production Plant', 'W001', 'Main Warehouse', '2024-01-01', 'CARPET001', 'Persian Carpet Large', 50.00, 500.00, 25000.00),
('P001', 'Main Production Plant', 'W001', 'Main Warehouse', '2024-01-02', 'CARPET002', 'Modern Rug Medium', 75.00, 300.00, 22500.00),
('P002', 'Secondary Plant', 'W002', 'Secondary Warehouse', '2024-01-01', 'CARPET003', 'Traditional Runner', 100.00, 150.00, 15000.00),
('P002', 'Secondary Plant', 'W002', 'Secondary Warehouse', '2024-01-02', 'CARPET004', 'Luxury Persian', 25.00, 800.00, 20000.00),
('P001', 'Main Production Plant', 'W001', 'Main Warehouse', '2024-01-03', 'CARPET005', 'Contemporary Design', 60.00, 400.00, 24000.00);

-- 3. Production Trend (Table 3 from SSMS)
INSERT INTO import.tbl_production_trend (ProductionDate, PlantCode, PlantName, BusinessUnitCode, BusinessUnitName, ProductTypeCode, ProductTypeName, PlannedProduction, ActualProduction, ProductionEfficiency)
VALUES 
('2024-01-01', 'P001', 'Main Production Plant', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 100.00, 95.00, 95.0),
('2024-01-02', 'P001', 'Main Production Plant', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 110.00, 108.00, 98.2),
('2024-01-03', 'P001', 'Main Production Plant', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 105.00, 102.00, 97.1),
('2024-01-01', 'P002', 'Secondary Plant', 'BU002', 'Rug Production', 'PT002', 'Modern Rugs', 80.00, 82.00, 102.5),
('2024-01-02', 'P002', 'Secondary Plant', 'BU002', 'Rug Production', 'PT002', 'Modern Rugs', 85.00, 87.00, 102.4);

-- 4. Production Current vs Last Year Comparison (Table 4 from SSMS)
INSERT INTO import.tbl_prod_cur_lst_yr_compar (ComparisonDate, BusinessUnitCode, BusinessUnitName, ProductTypeCode, ProductTypeName, CurrentYearProduction, PreviousYearProduction, YoYChange)
VALUES 
('2024-01-01', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 95.00, 85.00, 11.76),
('2024-01-02', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 108.00, 92.00, 17.39),
('2024-01-03', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 102.00, 88.00, 15.91),
('2024-01-01', 'BU002', 'Rug Production', 'PT002', 'Modern Rugs', 82.00, 78.00, 5.13),
('2024-01-02', 'BU002', 'Rug Production', 'PT002', 'Modern Rugs', 87.00, 81.00, 7.41);

-- 5. Sales Production Calendar (Table 5 from SSMS)
INSERT INTO import.tbl_sales_prod_calendar (CalendarDate, BusinessUnitCode, BusinessUnitName, ProductTypeCode, ProductTypeName, PlannedProduction, ActualProduction, PlannedSales, ActualSales)
VALUES 
('2024-01-01', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 100.00, 95.00, 90.00, 88.00),
('2024-01-02', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 110.00, 108.00, 100.00, 102.00),
('2024-01-03', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 105.00, 102.00, 95.00, 97.00),
('2024-01-01', 'BU002', 'Rug Production', 'PT002', 'Modern Rugs', 80.00, 82.00, 75.00, 79.00),
('2024-01-02', 'BU002', 'Rug Production', 'PT002', 'Modern Rugs', 85.00, 87.00, 80.00, 83.00);

-- 6. KPI Summary (Excel File 1)
INSERT INTO import.tbl_kpi_summary (KPIDate, KPIName, KPIValue, KPITarget, KPIStatus, BusinessUnitCode)
VALUES 
('2024-01-01', 'Production Efficiency', 95.0, 90.0, 'Above Target', 'BU001'),
('2024-01-01', 'Inventory Turnover', 4.2, 4.0, 'Above Target', 'BU001'),
('2024-01-02', 'Production Efficiency', 98.2, 90.0, 'Above Target', 'BU001'),
('2024-01-02', 'Quality Score', 92.5, 85.0, 'Above Target', 'BU001'),
('2024-01-01', 'Production Efficiency', 102.5, 90.0, 'Above Target', 'BU002');

-- 7. Production Budget Forecast (Excel File 2)
INSERT INTO import.tbl_prod_budget_forecast (ForecastDate, BusinessUnitCode, BusinessUnitName, ProductTypeCode, ProductTypeName, BudgetAmount, ForecastAmount, ActualAmount)
VALUES 
('2024-01-01', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 50000.00, 48000.00, 47500.00),
('2024-01-02', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 55000.00, 54000.00, 54200.00),
('2024-01-03', 'BU001', 'Carpet Manufacturing', 'PT001', 'Persian Carpets', 52500.00, 51000.00, 51100.00),
('2024-01-01', 'BU002', 'Rug Production', 'PT002', 'Modern Rugs', 40000.00, 41000.00, 41200.00),
('2024-01-02', 'BU002', 'Rug Production', 'PT002', 'Modern Rugs', 42500.00, 43500.00, 43700.00);

PRINT 'Source data populated successfully!';
PRINT 'Tables populated: 5 SSMS tables + 2 Excel imports';