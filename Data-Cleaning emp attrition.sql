USE employee_attrition_raw;
SELECT DATABASE();

DROP TABLE IF EXISTS emp_attrition_csv;

CREATE TABLE emp_attrition_csv (
    Employee_ID INT,
    Age INT,
    Gender VARCHAR(10),
    Years_at_Company INT,
    Job_Role VARCHAR(50),
    Monthly_Income INT,
    Work_Life_Balance VARCHAR(20),
    Job_Satisfaction VARCHAR(20),
    Performance_Rating VARCHAR(20),
    Number_of_Promotions INT,
    Overtime VARCHAR(5),
    Distance_from_Home DECIMAL(6,2) NULL,
    Education_Level VARCHAR(30),
    Marital_Status VARCHAR(15),
    Number_of_Dependents INT,
    Job_Level VARCHAR(20),
    Company_Size VARCHAR(10),
    Company_Tenure_Months DECIMAL(6,2) NULL,
    Remote_Work VARCHAR(5),
    Leadership_Opportunities VARCHAR(5),
    Innovation_Opportunities VARCHAR(5),
    Company_Reputation VARCHAR(20),
    Employee_Recognition VARCHAR(20),
    Attrition VARCHAR(10)
) CHARACTER SET utf8mb4;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Emp_attrition_csv.csv'
INTO TABLE emp_attrition_csv
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Employee_ID, Age, Gender, Years_at_Company, Job_Role, Monthly_Income,
 Work_Life_Balance, Job_Satisfaction, Performance_Rating, Number_of_Promotions,
 Overtime, @Distance_from_Home, Education_Level, Marital_Status, Number_of_Dependents,
 Job_Level, Company_Size, @Company_Tenure_Months, Remote_Work, Leadership_Opportunities,
 Innovation_Opportunities, Company_Reputation, Employee_Recognition, Attrition)
SET
 Distance_from_Home = NULLIF(@Distance_from_Home, ''),
 Company_Tenure_Months = NULLIF(@Company_Tenure_Months, '');


SELECT COUNT(*) FROM emp_attrition_csv;

-- Fixing the encoding--
UPDATE emp_attrition_csv
SET Education_Level = REPLACE(Education_Level, 'â€™', '''')
WHERE Education_Level LIKE '%â€™%';

-- Adding the temp ID column--
ALTER TABLE emp_attrition_csv ADD COLUMN temp_row_id INT AUTO_INCREMENT PRIMARY KEY;

SELECT COUNT(*) FROM emp_attrition_csv;

-- Identifying the duplicates--
SELECT Employee_ID, Job_Role, Monthly_Income, Age, COUNT(*) AS cnt
FROM emp_attrition_csv
GROUP BY Employee_ID, Job_Role, Monthly_Income, Age
HAVING COUNT(*) > 1;


DELETE t1 FROM emp_attrition_csv t1
JOIN (
    SELECT MIN(temp_row_id) AS keep_id, Employee_ID, Job_Role, Monthly_Income, Age
    FROM emp_attrition_csv
    GROUP BY Employee_ID, Job_Role, Monthly_Income, Age
    HAVING COUNT(*) > 1
) dup 
ON t1.Employee_ID = dup.Employee_ID 
AND t1.Job_Role = dup.Job_Role 
AND t1.Monthly_Income = dup.Monthly_Income 
AND t1.Age = dup.Age
WHERE t1.temp_row_id <> dup.keep_id;

SELECT COUNT(*) FROM emp_attrition_csv;

ALTER TABLE emp_attrition_csv DROP COLUMN temp_row_id;

-- Number of Dependents outliers--
SELECT * 
FROM emp_attrition_csv WHERE Number_of_Dependents IN (10, 15);

-- Distance fom Home--
SELECT MIN(Distance_from_Home), MAX(Distance_from_Home), AVG(Distance_from_Home) 
FROM emp_attrition_csv;


SELECT Job_Role, Company_Size, Attrition, COUNT(*) 
FROM emp_attrition_csv 
WHERE Number_of_Dependents IN (10, 15)
GROUP BY Job_Role, Company_Size, Attrition;









