
-- ...................................................................
-- ...................... [1] EXPLORE TABLES .........................
-- ...................................................................

-- ===================================================================
-- [1.1] EXPLORE TABLE: amenities
-- ===================================================================

----------------------------------------------------------------------
-- [1.1.1] Inspect data type
----------------------------------------------------------------------
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'amenities'

----------------------------------------------------------------------
-- [1.1.2] View first few rows
----------------------------------------------------------------------
SELECT * 
FROM dbo.amenities;
-- ORDER BY month ASC;

----------------------------------------------------------------------
-- [1.1.3] Count total rows 
----------------------------------------------------------------------
SELECT COUNT(*) as row_count
FROM dbo.amenities;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT unified_id) AS distinct_ids,
    COUNT(DISTINCT CAST(unified_id AS VARCHAR) + '_' + CAST(month AS VARCHAR)) AS distinct_id_month_combos
FROM amenities;

-- distinct_id_month_combos concatenates each row’s unified_id and month_date like:
-- unified_id	month_date	Combined String
-- 101	2024-01-01	101_2024-01-01
-- 101	2024-01-01	101_2024-01-01
-- 102	2024-01-01	102_2024-01-01
-- 101	2024-02-01	101_2024-02-01

-- Now if we count distinct combinations, we get:
-- 101_2024-01-01
-- 102_2024-01-01
-- 101_2024-02-01
-- 103_2024-01-01

----------------------------------------------------------------------
-- [1.1.4] Count number of missing
----------------------------------------------------------------------
-- LOOK FOR NULL VALUES
-- COUNT(*) counts all rows
-- COUNT(column_type) counts only NON-NULL values
SELECT 
	COUNT(*) - COUNT(unified_id) AS missing_unified_id,
	COUNT(*) - COUNT(month) AS missing_month,
	COUNT(*) - COUNT(hot_tub) AS missing_hot_tub,
	COUNT(*) - COUNT(pool) AS missing_pool
FROM dbo.amenities;

-- LTRIM(string) | Left Trim – removes leading spaces
-- RTRIM(string) | Right Trim – removes trailing spaces
-- LTRIM(RTRIM(string))	| Trims both sides (leading & trailing)
SELECT 
    SUM(CASE WHEN LTRIM(RTRIM(unified_id)) = '' THEN 1 ELSE 0 END) AS empty_unified_id,
    SUM(CASE WHEN LTRIM(RTRIM(month)) = '' THEN 1 ELSE 0 END) AS empty_month,
	SUM(CASE WHEN LTRIM(RTRIM(hot_tub)) = '' THEN 1 ELSE 0 END) as empty_hot_tub,
	SUM(CASE WHEN LTRIM(RTRIM(pool)) = '' THEN 1 ELSE 0 END) as empty_pool
FROM dbo.amenities;

----------------------------------------------------------------------
-- [1.1.5] Count number of duplicates
----------------------------------------------------------------------
IF EXISTS (
    SELECT 1
    FROM amenities
    GROUP BY unified_id, month, hot_tub, pool
    HAVING COUNT(*) > 1
)
BEGIN
    SELECT unified_id, month, hot_tub, pool, COUNT(*) AS occurrences
    FROM amenities
    GROUP BY unified_id, month, hot_tub, pool
    HAVING COUNT(*) > 1;
END
ELSE
BEGIN
    SELECT 'No Duplicates' AS message;
END

-- ===================================================================
-- [1.2] EXPLORE TABLE: geolocation
-- ===================================================================

----------------------------------------------------------------------
-- [1.2.1] Inspect data type
----------------------------------------------------------------------
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'geolocation'

----------------------------------------------------------------------
-- [1.2.2] View first few rows
----------------------------------------------------------------------
SELECT TOP 15 *
FROM dbo.geolocation;

----------------------------------------------------------------------
-- [1.2.3] Count total rows 
----------------------------------------------------------------------
SELECT COUNT(*) as row_count
FROM dbo.geolocation;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT unified_id) AS distinct_ids,
    COUNT(DISTINCT CAST(unified_id AS VARCHAR) + '_' + CAST(month AS VARCHAR)) AS distinct_id_month_combos
FROM geolocation;

----------------------------------------------------------------------
-- [1.2.4] Count number of missing
----------------------------------------------------------------------
-- LOOK FOR NULL VALUES
-- COUNT(*) counts all rows
-- COUNT(column_type) counts only NON-NULL values
SELECT 
	COUNT(*) - COUNT(unified_id) AS missing_unified_id,
	COUNT(*) - COUNT(month) AS missing_month,
	COUNT(*) - COUNT(street_name) AS missing_street_name,
	COUNT(*) - COUNT(latitude) AS missing_latitude,
	COUNT(*) - COUNT(longitude) AS missing_longitude
FROM dbo.geolocation;

-- LTRIM(string) | Left Trim – removes leading spaces
-- RTRIM(string) | Right Trim – removes trailing spaces
-- LTRIM(RTRIM(string))	| Trims both sides (leading & trailing)
SELECT 
    SUM(CASE WHEN LTRIM(RTRIM(unified_id)) = '' THEN 1 ELSE 0 END) AS empty_unified_id,
    SUM(CASE WHEN LTRIM(RTRIM(month)) = '' THEN 1 ELSE 0 END) AS empty_month,
    SUM(CASE WHEN LTRIM(RTRIM(street_name)) = '' THEN 1 ELSE 0 END) AS empty_street_name,
    SUM(CASE WHEN LTRIM(RTRIM(latitude)) = '' THEN 1 ELSE 0 END) AS empty_latitude,
    SUM(CASE WHEN LTRIM(RTRIM(longitude)) = '' THEN 1 ELSE 0 END) AS empty_longitude
FROM dbo.geolocation;
-- empy values: 37722

----------------------------------------------------------------------
-- [1.2.5] Count number of duplicates
----------------------------------------------------------------------
IF EXISTS (
    SELECT 1
    FROM geolocation
    GROUP BY unified_id, month, street_name, latitude, longitude
    HAVING COUNT(*) > 1
)
BEGIN
    SELECT unified_id, month, street_name, latitude, longitude, COUNT(*) AS occurrences
    FROM geolocation
    GROUP BY unified_id, month, street_name, latitude, longitude
    HAVING COUNT(*) > 1;
END
ELSE
BEGIN
    SELECT 'No Duplicates' AS message;
END

-- ===================================================================
-- [1.3] EXPLORE TABLE: market_analysis
-- ===================================================================

----------------------------------------------------------------------
-- [1.3.1] Inspect data type
----------------------------------------------------------------------
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'market_analysis'

----------------------------------------------------------------------
-- [1.3.2] View first few rows
----------------------------------------------------------------------
SELECT TOP 115 *
FROM dbo.market_analysis;

----------------------------------------------------------------------
-- [1.3.3] Count total rows 
----------------------------------------------------------------------
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT unified_id) AS distinct_ids,
    COUNT(DISTINCT CAST(unified_id AS VARCHAR) + '_' + CAST(month AS VARCHAR)) AS distinct_id_month_combos
FROM dbo.market_analysis;

----------------------------------------------------------------------
-- [1.3.4] Count number of missing
----------------------------------------------------------------------
-- LOOK FOR NULL VALUES
-- COUNT(*) counts all rows
-- COUNT(column_type) counts only NON-NULL values
SELECT 
	COUNT(*) - COUNT(unified_id) AS missing_unified_id,
	COUNT(*) - COUNT(month) AS missing_month,
	COUNT(*) - COUNT(zipcode) AS missing_zipcode,
	COUNT(*) - COUNT(city) AS missing_city,
	COUNT(*) - COUNT(host_type) AS missing_host_type,
	COUNT(*) - COUNT(bedrooms) AS missing_bedrooms,
	COUNT(*) - COUNT(bathrooms) AS missing_bathrooms,
	COUNT(*) - COUNT(guests) AS missing_guests,
	COUNT(*) - COUNT(revenue) AS missing_revenue,
	COUNT(*) - COUNT(openness) AS missing_openness,
	COUNT(*) - COUNT(occupancy) AS missing_occupancy,
	COUNT(*) - COUNT([nightly rate]) AS missing_nightly_rate,
	COUNT(*) - COUNT([lead time]) AS missing_lead_time,
	COUNT(*) - COUNT([length stay]) AS missing_length_stay
FROM dbo.market_analysis;

-- LTRIM(string) | Left Trim – removes leading spaces
-- RTRIM(string) | Right Trim – removes trailing spaces
-- LTRIM(RTRIM(string))	| Trims both sides (leading & trailing)
SELECT 
	SUM(CASE WHEN LTRIM(RTRIM(unified_id)) = '' THEN 1 ELSE 0 END) AS empty_unified_id,
	SUM(CASE WHEN LTRIM(RTRIM(month)) = '' THEN 1 ELSE 0 END) AS empty_month,
	SUM(CASE WHEN LTRIM(RTRIM(zipcode)) = '' THEN 1 ELSE 0 END) AS empty_zipcode,
	SUM(CASE WHEN LTRIM(RTRIM(city)) = '' THEN 1 ELSE 0 END) AS empty_city,
	SUM(CASE WHEN LTRIM(RTRIM(host_type)) = '' THEN 1 ELSE 0 END) AS empty_host_type,
	SUM(CASE WHEN LTRIM(RTRIM(bedrooms)) = '' THEN 1 ELSE 0 END) AS empty_bedrooms,
	SUM(CASE WHEN LTRIM(RTRIM(bathrooms)) = '' THEN 1 ELSE 0 END) AS empty_bathrooms,
	SUM(CASE WHEN LTRIM(RTRIM(guests)) = '' THEN 1 ELSE 0 END) AS empty_guests,
	SUM(CASE WHEN LTRIM(RTRIM(revenue)) = '' THEN 1 ELSE 0 END) AS empty_revenue,
	SUM(CASE WHEN LTRIM(RTRIM(openness)) = '' THEN 1 ELSE 0 END) AS empty_openness,
	SUM(CASE WHEN LTRIM(RTRIM(occupancy)) = '' THEN 1 ELSE 0 END) AS empty_occupancy,
	SUM(CASE WHEN LTRIM(RTRIM([nightly rate])) = '' THEN 1 ELSE 0 END) AS empty_nightly_rate,
	SUM(CASE WHEN LTRIM(RTRIM([lead time])) = '' THEN 1 ELSE 0 END) AS empty_lead_time,
	SUM(CASE WHEN LTRIM(RTRIM([length stay])) = '' THEN 1 ELSE 0 END) AS empty_length_stay
