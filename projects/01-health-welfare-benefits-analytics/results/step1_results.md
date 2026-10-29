# Step 1 — Data Profiling Results

## 1. Objective

In this step, I reviewed the dataset structure and ran initial data-quality checks on the synthetic Health & Welfare Benefits Analytics dataset. The goal was to establish a baseline and identify issues that may affect later analysis.

## 2. Dataset Row Counts

| Table | Row Count |
|---|---:|
| Clients | 10 |
| Employees | 2,000 |
| Plans | 31 |
| Eligibility | 6,172 |
| Enrollments | 2,918 |
| **Total** | **12,131** |

The five tables contain 12,131 records in total. These counts give us a starting point for further validation, but row counts alone do not confirm that the data is complete or accurate.

## 3. Profiling Results

### Task 1 — Missing Department and Location Values

**Actual results:**

| Data-quality check | Missing or blank records | Percentage of employees |
|---|---:|---:|
| Department | 17 | 0.85% |
| Location | 13 | 0.65% |

Percentages are calculated using the 2,000 employee records.

**Interpretation:**

- **Department:** 17 employee records (0.85%) have a missing or blank department value. This could affect department-level reporting and workforce comparisons.
- **Location:** 13 employee records (0.65%) have a missing or blank location value. This could affect location-based summaries.
- **Overall:** Both rates are below 1%, but the affected records should still be reviewed before using these fields in reports.

**Recommended actions:**

1. Identify the affected records using `employee_id`.
2. Check a reliable source to see whether the missing values can be confirmed.
3. Fill in values only when they can be verified.
4. If a value cannot be confirmed, keep it missing or use a consistent label such as `Unknown`, depending on the reporting rules.
5. Document any changes and rerun the query.

Do not delete records or guess values simply to remove missing data.

### Task 2 — Enrollment Status Distribution

**Actual results:**

| Enrollment Status | Record Count | Percentage |
|---|---:|---:|
| Active | 2,625 | 89.96% |
| Pending | 162 | 5.55% |
| Cancelled | 117 | 4.01% |
| Unknown | 6 | 0.21% |
| ACTIVE | 6 | 0.21% |
| In progress | 2 | 0.07% |
| **Total** | **2,918** | **100.00%** |

**Interpretation:**

Most enrollment records are labelled `Active` (2,625 records, or 89.96%). Another 162 records are `Pending` (5.55%), and 117 are `Cancelled` (4.01%). The remaining records are labelled `Unknown` (6), `ACTIVE` (6), and `In progress` (2).

**Data-quality observations:**

- `Active` and `ACTIVE` appear as separate categories, which may be a capitalization inconsistency.
- The six `Unknown` records need to be checked to understand whether the status is genuinely unavailable.
- The meaning of `In progress` should be confirmed before deciding whether it needs to remain a separate status.

**Recommended actions:**

1. Confirm whether `Active` and `ACTIVE` mean the same thing before standardizing the labels.
2. Investigate the `Unknown` and `In progress` records.
3. Preserve the original values before making any changes.
4. Rerun the query after any approved cleanup to check the updated distribution.

### Task 3 — Duplicate Enrollment Business Combinations

**Actual results:**

The query returned **24 repeated combinations** based on `employee_id`, `plan_id`, `coverage_start_date`, and `coverage_end_date`.

The 24 combinations each contain two records, for 48 records involved and 24 records beyond one record per combination.

**Interpretation:**

The results show that the same employee, plan, and coverage period appear together more than once for 24 combinations. This may indicate duplicate enrollment records, but the query does not prove that the records are erroneous. There may be business reasons for a combination to appear more than once.

**Recommended actions:**

1. Review each of the 24 combinations.
2. Compare the associated `enrollment_id` and `enrollment_status` values to see whether the records differ.
3. Check the business rules to determine whether repeated combinations are permitted.
4. Remove records only if they are confirmed to be invalid duplicates and the correction is approved.
5. Rerun the query after any approved changes.

