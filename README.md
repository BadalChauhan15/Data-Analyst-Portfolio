# Data Analyst Portfolio

A project-based portfolio documenting hands-on practice in SQL, Excel, Power BI, and business analysis. Projects use synthetic or properly licensed public data.

## Projects

| Project | Status | Tools | Focus |
|---|---|---|---|
| [01 — Health & Welfare Benefits Analytics](projects/01-health-welfare-benefits-analytics/README.md) | Step 1 documented; Step 2 investigations reported complete, validation pending | MySQL; Power BI specification | Eligibility, enrollment, data quality |
| [02 — Retail Sales & Customer Analytics](projects/02-retail-sales-analytics/README.md) | Planned | SQL, Excel, Power BI | Revenue, products, customers |
| [03 — Operations & Data Quality Analytics](projects/03-operations-data-quality-analytics/README.md) | Planned | SQL, Excel, Power BI | Turnaround time, SLA, exceptions |

## Current progress

- [x] Created the synthetic Project 1 dataset and documented its table structure.
- [x] Imported the five tables into MySQL and verified 12,131 total records.
- [x] Ran the four Step 1 data-profiling checks and documented the results provided during the project.
- [x] Record the reported Step 2 investigations for missing fields, enrollment statuses, repeated enrollment keys, and employee/plan client mismatches.
- [ ] Reconcile the Step 1 versus Step 2 mismatch count and validate the business rules and assumed plan end dates.
- [ ] Complete eligibility and enrollment analysis.
- [ ] Build and validate a Power BI dashboard.

The recorded Step 2 findings are aggregate summaries reported during the project; rerun the SQL against the source data before treating them as independently reproduced. The package does not include row-level SQL exports, a completed Power BI `.pbix`, or genuine dashboard screenshots. Power BI materials are specifications and build guidance only.

## How to use this repository

Start with `LEARNING_ORDER.md` and `projects/01-health-welfare-benefits-analytics/README.md`. Review `docs/PROJECT_BRIEF.md`, follow the SQL scripts in order, and record measured results rather than assuming or inventing values. See `projects/01-health-welfare-benefits-analytics/results/verified/` for the reported aggregate summaries and `powerbi/` for the report specification.

## Working principles

- Start with a business question.
- Preserve raw data and document assumptions.
- Validate calculations and table grain.
- Separate findings from hypotheses.
- Never publish employer-confidential data, real client/employee records, credentials, or secrets.