FROM dbo.market_analysis;


----------------------------------------------------------------------
-- [1.3.5] Count number of duplicates
----------------------------------------------------------------------
IF EXISTS (
    SELECT unified_id, month
    FROM market_analysis
    GROUP BY unified_id, month
    HAVING COUNT(*) > 1
)
BEGIN
    -- Show the duplicates
    SELECT unified_id, month, COUNT(*) AS occurrences
    FROM market_analysis
    GROUP BY unified_id, month
    HAVING COUNT(*) > 1;
END
ELSE
BEGIN
    -- Show a "No Duplicates" message
    SELECT 'No Duplicates' AS message;
END

-- ===================================================================
-- [1.4] EXPLORE TABLE: market_analysis_2019
-- ===================================================================

----------------------------------------------------------------------
-- [1.4.1] Inspect data type
----------------------------------------------------------------------
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'market_analysis_2019'

----------------------------------------------------------------------
-- [1.4.2] View first few rows
----------------------------------------------------------------------
SELECT TOP 115 *
FROM dbo.market_analysis_2019;

----------------------------------------------------------------------
-- [1.4.3] Count total rows 
----------------------------------------------------------------------
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT unified_id) AS distinct_ids,
    COUNT(DISTINCT CAST(unified_id AS VARCHAR) + '_' + CAST(month AS VARCHAR)) AS distinct_id_month_combos
FROM dbo.market_analysis_2019;

----------------------------------------------------------------------
-- [1.4.4] Count number of missing
----------------------------------------------------------------------
-- LOOK FOR NULL VALUES
-- COUNT(*) counts all rows
-- COUNT(column_type) counts only NON-NULL values
SELECT 
	COUNT(*) - COUNT(unified_id) AS missing_unified_id,
	COUNT(*) - COUNT(month) AS missing_month,
	COUNT(*) - COUNT(zipcode) AS missing_zipcode,
	COUNT(*) - COUNT(city) AS missing_city,
	COUNT(*) - COUNT(host_type) AS missing_host_type,
	COUNT(*) - COUNT(bedrooms) AS missing_bedrooms,
	COUNT(*) - COUNT(bathrooms) AS missing_bathrooms,
	COUNT(*) - COUNT(guests) AS missing_guests,
	COUNT(*) - COUNT(revenue) AS missing_revenue,
	COUNT(*) - COUNT(openness) AS missing_openness,
	COUNT(*) - COUNT(occupancy) AS missing_occupancy,
	COUNT(*) - COUNT([nightly rate]) AS missing_nightly_rate,
	COUNT(*) - COUNT([lead time]) AS missing_lead_time,
	COUNT(*) - COUNT([length stay]) AS missing_length_stay
FROM dbo.market_analysis_2019;

-- LTRIM(string) | Left Trim – removes leading spaces
-- RTRIM(string) | Right Trim – removes trailing spaces
-- LTRIM(RTRIM(string))	| Trims both sides (leading & trailing)
SELECT 
	SUM(CASE WHEN LTRIM(RTRIM(unified_id)) = '' THEN 1 ELSE 0 END) AS empty_unified_id,
	SUM(CASE WHEN LTRIM(RTRIM(month)) = '' THEN 1 ELSE 0 END) AS empty_month,
	SUM(CASE WHEN LTRIM(RTRIM(zipcode)) = '' THEN 1 ELSE 0 END) AS empty_zipcode,
	SUM(CASE WHEN LTRIM(RTRIM(city)) = '' THEN 1 ELSE 0 END) AS empty_city,
	SUM(CASE WHEN LTRIM(RTRIM(host_type)) = '' THEN 1 ELSE 0 END) AS empty_host_type,
	SUM(CASE WHEN LTRIM(RTRIM(bedrooms)) = '' THEN 1 ELSE 0 END) AS empty_bedrooms,
	SUM(CASE WHEN LTRIM(RTRIM(bathrooms)) = '' THEN 1 ELSE 0 END) AS empty_bathrooms,
	SUM(CASE WHEN LTRIM(RTRIM(guests)) = '' THEN 1 ELSE 0 END) AS empty_guests,
	SUM(CASE WHEN LTRIM(RTRIM(revenue)) = '' THEN 1 ELSE 0 END) AS empty_revenue,
	SUM(CASE WHEN LTRIM(RTRIM(openness)) = '' THEN 1 ELSE 0 END) AS empty_openness,
	SUM(CASE WHEN LTRIM(RTRIM(occupancy)) = '' THEN 1 ELSE 0 END) AS empty_occupancy,
	SUM(CASE WHEN LTRIM(RTRIM([nightly rate])) = '' THEN 1 ELSE 0 END) AS empty_nightly_rate,
	SUM(CASE WHEN LTRIM(RTRIM([lead time])) = '' THEN 1 ELSE 0 END) AS empty_lead_time,
	SUM(CASE WHEN LTRIM(RTRIM([length stay])) = '' THEN 1 ELSE 0 END) AS empty_length_stay
FROM dbo.market_analysis_2019;

----------------------------------------------------------------------
-- [1.4.5] Count number of duplicates
----------------------------------------------------------------------
IF EXISTS (
    SELECT unified_id, month
    FROM market_analysis_2019
    GROUP BY unified_id, month
    HAVING COUNT(*) > 1
)
BEGIN
    -- Show the duplicates
    SELECT unified_id, month, COUNT(*) AS occurrences
    FROM market_analysis_2019
    GROUP BY unified_id, month
    HAVING COUNT(*) > 1;
END
ELSE
BEGIN
    -- Show a "No Duplicates" message
    SELECT 'No Duplicates' AS message;
END

-- ===================================================================
-- [1.5] EXPLORE TABLE: sales_properties_total_zipcode_92252
-- ===================================================================

----------------------------------------------------------------------
-- [1.5.1] Inspect data type
----------------------------------------------------------------------
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_total_zipcode_92252'

----------------------------------------------------------------------
-- [1.5.2] View first few rows
----------------------------------------------------------------------
SELECT TOP 115 *
FROM dbo.sales_properties_total_zipcode_92252;

----------------------------------------------------------------------
-- [1.5.3] Count total rows 
----------------------------------------------------------------------
SELECT COUNT(*) as row_count
FROM dbo.sales_properties_total_zipcode_92252;

----------------------------------------------------------------------
-- [1.5.4] Count number of missing
----------------------------------------------------------------------
-- LOOK FOR NULL VALUES
-- COUNT(*) counts all rows
-- COUNT(column_type) counts only NON-NULL values
SELECT 
	COUNT(*) - COUNT(Url) AS missing_url,
	COUNT(*) - COUNT(Zestimate) AS missing_zestimate,
	COUNT(*) - COUNT(Price) AS missing_Price,
	COUNT(*) - COUNT([Rent Zestimate]) AS mising_rent_zestimate,
	COUNT(*) - COUNT([Days On Zillow]) AS missing_days_on_zillow,
	COUNT(*) - COUNT(Bathrooms) AS missing_bathrooms,
	COUNT(*) - COUNT(Bedrooms) AS missing_bedrooms,
	COUNT(*) - COUNT([Living Area]) AS missing_living_area,
	COUNT(*) - COUNT([Lot Size]) AS missing_lot_size,
	COUNT(*) - COUNT([Home Type]) AS missing_home_type,
	COUNT(*) - COUNT([Street Address]) AS missing_street_address,
	COUNT(*) - COUNT(City) AS missing_city,
	COUNT(*) - COUNT(Zip) AS missing_zip,
	COUNT(*) - COUNT(State) AS missing_state,
	COUNT(*) - COUNT(Country) AS missing_country,
	COUNT(*) - COUNT([Broker Name]) AS missing_broker_name,
	COUNT(*) - COUNT([Has 3D Model]) AS missing_has_3d_model,
	COUNT(*) - COUNT([Has Image]) AS missing_has_image,
	COUNT(*) - COUNT([Has Video]) AS missing_has_video,
	COUNT(*) - COUNT(isZillowOwned) AS missing_isZillowOwned,
	COUNT(*) - COUNT(sgapt) AS missing_sgapt,
	COUNT(*) - COUNT(statusText) AS missing_statusText,
	COUNT(*) - COUNT(statusType) AS missing_statusType	
FROM dbo.sales_properties_total_zipcode_92252;