### Task 4 — Employee/Client versus Plan/Client Mismatch

**Actual results:**

The query returned **20 mismatched enrollment records** where the employee's client ID differs from the associated plan's client ID.

**Interpretation:**

These 20 records may indicate a data-integrity issue because employees would generally be expected to enroll in plans associated with their own client. However, the query identifies a mismatch; it does not establish that every record is incorrect. The results should be checked against the applicable business rules and source records.

**Recommended actions:**

1. Review the 20 flagged enrollment records.
2. Verify the employee's client assignment and the plan's client assignment.
3. Confirm whether cross-client enrollment is allowed under the business rules.
4. Correct a record only when the discrepancy and the correct value have been verified.
5. Rerun the query after approved corrections to confirm the outcome.

## 4. Step 1 Summary

The initial profiling established a baseline of 12,131 records across five tables and identified several areas that need further review.

| Check | Finding | Potential impact |
|---|---|---|
| Missing departments | 17 employee records (0.85%) | May affect department-level reporting |
| Missing locations | 13 employee records (0.65%) | May affect location-based analysis |
| Enrollment statuses | Six distinct status labels | May affect consistent status reporting |
| Repeated enrollment combinations | 24 combinations; 48 records involved, assuming each combination appears twice | May indicate duplicate records or valid repeated business events |
| Employee/client versus plan/client mismatch | 20 enrollment records | May indicate an incorrect client or plan assignment |

### Key Takeaways

1. A small number of employee records are missing department or location information.
2. Enrollment statuses may need standardization, but the business meaning of each label should be confirmed first.
3. The duplicate check found repeated business-key combinations that need investigation before any records are removed.
4. Twenty enrollment records have different client IDs for the employee and associated plan. These should be checked against the business rules.
5. The findings are signals for further investigation, not proof that every flagged record is incorrect.

### Conclusion

Step 1 provides an initial view of the dataset's structure and data quality. Before using the data for deeper analysis, I would investigate the flagged records, confirm the relevant business rules, document any approved corrections, and rerun the checks to validate the results.

## 5. Scope and Assumptions

### Scope

This step covers initial profiling in MySQL, including:

- Validating row counts in the `clients`, `employees`, `plans`, `eligibility`, and `enrollments` tables.
- Checking for missing or blank department and location values in `employees`.
- Reviewing the distribution of enrollment statuses.
- Finding repeated combinations of `employee_id`, `plan_id`, `coverage_start_date`, and `coverage_end_date`.
- Finding enrollment records where the employee's client ID differs from the plan's client ID.
- Documenting findings and recommended follow-up actions.

### Assumptions and Limitations

1. **Synthetic data:** This dataset is for portfolio practice and does not represent verified production data from a real employer or benefits provider.
2. **Row counts:** The verified counts are 10 clients, 2,000 employees, 31 plans, 6,172 eligibility records, and 2,918 enrollment records.
3. **Missing values:** Department and location are treated as missing when the value is `NULL` or contains only blank spaces.
4. **Status labels:** The status counts reflect the values returned by the query. Similar-looking labels should only be combined after their meanings are confirmed.
5. **Repeated combinations:** A repeated combination is a potential duplicate, not automatic proof of an erroneous record. The reported total of 48 records and 24 excess records assumes each of the 24 combinations appears exactly twice.
6. **Client mismatch:** The check flags records where the employee's `client_id` differs from the plan's `client_id`. It assumes these IDs should normally match, subject to confirmation of the business rules and any exceptions.
7. **No unverified changes:** Records should not be deleted, reassigned, or modified just because a query flags them.
8. **No database changes in this step:** This document records profiling findings and recommendations; it does not imply that any data was changed.
9. **Percentage calculations:** Missing department and location percentages use 2,000 employees as the denominator. Enrollment status percentages use 2,918 enrollment records.

### Deliverable

The deliverable for Step 1 is a documented baseline of table sizes, data-quality findings, interpretations, and recommended follow-up checks. These findings will guide the next stage of data quality investigation and preparation.
