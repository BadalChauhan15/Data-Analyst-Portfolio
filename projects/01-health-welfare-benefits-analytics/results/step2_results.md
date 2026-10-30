# Step 2 — Data Quality Investigation Results

## 1. Objective

In Step 1, the initial profiling checks highlighted missing employee attributes, inconsistent enrollment status labels, repeated enrollment combinations, and employee/plan client mismatches.

The purpose of Step 2 is to inspect the affected records, understand the nature of each finding, and identify what needs to be checked against source data or business rules before any changes are made.

All queries in this step are read-only `SELECT` statements. No records are updated or deleted.

## 2. Investigation Results

### Task 1 — Missing Department and Location Values

**Investigation performed:**

Retrieved employees with a missing or blank department, employees with a missing or blank location, employees with both fields missing, and employees with either field missing.

**Actual results:**

| Check | Employee records |
|---|---:|
| Missing or blank department | 17 |
| Missing or blank location | 13 |
| Both department and location missing | 0 |
| Either department or location missing | 30 |

**Interpretation:**

The investigation returned 30 employee records with at least one missing attribute. Seventeen records have a missing department and 13 have a missing location. No employee was found with both fields missing.

The two groups therefore contain separate employee records. The affected values should be checked against a reliable source before any correction is made.

**Recommended actions:**

1. Review the affected employees using their `employee_id`.
2. Verify missing values against an approved source.
3. Populate a value only when it can be confirmed.
4. Retain unresolved values as missing or use an agreed reporting label such as `Unknown`.
5. Rerun the checks after any approved correction.

### Task 2 — Enrollment Status Investigation

**Investigation performed:**

The Step 1 distribution showed six status labels. The Step 2 detail query retrieves individual records with `Unknown`, `In progress`, or `ACTIVE` labels for review.

**Step 1 actual results:**

| Enrollment Status | Record Count |
|---|---:|
| Active | 2,625 |
| Pending | 162 |
| Cancelled | 117 |
| Unknown | 6 |
| ACTIVE | 6 |
| In progress | 2 |
| **Total** | **2,918** |

**Step 2 record-level results:**

The status-formatting query identified seven distinct enrollment status values across 2,918 records.

| Enrollment Status | Record Count | Percentage |
|---|---:|---:|
| Active | 2,621 | 89.89% |
| Pending | 162 | 5.55% |
| Cancelled | 117 | 4.01% |
| Unknown | 6 | 0.21% |
| ACTIVE | 6 | 0.21% |
| active | 4 | 0.14% |
| In progress | 2 | 0.07% |
| **Total** | **2,918** | **100.00%** |

**Key findings:**

1. **Inconsistent capitalization:** The values `Active`, `ACTIVE`, and `active` appear as separate categories. Together, they account for 2,631 records. They may represent the same enrollment status, but this should be confirmed before standardization.
2. **No trailing spaces detected:** The `HEX()` and `LENGTH()` checks show that the three capitalization variations do not contain trailing spaces.
3. **Unknown status:** Six records have an `Unknown` status. Their business meaning needs to be investigated.
4. **In progress status:** Two records have an `In progress` status. These should be reviewed to understand whether this is a valid enrollment stage.

**Interpretation:**

The investigation identified inconsistent capitalization in the enrollment status field. This can lead to fragmented reporting because the same apparent status is counted under separate categories.

The `Unknown` and `In progress` values also require further review. Although the affected records have valid employee IDs and plan IDs, this alone does not confirm that their enrollment statuses are correct.

**Recommended actions:**

1. Confirm whether `Active`, `ACTIVE`, and `active` represent the same business status.
2. If confirmed, standardize these values to `Active`.
3. Investigate the six `Unknown` records.
4. Confirm the business meaning of the two `In progress` records.
5. Preserve the original values and document any approved transformations.
6. Re-run the status distribution query after approved corrections.

#### Investigation of `In progress` Records

**Actual results:**

The query returned two enrollment records with an `In progress` status.

