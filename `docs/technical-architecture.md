# SorayiCarpets Business Intelligence System: Technical Documentation
## 1. Executive Summary
This document provides comprehensive technical documentation for the SorayiCarpets Business Intelligence System, developed as part of the CS 360 Data Analytics course project. **For the scope of this project, the implementation focuses primarily on inventory analytics**, demonstrating a complete BI solution from operational data sources through to executive dashboards.
The system implements an enterprise-grade Business Intelligence architecture supporting inventory management analytics for a carpet manufacturing organization.


## 2. Business Intelligence Architecture
### 2.1 BI Architecture Overview
The SorayiCarpets BI System employs a traditional three-layer BI architecture following Kimball's bottom-up approach to data warehousing. This architecture implements the classic BI stack: **Operational Source Systems → Data Warehouse → Data Marts → BI Presentation Layer**.

### 2.2 BI Technology Stack
**Data Integration Layer:**
- Extract-Transform-Load (ETL) processes using T-SQL
- Data staging and cleansing procedures
- Incremental and full refresh capabilities

**Data Storage Layer:**
- Operational Data Store (ODS): SorayiCarpets
- Enterprise Data Warehouse (EDW): SorayiCarpets_DWH
- Data Marts: SorayiCarpets_Star (dimensional models)

**BI Presentation Layer:**
- Self-service analytics: Power BI Desktop
- Interactive dashboards and reports
- OLAP capabilities through star schema

### 2.3 Data Flow Architecture
OLTP Systems → Staging Area → Data Warehouse → Data Marts → BI Tools → End Users
**Primary Focus: Inventory Analytics** - While the architecture supports multiple business domains (production, sales, comparison), this implementation concentrates on inventory management as the primary use case.


## 3. Data Warehouse Design
### 3.1 Operational Data Store (SorayiCarpets)
#### 3.1.1 Source System Integration
The ODS integrates heterogeneous data sources as required for enterprise BI:
- **Structured Data**: Relational database tables
- **Semi-structured Data**: Excel file imports (evidenced by `$` suffix tables)

#### 3.1.2 Master Data Management
Key master data entities include:
- Plant master data
- Product master data
- Calendar/time master data
- Organizational hierarchy data

### 3.2 Enterprise Data Warehouse (SorayiCarpets_DWH)
#### 3.2.1 Data Warehouse Layers
Following Kimball's staging approach:
**Staging Layer (`landing` schema):**
- Temporary storage for ETL processing
- Data validation and cleansing
- Change data capture preparation

**Archive Layer (`archive` schema):**
- Historical data preservation
- Audit trail maintenance
- Data lineage tracking

**Integration Layer (`dbo` schema):**
- ETL orchestration procedures
- Data quality monitoring
- Process metadata management

#### 3.2.2 Data Warehouse Metadata
The `ETLLoadLog` table implements comprehensive ETL metadata tracking:
- Process execution lineage
- Data quality metrics
- Performance monitoring
- Error handling and recovery

### 3.3 Data Marts (SorayiCarpets_Star)
#### 3.3.1 Dimensional Modeling Approach
The data marts implement Kimball's dimensional modeling methodology with **inventory analytics as the primary focus**:
**Inventory Data Mart (`inventory_star`):**
- **Fact Table**: `FactInventory` - Contains inventory KPIs and metrics
- **Dimension Tables**: Time, Plant, Product, Warehouse, Business Unit
- **Grain**: Daily inventory snapshot by plant, product, and warehouse

**Supporting Data Marts:**
- production_star: Production analytics (supporting inventory analysis)
- comparison_star: Year-over-year trending (supporting inventory forecasting)

#### 3.3.2 Inventory Star Schema Design
**Fact Table Metrics:**
- Quantity on Hand (inventory levels)
- Unit Cost (inventory valuation)
- Total Value (extended inventory value)
- Inventory Turnover (inventory efficiency KPI)

**Dimensional Attributes:**
- **Date Dimension**: Calendar hierarchy for temporal analysis
- **Plant Dimension**: Manufacturing facility attributes
- **Product Dimension**: Product categorization and hierarchy
- **Warehouse Dimension**: Storage location attributes
- **Business Unit Dimension**: Organizational structure


## 4. Business Intelligence ETL Processes
### 4.1 ETL Methodology
The BI system implements an **ELT (Extract-Load-Transform)** approach optimized for modern data warehouse platforms:
1. **Extract**: Data extraction from operational systems
2. **Load**: Bulk loading into staging areas
3. **Transform**: In-database transformation using SQL

### 4.2 Data Integration Patterns
#### 4.2.1 Initial Load (Full Refresh)
- Complete data warehouse population
- Dimension table initialization
- Fact table historical loading
- **Primary Focus**: Inventory historical data establishment

#### 4.2.2 Incremental Load (Delta Processing)
- Change data capture from source systems
- Slowly Changing Dimension (SCD) processing
- Incremental fact table updates
- **Primary Focus**: Daily inventory position updates

### 4.3 Data Quality Framework
**Data Profiling**: Source system analysis and validation
**Data Cleansing**: Null handling and standardization
**Data Validation**: Business rule enforcement
**Data Monitoring**: Ongoing quality assessment

## 5. BI Orchestration and Workflow Management
### 5.1 ETL Orchestration Framework
The BI system implements **procedural orchestration** using database-native capabilities:

**Master Orchestration Process:**
- Centralized workflow control
- Dependency management
- Error handling and recovery
- Performance monitoring

**Inventory-Focused Orchestration:**
Given the project's inventory focus, the orchestration prioritizes:
1. Inventory data extraction and validation
2. Inventory dimension processing
3. Inventory fact table population
4. Inventory KPI calculation

### 5.2 Scheduling and Automation
**Batch Processing Windows:**
- Daily full refresh capability
- Intraday incremental updates
- Real-time inventory position updates

**Monitoring and Alerting:**
- ETL process monitoring
- Data quality alerts
- Performance threshold monitoring


## 6. Business Intelligence Presentation Layer
### 6.1 OLAP and Analytics
**Star Schema Benefits:**
- Optimized for analytical queries
- Dimensional filtering and slicing
- Hierarchical drill-down capabilities
- Aggregation performance

**Inventory Analytics Focus:**
- Inventory levels by plant and product
- Inventory turnover analysis
- Stock-out risk assessment
- Inventory valuation reporting

### 6.2 Self-Service BI
**Power BI Implementation:**
- Interactive dashboards
- Ad-hoc query capabilities
- Mobile BI access
- Collaborative analytics

**Key Performance Indicators (KPIs):**
- Inventory turnover ratio
- Days sales outstanding
- Stock-out frequency
- Inventory accuracy


## 7. Implementation Scope and Focus
### 7.1 Project Scope Definition
**Primary Focus: Inventory Analytics**
This CS 360 project implementation concentrates on inventory management as the primary business domain, while establishing the architectural foundation for enterprise-wide BI expansion.

**Inventory Use Cases Implemented:**
- Daily inventory position reporting
- Plant-level inventory analysis
- Product-level inventory tracking
- Historical inventory trending

**Future Expansion Capability:**
The architecture supports extension to additional business domains including production analytics, sales performance, and financial reporting.

### 7.2 Business Value Delivered
**Inventory Management Benefits:**
- Real-time inventory visibility
- Data-driven inventory optimization
- Improved inventory accuracy
- Enhanced decision-making capabilities


## 8. Technical Implementation Details
### 8.1 Database Design Patterns
**Dimensional Modeling:**
- Conformed dimensions across data marts
- Slowly Changing Dimension implementation
- Surrogate key management
- Business key preservation

**Performance Optimization:**
- Appropriate indexing strategies
- Partitioning for large fact tables
- Query optimization techniques
- Aggregation strategies

### 8.2 Data Governance
**Data Lineage:** Complete traceability from source to presentation
**Data Security:** Role-based access control implementation
**Data Retention:** Archive and purge policies
**Change Management:** Version control and deployment procedures


## 9. Conclusion
The SorayiCarpets Business Intelligence System demonstrates a comprehensive implementation of modern BI architecture and methodologies. **With its primary focus on inventory analytics**, the system provides a solid foundation for data-driven decision making in inventory management while establishing the technical infrastructure for enterprise-wide BI expansion.
The implementation successfully addresses all CS 360 project requirements while delivering a production-ready BI solution that follows industry best practices in data warehousing, dimensional modeling, and business intelligence.


## 10. References
1. Kimball, R., & Ross, M. (2013). *The Data Warehouse Toolkit: The Definitive Guide to Dimensional Modeling* (3rd ed.). Wiley.
2. Inmon, W. H. (2005). *Building the Data Warehouse* (4th ed.). Wiley.
3. Turban, E., Sharda, R., & Delen, D. (2014). *Business Intelligence and Analytics: Systems for Decision Support* (10th ed.). Pearson.
4. Microsoft. (2023). *Power BI Documentation*. [https://docs.microsoft.com/en-us/power-bi/](https://docs.microsoft.com/en-us/power-bi/)
