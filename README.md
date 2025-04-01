# Airbnb Revenue Analysis

---

### Table of Contents 

[1. Background](#project-background) <br>
[2. Executive Summary](#executive-summary) <br>
[3. Dataset Overivew](#dataset-overview) <br>
[4. Data Cleaning and Preprocessing](#data-cleaning) <br>
[5. Sentiment Analysis Approach](#sentiment-analysis) <br>
[6. Insights Deep-Dive](#insights-deep-dive) <br>

---

## 1. Project Background <a name="project-background"></a>  
<a href="#toc">[ back to contents ]</a>

<p align="justify"> 
Airbnb, the world’s leading online marketplace for short-term rentals and unique travel experiences, has transformed how people travel and engage with local communities. This project aims to explore key operational trends—such as revenue patterns, transaction volume, and geographic performance—over a four-year period (2019–2022) to identify opportunities for growth and optimization. By examining quarterly fluctuations, city and street-level distributions, and host type behaviors, the study seeks to uncover actionable insights that can help improve revenue outcomes across the platform.
</p>

## 2. Executive Summary <a name="executive-summary"></a>  
<a href="#toc">[ back to contents ]</a>

<p align="justify"> 
This analysis examines Airbnb’s operational performance from 2019 to 2022, with the goal of identifying trends and insights that can drive revenue growth. Despite an encouraging rise in both transactions and listings in the most recent year, a concerning decline in total and average revenue was observed. The study investigates this discrepancy by analyzing seasonal patterns, geographic contributions at the city and street levels, and variations across host types. Key findings reveal that nightly rates have dropped significantly in Q2–Q4 of 2022, especially among professional hosts, likely contributing to the revenue decline. Additionally, while Big Bear Lake City generates the highest total revenue, average revenue is more evenly distributed across cities, with Cholla Avenue in Yuca Valley emerging as a top performer. Based on these insights, two strategic recommendations are proposed: implement targeted seasonal rate increases to recover lost revenue and replicate successful practices from high-performing locations to improve revenue across underperforming areas.
</p>

## 3. Data Overview <a name="dataset-overview"></a>  
<a href="#toc">[ back to contents ]</a>


## 4. Data Cleaning & Preprocessing <a name="data-cleaning"></a>  
<a href="#toc">[ back to contents ]</a>

SQL was utilized for cleaning and processing, ensuring the data was complete, consistent, and analysis-ready.

- **Seaching for Duplicate and Missing Values**
  - To identify duplicates, the query groups rows based on key fields and uses `HAVING COUNT(*) > 1` to detect repeated combinations—none were found in this case. 
  - Missing values were identified by comparing the total row count to the count of non-null entries using `COUNT(*) - COUNT(column_name)`. Additionally, empty string values were detected using `LTRIM(RTRIM(column_name)) = ''` to flag fields that appeared filled but contained no meaningful data. No essential columns had missing values that required further cleaning or corrective action.

- **Data Standardization**
  - Text identifiers such as 'AIR' were removed from the `unified_id` field 
  - The `month` column, originally in 'YYYY-MM' string format, was converted into a proper SQL DATE by appending '-01'
  
- **Data Type Conversions**
  - Numeric content stored as strings was converted into appropriate types such as `INT` or `FLOAT` using `CAST(column_name AS INT)` or `CAST(column_name AS FLOAT)` to ensure accurate computation and analysis.
  - For columns containing numeric strings with commas (e.g., `'1,000.00'`), the commas were removed using `REPLACE(column_name, ',', '.')` before casting the values to `FLOAT` for proper decimal interpretation.

---
