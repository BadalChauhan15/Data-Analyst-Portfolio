# Progress Snapshot — Data Analyst Portfolio

## Current status

**Project 1: Health & Welfare Benefits Analytics — Step 1 profiling documented.**  
**Next task:** Step 2 data-quality investigation.

## Completed

- Prepared a synthetic benefits dataset with five tables.
- Created/imported the data into MySQL Workbench.
- Verified table row counts: 10 clients, 2,000 employees, 31 plans, 6,172 eligibility records, and 2,918 enrollment records.
- Ran the initial data profiling checks:
  - Missing/blank employee department and location values.
  - Enrollment status distribution.
  - Repeated employee-plan-coverage combinations.
  - Employee-client versus plan-client mismatches.
- Documented actual results, interpretation, assumptions, and recommended actions in Project 1.

## Important assumption to revisit

During setup, 26 missing `plans.end_date` values were set to `2025-12-31` to resolve an import issue. This should be reviewed in Step 2. It is not a verified source value and should not be treated as a general data-cleaning rule.

## Next

1. Investigate all records flagged by Step 1.
2. Validate plan dates and coverage periods.
3. Document approved data-cleaning rules without overwriting raw source data.
4. Build validated eligibility/enrollment metrics.
5. Create a Power BI report and record progress in `docs/progress_tracker.csv`.
