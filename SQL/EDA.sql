
-- Overll Attrition rate--
SELECT 
    Attrition, 
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM emp_attrition_csv), 2) AS percentage
FROM emp_attrition_csv
GROUP BY Attrition;

-- Numeric field distributions(spread and skew indicators)
SELECT 
    'Age' AS metric,
    MIN(Age) AS min_val, MAX(Age) AS max_val, 
    ROUND(AVG(Age),1) AS mean_val,
    (SELECT Age FROM emp_attrition_csv ORDER BY Age LIMIT 1 OFFSET (SELECT COUNT(*)/2 FROM emp_attrition_csv)) AS median_val
FROM emp_attrition_csv
UNION ALL
SELECT 
    'Monthly_Income',
    MIN(Monthly_Income), MAX(Monthly_Income), 
    ROUND(AVG(Monthly_Income),1),
    (SELECT Monthly_Income FROM emp_attrition_csv ORDER BY Monthly_Income LIMIT 1 OFFSET (SELECT COUNT(*)/2 FROM emp_attrition_csv))
FROM emp_attrition_csv
UNION ALL
SELECT 
    'Years_at_Company',
    MIN(Years_at_Company), MAX(Years_at_Company), 
    ROUND(AVG(Years_at_Company),1),
    (SELECT Years_at_Company FROM emp_attrition_csv ORDER BY Years_at_Company LIMIT 1 OFFSET (SELECT COUNT(*)/2 FROM emp_attrition_csv))
FROM emp_attrition_csv;


SET @row_count = (SELECT COUNT(*) FROM emp_attrition_csv);
SET @offset_val = @row_count DIV 2;

SELECT 
    'Age' AS metric,
    MIN(Age) AS min_val, MAX(Age) AS max_val, 
    ROUND(AVG(Age),1) AS mean_val
FROM emp_attrition_csv;

SELECT Age AS median_age FROM emp_attrition_csv ORDER BY Age LIMIT 1 OFFSET @offset_val;


SET @row_count = (SELECT COUNT(*) FROM emp_attrition_csv);
SET @offset_val = @row_count DIV 2;

SELECT 
    MIN(Monthly_Income) AS min_val, MAX(Monthly_Income) AS max_val, 
    ROUND(AVG(Monthly_Income),1) AS mean_val
FROM emp_attrition_csv;

SELECT Monthly_Income AS median_income FROM emp_attrition_csv ORDER BY Monthly_Income LIMIT 1 OFFSET @offset_val;


SET @row_count = (SELECT COUNT(*) FROM emp_attrition_csv);
SET @offset_val = @row_count DIV 2;

SELECT 
    MIN(Years_at_Company) AS min_val, MAX(Years_at_Company) AS max_val, 
    ROUND(AVG(Years_at_Company),1) AS mean_val
FROM emp_attrition_csv;

SELECT Years_at_Company AS median_years FROM emp_attrition_csv ORDER BY Years_at_Company LIMIT 1 OFFSET @offset_val;

-- Job Role--
SELECT Job_Role, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Job_Role
ORDER BY attrition_rate DESC;

-- Overtime--
SELECT Overtime, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Overtime
ORDER BY attrition_rate DESC;

-- Remote work--
SELECT Remote_Work, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Remote_Work
ORDER BY attrition_rate DESC;

-- Company size
SELECT Company_Size, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Company_Size
ORDER BY attrition_rate DESC;

SELECT VERSION();

-- Age--
SET @row_count = (SELECT COUNT(*) FROM emp_attrition_csv);
SET @offset_val = @row_count DIV 2;

SET @sql = CONCAT('SELECT Age AS median_age FROM emp_attrition_csv ORDER BY Age LIMIT 1 OFFSET ', @offset_val);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


-- Monthly Income--
SET @row_count = (SELECT COUNT(*) FROM emp_attrition_csv);
SET @offset_val = @row_count DIV 2;

SET @sql = CONCAT('SELECT Monthly_Income AS median_income FROM emp_attrition_csv ORDER BY Monthly_Income LIMIT 1 OFFSET ', @offset_val);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Years at company--
SET @row_count = (SELECT COUNT(*) FROM emp_attrition_csv);
SET @offset_val = @row_count DIV 2;

SET @sql = CONCAT('SELECT Years_at_Company AS median_years FROM emp_attrition_csv ORDER BY Years_at_Company LIMIT 1 OFFSET ', @offset_val);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Work life balance--
SELECT Work_Life_Balance, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Work_Life_Balance
ORDER BY attrition_rate DESC;

-- Job Satisfaction--
SELECT Job_Satisfaction, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Job_Satisfaction
ORDER BY attrition_rate DESC;

-- Performance Rating
SELECT Performance_Rating, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Performance_Rating
ORDER BY attrition_rate DESC;

-- Education level
SELECT Education_Level, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Education_Level
ORDER BY attrition_rate DESC;

-- Marital status--
SELECT Marital_Status, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Marital_Status
ORDER BY attrition_rate DESC;

-- Job Level--
SELECT Job_Level, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Job_Level
ORDER BY attrition_rate DESC;

-- Leadership Opportunities
SELECT Leadership_Opportunities, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Leadership_Opportunities
ORDER BY attrition_rate DESC;

-- Innovation Opportunities
SELECT Innovation_Opportunities, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Innovation_Opportunities
ORDER BY attrition_rate DESC;

-- Company Reputation
SELECT Company_Reputation, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Company_Reputation
ORDER BY attrition_rate DESC;

-- Employee Recognition
SELECT Employee_Recognition, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Employee_Recognition
ORDER BY attrition_rate DESC;

-- Gender--
SELECT Gender, 
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Gender
ORDER BY attrition_rate DESC;

-- Remote work (cross-tabulated with overtime)
SELECT Remote_Work, Overtime,
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Remote_Work, Overtime
ORDER BY attrition_rate DESC;


