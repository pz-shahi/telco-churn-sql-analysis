-- 04_tenure_analysis.sql

-- A. Average tenure: churned vs stayed
SELECT Churn,
       COUNT(*) AS customers,
       ROUND(AVG(tenure), 1) AS avg_tenure_months
FROM telco_churn
GROUP BY Churn;

-- B. Churn rate by tenure bucket
SELECT CASE WHEN tenure <= 12 THEN '1) 0-12 months'
            WHEN tenure <= 24 THEN '2) 13-24 months'
            WHEN tenure <= 48 THEN '3) 25-48 months'
            ELSE '4) 49+ months' END AS tenure_group,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
GROUP BY tenure_group
ORDER BY tenure_group;

-- C. Does tenure still matter inside month-to-month contracts? (controls for contract)
SELECT CASE WHEN tenure <= 12 THEN '1) 0-12 months'
            WHEN tenure <= 24 THEN '2) 13-24 months'
            WHEN tenure <= 48 THEN '3) 25-48 months'
            ELSE '4) 49+ months' END AS tenure_group,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
WHERE Contract = 'Month-to-month'
GROUP BY tenure_group
ORDER BY tenure_group;
