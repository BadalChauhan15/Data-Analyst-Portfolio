# Health & Welfare Benefits Analytics

**Status:** Step 1 documented; Step 2 investigations reported complete, with business validation pending
**Tools:** MySQL / MySQL Workbench; Power BI report specification provided
**Data:** Synthetic dataset created for portfolio practice

## Business scenario

A fictional benefits administrator wants to understand employee eligibility, enrollment participation, and data-quality exceptions across medical, dental, and vision plans.

## Business questions

1. How many employee-plan pairs are eligible?
2. What proportion of eligible employee-plan pairs have valid active enrollment?
3. How does participation vary by client, benefit type, and location?
4. Which data-quality exceptions need investigation?
5. What assumptions and limitations affect the results?

## Dataset tables

| Table | Grain |
|---|---|
| `clients` | One row per fictional employer/client |
| `employees` | One row per fictional employee |
| `plans` | One row per fictional benefit plan |
| `eligibility` | One row per eligibility record for an employee-plan pair |
| `enrollments` | One row per enrollment record; the synthetic data includes intentional quality issues |

## Verified row counts

| Table | Rows |
|---|---:|
| `clients` | 10 |
| `employees` | 2,000 |
| `plans` | 31 |
| `eligibility` | 6,172 |
| `enrollments` | 2,918 |
| **Total** | **12,131** |

## Project files

- `data/raw/` — original synthetic CSV files
- `sql/00_create_schema.sql` — database/table setup
- `sql/00b_loading_guide.sql` — CSV import notes
- `sql/00_row_count_validation.sql` — row-count validation
- `sql/01_data_profiling.sql` — Step 1 profiling queries
- `sql/02_analysis_queries.sql` — initial analysis query examples
- `documentation/data_dictionary.md` — table and field descriptions
- `documentation/kpi_definitions.md` — proposed KPI definitions
- `documentation/step1_data_profiling.md` — profiling method and questions
- `results/step1_results.md` — findings and interpretation from Step 1
- `results/task3_duplicate_combinations.csv` — duplicate-combination output supplied during analysis

## Step 1 — Completed profiling

The initial checks covered:
1. Missing or blank department and location values.
2. Enrollment status distribution.
3. Repeated employee-plan-coverage combinations.
4. Employee-client versus plan-client mismatches.

See [`results/step1_results.md`](results/step1_results.md) for the recorded results and recommended follow-up actions.

## Step 2 — Investigations reported

- Missing fields: 17 employees have missing department values, 13 have missing locations, 0 have both missing, and 30 have either field missing.
- Enrollment statuses: seven source values were reported; the 8 `Unknown` or `In progress` records had employee and plan references. Their business meanings remain unconfirmed.
- Repeated enrollment keys: 24 combinations across 48 records were reported, each occurring twice (23 Active pairs and one Cancelled pair). These are potential duplicates pending business validation.
- Employee/plan client mismatches: 22 records across 20 client pairs were reported, with no missing references or repeated business keys among them. The Step 1 baseline of 20 remains unreconciled.

These aggregate findings were reported during the project and have not been independently rerun as part of this package merge. See [`results/verified/`](results/verified/) for the summaries and [`results/PENDING_RESULTS.md`](results/PENDING_RESULTS.md) for outstanding work. No row-level SQL result exports were supplied.

## Assumption requiring review

During import setup, 26 missing `plans.end_date` values were set to `2025-12-31` so the eligibility data could be imported. This is a temporary project assumption, not a generally valid imputation rule. Review those records during Step 2 and do not treat the assumed dates as verified source values.

## Next steps

1. Re-run the Step 2 queries and save genuine row-level outputs as needed.
2. Reconcile the mismatch count of 20 versus 22, validate duplicate and eligibility rules, and review the 26 assumed plan end dates against source rules.
3. Define eligibility and enrollment business rules.
4. Calculate and validate enrollment metrics at a consistent employee-plan grain.
5. Build the Power BI dashboard from the supplied specifications, then save the real `.pbix` and genuine screenshots. The package does not include a completed `.pbix` or dashboard images.

## Data and privacy note

This project uses synthetic data. Do not add employer-confidential information, real employee/client records, credentials, or database passwords to the repository.
