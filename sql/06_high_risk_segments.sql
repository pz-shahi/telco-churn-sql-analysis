-- 06_high_risk_segments.sql

-- A. Inside month-to-month + electronic check: internet service x tech support
SELECT InternetService, TechSupport,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
WHERE Contract = 'Month-to-month' AND PaymentMethod = 'Electronic check'
GROUP BY InternetService, TechSupport
ORDER BY churn_rate DESC;

-- B. Profile: high-risk segment vs everyone else
SELECT CASE WHEN Contract = 'Month-to-month' AND PaymentMethod = 'Electronic check'
            THEN 'High-risk segment' ELSE 'All other customers' END AS grp,
       COUNT(*) AS customers,
       ROUND(AVG(tenure), 1) AS avg_tenure,
       ROUND(AVG(MonthlyCharges), 2) AS avg_monthly,
       ROUND(SUM(InternetService = 'Fiber optic') * 100.0 / COUNT(*), 1) AS pct_fiber,
       ROUND(SUM(TechSupport = 'No') * 100.0 / COUNT(*), 1) AS pct_no_tech_support
FROM telco_churn
GROUP BY grp;

-- C. Three-factor segment: month-to-month + fiber + no tech support (expect 57.52%)
SELECT COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
WHERE Contract = 'Month-to-month'
  AND InternetService = 'Fiber optic'
  AND TechSupport = 'No';
