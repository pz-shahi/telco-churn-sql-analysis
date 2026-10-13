# Telco Customer Churn Analysis (SQL)

A product analytics case study: who churns, when, and what a product team can do about it. Built in **MySQL** on the IBM Telco Customer Churn dataset (7,043 customers, 21 columns).

## Key findings

| Finding | Result |
|---|---|
| Overall churn | 26.54% (1,869 of 7,043) |
| Month-to-month vs two-year contract | 42.71% vs 2.83% |
| First 12 months vs 49+ months | 47.44% vs 9.51% |
| Fiber vs DSL | 41.89% vs 18.96% |
| Fiber, no tech support | 49.37% (vs 22.63% with tech support) |
| Highest-risk segment: month-to-month + fiber + no tech support | 57.52% churn; 25.5% of customers, about 55% of all churn |

Findings are descriptive associations, not proof of causation.

## Repo structure

```
sql/
  01_setup_and_import.sql          create database/table, import CSV
  02_data_quality_and_cleaning.sql duplicates, blank TotalCharges, numeric column
  03_overall_contract_payment.sql  overall churn, contract, charges, payment, contract x payment
  04_tenure_analysis.sql           tenure buckets, tenure within month-to-month
  05_service_drivers.sql           internet service, tech support, online security, pricing
  06_high_risk_segments.sql        segment deep dive
data/                              put telco_churn.csv here (not committed)
docs/                              report PDF and slide deck PDF
```

## How to run

1. Download the dataset into `data/` (see `data/README.md`).
2. Run the scripts in `sql/` in order (01 to 06) in MySQL.

## Data cleaning notes

- No duplicate customers.
- 11 blank `TotalCharges` rows, all new customers (tenure 0, not churned). Kept in the analysis, stored as NULL in a new numeric column `TotalCharges_num`.

## Recommendations (summary)

1. Bundle or trial tech support for fiber, month-to-month customers.
2. Build a first-year onboarding and check-in program.
3. Offer incentives to move month-to-month customers to longer contracts.
4. Run an A/B test (90-day churn) before scaling.

## Limitations and next steps

Descriptive analysis only; no significance testing or predictive model yet. Next: churn prediction model in Python, significance tests, dashboard, and the A/B test.

## Author

Pantea Shahrokhi
