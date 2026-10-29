USE benefits_analytics;

-- NOTE: These are starter queries. Validate date/status/business rules before using results.

-- 1. Eligible employee-plan counts by client and benefit type
SELECT p.client_id, c.client_name, p.benefit_type,
       COUNT(DISTINCT CONCAT(el.employee_id, '-', el.plan_id)) AS eligible_employee_plan_pairs
FROM eligibility el
JOIN plans p ON el.plan_id = p.plan_id
JOIN clients c ON p.client_id = c.client_id
WHERE el.eligibility_status = 'Eligible'
GROUP BY p.client_id, c.client_name, p.benefit_type
ORDER BY c.client_name, p.benefit_type;

-- 2. Active enrollment records by client and benefit type
SELECT p.client_id, c.client_name, p.benefit_type,
       COUNT(DISTINCT e.employee_id) AS enrolled_employees
FROM enrollments e
JOIN employees emp ON e.employee_id = emp.employee_id
JOIN plans p ON e.plan_id = p.plan_id
JOIN clients c ON p.client_id = c.client_id
WHERE UPPER(TRIM(e.enrollment_status)) = 'ACTIVE'
  AND emp.client_id = p.client_id
GROUP BY p.client_id, c.client_name, p.benefit_type
ORDER BY enrolled_employees DESC;

-- 3. Enrollment rate by client and benefit type.
-- This counts employee-plan pairs and deduplicates enrollment by employee-plan.
WITH eligible AS (
  SELECT DISTINCT el.employee_id, el.plan_id, p.client_id, p.benefit_type
  FROM eligibility el
  JOIN plans p ON el.plan_id = p.plan_id
  JOIN employees emp ON emp.employee_id = el.employee_id
  WHERE el.eligibility_status = 'Eligible'
    AND emp.client_id = p.client_id
),
enrolled AS (
  SELECT DISTINCT e.employee_id, e.plan_id
  FROM enrollments e
  JOIN employees emp ON emp.employee_id = e.employee_id
  JOIN plans p ON p.plan_id = e.plan_id
  WHERE UPPER(TRIM(e.enrollment_status)) = 'ACTIVE'
    AND emp.client_id = p.client_id
)
SELECT eligible.client_id, c.client_name, eligible.benefit_type,
       COUNT(*) AS eligible_employee_plan_pairs,
       SUM(CASE WHEN enrolled.employee_id IS NOT NULL THEN 1 ELSE 0 END) AS enrolled_employee_plan_pairs,
       ROUND(100.0 * SUM(CASE WHEN enrolled.employee_id IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0), 2) AS enrollment_rate_pct
FROM eligible
LEFT JOIN enrolled
  ON eligible.employee_id = enrolled.employee_id
 AND eligible.plan_id = enrolled.plan_id
JOIN clients c ON c.client_id = eligible.client_id
GROUP BY eligible.client_id, c.client_name, eligible.benefit_type
ORDER BY enrollment_rate_pct DESC;

-- 4. Monthly active enrollment starts
SELECT DATE_FORMAT(e.coverage_start_date, '%Y-%m') AS enrollment_month,
       p.benefit_type,
       COUNT(DISTINCT CONCAT(e.employee_id, '-', e.plan_id)) AS employee_plan_pairs
FROM enrollments e
JOIN employees emp ON emp.employee_id = e.employee_id
JOIN plans p ON p.plan_id = e.plan_id
WHERE UPPER(TRIM(e.enrollment_status)) = 'ACTIVE'
  AND emp.client_id = p.client_id
GROUP BY DATE_FORMAT(e.coverage_start_date, '%Y-%m'), p.benefit_type
ORDER BY enrollment_month, p.benefit_type;

-- 5. Quality issue counts
SELECT 'Missing department' AS issue_type, COUNT(*) AS issue_count
FROM employees WHERE department IS NULL OR TRIM(department) = ''
UNION ALL
SELECT 'Missing location', COUNT(*)
FROM employees WHERE location IS NULL OR TRIM(location) = ''
UNION ALL
SELECT 'Client-plan mismatch', COUNT(*)
FROM enrollments e
JOIN employees emp ON e.employee_id = emp.employee_id
JOIN plans p ON e.plan_id = p.plan_id
WHERE emp.client_id <> p.client_id
UNION ALL
SELECT 'Invalid enrollment status', COUNT(*)
FROM enrollments
WHERE UPPER(TRIM(enrollment_status)) NOT IN ('ACTIVE','PENDING','CANCELLED')
   OR enrollment_status IS NULL;
