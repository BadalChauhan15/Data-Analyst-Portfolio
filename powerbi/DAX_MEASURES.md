# DAX starters
Enrollment Rows = COUNTROWS(Enrollments)
Distinct Enrolled Employees = DISTINCTCOUNT(Enrollments[employee_id])
Active Source Label Rows = CALCULATE(COUNTROWS(Enrollments), Enrollments[status] = "Active")
Pending Source Label Rows = CALCULATE(COUNTROWS(Enrollments), Enrollments[status] = "Pending")
Cancelled Source Label Rows = CALCULATE(COUNTROWS(Enrollments), Enrollments[status] = "Cancelled")
Use exact labels pending approval. Do not create enrollment rate until denominator, eligibility snapshot, and grain are approved.
