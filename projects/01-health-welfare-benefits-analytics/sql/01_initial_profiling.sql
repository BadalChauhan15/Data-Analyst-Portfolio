SELECT 'clients' table_name,COUNT(*) row_count FROM clients UNION ALL SELECT 'employees',COUNT(*) FROM employees UNION ALL SELECT 'plans',COUNT(*) FROM plans UNION ALL SELECT 'eligibility',COUNT(*) FROM eligibility UNION ALL SELECT 'enrollments',COUNT(*) FROM enrollments;
SELECT SUM(department IS NULL OR TRIM(department)='') missing_department,SUM(location IS NULL OR TRIM(location)='') missing_location,SUM((department IS NULL OR TRIM(department)='') AND (location IS NULL OR TRIM(location)='')) both_missing FROM employees;
SELECT status,COUNT(*) FROM enrollments GROUP BY status;
