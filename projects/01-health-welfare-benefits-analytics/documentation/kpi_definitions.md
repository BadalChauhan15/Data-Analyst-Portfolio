# KPI Definitions

1. Eligible employee-plan pairs: distinct `(employee_id, plan_id)` combinations marked `Eligible` for the reporting period.
2. Enrolled employee-plan pairs: distinct eligible employee-plan pairs with a valid active enrollment under the agreed status and date rules.
3. Enrollment rate: enrolled employee-plan pairs / eligible employee-plan pairs * 100. This is not a count of unique people across benefits.
4. Data quality issue count: records meeting each documented exception rule. One record can have more than one issue; issue counts should not automatically be summed to infer unique bad records.
5. Monthly enrollment starts: distinct employee-plan pairs by coverage start month, after status and data quality filters.
6. Duplicate business event: same employee, plan, coverage start, and coverage end appearing more than once; confirm business semantics before removing any row.
