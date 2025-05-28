# SorayiCarpets Data Analytics - CS 360 Project

## 🏢 Business Context
Data analytics solution for SorayiCarpets, a carpet manufacturing company, focusing on inventory management and production analytics.

## 🏗️ Architecture Overview

### Databases:
- **SorayiCarpets**: Source system with Excel imports
- **SorayiCarpets_DWH**: Data warehouse with landing/archive schemas  
- **SorayiCarpets_Star**: Star schema with inventory/production/comparison schemas

## 📊 Key Metrics
- **3,104 inventory records** processed
- **5 source tables** + 2 Excel files
- **3 star schemas** (inventory, production, comparison); kindly note as per the requirements, the major focus was on inventory
- **Automated ETL orchestration** with error handling

## 🎯 CS 360 Requirements Compliance
- ✅ **Data Sources**: SQL Server + Excel files
- ✅ **Data Warehousing**: Complete DWH with landing/archive
- ✅ **Star Schema**: Multi-dimensional design with 3,104+ records
- ✅ **Visualization**: Power BI dashboards
- ✅ **Orchestration**: Automated ETL pipeline
- ✅ **Documentation**: Comprehensive SQL organization

## 🚀 Demo Instructions

### Quick Start:
1. **Setup**: Run scripts in `etl/` folder in order
2. **Demo**: Execute `presentation/demo_script.sql`
3. **Verify**: Check Power BI dashboard connectivity

### Expected Results:
- 3,104 records in inventory_star.FactInventory
- Real-time Power BI visualizations
- Complete ETL orchestration logs

## 📁 Project Structure
- 001: ETL --> ETL procedures and orchestration
- 002: Verification --> Testing and validation scripts
- 003: Data-sources --> Source data analysis
- 004: power BI --> Demo scripts for presentation

## 🎯 Key Features
- **Production-Ready**: Comprehensive error handling and logging
- **Scalable**: Modular ETL design for easy expansion
- **Real-Time**: Automated incremental loads
- **Professional**: Industry-standard data warehouse patterns

## 🛠️ Technology Stack
- **Database**: SQL Server 2019+
- **ETL**: T-SQL stored procedures
- **Orchestration**: Custom ETL pipeline
- **Visualization**: Power BI Desktop
- **Version Control**: GitHub