| Enrollment ID | Employee ID | Plan ID | Coverage Start Date | Coverage End Date |
|---|---|---|---|---|
| EN0001123 | E00786 | P031 | 2025-02-06 | 2025-12-31 |
| EN001580 | E01102 | P005 | 2025-02-13 | 2025-12-31 |

**Interpretation:**

Both records contain valid enrollment, employee, and plan identifiers. Their coverage start and end dates are also populated.

However, the enrollment status remains `In progress` for both records. The available data does not establish why these enrollments have not moved to another status.

**Recommended actions:**

1. Verify whether `In progress` is a valid enrollment status under the business rules.
2. Check whether additional enrollment processing or approval is required.
3. Confirm whether these records should remain `In progress` or transition to another status.
4. Do not change the status without verifying the applicable business rules.

#### Investigation of `Unknown` Enrollment Records

**Actual results:**

The query returned six enrollment records with an `Unknown` status.

| Enrollment ID | Employee ID | Plan ID | Coverage Start Date | Coverage End Date |
|---|---|---|---|---|
| EN0000108 | E00064 | P017 | 2025-01-25 | 2025-12-31 |
| EN0000111 | E00065 | P030 | 2025-02-15 | 2025-12-23 |
| EN0000704 | E00489 | P015 | 2025-01-10 | 2025-12-31 |
| EN0000839 | E00582 | P021 | 2025-02-11 | 2025-12-31 |
| EN0000887 | E00616 | P027 | 2025-02-13 | 2025-12-31 |
| EN0001572 | E01098 | P029 | 2025-01-14 | 2025-12-31 |

**Interpretation:**

All six records have populated employee IDs, plan IDs, coverage start dates, and coverage end dates.

Five records have a coverage end date of `2025-12-31`, while one record has a coverage end date of `2025-12-23`.

Although the enrollment and coverage information is populated, all six records still have an `Unknown` enrollment status. This indicates that the status requires further investigation. The available information does not establish what the correct enrollment status should be.

**Recommended actions:**

1. Verify whether `Unknown` is an accepted enrollment status under the business rules.
2. Check the original enrollment source records to identify whether the correct status is available.
3. Review whether these records were created through an incomplete enrollment or data integration process.
4. Update the status only after confirming the correct value from a reliable source.
5. Preserve the original status values for audit and traceability.

#### Employee and Plan Reference Validation

**Actual results:**

The reference validation query returned 0 records.

| Validation check | Result |
|---|---:|
| Records investigated | 8 |
| Missing employee references | 0 |
| Missing plan references | 0 |
| Mismatched references | 0 |

**Interpretation:**

All six records with an `Unknown` status and both records with an `In progress` status have matching employee and plan references in their respective tables.

No missing employee or plan references were identified during this validation.

This indicates that the issue with these eight records is related to their enrollment status classification rather than missing employee or plan references.

However, the correct enrollment status cannot be determined from reference validation alone.

**Recommended actions:**

1. Retain the existing employee and plan references.
2. Verify the enrollment statuses against reliable source records or business rules.
3. Avoid changing the statuses without confirmation.
4. Document any approved status corrections for traceability.

### Task 3 — Duplicate Enrollment Business Combinations

**Investigation performed:**

The Step 1 query identified 24 repeated combinations using `employee_id`, `plan_id`, `coverage_start_date`, and `coverage_end_date`. The Step 2 detail query retrieves the individual enrollment records, including `enrollment_id` and `enrollment_status`, for comparison.

**Step 1 actual results:**

- Repeated combinations identified: 24
- Records involved: 48, assuming each combination occurs exactly twice
- Records beyond one per combination: 24, under the same assumption

**Step 2 record-level results:** _Not recorded yet. Run Tasks 3A and 3B and inspect the returned rows._

**Interpretation:**

A repeated business-key combination means the same employee, plan, and coverage period occur more than once. This is a potential duplicate, but it does not automatically mean the records are invalid. Compare the individual enrollment IDs and statuses and check the applicable business rules.

