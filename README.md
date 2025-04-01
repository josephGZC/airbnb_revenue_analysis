# Airbnb Revenue Analysis

<div align="center">
  <img src="https://github.com/user-attachments/assets/ae38f348-6374-41de-beb0-deae7fa472ca" width="100%">
</div>

---

### Table of Contents 

[1. Background](#project-background) <br>
[2. Executive Summary](#executive-summary) <br>
[3. Dataset Overivew](#dataset-overview) <br>
[4. Data Cleaning and Preprocessing](#data-cleaning) <br>
[5. Insights Deep-Dive](#insights-deep-dive) <br>

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
  
- **Data Type Conversion**
  - Numeric content stored as strings was converted into appropriate types such as `INT` or `FLOAT` using `CAST(column_name AS INT)` or `CAST(column_name AS FLOAT)` to ensure accurate computation and analysis.
  - For columns containing numeric strings with commas (e.g., `'1,000.00'`), the commas were removed using `REPLACE(column_name, ',', '.')` before casting the values to `FLOAT` for proper decimal interpretation.

## 5. Insights Deep-Dive <a name="insights-deep-dive"></a>
<a href="#toc">[ back to contents ]</a>

### 5.1. Revenue and Operations Overview

- Over the past four years, the total revenue has amounted to $783.7M, with the current year generating $245M—3.3% lower than the previous year. In terms of average revenue, the past four-year average stands at $5.35K, while the current year's average has dropped to $5K, representing a 20.6% decline compared to the previous year.

- Over the past four years, there have been a total of 146.5K bookings, with the current year accounting for 47K—a 22% increase from the previous year. Similarly, total listings over this period reached 7.4K, with the current year contributing 5K listings, marking an 18.2% increase from the previous year.
  
- Despite increases in the number of bookings and listings, both total and average revenue are declining. This warrants further investigation.
<div align="center">
  <img src="https://github.com/user-attachments/assets/86daa387-edc9-4d10-9d94-67973962f505" width="85%">
  <img src="https://github.com/user-attachments/assets/7e53d3b0-70ec-4514-8a62-862335fe1b31" width="85%">
</div> 


### 5.2. Time Trends

- For Revenue and Average Revenue, a noticeable dip occurs in the 2nd quarter, followed by a gradual increase from the 3rd quarter until the 1st quarter of the subsequent year.
- Regarding Bookings and Listings, an upward curve is evident over the quarters, although a significant dip is observed around Q2 2020, which is likely attributable to the drastic reduction in visitor numbers caused by COVID-19.
<table cellspacing="0" cellpadding="0">
  <tr>
    <td style="border: 1px solid white; padding: 5px 5px 2px 5px;">
      <img src="https://github.com/user-attachments/assets/0d5f1164-938d-4a3f-ac13-d83f6e41c001" width="100%">
    </td>
    <td style="border: 1px solid white; padding: 5px 5px 2px 5px;">
      <img src="https://github.com/user-attachments/assets/495202a0-d7ad-4427-95ad-cbaf1f40b0ff" width="100%">
    </td>
  </tr>
  <tr>
    <td style="border: 1px solid white; padding: 2px 5px 5px 5px;">
      <img src="https://github.com/user-attachments/assets/5d538035-fd0a-45c8-9e88-0340f9af16fb" width="100%">
    </td>
    <td style="border: 1px solid white; padding: 2px 5px 5px 5px;">
      <img src="https://github.com/user-attachments/assets/09e3d93d-393a-4241-a635-77166a433460" width="100%">
    </td>
  </tr>
</table>

### 5.3. City and Street Breakdown

- Big Bear Lake City is the dominant revenue driver, accounting for 58.5% of total revenue, and the top 5 revenue streets are all located within this city.

- In terms of average revenue, the distribution among cities is more balanced, ranging between 19% and 28%, with Cholla Avenue in Yuca Valley emerging as the leader in average revenue.

- While Big Bear Lake City drives overall revenue, the analysis of average revenue reveals performance differences across streets and cities, suggesting that specific high-performing streets, such as those in Yuca Valley, may be key targets for further investigation.

<div align="center">
  <img src="https://github.com/user-attachments/assets/b6f6071b-cfa4-4fe2-a548-d07f7c810a97" width="60%">
  <img src="https://github.com/user-attachments/assets/656883ae-2744-4180-8d82-f823f2487651" width="60%">
</div> 


### 5.4. Host Type and Nightly Rates

- Professional hosts lead with 62% of listings, followed by single owners who contribute 21.2%, while hosts with 2-5 units account for 16%.

- From 2019 to 2021, there was an overall increase in quarterly nightly rates across all host types; however, a decrease in nightly rates is observed in 2022 across all quarters.

- Based on the specific percent decrease values, nightly rates could be strategically raised by approximately 14% or more in Q2, 17% or more in Q3, and 14% or more in Q4 to recover lost revenue.

| Quarter | Professionals | 2–5 Units | Single Owners |
|---------|---------------|-----------|----------------|
| Q1      | 2.526         |           |                |
| Q2      | 13.499        | 13.622    | 13.609         |
| Q3      | 16.992        | 16.575    | 17.957         |
| Q4      | 14.471        | 14.223    | 12.085         |

## 6. Recommendations
Optimize Nightly Rates Based on Seasonal Trends
Address the revenue decline by implementing targeted rate increases of approximately 14–17% in Q2–Q4, especially for professional hosts. This pricing adjustment aligns with historical drops and can help recover lost revenue without discouraging bookings, given the concurrent rise in transactions and listings.
Leverage High-Performing Locations to Guide Growth
Use insights from Big Bear Lake City and Cholla Avenue in Yuca Valley—the top contributors to total and average revenue—as benchmarks. Identify common features and strategies in these areas and replicate them in underperforming cities and streets to boost overall platform revenue.