-- LTRIM(string) | Left Trim – removes leading spaces
-- RTRIM(string) | Right Trim – removes trailing spaces
-- LTRIM(RTRIM(string))	| Trims both sides (leading & trailing)
SELECT 
	SUM(CASE WHEN LTRIM(RTRIM(Url)) = '' THEN 1 ELSE 0 END) AS empty_url,
	SUM(CASE WHEN LTRIM(RTRIM(Zestimate)) = '' THEN 1 ELSE 0 END) AS empty_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM(Price)) = '' THEN 1 ELSE 0 END) AS empty_price,
	SUM(CASE WHEN LTRIM(RTRIM([Rent Zestimate])) = '' THEN 1 ELSE 0 END) AS empty_rent_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM([Days On Zillow])) = '' THEN 1 ELSE 0 END) AS empty_days_on_zillow,
	SUM(CASE WHEN LTRIM(RTRIM(Bathrooms)) = '' THEN 1 ELSE 0 END) AS empty_bathrooms,
	SUM(CASE WHEN LTRIM(RTRIM(Bedrooms)) = '' THEN 1 ELSE 0 END) AS empty_bedrooms,
	SUM(CASE WHEN LTRIM(RTRIM([Living Area])) = '' THEN 1 ELSE 0 END) AS empty_living_area,
	SUM(CASE WHEN LTRIM(RTRIM([Lot Size])) = '' THEN 1 ELSE 0 END) AS empty_lot_size,
	SUM(CASE WHEN LTRIM(RTRIM([Home Type])) = '' THEN 1 ELSE 0 END) AS empty_home_type,
	SUM(CASE WHEN LTRIM(RTRIM([Street Address])) = '' THEN 1 ELSE 0 END) AS empty_street_address,
	SUM(CASE WHEN LTRIM(RTRIM(City)) = '' THEN 1 ELSE 0 END) AS empty_city,
	SUM(CASE WHEN LTRIM(RTRIM(Zip)) = '' THEN 1 ELSE 0 END) AS empty_zip,
	SUM(CASE WHEN LTRIM(RTRIM(State)) = '' THEN 1 ELSE 0 END) AS empty_state,
	SUM(CASE WHEN LTRIM(RTRIM(Country)) = '' THEN 1 ELSE 0 END) AS empty_country,
	SUM(CASE WHEN LTRIM(RTRIM([Broker Name])) = '' THEN 1 ELSE 0 END) AS empty_broker_name,
	SUM(CASE WHEN LTRIM(RTRIM([Has 3D Model])) = '' THEN 1 ELSE 0 END) AS empty_has_3d_model,
	SUM(CASE WHEN LTRIM(RTRIM([Has Image])) = '' THEN 1 ELSE 0 END) AS empty_has_image,
	SUM(CASE WHEN LTRIM(RTRIM([Has Video])) = '' THEN 1 ELSE 0 END) AS empty_has_video,
	SUM(CASE WHEN LTRIM(RTRIM(isZillowOwned)) = '' THEN 1 ELSE 0 END) AS empty_isZillowOwned,
	SUM(CASE WHEN LTRIM(RTRIM(sgapt)) = '' THEN 1 ELSE 0 END) AS empty_sgapt,
	SUM(CASE WHEN LTRIM(RTRIM(statusText)) = '' THEN 1 ELSE 0 END) AS empty_statusText,
	SUM(CASE WHEN LTRIM(RTRIM(statusType)) = '' THEN 1 ELSE 0 END) AS empty_statusType
FROM dbo.sales_properties_total_zipcode_92252;


-- ===================================================================
-- [1.6] EXPLORE TABLE: sales_properties_total_zipcode_92284
-- ===================================================================

----------------------------------------------------------------------
-- [1.6.1] Inspect data type
----------------------------------------------------------------------
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_total_zipcode_92284'

----------------------------------------------------------------------
-- [1.6.2] View first few rows
----------------------------------------------------------------------
SELECT TOP 115 *
FROM dbo.sales_properties_total_zipcode_92284;

----------------------------------------------------------------------
-- [1.6.3] Count total rows 
----------------------------------------------------------------------
SELECT COUNT(*) as row_count
FROM dbo.sales_properties_total_zipcode_92284;

----------------------------------------------------------------------
-- [1.6.4] Count number of missing
----------------------------------------------------------------------
-- LOOK FOR NULL VALUES
-- COUNT(*) counts all rows
-- COUNT(column_type) counts only NON-NULL values
SELECT 
	COUNT(*) - COUNT(Url) AS missing_url,
	COUNT(*) - COUNT(Zestimate) AS missing_zestimate,
	COUNT(*) - COUNT(Price) AS missing_Price,
	COUNT(*) - COUNT([Rent Zestimate]) AS mising_rent_zestimate,
	COUNT(*) - COUNT([Days On Zillow]) AS missing_days_on_zillow,
	COUNT(*) - COUNT(Bathrooms) AS missing_bathrooms,
	COUNT(*) - COUNT(Bedrooms) AS missing_bedrooms,
	COUNT(*) - COUNT([Living Area]) AS missing_living_area,
	COUNT(*) - COUNT([Lot Size]) AS missing_lot_size,
	COUNT(*) - COUNT([Home Type]) AS missing_home_type,
	COUNT(*) - COUNT([Street Address]) AS missing_street_address,
	COUNT(*) - COUNT(City) AS missing_city,
	COUNT(*) - COUNT(Zip) AS missing_zip,
	COUNT(*) - COUNT(State) AS missing_state,
	COUNT(*) - COUNT(Country) AS missing_country,
	COUNT(*) - COUNT([Broker Name]) AS missing_broker_name,
	COUNT(*) - COUNT([Has 3D Model]) AS missing_has_3d_model,
	COUNT(*) - COUNT([Has Image]) AS missing_has_image,
	COUNT(*) - COUNT([Has Video]) AS missing_has_video,
	COUNT(*) - COUNT(isZillowOwned) AS missing_isZillowOwned,
	COUNT(*) - COUNT(sgapt) AS missing_sgapt,
	COUNT(*) - COUNT(statusText) AS missing_statusText,
	COUNT(*) - COUNT(statusType) AS missing_statusType	
FROM dbo.sales_properties_total_zipcode_92284;

-- LTRIM(string) | Left Trim – removes leading spaces
-- RTRIM(string) | Right Trim – removes trailing spaces
-- LTRIM(RTRIM(string))	| Trims both sides (leading & trailing)
SELECT 
	SUM(CASE WHEN LTRIM(RTRIM(Url)) = '' THEN 1 ELSE 0 END) AS empty_url,
	SUM(CASE WHEN LTRIM(RTRIM(Zestimate)) = '' THEN 1 ELSE 0 END) AS empty_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM(Price)) = '' THEN 1 ELSE 0 END) AS empty_price,
	SUM(CASE WHEN LTRIM(RTRIM([Rent Zestimate])) = '' THEN 1 ELSE 0 END) AS empty_rent_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM([Days On Zillow])) = '' THEN 1 ELSE 0 END) AS empty_days_on_zillow,
	SUM(CASE WHEN LTRIM(RTRIM(Bathrooms)) = '' THEN 1 ELSE 0 END) AS empty_bathrooms,
	SUM(CASE WHEN LTRIM(RTRIM(Bedrooms)) = '' THEN 1 ELSE 0 END) AS empty_bedrooms,
	SUM(CASE WHEN LTRIM(RTRIM([Living Area])) = '' THEN 1 ELSE 0 END) AS empty_living_area,
	SUM(CASE WHEN LTRIM(RTRIM([Lot Size])) = '' THEN 1 ELSE 0 END) AS empty_lot_size,
	SUM(CASE WHEN LTRIM(RTRIM([Home Type])) = '' THEN 1 ELSE 0 END) AS empty_home_type,
	SUM(CASE WHEN LTRIM(RTRIM([Street Address])) = '' THEN 1 ELSE 0 END) AS empty_street_address,
	SUM(CASE WHEN LTRIM(RTRIM(City)) = '' THEN 1 ELSE 0 END) AS empty_city,
	SUM(CASE WHEN LTRIM(RTRIM(Zip)) = '' THEN 1 ELSE 0 END) AS empty_zip,
	SUM(CASE WHEN LTRIM(RTRIM(State)) = '' THEN 1 ELSE 0 END) AS empty_state,
	SUM(CASE WHEN LTRIM(RTRIM(Country)) = '' THEN 1 ELSE 0 END) AS empty_country,
	SUM(CASE WHEN LTRIM(RTRIM([Broker Name])) = '' THEN 1 ELSE 0 END) AS empty_broker_name,
	SUM(CASE WHEN LTRIM(RTRIM([Has 3D Model])) = '' THEN 1 ELSE 0 END) AS empty_has_3d_model,
	SUM(CASE WHEN LTRIM(RTRIM([Has Image])) = '' THEN 1 ELSE 0 END) AS empty_has_image,
	SUM(CASE WHEN LTRIM(RTRIM([Has Video])) = '' THEN 1 ELSE 0 END) AS empty_has_video,
	SUM(CASE WHEN LTRIM(RTRIM(isZillowOwned)) = '' THEN 1 ELSE 0 END) AS empty_isZillowOwned,
	SUM(CASE WHEN LTRIM(RTRIM(sgapt)) = '' THEN 1 ELSE 0 END) AS empty_sgapt,
	SUM(CASE WHEN LTRIM(RTRIM(statusText)) = '' THEN 1 ELSE 0 END) AS empty_statusText,
	SUM(CASE WHEN LTRIM(RTRIM(statusType)) = '' THEN 1 ELSE 0 END) AS empty_statusType
FROM dbo.sales_properties_total_zipcode_92284;

-- ===================================================================
-- [1.7] EXPLORE TABLE: sales_properties_total_zipcode_92314
-- ===================================================================

----------------------------------------------------------------------
-- [1.7.1] Inspect data type
----------------------------------------------------------------------
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_total_zipcode_92314'

----------------------------------------------------------------------
-- [1.7.2] View first few rows
----------------------------------------------------------------------
SELECT TOP 115 *
FROM dbo.sales_properties_total_zipcode_92314;

----------------------------------------------------------------------
-- [1.7.3] Count total rows 
----------------------------------------------------------------------
SELECT COUNT(*) as row_count
FROM dbo.sales_properties_total_zipcode_92314;

