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