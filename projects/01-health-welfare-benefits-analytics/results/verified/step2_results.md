# Verified aggregate findings
Task 1: 17 department missing, 13 location missing, 0 both, 30 either.
Task 2: Active 2621; Pending 162; Cancelled 117; Unknown 6; ACTIVE 6; active 4; In progress 2; total 2918. No trailing spaces in case variants per reported checks. Eight Unknown/In progress rows had values and valid employee/plan references. Meanings unresolved; no changes.
Task 3: 24 repeated business keys, twice each (48 records); 23 Active pairs, one Cancelled. Potential duplicates only.
Task 4: current 22 mismatch records across 20 pairs; two pairs with 2 records, eighteen with 1; zero missing refs, zero repeated keys. Step 1 count 20 remains unexplained.
Import assumption: 26 missing plans.end_date values set to 2025-12-31; validation required. Values are conversation-reported, not newly queried.
