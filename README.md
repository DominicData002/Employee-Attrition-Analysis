# Employee Attrition Analysis

End-to-end analysis of an employee attrition dataset: MySQL data cleaning, SQL-based exploratory and business analysis, and a Power BI dashboard identifying the strongest drivers of employee turnover.

## Dataset

- **Source:** Employee Attrition dataset (Kaggle-style HR dataset)
- **Original size:** 74,610 rows, 24 columns
- **Final size after cleaning:** 74,498 rows
- **Target variable:** Attrition (Stayed / Left)

## Tools Used

- **MySQL Workbench** — data cleaning and SQL analysis
- **Power BI** — dashboard and visualization
- **GitHub** — version control and documentation

## Data Cleaning Summary

Full cleaning process was done in MySQL. Key issues found and resolved:

| Issue | Detail | Resolution |
|---|---|---|
| Row count mismatch | Source CSV had 74,610 rows; MySQL Workbench's Import Wizard silently dropped 3,975 rows on initial import | Re-imported using `LOAD DATA INFILE` instead of the wizard |
| Character encoding | `Education Level` values for Bachelor's/Master's Degree had corrupted apostrophes (37,409 rows) from a UTF-8 double-encoding issue in the source file | Fixed with `REPLACE()` |
| Missing values | `Distance_from_Home` (1,912 rows) and `Company_Tenure_Months` (2,413 rows) had genuine missing values | Left as NULL, not imputed |
| Duplicates | 112 exact full-row duplicates | Removed (74,610 → 74,498), matched on Employee_ID, Job_Role, Monthly_Income, and Age |
| Outliers | 48 rows with Number_of_Dependents = 10 or 15, isolated from the otherwise smooth 0–6 distribution | Checked for batch/pattern errors (Job Role, Company Size, Attrition) — none found. Left unchanged, flagged as unverified outliers |

### Known Data Limitations (not corrected — documented instead)

- **Years_at_Company vs Company_Tenure_Months:** 91.6% of rows show disagreement greater than one year when tenure is converted to years. No way to determine which field is accurate — any analysis involving tenure should account for this.
- **Age vs Years_at_Company:** 32% of rows imply a start age under 16, which is physically implausible. Same root uncertainty as above — documented, not corrected.

## Exploratory Data Analysis — Key Findings

**Overall attrition rate:** ~47.5% (35,419 Left / 39,079 Stayed after dedup)

**Strong drivers of attrition:**
- Job Level (Entry 63% → Senior 20%)
- Marital Status (Single 67% → Married 36%)
- Remote Work (No 53% → Yes 25%)
- Work-Life Balance (Poor 60% → Excellent 36%)
- Company Reputation (Poor 56% → Good 43%)

**Weak or no relationship to attrition:**
- Job Role, Employee Recognition, Leadership Opportunities, Innovation Opportunities (all under a 3-point spread across categories)
- Education Level, aside from PhD holders showing a notably lower rate (24%)

**Notable data behavior:** Job Satisfaction and Performance Rating did not behave monotonically with attrition (higher satisfaction did not consistently predict lower attrition) — a pattern more typical of synthetic datasets than causal HR data.

## Business Analysis — Key Findings

1. **Single, entry-level employees are the highest-risk segment — 82% attrition rate**, the strongest single finding in the dataset (Marital Status × Job Level).
2. **Job Level and Remote Work compound** — Entry-level, non-remote employees attrite at 69%, while Senior-level remote employees attrite at just 5%.
3. **Income does not predict attrition.** Average income for employees who left (7,317) vs stayed (7,370) is nearly identical, and attrition rate drifts only ~4 points across the full income range. This directly contradicts a common assumption and is worth noting explicitly.
4. **Work-Life Balance is the dominant quality-of-work driver**, outweighing Company Reputation — a poor work-life balance keeps attrition high even when company reputation is strong.
5. **Promotions show a threshold effect, not a linear one.** Attrition holds flat around 48–49% for employees with 0–2 promotions, then drops sharply to ~24% at 3+ promotions.

## Dashboard

Three-page Power BI dashboard:

1. **Overview** — headline KPIs and top single-variable drivers
   ![Overview](screenshots/overview.png)

2. **Compounding Risk Factors** — matrix views showing how Job Level, Marital Status, Remote Work, and Work-Life Balance interact
   ![Compounding Risk Factors](screenshots/compounding-risk-factors.png)

3. **What Doesn't Drive Attrition** — income and other weak/non-drivers, included for analytical transparency
   ![What Doesn't Drive Attrition](screenshots/what-doesnt-drive-attrition.png)

The `.pbix` file is available in the `dashboard` folder.

## Repository Structure

```
├── sql/                  # Data cleaning and analysis scripts
├── dashboard/            # Power BI .pbix file
├── screenshots/          # Dashboard page images
├── data-quality-notes.md # Full cleaning documentation
└── README.md
```
