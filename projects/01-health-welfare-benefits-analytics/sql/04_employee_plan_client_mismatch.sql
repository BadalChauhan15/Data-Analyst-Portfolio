SELECT e.enrollment_id,x.client_id employee_client_id,p.client_id plan_client_id,e.employee_id,e.plan_id,e.status FROM enrollments e JOIN employees x ON x.employee_id=e.employee_id JOIN plans p ON p.plan_id=e.plan_id WHERE x.client_id<>p.client_id;
SELECT COUNT(*) FROM enrollments e JOIN employees x ON x.employee_id=e.employee_id JOIN plans p ON p.plan_id=e.plan_id WHERE x.client_id<>p.client_id;
SELECT x.client_id,p.client_id,COUNT(*) FROM enrollments e JOIN employees x ON x.employee_id=e.employee_id JOIN plans p ON p.plan_id=e.plan_id WHERE x.client_id<>p.client_id GROUP BY x.client_id,p.client_id;
SELECT e.enrollment_id FROM enrollments e LEFT JOIN employees x ON x.employee_id=e.employee_id LEFT JOIN plans p ON p.plan_id=e.plan_id WHERE x.employee_id IS NULL OR p.plan_id IS NULL;
