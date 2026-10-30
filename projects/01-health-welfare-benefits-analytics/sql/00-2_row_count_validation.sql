-- Project 1: Verify the expected imported row counts.
USE benefits_analytics;

SELECT 'clients' AS table_name, COUNT(*) AS actual_rows, 10 AS expected_rows FROM clients
UNION ALL
SELECT 'employees', COUNT(*), 2000 FROM employees
UNION ALL
SELECT 'plans', COUNT(*), 31 FROM plans
UNION ALL
SELECT 'eligibility', COUNT(*), 6172 FROM eligibility
UNION ALL
SELECT 'enrollments', COUNT(*), 2918 FROM enrollments;
