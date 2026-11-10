SELECT COUNT(*) FROM plans WHERE end_date IS NULL;
SELECT plan_id,start_date,end_date FROM plans WHERE end_date='2025-12-31';
-- Read-only review; verify against source before any changes.
SELECT e.enrollment_id,e.plan_id,e.coverage_start_date,e.coverage_end_date,p.start_date,p.end_date FROM enrollments e JOIN plans p ON p.plan_id=e.plan_id WHERE (p.start_date IS NOT NULL AND e.coverage_start_date<p.start_date) OR (p.end_date IS NOT NULL AND e.coverage_end_date>p.end_date);
