-- Project 1: Health & Welfare Benefits Analytics
-- Step 1: Data profiling
-- MySQL 8.0+
-- Read-only SELECT queries. Run one query at a time and record actual results.

USE benefits_analytics;

-- 0. Verify imported row counts
SELECT 'clients' AS table_name, COUNT(*) AS total_rows FROM clients
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'plans', COUNT(*) FROM plans
UNION ALL
SELECT 'eligibility', COUNT(*) FROM eligibility
UNION ALL
SELECT 'enrollments', COUNT(*) FROM enrollments;

-- Task 1: Count missing or blank employee department and location values.
SELECT
    SUM(department IS NULL OR TRIM(department) = '') AS missing_departments,
    SUM(location IS NULL OR TRIM(location) = '') AS missing_locations
FROM employees;

-- Task 2: Inspect enrollment status values and counts.
-- This helps identify casing, whitespace, and unexpected status labels.
SELECT
    enrollment_status,
    COUNT(*) AS record_count
FROM enrollments
GROUP BY enrollment_status
ORDER BY record_count DESC;

-- Task 3: Find repeated employee-plan-coverage combinations.
-- These are potential duplicate business records; review before taking action.
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
ORDER BY duplicate_count DESC;

-- Task 4: Find enrollments where the employee's client differs from the plan's client.
SELECT
    e.enrollment_id,
    e.employee_id,
    emp.client_id AS employee_client_id,
    e.plan_id,
    p.client_id AS plan_client_id
FROM enrollments AS e
JOIN employees AS emp
    ON e.employee_id = emp.employee_id
JOIN plans AS p
    ON e.plan_id = p.plan_id
WHERE emp.client_id <> p.client_id
ORDER BY e.enrollment_id;
