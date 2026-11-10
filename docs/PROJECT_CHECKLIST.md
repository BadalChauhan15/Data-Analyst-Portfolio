# Portfolio Quality Checklist

Use this checklist to track the quality and completeness of each portfolio project. Check an item only when the work is completed and documented.

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
- [x] Duplicate enrollment combinations have been investigated at record level.
- [x] Employee-client versus plan-client mismatches have been investigated at record level.
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
- Step 2 Task 1 (missing department/location) is investigated and documented.
- Step 2 Task 2 (enrollment status) is investigated; business meanings and approved standardization remain pending.
- Step 2 Task 3 (duplicate enrollment combinations) is investigated at record level; business validation remains pending.
- Step 2 Task 4 (employee/client versus plan/client mismatch) is investigated at record level; business validation and the historical 20-versus-22 count reconciliation remain pending.
- The current Task 4 mismatch count is 22 in database `benefits_analytics`; the Step 1 recorded baseline was 20.
- The 26 `plans.end_date` values set to `2025-12-31` during import remain an assumption to review, not a verified source value.
