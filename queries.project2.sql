-- Database Creation and its usage
CREATE DATABASE  hr_analytics_db;
USE hr_analytics_db;
-- Table creation
CREATE TABLE  hr_data (
Age INT,
Attrition VARCHAR(5),
BusinessTravel VARCHAR(30),
DailyRate INT,
Department VARCHAR(50),
DistanceFromHome INT,
Education INT,
EducationField VARCHAR(50),
EmployeeNumber INT PRIMARY KEY,
EnvironmentSatisfaction INT,
Gender VARCHAR(10),
HourlyRate INT,
JobInvolvement INT,
JobLevel INT,
JobRole VARCHAR(50),
JobSatisfaction INT,
MaritalStatus VARCHAR(15),
MonthlyIncome INT,
MonthlyRate INT,
NumCompaniesWorked INT,
OverTime VARCHAR(5),
PercentSalaryHike INT,
PerformanceRating INT,
RelationshipSatisfaction INT,
StockOptionLevel INT,
TotalWorkingYears INT,
TrainingTimesLastYear INT,
WorkLifeBalance INT,
YearsAtCompany INT,
YearsInCurrentRole INT,
YearsSinceLastPromotion INT,
YearsWithCurrManager INT
);

-- Checking the count of table contents
SELECT COUNT(*) FROM hr_data;

-- Q1: Overall Attrition Rate
SELECT
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left_Company,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0
/ COUNT(*) AS Attrition_Rate_Pct
from hr_data;

-- Q2: Attrition by Department
SELECT
Department,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Left_Company,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*)
AS Attrition_Rate_Pct
FROM hr_data
GROUP BY Department
ORDER BY Attrition_Rate_Pct DESC;

-- Q3: Attrition by Job Role
SELECT JobRole,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Left_Company,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*)
AS Attrition_Pct
FROM hr_data
GROUP BY JobRole
ORDER BY Attrition_Pct DESC;

-- Q4: Does OverTime Cause Attrition?
SELECT OverTime,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Left_Company,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*)
AS Attrition_Pct
FROM hr_data
GROUP BY OverTime;

-- Q5: Salary vs Attrition
SELECT
CASE
WHEN MonthlyIncome < 3000 THEN 'Low'
WHEN MonthlyIncome < 6000 THEN 'Mid'
WHEN MonthlyIncome < 10000 THEN 'Upper-Mid'
ELSE 'High'
END AS Salary_Range,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Left_Company,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*)
AS Attrition_Pct
from hr_data
Group by Salary_Range
order by Attrition_Pct DESC;

-- Q6: Job Satisfaction vs Attrition
SELECT
JobSatisfaction,
CASE JobSatisfaction
WHEN 1 THEN 'Low'
WHEN 2 THEN 'Medium'
WHEN 3 THEN 'High'
WHEN 4 THEN 'Very High'
END AS Satisfaction_Level,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*)
AS Attrition_Pct
FROM hr_data
GROUP BY JobSatisfaction, Satisfaction_Level
ORDER BY JobSatisfaction;

-- Q7: Age Group Attrition
SELECT
CASE
WHEN Age < 25 THEN 'Under 25'
WHEN Age < 35 THEN '25-34'
WHEN Age < 45 THEN '35-44'
WHEN Age < 55 THEN '45-54'
ELSE '55+'
END AS Age_Group,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Left_Company,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*)
AS Attrition_Pct
FROM hr_data
GROUP BY Age_Group
ORDER BY Attrition_Pct DESC;