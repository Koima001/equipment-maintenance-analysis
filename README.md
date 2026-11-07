# Equipment Maintenance Analysis

## Project Overview

This project analyses equipment maintenance work orders to explore maintenance operations, equipment performance, downtime, labour utilisation, and maintenance costs.

The project demonstrates the use of **Excel, SQL, and Power BI** in preparing, analysing, and visualising equipment maintenance data. It aims to transform raw maintenance records into meaningful insights that can support maintenance planning, operational monitoring, and decision-making.

## Tools and Technologies

- **Excel:** Dataset inspection and preliminary data handling.
- **SQL (MySQL):** Data cleaning, validation, transformation, and querying.
- **Power BI:** Data visualisation, dashboard development, and reporting.

## Project Workflow

### 1. Data Preparation and Cleaning

The equipment maintenance dataset was inspected and cleaned using SQL.

The cleaning process included:

- Identification and removal of duplicate records.
- Identification of missing values.
- Conversion of blank `Closed Date` values to `NULL`.
- Conversion of blank `Technician ID` values to `NULL`.
- Validation of the cleaned dataset.

The cleaning assessment identified and removed **4 duplicate records**. Additionally, **251 blank Closed Date values** and **12 blank Technician ID values** were converted to `NULL`.

The equipment register was also inspected and did not require cleaning.

### 2. Data Analysis

SQL was used to query and analyse the maintenance data, supporting the examination of work orders, maintenance activities, equipment-related information, and operational performance.

### 3. Power BI Dashboards

Two interactive dashboards were developed:

**Dashboard 1: Maintenance Operations Analysis**

Focuses on maintenance operations, including:
- Work orders by site and priority.
- Labour hours by criticality.
- Total downtime by failure mode.

**Dashboard 2: Maintenance Cost Analysis**

Focuses on the cost dimension of equipment maintenance, providing a visual overview of maintenance expenditure.

## Repository Structure


*The repository structure may be adjusted to match the final uploaded file names and formats.*

## Key Data Quality Findings

| Cleaning Activity | Records |
|---|---:|
| Duplicate records identified and removed | 4 |
| Blank Closed Date values converted to NULL | 251 |
| Blank Technician ID values converted to NULL | 12 |

**Note:** Converting blank values to `NULL` preserves the missing-data status rather than replacing the missing information with assumed values.

## Project Outcomes

The project demonstrates the ability to:

- Inspect and prepare operational datasets.
- Identify and address data quality issues using SQL.
- Work with related maintenance datasets.
- Develop SQL queries for data analysis.
- Build interactive Power BI dashboards.
- Present operational and cost information through data visualisations.

## Conclusion

This project demonstrates an end-to-end data analysis workflow, from raw data inspection and SQL-based cleaning to interactive Power BI reporting. The resulting dashboards provide an accessible way to explore equipment maintenance operations and costs.

---

**Author:** Purity Koima  
**Project Area:** Business Analytics | Equipment Maintenance Analysis