----------------------------------------------------------------------
-- [1.7.4] Count number of missing
----------------------------------------------------------------------
-- LOOK FOR NULL VALUES
-- COUNT(*) counts all rows
-- COUNT(column_type) counts only NON-NULL values
SELECT 
	COUNT(*) - COUNT(Url) AS missing_url,
	COUNT(*) - COUNT(Zestimate) AS missing_zestimate,
	COUNT(*) - COUNT(Price) AS missing_Price,
	COUNT(*) - COUNT([Rent Zestimate]) AS mising_rent_zestimate,
	COUNT(*) - COUNT([Days On Zillow]) AS missing_days_on_zillow,
	COUNT(*) - COUNT(Bathrooms) AS missing_bathrooms,
	COUNT(*) - COUNT(Bedrooms) AS missing_bedrooms,
	COUNT(*) - COUNT([Living Area]) AS missing_living_area,
	COUNT(*) - COUNT([Lot Size]) AS missing_lot_size,
	COUNT(*) - COUNT([Home Type]) AS missing_home_type,
	COUNT(*) - COUNT([Street Address]) AS missing_street_address,
	COUNT(*) - COUNT(City) AS missing_city,
	COUNT(*) - COUNT(Zip) AS missing_zip,
	COUNT(*) - COUNT(State) AS missing_state,
	COUNT(*) - COUNT(Country) AS missing_country,
	COUNT(*) - COUNT([Broker Name]) AS missing_broker_name,
	COUNT(*) - COUNT([Has 3D Model]) AS missing_has_3d_model,
	COUNT(*) - COUNT([Has Image]) AS missing_has_image,
	COUNT(*) - COUNT([Has Video]) AS missing_has_video,
	COUNT(*) - COUNT(isZillowOwned) AS missing_isZillowOwned,
	COUNT(*) - COUNT(sgapt) AS missing_sgapt,
	COUNT(*) - COUNT(statusText) AS missing_statusText,
	COUNT(*) - COUNT(statusType) AS missing_statusType	
FROM dbo.sales_properties_total_zipcode_92314;

-- LTRIM(string) | Left Trim – removes leading spaces
-- RTRIM(string) | Right Trim – removes trailing spaces
-- LTRIM(RTRIM(string))	| Trims both sides (leading & trailing)
SELECT 
	SUM(CASE WHEN LTRIM(RTRIM(Url)) = '' THEN 1 ELSE 0 END) AS empty_url,
	SUM(CASE WHEN LTRIM(RTRIM(Zestimate)) = '' THEN 1 ELSE 0 END) AS empty_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM(Price)) = '' THEN 1 ELSE 0 END) AS empty_price,
	SUM(CASE WHEN LTRIM(RTRIM([Rent Zestimate])) = '' THEN 1 ELSE 0 END) AS empty_rent_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM([Days On Zillow])) = '' THEN 1 ELSE 0 END) AS empty_days_on_zillow,
	SUM(CASE WHEN LTRIM(RTRIM(Bathrooms)) = '' THEN 1 ELSE 0 END) AS empty_bathrooms,
	SUM(CASE WHEN LTRIM(RTRIM(Bedrooms)) = '' THEN 1 ELSE 0 END) AS empty_bedrooms,
	SUM(CASE WHEN LTRIM(RTRIM([Living Area])) = '' THEN 1 ELSE 0 END) AS empty_living_area,
	SUM(CASE WHEN LTRIM(RTRIM([Lot Size])) = '' THEN 1 ELSE 0 END) AS empty_lot_size,
	SUM(CASE WHEN LTRIM(RTRIM([Home Type])) = '' THEN 1 ELSE 0 END) AS empty_home_type,
	SUM(CASE WHEN LTRIM(RTRIM([Street Address])) = '' THEN 1 ELSE 0 END) AS empty_street_address,
	SUM(CASE WHEN LTRIM(RTRIM(City)) = '' THEN 1 ELSE 0 END) AS empty_city,
	SUM(CASE WHEN LTRIM(RTRIM(Zip)) = '' THEN 1 ELSE 0 END) AS empty_zip,
	SUM(CASE WHEN LTRIM(RTRIM(State)) = '' THEN 1 ELSE 0 END) AS empty_state,
	SUM(CASE WHEN LTRIM(RTRIM(Country)) = '' THEN 1 ELSE 0 END) AS empty_country,
	SUM(CASE WHEN LTRIM(RTRIM([Broker Name])) = '' THEN 1 ELSE 0 END) AS empty_broker_name,
	SUM(CASE WHEN LTRIM(RTRIM([Has 3D Model])) = '' THEN 1 ELSE 0 END) AS empty_has_3d_model,
	SUM(CASE WHEN LTRIM(RTRIM([Has Image])) = '' THEN 1 ELSE 0 END) AS empty_has_image,
	SUM(CASE WHEN LTRIM(RTRIM([Has Video])) = '' THEN 1 ELSE 0 END) AS empty_has_video,
	SUM(CASE WHEN LTRIM(RTRIM(isZillowOwned)) = '' THEN 1 ELSE 0 END) AS empty_isZillowOwned,
	SUM(CASE WHEN LTRIM(RTRIM(sgapt)) = '' THEN 1 ELSE 0 END) AS empty_sgapt,
	SUM(CASE WHEN LTRIM(RTRIM(statusText)) = '' THEN 1 ELSE 0 END) AS empty_statusText,
	SUM(CASE WHEN LTRIM(RTRIM(statusType)) = '' THEN 1 ELSE 0 END) AS empty_statusType
FROM dbo.sales_properties_total_zipcode_92314;

-- ===================================================================
-- [1.8] EXPLORE TABLE: sales_properties_total_zipcode_92315
-- ===================================================================

----------------------------------------------------------------------
-- [1.8.1] Inspect data type
----------------------------------------------------------------------
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_total_zipcode_92315'

----------------------------------------------------------------------
-- [1.8.2] View first few rows
----------------------------------------------------------------------
SELECT TOP 115 *
FROM dbo.sales_properties_total_zipcode_92315;

----------------------------------------------------------------------
-- [1.8.3] Count total rows 
----------------------------------------------------------------------
SELECT COUNT(*) as row_count
FROM dbo.sales_properties_total_zipcode_92315

----------------------------------------------------------------------
-- [1.8.4] Count number of missing
----------------------------------------------------------------------
-- LOOK FOR NULL VALUES
-- COUNT(*) counts all rows
-- COUNT(column_type) counts only NON-NULL values
SELECT 
	COUNT(*) - COUNT(Url) AS missing_url,
	COUNT(*) - COUNT(Zestimate) AS missing_zestimate,
	COUNT(*) - COUNT(Price) AS missing_Price,
	COUNT(*) - COUNT([Rent Zestimate]) AS mising_rent_zestimate,
	COUNT(*) - COUNT([Days On Zillow]) AS missing_days_on_zillow,
	COUNT(*) - COUNT(Bathrooms) AS missing_bathrooms,
	COUNT(*) - COUNT(Bedrooms) AS missing_bedrooms,
	COUNT(*) - COUNT([Living Area]) AS missing_living_area,
	COUNT(*) - COUNT([Lot Size]) AS missing_lot_size,
	COUNT(*) - COUNT([Home Type]) AS missing_home_type,
	COUNT(*) - COUNT([Street Address]) AS missing_street_address,
	COUNT(*) - COUNT(City) AS missing_city,
	COUNT(*) - COUNT(Zip) AS missing_zip,
	COUNT(*) - COUNT(State) AS missing_state,
	COUNT(*) - COUNT(Country) AS missing_country,
	COUNT(*) - COUNT([Broker Name]) AS missing_broker_name,
	COUNT(*) - COUNT([Has 3D Model]) AS missing_has_3d_model,
	COUNT(*) - COUNT([Has Image]) AS missing_has_image,
	COUNT(*) - COUNT([Has Video]) AS missing_has_video,
	COUNT(*) - COUNT(isZillowOwned) AS missing_isZillowOwned,
	COUNT(*) - COUNT(sgapt) AS missing_sgapt,
	COUNT(*) - COUNT(statusText) AS missing_statusText,
	COUNT(*) - COUNT(statusType) AS missing_statusType	
FROM dbo.sales_properties_total_zipcode_92315;

