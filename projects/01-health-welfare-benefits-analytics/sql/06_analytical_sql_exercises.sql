SELECT plan_id,status,COUNT(*) FROM enrollments GROUP BY plan_id,status;
SELECT plan_id,COUNT(DISTINCT employee_id) FROM enrollments GROUP BY plan_id;
SELECT DATE_FORMAT(coverage_start_date,'%Y-%m'),COUNT(*) FROM enrollments GROUP BY DATE_FORMAT(coverage_start_date,'%Y-%m');
-- Define valid eligibility denominator and date before calculating rates.
