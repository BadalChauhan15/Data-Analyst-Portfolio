SELECT COUNT(*) enrollment_rows,COUNT(DISTINCT enrollment_id) distinct_ids FROM enrollments;
SELECT status,COUNT(*) FROM enrollments GROUP BY status;
SELECT COUNT(*) FROM enrollments e LEFT JOIN employees x ON x.employee_id=e.employee_id WHERE x.employee_id IS NULL;
SELECT COUNT(*) FROM enrollments e LEFT JOIN plans p ON p.plan_id=e.plan_id WHERE p.plan_id IS NULL;