-- LTRIM(string) | Left Trim – removes leading spaces
-- RTRIM(string) | Right Trim – removes trailing spaces
-- LTRIM(RTRIM(string))	| Trims both sides (leading & trailing)
SELECT 
	SUM(CASE WHEN LTRIM(RTRIM(Url)) = '' THEN 1 ELSE 0 END) AS empty_url,
	SUM(CASE WHEN LTRIM(RTRIM(Zestimate)) = '' THEN 1 ELSE 0 END) AS empty_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM(Price)) = '' THEN 1 ELSE 0 END) AS empty_price,
	SUM(CASE WHEN LTRIM(RTRIM([Rent Zestimate])) = '' THEN 1 ELSE 0 END) AS empty_rent_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM([Days On Zillow])) = '' THEN 1 ELSE 0 END) AS empty_days_on_zillow,
	SUM(CASE WHEN LTRIM(RTRIM(Bathrooms)) = '' THEN 1 ELSE 0 END) AS empty_bathrooms,
	SUM(CASE WHEN LTRIM(RTRIM(Bedrooms)) = '' THEN 1 ELSE 0 END) AS empty_bedrooms,
	SUM(CASE WHEN LTRIM(RTRIM([Living Area])) = '' THEN 1 ELSE 0 END) AS empty_living_area,
	SUM(CASE WHEN LTRIM(RTRIM([Lot Size])) = '' THEN 1 ELSE 0 END) AS empty_lot_size,
	SUM(CASE WHEN LTRIM(RTRIM([Home Type])) = '' THEN 1 ELSE 0 END) AS empty_home_type,
	SUM(CASE WHEN LTRIM(RTRIM([Street Address])) = '' THEN 1 ELSE 0 END) AS empty_street_address,
	SUM(CASE WHEN LTRIM(RTRIM(City)) = '' THEN 1 ELSE 0 END) AS empty_city,
	SUM(CASE WHEN LTRIM(RTRIM(Zip)) = '' THEN 1 ELSE 0 END) AS empty_zip,
	SUM(CASE WHEN LTRIM(RTRIM(State)) = '' THEN 1 ELSE 0 END) AS empty_state,
	SUM(CASE WHEN LTRIM(RTRIM(Country)) = '' THEN 1 ELSE 0 END) AS empty_country,
	SUM(CASE WHEN LTRIM(RTRIM([Broker Name])) = '' THEN 1 ELSE 0 END) AS empty_broker_name,
	SUM(CASE WHEN LTRIM(RTRIM([Has 3D Model])) = '' THEN 1 ELSE 0 END) AS empty_has_3d_model,
	SUM(CASE WHEN LTRIM(RTRIM([Has Image])) = '' THEN 1 ELSE 0 END) AS empty_has_image,
	SUM(CASE WHEN LTRIM(RTRIM([Has Video])) = '' THEN 1 ELSE 0 END) AS empty_has_video,
	SUM(CASE WHEN LTRIM(RTRIM(isZillowOwned)) = '' THEN 1 ELSE 0 END) AS empty_isZillowOwned,
	SUM(CASE WHEN LTRIM(RTRIM(sgapt)) = '' THEN 1 ELSE 0 END) AS empty_sgapt,
	SUM(CASE WHEN LTRIM(RTRIM(statusText)) = '' THEN 1 ELSE 0 END) AS empty_statusText,
	SUM(CASE WHEN LTRIM(RTRIM(statusType)) = '' THEN 1 ELSE 0 END) AS empty_statusType
FROM dbo.sales_properties_total_zipcode_92315;

-- ===================================================================
-- [1.9] EXPLORE TABLE: sales_properties_with_pool_zipcode_92252
-- ===================================================================

----------------------------------------------------------------------
-- [1.9.1] Inspect data type
----------------------------------------------------------------------
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_with_pool_zipcode_92252'

----------------------------------------------------------------------
-- [1.9.2] View first few rows
----------------------------------------------------------------------
SELECT TOP 115 *
FROM dbo.sales_properties_with_pool_zipcode_92252;

----------------------------------------------------------------------
-- [1.9.3] Count total rows 
----------------------------------------------------------------------
SELECT COUNT(*) as row_count
FROM dbo.sales_properties_with_pool_zipcode_92252

----------------------------------------------------------------------
-- [1.9.4] Count number of missing
----------------------------------------------------------------------
-- LOOK FOR NULL VALUES
-- COUNT(*) counts all rows
-- COUNT(column_type) counts only NON-NULL values
SELECT 
	COUNT(*) - COUNT(Url) AS missing_url,
	COUNT(*) - COUNT(Zestimate) AS missing_zestimate,
	COUNT(*) - COUNT(Price) AS missing_Price,
	COUNT(*) - COUNT([Rent Zestimate]) AS mising_rent_zestimate,
	COUNT(*) - COUNT([Days On Zillow]) AS missing_days_on_zillow,
	COUNT(*) - COUNT(Bathrooms) AS missing_bathrooms,
	COUNT(*) - COUNT(Bedrooms) AS missing_bedrooms,
	COUNT(*) - COUNT([Living Area]) AS missing_living_area,
	COUNT(*) - COUNT([Lot Size]) AS missing_lot_size,
	COUNT(*) - COUNT([Home Type]) AS missing_home_type,
	COUNT(*) - COUNT([Street Address]) AS missing_street_address,
	COUNT(*) - COUNT(City) AS missing_city,
	COUNT(*) - COUNT(Zip) AS missing_zip,
	COUNT(*) - COUNT(State) AS missing_state,
	COUNT(*) - COUNT(Country) AS missing_country,
	COUNT(*) - COUNT([Broker Name]) AS missing_broker_name,
	COUNT(*) - COUNT([Has 3D Model]) AS missing_has_3d_model,
	COUNT(*) - COUNT([Has Image]) AS missing_has_image,
	COUNT(*) - COUNT([Has Video]) AS missing_has_video,
	COUNT(*) - COUNT(isZillowOwned) AS missing_isZillowOwned,
	COUNT(*) - COUNT(sgapt) AS missing_sgapt,
	COUNT(*) - COUNT(statusText) AS missing_statusText,
	COUNT(*) - COUNT(statusType) AS missing_statusType	
FROM dbo.sales_properties_with_pool_zipcode_92252;

-- LTRIM(string) | Left Trim – removes leading spaces
-- RTRIM(string) | Right Trim – removes trailing spaces
-- LTRIM(RTRIM(string))	| Trims both sides (leading & trailing)
SELECT 
	SUM(CASE WHEN LTRIM(RTRIM(Url)) = '' THEN 1 ELSE 0 END) AS empty_url,
	SUM(CASE WHEN LTRIM(RTRIM(Zestimate)) = '' THEN 1 ELSE 0 END) AS empty_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM(Price)) = '' THEN 1 ELSE 0 END) AS empty_price,
	SUM(CASE WHEN LTRIM(RTRIM([Rent Zestimate])) = '' THEN 1 ELSE 0 END) AS empty_rent_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM([Days On Zillow])) = '' THEN 1 ELSE 0 END) AS empty_days_on_zillow,
	SUM(CASE WHEN LTRIM(RTRIM(Bathrooms)) = '' THEN 1 ELSE 0 END) AS empty_bathrooms,
	SUM(CASE WHEN LTRIM(RTRIM(Bedrooms)) = '' THEN 1 ELSE 0 END) AS empty_bedrooms,
	SUM(CASE WHEN LTRIM(RTRIM([Living Area])) = '' THEN 1 ELSE 0 END) AS empty_living_area,
	SUM(CASE WHEN LTRIM(RTRIM([Lot Size])) = '' THEN 1 ELSE 0 END) AS empty_lot_size,
	SUM(CASE WHEN LTRIM(RTRIM([Home Type])) = '' THEN 1 ELSE 0 END) AS empty_home_type,
	SUM(CASE WHEN LTRIM(RTRIM([Street Address])) = '' THEN 1 ELSE 0 END) AS empty_street_address,
	SUM(CASE WHEN LTRIM(RTRIM(City)) = '' THEN 1 ELSE 0 END) AS empty_city,
	SUM(CASE WHEN LTRIM(RTRIM(Zip)) = '' THEN 1 ELSE 0 END) AS empty_zip,
	SUM(CASE WHEN LTRIM(RTRIM(State)) = '' THEN 1 ELSE 0 END) AS empty_state,
	SUM(CASE WHEN LTRIM(RTRIM(Country)) = '' THEN 1 ELSE 0 END) AS empty_country,
	SUM(CASE WHEN LTRIM(RTRIM([Broker Name])) = '' THEN 1 ELSE 0 END) AS empty_broker_name,
	SUM(CASE WHEN LTRIM(RTRIM([Has 3D Model])) = '' THEN 1 ELSE 0 END) AS empty_has_3d_model,
	SUM(CASE WHEN LTRIM(RTRIM([Has Image])) = '' THEN 1 ELSE 0 END) AS empty_has_image,
	SUM(CASE WHEN LTRIM(RTRIM([Has Video])) = '' THEN 1 ELSE 0 END) AS empty_has_video,
	SUM(CASE WHEN LTRIM(RTRIM(isZillowOwned)) = '' THEN 1 ELSE 0 END) AS empty_isZillowOwned,
	SUM(CASE WHEN LTRIM(RTRIM(sgapt)) = '' THEN 1 ELSE 0 END) AS empty_sgapt,
	SUM(CASE WHEN LTRIM(RTRIM(statusText)) = '' THEN 1 ELSE 0 END) AS empty_statusText,
	SUM(CASE WHEN LTRIM(RTRIM(statusType)) = '' THEN 1 ELSE 0 END) AS empty_statusType
FROM dbo.sales_properties_with_pool_zipcode_92252;

-- ===================================================================
-- [1.10] EXPLORE TABLE: sales_properties_with_pool_zipcode_92284
-- ===================================================================

----------------------------------------------------------------------
-- [1.10.1] Inspect data type
----------------------------------------------------------------------
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_with_pool_zipcode_92284'

----------------------------------------------------------------------
-- [1.10.2] View first few rows
----------------------------------------------------------------------
SELECT TOP 115 *
FROM dbo.sales_properties_with_pool_zipcode_92284;

----------------------------------------------------------------------
-- [1.10.3] Count total rows 
----------------------------------------------------------------------
SELECT COUNT(*) as row_count
FROM dbo.sales_properties_with_pool_zipcode_92284

----------------------------------------------------------------------
-- [1.10.4] Count number of missing
----------------------------------------------------------------------
-- LOOK FOR NULL VALUES
-- COUNT(*) counts all rows
-- COUNT(column_type) counts only NON-NULL values
SELECT 
	COUNT(*) - COUNT(Url) AS missing_url,
	COUNT(*) - COUNT(Zestimate) AS missing_zestimate,
	COUNT(*) - COUNT(Price) AS missing_Price,
	COUNT(*) - COUNT([Rent Zestimate]) AS mising_rent_zestimate,
	COUNT(*) - COUNT([Days On Zillow]) AS missing_days_on_zillow,
	COUNT(*) - COUNT(Bathrooms) AS missing_bathrooms,
	COUNT(*) - COUNT(Bedrooms) AS missing_bedrooms,
	COUNT(*) - COUNT([Living Area]) AS missing_living_area,
	COUNT(*) - COUNT([Lot Size]) AS missing_lot_size,
	COUNT(*) - COUNT([Home Type]) AS missing_home_type,
	COUNT(*) - COUNT([Street Address]) AS missing_street_address,
	COUNT(*) - COUNT(City) AS missing_city,
	COUNT(*) - COUNT(Zip) AS missing_zip,
	COUNT(*) - COUNT(State) AS missing_state,
	COUNT(*) - COUNT(Country) AS missing_country,
	COUNT(*) - COUNT([Broker Name]) AS missing_broker_name,
	COUNT(*) - COUNT([Has 3D Model]) AS missing_has_3d_model,
	COUNT(*) - COUNT([Has Image]) AS missing_has_image,
	COUNT(*) - COUNT([Has Video]) AS missing_has_video,
	COUNT(*) - COUNT(isZillowOwned) AS missing_isZillowOwned,
	COUNT(*) - COUNT(sgapt) AS missing_sgapt,
	COUNT(*) - COUNT(statusText) AS missing_statusText,
	COUNT(*) - COUNT(statusType) AS missing_statusType	
