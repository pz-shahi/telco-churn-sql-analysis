-- 01_setup_and_import.sql
-- Creates the database and table, then imports the CSV (MySQL).
-- NOTE: adjust the file path and column types if your setup differs.

CREATE DATABASE IF NOT EXISTS telco_churn_analysis;
USE telco_churn_analysis;

CREATE TABLE IF NOT EXISTS telco_churn (
    customerID        VARCHAR(20),
    gender            VARCHAR(10),
    SeniorCitizen     TINYINT,
    Partner           VARCHAR(5),
    Dependents        VARCHAR(5),
    tenure            INT,
    PhoneService      VARCHAR(5),
    MultipleLines     VARCHAR(30),
    InternetService   VARCHAR(20),
    OnlineSecurity    VARCHAR(30),
    OnlineBackup      VARCHAR(30),
    DeviceProtection  VARCHAR(30),
    TechSupport       VARCHAR(30),
    StreamingTV       VARCHAR(30),
    StreamingMovies   VARCHAR(30),
    Contract          VARCHAR(20),
    PaperlessBilling  VARCHAR(5),
    PaymentMethod     VARCHAR(30),
    MonthlyCharges    DECIMAL(8,2),
    TotalCharges      VARCHAR(20),   -- stored as text in the source file; cleaned in step 02
    Churn             VARCHAR(5)
);

-- Allow loading a local file (run once; may require admin rights)
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/path/to/telco_churn.csv'
INTO TABLE telco_churn
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Verify the import: expect 7043
SELECT COUNT(*) AS total_rows FROM telco_churn;
SELECT * FROM telco_churn LIMIT 10;
