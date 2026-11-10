-- Step 2: Data Quality Investigation
-- Project: Health & Welfare Benefits Analytics
-- Database: MySQL
-- Read-only SELECT queries. Run one query at a time and record actual results.

USE health_welfare_benefits;

-- Task 1A: Employees with missing/blank department
SELECT employee_id, department, location
FROM employees
WHERE department IS NULL OR TRIM(department) = ''
ORDER BY employee_id;

-- Task 1B: Employees with missing/blank location
SELECT employee_id, department, location
FROM employees
WHERE location IS NULL OR TRIM(location) = ''
ORDER BY employee_id;

-- Task 1C: Employees with BOTH department and location missing
SELECT employee_id, department, location
FROM employees
WHERE (department IS NULL OR TRIM(department) = '')
  AND (location IS NULL OR TRIM(location) = '')
ORDER BY employee_id;

-- Task 1D: Employees with EITHER department or location missing
SELECT employee_id, department, location
FROM employees
WHERE (department IS NULL OR TRIM(department) = '')
   OR (location IS NULL OR TRIM(location) = '')
ORDER BY employee_id;

-- Task 2A: Enrollment status distribution
SELECT enrollment_status, COUNT(*) AS record_count
FROM enrollments
GROUP BY enrollment_status
ORDER BY record_count DESC;

-- Task 2B: Inspect status values that need review
SELECT enrollment_id, employee_id, plan_id, enrollment_status
FROM enrollments
WHERE LOWER(TRIM(enrollment_status)) IN ('unknown', 'in progress')
   OR UPPER(TRIM(enrollment_status)) = 'ACTIVE'
ORDER BY enrollment_status, enrollment_id;

-- Task 2C: Investigate the two In progress records
SELECT
    e.enrollment_id,
    e.employee_id,
    e.plan_id,
    e.enrollment_status,
    e.coverage_start_date,
    e.coverage_end_date
FROM enrollments AS e
WHERE TRIM(e.enrollment_status) = 'In progress';

-- Task 2D: Investigate the six Unknown records
SELECT
    e.enrollment_id,
    e.employee_id,
    e.plan_id,
    e.enrollment_status,
    e.coverage_start_date,
    e.coverage_end_date
FROM enrollments AS e
WHERE TRIM(e.enrollment_status) = 'Unknown'
ORDER BY e.enrollment_id;

-- Task 2E: Verify employee and plan references
SELECT
    e.enrollment_id,
    e.employee_id,
    emp.employee_id AS matched_employee_id,
    e.plan_id,
    p.plan_id AS matched_plan_id,
    e.enrollment_status
FROM enrollments AS e
LEFT JOIN employees AS emp
    ON e.employee_id = emp.employee_id
LEFT JOIN plans AS p
    ON e.plan_id = p.plan_id
WHERE TRIM(e.enrollment_status) IN ('Unknown', 'In progress')
  AND (
      emp.employee_id IS NULL
      OR p.plan_id IS NULL
  );

-- Task 3A: Find repeated enrollment business-key combinations
SELECT
    employee_id,
    plan_id,
    coverage_start_date,
    coverage_end_date,
    COUNT(*) AS duplicate_count
FROM enrollments
GROUP BY
    employee_id,
    plan_id,
    coverage_start_date,
    coverage_end_date
HAVING COUNT(*) > 1
ORDER BY
    duplicate_count DESC,
    employee_id,
    plan_id;

-- Task 3B: Retrieve individual records in repeated combinations
SELECT
    e.enrollment_id,
    e.employee_id,
    e.plan_id,
    e.coverage_start_date,
    e.coverage_end_date,
    e.enrollment_status
FROM enrollments AS e
JOIN (
    SELECT
        employee_id,
        plan_id,
        coverage_start_date,
        coverage_end_date
    FROM enrollments
    GROUP BY
        employee_id,
        plan_id,
        coverage_start_date,
        coverage_end_date
    HAVING COUNT(*) > 1
) AS repeated
    ON e.employee_id = repeated.employee_id
   AND e.plan_id = repeated.plan_id
   AND e.coverage_start_date = repeated.coverage_start_date
   AND e.coverage_end_date = repeated.coverage_end_date
ORDER BY
    e.employee_id,
    e.plan_id,
    e.coverage_start_date,
    e.enrollment_id;

-- Task 3C: Check exact duplicates across all available enrollment columns
SELECT
    enrollment_id,
    employee_id,
    plan_id,
    enrollment_status,
    coverage_start_date,
    coverage_end_date,
    COUNT(*) AS record_count
FROM enrollments
GROUP BY
    enrollment_id,
    employee_id,
    plan_id,
    enrollment_status,
    coverage_start_date,
    coverage_end_date
HAVING COUNT(*) > 1
ORDER BY
    record_count DESC;

/*
Task 3C returned 0 rows in the reported execution.

Caveat: enrollment_id is the primary key. Including it in the grouping means
records with different enrollment IDs cannot be grouped together. Therefore,
this is a limited exact-row check, not proof that repeated business-key
combinations are legitimate. Task 3A and Task 3B are the meaningful
business-key duplicate investigation.
*/

-- Task 4A: Retrieve enrollment records with employee-plan client mismatches
SELECT
    e.enrollment_id,
    e.employee_id,
    emp.client_id AS employee_client_id,
    e.plan_id,
    p.client_id AS plan_client_id
FROM enrollments AS e
INNER JOIN employees AS emp
    ON e.employee_id = emp.employee_id
INNER JOIN plans AS p
    ON e.plan_id = p.plan_id
WHERE emp.client_id <> p.client_id
ORDER BY e.enrollment_id;

-- Task 4B: Summarize mismatches by employee client and plan client
-- Run after reviewing Task 4A results.
SELECT
    emp.client_id AS employee_client_id,
    p.client_id AS plan_client_id,
    COUNT(*) AS mismatched_enrollment_count
FROM enrollments AS e
INNER JOIN employees AS emp
    ON e.employee_id = emp.employee_id
INNER JOIN plans AS p
    ON e.plan_id = p.plan_id
WHERE emp.client_id <> p.client_id
GROUP BY
    emp.client_id,
    p.client_id
ORDER BY
    mismatched_enrollment_count DESC,
    employee_client_id,
    plan_client_id;

-- Task 4C: Check whether employee and plan references are missing
-- This is a separate referential-integrity check. It does not count
-- client mismatches where both related records exist.
SELECT
    e.enrollment_id,
    e.employee_id,
    emp.client_id AS employee_client_id,
    e.plan_id,
    p.client_id AS plan_client_id,
    CASE
        WHEN emp.employee_id IS NULL THEN 'Employee reference missing'
        WHEN p.plan_id IS NULL THEN 'Plan reference missing'
    END AS reference_issue
FROM enrollments AS e
LEFT JOIN employees AS emp
    ON e.employee_id = emp.employee_id
LEFT JOIN plans AS p
    ON e.plan_id = p.plan_id
WHERE emp.employee_id IS NULL
   OR p.plan_id IS NULL
ORDER BY e.enrollment_id;

/*
Interpretation notes:
- A client mismatch is identified when employee.client_id <> plan.client_id.
- INNER JOIN is appropriate for Task 4A because the comparison requires
  matching employee and plan records.
- Task 4C uses LEFT JOIN to reveal missing references separately.
- A mismatch is a potential data-quality issue, not automatically a confirmed
  error. Validate client/plan eligibility rules and any approved exceptions.
- Do not modify data until the business rule and correction are approved.
*/