FROM dbo.sales_properties_with_pool_zipcode_92284;

-- LTRIM(string) | Left Trim – removes leading spaces
-- RTRIM(string) | Right Trim – removes trailing spaces
-- LTRIM(RTRIM(string))	| Trims both sides (leading & trailing)
SELECT 
	SUM(CASE WHEN LTRIM(RTRIM(Url)) = '' THEN 1 ELSE 0 END) AS empty_url,
	SUM(CASE WHEN LTRIM(RTRIM(Zestimate)) = '' THEN 1 ELSE 0 END) AS empty_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM(Price)) = '' THEN 1 ELSE 0 END) AS empty_price,
	SUM(CASE WHEN LTRIM(RTRIM([Rent Zestimate])) = '' THEN 1 ELSE 0 END) AS empty_rent_zestimate,
	SUM(CASE WHEN LTRIM(RTRIM([Days On Zillow])) = '' THEN 1 ELSE 0 END) AS empty_days_on_zillow,
	SUM(CASE WHEN LTRIM(RTRIM(Bathrooms)) = '' THEN 1 ELSE 0 END) AS empty_bathrooms,
	SUM(CASE WHEN LTRIM(RTRIM(Bedrooms)) = '' THEN 1 ELSE 0 END) AS empty_bedrooms,
	SUM(CASE WHEN LTRIM(RTRIM([Living Area])) = '' THEN 1 ELSE 0 END) AS empty_living_area,
	SUM(CASE WHEN LTRIM(RTRIM([Lot Size])) = '' THEN 1 ELSE 0 END) AS empty_lot_size,
	SUM(CASE WHEN LTRIM(RTRIM([Home Type])) = '' THEN 1 ELSE 0 END) AS empty_home_type,
	SUM(CASE WHEN LTRIM(RTRIM([Street Address])) = '' THEN 1 ELSE 0 END) AS empty_street_address,
	SUM(CASE WHEN LTRIM(RTRIM(City)) = '' THEN 1 ELSE 0 END) AS empty_city,
	SUM(CASE WHEN LTRIM(RTRIM(Zip)) = '' THEN 1 ELSE 0 END) AS empty_zip,
	SUM(CASE WHEN LTRIM(RTRIM(State)) = '' THEN 1 ELSE 0 END) AS empty_state,
	SUM(CASE WHEN LTRIM(RTRIM(Country)) = '' THEN 1 ELSE 0 END) AS empty_country,
	SUM(CASE WHEN LTRIM(RTRIM([Broker Name])) = '' THEN 1 ELSE 0 END) AS empty_broker_name,
	SUM(CASE WHEN LTRIM(RTRIM([Has 3D Model])) = '' THEN 1 ELSE 0 END) AS empty_has_3d_model,
	SUM(CASE WHEN LTRIM(RTRIM([Has Image])) = '' THEN 1 ELSE 0 END) AS empty_has_image,
	SUM(CASE WHEN LTRIM(RTRIM([Has Video])) = '' THEN 1 ELSE 0 END) AS empty_has_video,
	SUM(CASE WHEN LTRIM(RTRIM(isZillowOwned)) = '' THEN 1 ELSE 0 END) AS empty_isZillowOwned,
	SUM(CASE WHEN LTRIM(RTRIM(sgapt)) = '' THEN 1 ELSE 0 END) AS empty_sgapt,
	SUM(CASE WHEN LTRIM(RTRIM(statusText)) = '' THEN 1 ELSE 0 END) AS empty_statusText,
	SUM(CASE WHEN LTRIM(RTRIM(statusType)) = '' THEN 1 ELSE 0 END) AS empty_statusType
FROM dbo.sales_properties_with_pool_zipcode_92284;

-- ...................................................................
-- ......... [2] CREATE VIEWS WITH PROPER DATA TYPE ..................
-- ...................................................................

-- ===================================================================
-- [2.1] CREATE VIEW: amenities
-- ===================================================================

CREATE OR ALTER VIEW amenities_datatype_fix AS
SELECT 
    -- Remove 'AIR' and convert unified_id to INT
    REPLACE(unified_id, 'AIR', '') AS unified_id,

    -- Convert 'YYYY-MM' to a DATE type by appending '-01'
    CAST(month + '-01' AS DATE) AS month_date,

	-- Convert hot_tub to INT
    CAST(hot_tub AS INT) AS hot_tub_int,

	-- Convert pool to INT
    CAST(pool AS INT) AS pool_int
FROM dbo.amenities;

-- Confirm data type change
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'amenities_datatype_fix'

-- View first few rows
SELECT *
FROM amenities_datatype_fix;

-- ===================================================================
-- [2.2] CREATE VIEW: geolocation
-- ===================================================================

CREATE VIEW geolocation_datatype_fix AS
SELECT 
    -- Remove 'AIR' and convert unified_id to INT
    REPLACE(unified_id, 'AIR', '') AS unified_id,

    -- Convert 'YYYY-MM' to DATE by appending '-01'
    CAST(month + '-01' AS DATE) AS month_date,

    street_name,
    latitude,
    longitude
FROM dbo.geolocation;

-- Confirm data type change
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'geolocation_datatype_fix'

-- View first few rows
SELECT *
FROM geolocation_datatype_fix;

-- ===================================================================
-- [2.3] CREATE VIEW: market_analysis
-- ===================================================================

CREATE OR ALTER VIEW market_analysis_datatype_fix AS
SELECT 
    unified_id,

    -- Convert 'YYYY-MM' to DATE by appending '-01'
    CAST(month + '-01' AS DATE) AS month_date,

    zipcode,

    -- Convert bedrooms to INT
    CAST(bedrooms AS INT) AS bedrooms_int,

    -- Convert bathrooms to INT
    CAST(bathrooms AS FLOAT) AS bathrooms_float,

    guests,

    -- Remove commas from revenue and convert to BIGINT
    CAST(REPLACE(revenue, ',', '.') AS FLOAT) AS revenue_float,

    -- Convert openness to INT
    CAST(openness AS INT) AS openness_int,

    city,
    host_type,

	-- Remove commas from occupancy and convert to FLOAT
    CAST(REPLACE(occupancy, ',', '.') AS FLOAT) AS occupancy_float,

	-- Remove commas from nightly rate and convert to FLOAT
	CAST(REPLACE([nightly rate], ',', '.') AS FLOAT) AS nightly_rate_float,

	-- Remove commas from lead time and convert to FLOAT
	CAST(REPLACE([lead time], ',', '.') AS FLOAT) AS lead_time_float,

	-- Remove commas from length stay and convert to FLOAT
	CAST(REPLACE([length stay], ',', '.') AS FLOAT) AS length_stay_float
FROM dbo.market_analysis;

-- Confirm data type change
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'market_analysis_datatype_fix'

-- View first few rows
SELECT *
FROM market_analysis_datatype_fix;

-- ===================================================================
-- [2.4] CREATE VIEW: market_analysis_2019
-- ===================================================================

CREATE OR ALTER VIEW market_analysis_2019_datatype_fix AS
SELECT 
    -- Remove 'AIR' and convert unified_id to INT
    REPLACE(unified_id, 'AIR', '') AS unified_id,

    -- Convert 'YYYY-MM' to DATE by appending '-01'
    CAST(month + '-01' AS DATE) AS month_date,

    zipcode,

    -- Convert bedrooms to INT
    CAST(bedrooms AS INT) AS bedrooms_int,

    -- Convert bathrooms to INT
    CAST(bathrooms AS FLOAT) AS bathrooms_float,

    guests,

    -- Remove commas from revenue and convert to BIGINT
    CAST(REPLACE(revenue, ',', '.') AS FLOAT) AS revenue_float,

    -- Convert openness to INT
    CAST(openness AS INT) AS openness_int,

    city,
    host_type,

	-- Remove commas from occupancy and convert to FLOAT
    CAST(REPLACE(occupancy, ',', '.') AS FLOAT) AS occupancy_float,

	-- Remove commas from nightly rate and convert to FLOAT
	CAST(REPLACE([nightly rate], ',', '.') AS FLOAT) AS nightly_rate_float,

	-- Remove commas from lead time and convert to FLOAT
	CAST(REPLACE([lead time], ',', '.') AS FLOAT) AS lead_time_float,

	-- Remove commas from length stay and convert to FLOAT
	CAST(REPLACE([length stay], ',', '.') AS FLOAT) AS length_stay_float
FROM dbo.market_analysis_2019;

-- Confirm data type change
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'market_analysis_2019_datatype_fix'

-- View first few rows
SELECT *
FROM market_analysis_2019_datatype_fix;

-- ===================================================================
-- [2.5] CREATE VIEW: sales_properties_total_zipcode_92252
-- ===================================================================

