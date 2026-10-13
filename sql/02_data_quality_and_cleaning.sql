-- 02_data_quality_and_cleaning.sql

-- 1. Duplicate customers? (expect 7043 rows = 7043 unique)
SELECT COUNT(*) AS total_rows, COUNT(DISTINCT customerID) AS unique_customers
FROM telco_churn;

-- 2. Blank TotalCharges values (expect 11)
SELECT COUNT(*) AS blank_total_charges
FROM telco_churn
WHERE TRIM(TotalCharges) = '';

-- 3. Inspect them (all are tenure 0, Churn = 'No': new customers not yet billed)
SELECT customerID, tenure, MonthlyCharges, TotalCharges, Churn
FROM telco_churn
WHERE TRIM(TotalCharges) = '';

-- 4. Unexpected values in key categorical columns
SELECT Churn, COUNT(*) FROM telco_churn GROUP BY Churn;
SELECT Contract, COUNT(*) FROM telco_churn GROUP BY Contract;
SELECT InternetService, COUNT(*) FROM telco_churn GROUP BY InternetService;

-- 5. Add a clean numeric column. Blanks become NULL (not billed yet), not 0.
--    Run the ALTER once; it errors if the column already exists.
ALTER TABLE telco_churn ADD COLUMN TotalCharges_num DECIMAL(10,2);

-- If MySQL blocks the UPDATE (safe update mode): SET SQL_SAFE_UPDATES = 0;
UPDATE telco_churn
SET TotalCharges_num = CAST(NULLIF(TRIM(TotalCharges), '') AS DECIMAL(10,2));

-- 6. Verify: expect 7032 non-null and 11 null
SELECT COUNT(TotalCharges_num) AS non_null,
       SUM(TotalCharges_num IS NULL) AS nulls
FROM telco_churn;
