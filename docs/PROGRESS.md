# Progress Snapshot — Data Analyst Portfolio

## Current Status

**Project 1: Health & Welfare Benefits Analytics — Step 1 completed; Step 2 in progress.**

**Current focus:** Step 2 data-quality investigation.

- Step 1: Initial data profiling documented.
- Step 2, Task 1: Missing department and location investigation completed.
- Step 2, Task 2: Enrollment status investigation completed for the records and checks performed so far.
- Step 2, Task 3: Duplicate enrollment investigation is next.
- Step 2, Task 4: Employee/client versus plan/client mismatch investigation is still pending.

## Completed

### Project Setup and Dataset

- Prepared a synthetic benefits dataset containing five tables.
- Created and imported the dataset into MySQL Workbench.
- Verified the table row counts:
  - Clients: 10
  - Employees: 2,000
  - Plans: 31
  - Eligibility: 6,172
  - Enrollments: 2,918
  - **Total: 12,131 records**

### Step 1 — Initial Data Profiling

Completed and documented the following checks:

- Missing or blank employee department values: 17 (0.85%).
- Missing or blank employee location values: 13 (0.65%).
- Enrollment status distribution.
- Repeated employee-plan-coverage combinations: 24 combinations identified.
- Employee-client versus plan-client mismatches: 20 records identified.

The Step 1 findings, interpretations, assumptions, and recommended actions are documented in:

`projects/01-health-welfare-benefits-analytics/results/step1_results.md`

### Step 2 — Data Quality Investigation

**Task 1: Missing department and location — investigated**

- 17 employees have a missing or blank department.
- 13 employees have a missing or blank location.
- 0 employees have both fields missing.
- The query for either missing field returned 30 employee records.

**Task 2: Enrollment status — investigated**

The status distribution contains seven distinct source values:

| Enrollment Status | Record Count |
|---|---:|
| Active | 2,621 |
| Pending | 162 |
| Cancelled | 117 |
| Unknown | 6 |
| ACTIVE | 6 |
| active | 4 |
| In progress | 2 |
| **Total** | **2,918** |

Additional investigation findings:

- `Active`, `ACTIVE`, and `active` appear to be capitalization variations. Their equivalence should be confirmed before standardization.
- The `HEX()` and `LENGTH()` checks showed no trailing spaces in these three status variations.
- All 6 `Unknown` records and both `In progress` records were inspected. Their employee IDs, plan IDs, and coverage dates were populated.
- A `LEFT JOIN` reference check returned 0 rows, confirming that all 8 records matched employee and plan records in their respective tables.
- The correct business meaning of `Unknown` and `In progress` has not yet been established. No status values have been changed.

The Step 2 investigation and current findings are documented in:

`projects/01-health-welfare-benefits-analytics/results/step2_results.md`

The investigation queries are saved in:

`projects/01-health-welfare-benefits-analytics/sql/02_data_quality_investigation.sql`

## Important Assumption to Revisit

During dataset setup, 26 missing `plans.end_date` values were set to `2025-12-31` to resolve an import issue.

This date is an assumption, not a verified source value. It must be reviewed against the dataset's business rules before it is treated as correct. Keep the original raw data unchanged and document any approved transformation separately.

## Next Steps

1. **Step 2, Task 3:** Investigate the 24 repeated enrollment business-key combinations. Compare the individual enrollment IDs and statuses, and verify whether each combination occurs exactly twice.
2. **Step 2, Task 4:** Investigate the 20 employee/client versus plan/client mismatches and validate them against the applicable business rules.
3. Review the 26 assumed plan end dates and validate coverage dates against plan effective dates.
4. Document confirmed data-quality issues and approved cleaning rules without overwriting the raw source data.
5. Build validated eligibility and enrollment metrics.
6. Create a Power BI report and record progress in `docs/progress_tracker.csv`.

## Working Principles

- Keep raw source files unchanged.
- Use read-only queries during investigation.
- Do not delete or update records solely because a query flags them.
- Confirm business rules and source values before applying corrections.
- Record actual query results and assumptions in the project documentation.
