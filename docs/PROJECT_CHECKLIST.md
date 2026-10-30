# Portfolio Quality Checklist

## Project 1 — Health & Welfare Benefits Analytics

### Business context and data
- [ ] Business problem and stakeholder are clearly defined.
- [x] Dataset is identified as synthetic and used for portfolio practice.
- [ ] Table grain and relationships are explained clearly.
- [ ] KPI definitions specify numerator, denominator, and reporting period.

### SQL and data quality
- [x] SQL investigation scripts are formatted and commented.
- [x] Initial data-quality checks and assumptions are documented.
- [x] Findings are distinguished from hypotheses and items requiring business validation.
- [ ] Duplicate enrollment combinations have been investigated at record level.
- [ ] Employee-client versus plan-client mismatches have been investigated at record level.
- [ ] Plan end dates and coverage periods have been validated.
- [ ] Approved cleaning rules are documented, with raw source data preserved.
- [ ] Results are validated against independent totals.

### Analysis and reporting
- [ ] Eligibility and enrollment metrics are calculated and validated.
- [ ] Business findings and recommendations are supported by evidence.
- [ ] Power BI dashboard is complete.
- [ ] Dashboard screenshots are readable and included in the project.
- [ ] README explains how to reproduce the work.

### Portfolio safety and presentation
- [ ] No credentials, real personal data, or employer-confidential information are included.
- [ ] Folder structure and file names are consistent.
- [ ] All project documentation reflects the latest verified results.

## Current Progress Note

- Step 1 initial profiling is documented.
- Step 2 Task 1 (missing department/location investigation) is completed.
- Step 2 Task 2 (enrollment status investigation) has been performed; business meanings and any approved status corrections remain to be validated.
- Step 2 Task 3 (duplicate enrollment investigation) is next.
- Step 2 Task 4 (employee/client versus plan/client mismatch investigation) is pending.
- The 26 `plans.end_date` values set to `2025-12-31` during import remain an assumption to review, not a verified source value.