**Recommended actions:**

1. Review each repeated combination and its individual records.
2. Compare `enrollment_id` and `enrollment_status`.
3. Check whether repeated combinations are permitted by the business process.
4. Confirm whether all 24 combinations occur exactly twice before relying on the 48-record and 24-excess-record totals.
5. Do not delete records unless they are confirmed as invalid and the correction is approved.

### Task 4 — Employee/Client versus Plan/Client Mismatch

**Investigation performed:**

The Step 1 query identified enrollment records where the employee's `client_id` differs from the associated plan's `client_id`. The Step 2 query retrieves enrollment, employee, plan, status, and coverage details for review.

**Step 1 actual results:**

- Mismatched enrollment records identified: 20

**Step 2 record-level results:** _Not recorded yet. Run Task 4 and inspect the returned rows._

**Interpretation:**

These 20 records have different client IDs for the employee and the associated plan. This may indicate an incorrect employee or plan assignment, but it could also be permitted by a business rule or exception. The records need to be checked against reliable source information before being classified as errors.

**Recommended actions:**

1. Review all 20 flagged enrollment records.
2. Verify the employee's client assignment and the plan's client assignment.
3. Confirm whether cross-client enrollment is permitted.
4. Correct a record only when the discrepancy and correct value have been verified and the correction is approved.
5. Rerun the mismatch query after any approved correction.

## 3. Step 2 Summary

The investigation has progressed beyond the initial profiling counts by retrieving the employee records affected by missing department and location values. The results confirm 30 affected employees: 17 with a missing department, 13 with a missing location, and none with both fields missing.

The other three areas—enrollment status labels, repeated enrollment combinations, and employee/plan client mismatches—still require record-level review. Their Step 1 counts are retained as the starting point; detailed Step 2 findings should be added after the corresponding queries have been run and reviewed.

No data-cleaning changes have been made as part of this investigation. Any proposed correction must be supported by source data and the applicable business rules.

## 4. Scope and Assumptions

### Scope

This step investigates the data-quality findings raised during Step 1:

- Retrieve employees with missing or blank department and location values.
- Check whether any employee has both attributes missing.
- Inspect records with enrollment status labels that may need review.
- Retrieve individual records belonging to repeated enrollment business-key combinations.
- Inspect enrollment records where the employee's client ID differs from the plan's client ID.
- Document findings and identify follow-up checks.

### Assumptions and Limitations

1. **Synthetic dataset:** The analysis uses a synthetic dataset created for portfolio practice. It does not represent verified production data from a real employer or benefits provider.
2. **Missing values:** A department or location is treated as missing when it is `NULL` or contains only blank spaces.
3. **Employee counts:** The 17 missing-department records and 13 missing-location records are separate groups because the combined query returned zero records with both fields missing. The either-field query therefore returned 30 records.
4. **Status labels:** `Active` and `ACTIVE` remain separate source values until their equivalence is confirmed. `Unknown` and `In progress` are not assigned new meanings without business confirmation.
5. **Repeated combinations:** The duplicate check uses employee, plan, coverage start date, and coverage end date as its business key. Repeated combinations are potential duplicates, not automatically invalid records.
6. **Duplicate totals:** The estimate of 48 records involved and 24 excess records is valid only if all 24 repeated combinations occur exactly twice. Confirm individual counts before treating these totals as final.
7. **Client mismatch:** The check assumes employee and plan client IDs should normally match. Any permitted exceptions must be confirmed from the business rules.
8. **Read-only investigation:** The SQL file contains `SELECT` queries only. No records are updated or deleted in Step 2.
9. **Results not yet supplied:** Detailed outputs for the status, duplicate, and client-mismatch investigations have not yet been recorded here. Add them after running the corresponding queries.

### Deliverable

The Step 2 deliverables are the record-level investigation queries and this results document. Together, they provide a traceable record of what was checked, what has been confirmed, and which findings still require business validation before data cleaning.