-- Confirm business key and column names first.
SELECT employee_id,plan_id,coverage_start_date,coverage_end_date,COUNT(*) FROM enrollments GROUP BY employee_id,plan_id,coverage_start_date,coverage_end_date HAVING COUNT(*)>1;
SELECT e.* FROM enrollments e JOIN (SELECT employee_id,plan_id,coverage_start_date,coverage_end_date FROM enrollments GROUP BY employee_id,plan_id,coverage_start_date,coverage_end_date HAVING COUNT(*)>1) d USING(employee_id,plan_id,coverage_start_date,coverage_end_date) ORDER BY enrollment_id;
