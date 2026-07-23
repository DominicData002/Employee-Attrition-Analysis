1\. **Row count**: Source CSV had 74,610 rows; MySQL Workbench's Import Wizard silently dropped 3,975 on initial import — resolved by using `LOAD DATA INFILE` instead.  
**2\. Encoding**: `Education Level` values for Bachelor's/Master's Degree had corrupted apostrophes (37,409 rows) from a UTF-8 double-encoding issue in the source file — fixed via `REPLACE()`.  
**3\. Nulls**: `Distance_from_Home` (1,912 rows) and `Company_Tenure_Months` (2,413 rows) have genuine missing values — left as NULL, not imputed.  
**4\. Duplicates**: 112 exact full-row duplicates removed (74,610 → 74,498), identified by matching Employee\_ID, Job\_Role, Monthly\_Income, and Age.  
**5\. Number of Dependents**: 48 rows have values of 10 or 15, isolated from the otherwise smooth 0–6 distribution. Checked for batch patterns (Job Role, Company Size, Attrition) — none found. Left unchanged, flagged as unverified outliers.  
**6\. Years\_at\_Company vs Company\_Tenure\_Months**: 91.6% of rows show disagreement between these two fields greater than one year when tenure is converted to years. Cannot determine which field is accurate. Documented as a known limitation — any analysis using tenure should note this.  
**7\. Age vs Years\_at\_Company**: 32% of rows show `Age − Years_at_Company < 16`, implying an implausible start age. Same limitation as above — documented, not corrected.  
  

                       **Findings**   
1\.**Single, entry-level, non-remote employees are the highest attrition risk** (82% for Single+Entry, compounding further with Remote Work data from Q1)  
**2\. Work-Life Balance is the strongest quality-of-work-life driver**, more so than Company Reputation  
**3\. Income does not predict attrition** — a notable negative finding worth stating directly  
**4\. Promotion count shows a threshold effect at 3+**, not a linear relationship  