CREATE OR ALTER VIEW sales_properties_total_zipcode_92252_datatype_fix AS
SELECT
    Url AS url,
    Zestimate AS zestimate,
    CAST(Price AS INT) AS price,
    [Rent Zestimate] AS rent_zestimate,
    [Days On Zillow] AS days_on_zillow,
    CAST(Bathrooms AS INT) AS bathrooms,
    CAST(Bedrooms AS INT) AS bedrooms,
    [Living Area] AS living_area,
    [Lot Size] AS lot_size,
    [Home Type] AS home_type,
    [Street Address] AS street_address,
    City AS city,
    Zip AS zip,
    State AS state,
    Country AS country,
    [Broker Name] AS broker_name,
    [Has 3D Model] AS has_3d_model,
    [Has Image] AS has_image,
    [Has Video] AS has_video,
    isZillowOwned,
    sgapt,
    statusText,
    statusType
FROM dbo.sales_properties_total_zipcode_92252;

-- Confirm data type change
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_total_zipcode_92252_datatype_fix'

-- View first few rows
SELECT TOP 75 *
FROM sales_properties_total_zipcode_92252_datatype_fix;

-- ===================================================================
-- [2.6] CREATE VIEW: sales_properties_total_zipcode_92284
-- ===================================================================

CREATE OR ALTER VIEW sales_properties_total_zipcode_92284_datatype_fix AS
SELECT
    Url AS url,
    Zestimate AS zestimate,
    CAST(Price AS INT) AS price,
    [Rent Zestimate] AS rent_zestimate,
    [Days On Zillow] AS days_on_zillow,
    CAST(Bathrooms AS INT) AS bathrooms,
    CAST(Bedrooms AS INT) AS bedrooms,
    [Living Area] AS living_area,
    [Lot Size] AS lot_size,
    [Home Type] AS home_type,
    [Street Address] AS street_address,
    City AS city,
    Zip AS zip,
    State AS state,
    Country AS country,
    [Broker Name] AS broker_name,
    [Has 3D Model] AS has_3d_model,
    [Has Image] AS has_image,
    [Has Video] AS has_video,
    isZillowOwned,
    sgapt,
    statusText,
    statusType
FROM dbo.sales_properties_total_zipcode_92284;

-- Confirm data type change
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_total_zipcode_92284_datatype_fix'

-- View first few rows
SELECT TOP 75 *
FROM sales_properties_total_zipcode_92284_datatype_fix;

-- ===================================================================
-- [2.7] CREATE VIEW: sales_properties_total_zipcode_92314
-- ===================================================================

CREATE OR ALTER VIEW sales_properties_total_zipcode_92314_datatype_fix AS
SELECT
    Url AS url,
    Zestimate AS zestimate,
    CAST(Price AS INT) AS price,
    [Rent Zestimate] AS rent_zestimate,
    [Days On Zillow] AS days_on_zillow,
    CAST(Bathrooms AS INT) AS bathrooms,
    CAST(Bedrooms AS INT) AS bedrooms,
    [Living Area] AS living_area,
    [Lot Size] AS lot_size,
    [Home Type] AS home_type,
    [Street Address] AS street_address,
    City AS city,
    Zip AS zip,
    State AS state,
    Country AS country,
    [Broker Name] AS broker_name,
    [Has 3D Model] AS has_3d_model,
    [Has Image] AS has_image,
    [Has Video] AS has_video,
    isZillowOwned,
    sgapt,
    statusText,
    statusType
FROM dbo.sales_properties_total_zipcode_92314;

-- Confirm data type change
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_total_zipcode_92314_datatype_fix'

-- View first few rows
SELECT TOP 75 *
FROM sales_properties_total_zipcode_92314_datatype_fix;

-- ===================================================================
-- [2.8] CREATE VIEW: sales_properties_total_zipcode_92315
-- ===================================================================

CREATE OR ALTER VIEW sales_properties_total_zipcode_92315_datatype_fix AS
SELECT
    Url AS url,
    Zestimate AS zestimate,
    CAST(Price AS INT) AS price,
    [Rent Zestimate] AS rent_zestimate,
    [Days On Zillow] AS days_on_zillow,
    CAST(Bathrooms AS INT) AS bathrooms,
    CAST(Bedrooms AS INT) AS bedrooms,
    [Living Area] AS living_area,
    [Lot Size] AS lot_size,
    [Home Type] AS home_type,
    [Street Address] AS street_address,
    City AS city,
    Zip AS zip,
    State AS state,
    Country AS country,
    [Broker Name] AS broker_name,
    [Has 3D Model] AS has_3d_model,
    [Has Image] AS has_image,
    [Has Video] AS has_video,
    isZillowOwned,
    sgapt,
    statusText,
    statusType
FROM dbo.sales_properties_total_zipcode_92315;

-- Confirm data type change
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_total_zipcode_92315_datatype_fix'

-- View first few rows
SELECT TOP 75 *
FROM sales_properties_total_zipcode_92315_datatype_fix;

-- ===================================================================
-- [2.9] CREATE VIEW: sales_properties_with_pool_zipcode_92252
-- ===================================================================

CREATE OR ALTER VIEW sales_properties_with_pool_zipcode_92252_datatype_fix AS
SELECT
    Url AS url,
    Zestimate AS zestimate,
    CAST(Price AS INT) AS price,
    [Rent Zestimate] AS rent_zestimate,
    [Days On Zillow] AS days_on_zillow,
    CAST(Bathrooms AS INT) AS bathrooms,
    CAST(Bedrooms AS INT) AS bedrooms,
    [Living Area] AS living_area,
    [Lot Size] AS lot_size,
    [Home Type] AS home_type,
    [Street Address] AS street_address,
    City AS city,
    Zip AS zip,
    State AS state,
    Country AS country,
    [Broker Name] AS broker_name,
    [Has 3D Model] AS has_3d_model,
    [Has Image] AS has_image,
    [Has Video] AS has_video,
    isZillowOwned,
    sgapt,
    statusText,
    statusType
FROM dbo.sales_properties_with_pool_zipcode_92252;

-- Confirm data type change
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_with_pool_zipcode_92252_datatype_fix'

-- View first few rows
SELECT TOP 75 *
FROM sales_properties_with_pool_zipcode_92252_datatype_fix;

-- ===================================================================
-- [2.10] CREATE VIEW: sales_properties_with_pool_zipcode_92284
-- ===================================================================

CREATE OR ALTER VIEW sales_properties_with_pool_zipcode_92284_datatype_fix AS
SELECT
    Url AS url,
    Zestimate AS zestimate,
    CAST(Price AS INT) AS price,
    [Rent Zestimate] AS rent_zestimate,
    [Days On Zillow] AS days_on_zillow,
    CAST(Bathrooms AS INT) AS bathrooms,
    CAST(Bedrooms AS INT) AS bedrooms,
    [Living Area] AS living_area,
    [Lot Size] AS lot_size,
    [Home Type] AS home_type,
    [Street Address] AS street_address,
    City AS city,
    Zip AS zip,
    State AS state,
    Country AS country,
    [Broker Name] AS broker_name,
    [Has 3D Model] AS has_3d_model,
    [Has Image] AS has_image,
    [Has Video] AS has_video,
    isZillowOwned,
    sgapt,
    statusText,
    statusType
FROM dbo.sales_properties_with_pool_zipcode_92284;

-- Confirm data type change
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_properties_with_pool_zipcode_92284_datatype_fix'

-- View first few rows
SELECT TOP 75 *
FROM sales_properties_with_pool_zipcode_92284_datatype_fix;

-- ...................................................................
-- ....................... [3] MERGE TABLES ..........................
-- ...................................................................

-- ===================================================================
-- [3.1] MERGE TABLES: market_analysis, market_analysis_2019
-- ===================================================================

CREATE OR ALTER VIEW merged_market_analysis AS
SELECT * FROM market_analysis_2019_datatype_fix
UNION ALL
SELECT * FROM market_analysis_datatype_fix;

-- Confirm column contents
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'merged_market_analysis'

-- View first few rows
SELECT *
FROM merged_market_analysis;

-- ===================================================================
-- [3.2] MERGE TABLES: sales_properties_total_zipcode_92252, 92284, 92314, 92315
-- ===================================================================

CREATE OR ALTER VIEW merged_sales_properties AS
SELECT * FROM sales_properties_total_zipcode_92252_datatype_fix
UNION ALL
SELECT * FROM sales_properties_total_zipcode_92284_datatype_fix
UNION ALL
SELECT * FROM sales_properties_total_zipcode_92314_datatype_fix
UNION ALL
SELECT * FROM sales_properties_total_zipcode_92315_datatype_fix;

-- Confirm column contents
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'merged_sales_properties'

-- Confirm view contents
SELECT *
FROM merged_sales_properties;

-- ===================================================================
-- [3.3] MERGE TABLES: sales_properties_with_pool_zipcode_92252, 92284
-- ===================================================================

CREATE OR ALTER VIEW merged_sales_properties_with_pool AS
SELECT * FROM sales_properties_with_pool_zipcode_92252_datatype_fix
UNION ALL
SELECT * FROM sales_properties_with_pool_zipcode_92284_datatype_fix

-- Confirm column contents
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'merged_sales_properties_with_pool'

-- Confirm view contents
SELECT *
FROM merged_sales_properties_with_pool

-- ===================================================================
-- [3.4] MERGE NEW VIEWS: merged_sales_properties_total and merged_sales_properties_with_pool
-- ===================================================================

-- All pool contents are found in merged_sales_properties. Get the except rows and set pool = 0 
CREATE OR ALTER VIEW merged_sales_properties_added_column AS
SELECT 
    *, 
    0 AS pool
FROM (
    SELECT *
    FROM merged_sales_properties
    EXCEPT
    SELECT *
    FROM merged_sales_properties_with_pool
) AS diff;

