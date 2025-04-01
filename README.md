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


SQL was utilized to clean the 

### 1. Handling Missing Values

- **NULL Value Detection**  
  To identify missing values, the following method was used:
  ```sql
  COUNT(*) - COUNT(column_name)
  ```
  This gives the number of `NULL` entries in each column.

- **Empty String Detection**  
  To detect non-null but empty fields (e.g., `' '`), the following logic was used:
  ```sql
  LTRIM(RTRIM(column_name)) = ''
  ```

---

### 2. Detecting Duplicates

- Duplicate detection was done by grouping over key identifying columns and checking for multiple occurrences:
  ```sql
  GROUP BY column_1, column_2, ...
  HAVING COUNT(*) > 1
  ```
- Example for `amenities`:
  ```sql
  GROUP BY unified_id, month, hot_tub, pool
  HAVING COUNT(*) > 1
  ```

- In some cases, duplicates were confirmed using:
  ```sql
  IF EXISTS (...) BEGIN SELECT ... END ELSE SELECT 'No Duplicates'
  ```

---

### 3. Standardizing Identifiers

- **Removed Prefixes**  
  Removed text identifiers (e.g., `'AIR'`) from the `unified_id` field:
  ```sql
  REPLACE(unified_id, 'AIR', '')
  ```

- **Converted to Integer**  
  Converted the cleaned `unified_id` values to integer:
  ```sql
  CAST(unified_id AS INT)
  ```

---

### 4. Date Standardization

- Transformed `month` column (in `'YYYY-MM'` format) into proper SQL `DATE` values by appending `-01`:
  ```sql
  CAST(month + '-01' AS DATE) AS month_date
  ```

---

### 5. Data Type Conversions

- **String to Numeric**  
  Converted columns with numeric content stored as strings into appropriate types (e.g., `INT`, `FLOAT`):
  ```sql
  CAST(column_name AS INT)
  CAST(column_name AS FLOAT)
  ```

- **Removing Commas for Decimal Conversion**  
  Where numeric strings contained commas (e.g., `'1,000.00'`), they were first cleaned:
  ```sql
  REPLACE(column_name, ',', '.')
  CAST(...) AS FLOAT
  ```

- **Columns Converted Include**:
  - `revenue` → `revenue_float`
  - `occupancy` → `occupancy_float`
  - `nightly rate` → `nightly_rate_float`
  - `lead time` → `lead_time_float`
  - `length stay` → `length_stay_float`
  - `bedrooms` → `bedrooms_int`
  - `bathrooms` → `bathrooms_float`

---
