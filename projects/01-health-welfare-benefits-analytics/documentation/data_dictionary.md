# Data Dictionary

All data is synthetic. Dates are ISO-formatted `YYYY-MM-DD`.

## clients
- `client_id`: unique fictional employer key.
- `client_name`: fictional employer name.
- `industry`: fictional employer industry.
- `client_location`: employer's administrative location.

## employees
- `employee_id`: unique fictional employee key.
- `client_id`: employer key.
- `department`: department; some values intentionally missing.
- `location`: work location; some values intentionally missing.
- `hire_date`: synthetic hire date.
- `employment_status`: Active, Leave, or Terminated.

## plans
- `plan_id`: unique fictional plan key.
- `client_id`: employer that offers the plan.
- `benefit_type`: Medical, Dental, or Vision.
- `plan_name`: fictional plan label.
- `vendor_name`: fictional vendor.
- `effective_date`, `end_date`: plan validity dates; blank end date means no end date specified.

## eligibility
- `eligibility_id`: unique eligibility row key.
- `employee_id`, `plan_id`: employee-plan pair.
- `eligibility_start_date`, `eligibility_end_date`: eligibility coverage window.
- `eligibility_status`: Eligible or Ineligible.

## enrollments
- `enrollment_id`: unique row key, including duplicates of the underlying business event under different IDs.
- `employee_id`, `plan_id`: employee and selected plan.
- `enrollment_status`: Active, Pending, Cancelled, plus intentionally inconsistent values.
- `coverage_start_date`, `coverage_end_date`: synthetic coverage dates; some are intentionally invalid.
