-- Combined risk profile (Job level x Remote work)
SELECT Job_Level, Remote_Work,
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Job_Level, Remote_Work
ORDER BY attrition_rate DESC;

-- Income and attrition
SELECT Attrition, 
    ROUND(AVG(Monthly_Income),1) AS avg_income,
    COUNT(*) AS total
FROM emp_attrition_csv
GROUP BY Attrition;

SELECT 
    CASE 
        WHEN Monthly_Income < 3000 THEN 'Under 3000'
        WHEN Monthly_Income < 6000 THEN '3000-5999'
        WHEN Monthly_Income < 9000 THEN '6000-8999'
        WHEN Monthly_Income < 12000 THEN '9000-11999'
        ELSE '12000+'
    END AS income_band,
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY income_band
ORDER BY MIN(Monthly_Income);

-- Single and Entry level(high risk combination)
SELECT Marital_Status, Job_Level,
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Marital_Status, Job_Level
ORDER BY attrition_rate DESC;

-- Work life balance X Company reputation
SELECT Work_Life_Balance, Company_Reputation,
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Work_Life_Balance, Company_Reputation
ORDER BY attrition_rate DESC
LIMIT 10;

-- Promotions (does lack of advancement drive attrition)
SELECT Number_of_Promotions,
    SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) AS left_count,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM emp_attrition_csv
GROUP BY Number_of_Promotions
ORDER BY Number_of_Promotions;
