-- All pool contents are found in merged_sales_properties. Get the except rows and set pool = 1
CREATE OR ALTER VIEW merged_sales_properties_with_pool_added_column AS
SELECT 
    *, 
    1 AS pool
FROM (
    SELECT *
    FROM merged_sales_properties
    INTERSECT
    SELECT *
    FROM merged_sales_properties_with_pool
) AS same;

-- Merge entris with pool = 0 and pool = 1
CREATE OR ALTER VIEW merged_sales_properties_final AS
SELECT *
FROM merged_sales_properties_added_column
UNION ALL
SELECT *
FROM merged_sales_properties_with_pool_added_column;

-- Confirm view contents
SELECT *
FROM merged_sales_properties_final

-- ...................................................................
-- .................. [-] List of Processed Views ....................
-- ...................................................................
-- amenities_datatype_fix
-- geolocation_datatype_fix
-- merged_market_analysis
-- merged_sales_properties_final

SELECT TOP 3 *
FROM amenities_datatype_fix

SELECT TOP 3 *
FROM geolocation_datatype_fix

SELECT TOP 3 *
FROM merged_market_analysis

SELECT TOP 3 *
FROM merged_sales_properties_final

-- ...................................................................
-- .................... [4] GENERATE INSIGHTS ........................
-- ...................................................................

-- ===================================================================
-- [4.1] GENERATE INSIGHTS TABLE: geolocation
-- ===================================================================

----------------------------------------------------------------------
-- [4.1.1] Number of street name
----------------------------------------------------------------------
SELECT street_name, COUNT(street_name) as count
FROM dbo.geolocation
GROUP BY street_name
ORDER BY count DESC;
-- most missing is "blank" 37722

SELECT COUNT(DISTINCT street_name) AS unique_street_name_count
FROM dbo.geolocation
WHERE LTRIM(RTRIM(street_name)) <> '';
-- total of 242 street_names

----------------------------------------------------------------------
-- [4.1.2] Total revenue per street
----------------------------------------------------------------------
SELECT 
    gdf.street_name,
    SUM(mma.revenue_float) AS total_revenue,
	MIN(mma.revenue_float) AS min_revenue,
	MAX(mma.revenue_float) AS max_revenue,
    COUNT(mma.revenue_float) AS count_revenue
FROM geolocation_datatype_fix gdf
LEFT JOIN merged_market_analysis mma
    ON gdf.unified_id = mma.unified_id
   AND gdf.month_date = mma.month_date
GROUP BY  
    gdf.street_name
ORDER BY 
    total_revenue DESC;

----------------------------------------------------------------------
-- [4.1.3] Total revenue per month
----------------------------------------------------------------------
SELECT 
    gdf.month_date AS year_month,
    SUM(mma.revenue_float) AS total_revenue,
    MIN(mma.revenue_float) AS min_revenue,
    MAX(mma.revenue_float) AS max_revenue,
    COUNT(mma.revenue_float) AS count_revenue
FROM geolocation_datatype_fix gdf
LEFT JOIN merged_market_analysis mma
    ON gdf.unified_id = mma.unified_id
   AND gdf.month_date = mma.month_date
GROUP BY  
    gdf.month_date
ORDER BY 
    gdf.month_date;

-- ===================================================================
-- [4.2] GENERATE INSIGHTS TABLE: merged_market_analysis
-- ===================================================================

----------------------------------------------------------------------
-- [4.2.1] Number of city
----------------------------------------------------------------------
SELECT city, COUNT(city) as count
FROM dbo.merged_market_analysis
GROUP BY city
ORDER BY count DESC;
-- city --> Big Bear Lake, Big Bear City, Joshua Tree, Yucca Valley

SELECT COUNT(DISTINCT city) AS unique_city_count
FROM dbo.merged_market_analysis
WHERE LTRIM(RTRIM(city)) <> '';

----------------------------------------------------------------------
-- [4.2.2] Min, Max, and Total revenue 
----------------------------------------------------------------------

SELECT 
    SUM(revenue_float) AS total_revenue,
    MIN(revenue_float) AS min_revenue,
	MAX(revenue_float) AS max_revenue,
	AVG(revenue_float) AS avg_revenue,
	STDEV(revenue_float) AS std_revenue
FROM merged_market_analysis
-- total: 783,667,004.119721
-- max  :     155,187.2168

----------------------------------------------------------------------
-- [4.2.2] Total revenue per month
----------------------------------------------------------------------
SELECT 
    month_date,
    SUM(revenue_float) AS total_revenue,
	MIN(revenue_float) AS min_revenue,
	MAX(revenue_float) AS max_revenue,
    COUNT(revenue_float) AS count_revenue,
	AVG(revenue_float) AS avg_revenue,
	STDEV(revenue_float) AS std_revenue
FROM merged_market_analysis
GROUP BY month_date
ORDER BY month_date;

----------------------------------------------------------------------
-- [4.2.2] Total revenue per city
----------------------------------------------------------------------
SELECT 
    city,
    SUM(revenue_float) AS total_revenue,
	MIN(revenue_float) AS min_revenue,
	MAX(revenue_float) AS max_revenue,
    COUNT(revenue_float) AS count_revenue,
	AVG(revenue_float) AS avg_revenue,
	STDEV(revenue_float) AS std_revenue
FROM merged_market_analysis
GROUP BY city
ORDER BY total_revenue;

----------------------------------------------------------------------
-- [4.2.3] Total revenue per city per month
----------------------------------------------------------------------
SELECT 
    city,
	month_date,
    SUM(revenue_float) AS total_revenue,
    COUNT(revenue_float) AS count_revenue,
	AVG(revenue_float) AS avg_revenue,
	STDEV(revenue_float) AS std_revenue
FROM merged_market_analysis
GROUP BY city, month_date
ORDER BY city, month_date;

-- ...................................................................
-- ......................... [5] AUXILLARY ...........................
-- ...................................................................

-- ===================================================================
-- [5.1] AUXILLARY TABLE: merged_market_analysis_modified
-- ===================================================================

-- This view replaces the city in merged_market_analysis with the mode (most frequent) city per street,
-- as derived from the joined geolocation data (ignoring blank street names).
CREATE OR ALTER VIEW merged_market_analysis_modified AS
WITH 
    -- ------------------------------------------------
    -- Step 1: Join geolocation and merged_market_analysis
    --         Filter out records with blank street names.
    -- ------------------------------------------------
    JoinedData AS (
        SELECT 
            g.unified_id,
            g.month_date,
            g.street_name,
            m.city AS orig_city
        FROM geolocation_datatype_fix g
        JOIN merged_market_analysis m
            ON g.unified_id = m.unified_id
           AND g.month_date = m.month_date
        WHERE LTRIM(RTRIM(g.street_name)) <> ''
    ),
    -- ------------------------------------------------
    -- Step 2: Count the frequency of each city per street.
    -- ------------------------------------------------
    CityCounts AS (
        SELECT 
            street_name, 
            orig_city AS city, 
            COUNT(*) AS city_count
        FROM JoinedData
        GROUP BY street_name, orig_city
    ),
    -- ------------------------------------------------
    -- Step 3: Determine the mode city per street using row_number.
    -- ------------------------------------------------
    ModeCity AS (
        SELECT 
            street_name, 
            city AS mode_city,
            ROW_NUMBER() OVER (PARTITION BY street_name ORDER BY city_count DESC) AS rn
        FROM CityCounts
    )
-- ------------------------------------------------
-- Final Step: Replace the original city with the mode city (if a non-blank street exists).
-- ------------------------------------------------
SELECT
    m.unified_id,
    m.month_date,
    m.zipcode,
    m.bedrooms_int,
    m.bathrooms_float,
    m.guests,
    m.revenue_float,
    m.openness_int,
    CASE 
        WHEN g.street_name IS NOT NULL THEN mc.mode_city
        ELSE m.city
    END AS city,
    m.host_type,
    m.occupancy_float,
    m.nightly_rate_float,
    m.lead_time_float,
    m.length_stay_float
FROM merged_market_analysis m
LEFT JOIN geolocation_datatype_fix g
    ON m.unified_id = g.unified_id
   AND m.month_date = g.month_date
LEFT JOIN ModeCity mc
    ON g.street_name = mc.street_name
   AND mc.rn = 1;

-----------------------------------------------------------
-- INSPECTION QUERY: Validate street and city associations
-----------------------------------------------------------
WITH JoinedData AS (
    SELECT 
        g.street_name,
        g.unified_id,
        m.city
    FROM geolocation_datatype_fix g
    JOIN merged_market_analysis_modified m -- Using the modified view
        ON g.unified_id = m.unified_id
       AND g.month_date = m.month_date
)
SELECT
    street_name,
    COUNT(DISTINCT unified_id) AS unique_unified_id_count,
    STUFF((
        SELECT DISTINCT ', ' + jd.city
        FROM JoinedData jd
        WHERE jd.street_name = j.street_name
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS associated_cities
FROM JoinedData j
GROUP BY street_name
ORDER BY street_name ASC;

-----------------------------------------------------------
-- COMPARISON QUERY: Validate original street and city associations
-----------------------------------------------------------
WITH JoinedData AS (
    SELECT 
        g.street_name,
        g.unified_id,
        m.city
    FROM geolocation_datatype_fix g
    JOIN merged_market_analysis m -- Original table
        ON g.unified_id = m.unified_id
       AND g.month_date = m.month_date
)
SELECT
    street_name,
    COUNT(DISTINCT unified_id) AS unique_unified_id_count,
    STUFF((
        SELECT DISTINCT ', ' + jd.city
        FROM JoinedData jd
        WHERE jd.street_name = j.street_name
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS associated_cities
FROM JoinedData j
GROUP BY street_name
ORDER BY street_name ASC;
