# Model specification
Load Clients, Employees, Plans, Eligibility, Enrollments after validating schema/grain. Candidate 1:* links: Clients→Employees/Plans; Employees and Plans→Enrollments/Eligibility. Verify keys and cardinality, prefer single direction, avoid ambiguous fact-to-fact filtering. Keep source statuses exact until approved.
