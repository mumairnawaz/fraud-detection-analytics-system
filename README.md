# 💳 Fraud Detection & Risk Monitoring System (SQL Server + Power BI)

## Table of Contents

- [Problem](#problem)
- [Solution Overview](#solution-overview)
- [Technical Implementation](#technical-implementation)
- [Data Pipeline Architecture](#data-pipeline-architecture)
- [Analytics & Dashboard](#analytics--dashboard)
- [Business Impact](#business-impact)

---

<table width="90%" align="center">
<tr><td>

# Problem

A fintech system was processing transaction data through raw CSV files without any structured pipeline or reporting layer.

This created multiple technical and business issues:

- No centralized fraud detection system  
- Manual analysis of transactions  
- No real-time visibility into fraud patterns  
- Data inconsistencies (duplicates, missing values, invalid records)  
- Delayed fraud detection increasing financial risk  

The system was reactive rather than proactive, making it difficult to identify and prevent fraudulent transactions efficiently.

</td></tr>
</table>

---


<table width="90%" align="center">
<tr><td>

# Solution Overview

To address these challenges, an end-to-end fraud detection analytics system was developed using SQL Server and Power BI.

The solution focuses on:

- Structuring raw data into a reliable database  
- Automating data cleaning and validation  
- Enabling real-time analytics using DirectQuery  
- Building an interactive dashboard for fraud monitoring  

This transformed the workflow from manual analysis to an automated, data-driven system.

</td></tr>
</table>

---


<table width="90%" align="center">
<tr><td>

# Technical Implementation

The system was implemented in multiple stages:

### 1. Data Ingestion
- Imported transaction data from CSV into SQL Server  
- Created structured schema for transaction storage  

### 2. Data Cleaning & Validation (SQL Server)
- Removed duplicate transactions using window functions  
- Handled missing values using median and mode strategies  
- Standardized categorical fields (card type, merchant category, etc.)  
- Validated fraud flags and transaction values  

### 3. Query Optimization
- Applied indexing and partitioning for performance  
- Optimized queries for large transaction volumes  

### 4. Real-Time Integration (Power BI)
- Connected SQL Server using DirectQuery  
- Enabled real-time data refresh without duplication  
- Built DAX-based KPIs for fraud analysis
  

</td></tr>
</table>


---


<table width="90%" align="center">
<tr><td>

# Data Pipeline Architecture

The system follows a structured ETL pipeline:

Raw CSV Data → SQL Server (Cleaning & ETL) → Power BI Dashboard → Real-Time Fraud Monitoring

<p align="center">
  <img src="images/etl%20flow.png" width="92%">
</p>

</td></tr>
</table>

---

<table width="90%" align="center">
<tr><td>

# Analytics & Dashboard

The Power BI dashboard provides real-time fraud insights:

- Total transactions analyzed: **50,000+**  
- Fraudulent transactions: **1,021 (~2.04%)**  
- Fraud amount: **5.12M**  

Key analytical views:

- Fraud trends over time  
- Fraud distribution by merchant and country  
- Transaction behavior across device and mode  

<p align="center">
  <img src="images/Fraud%20Detection.png" width="92%">
</p>

<p align="center">
  <img src="images/dashboard_details.png" width="92%">
</p>

</td></tr>
</table>

---

<table width="90%" align="center">
<tr><td>

# Business Impact

The implemented system significantly improved fraud detection capabilities:

- Enabled real-time fraud monitoring (eliminating manual delays)  
- Improved data accuracy through automated cleaning and validation  
- Increased visibility into high-risk transactions and patterns  
- Supported faster and more informed decision-making  

This transformed the system from:

Reactive fraud detection → Proactive risk monitoring

</td></tr>
</table>
