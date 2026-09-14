SELECT * FROM hr_analist.fact_attrition;
select * from dim_employee;
select * from dim_job;
select 
e.EmployeeID,
e.Age,
e.AgeGroup,
e.MaritalStatus,
e.Education,
e.DistanceFromHome,
j.JobID,
j.Department,
j.JobRole,
j.JobLevel,
f.Attrition,
f.OverTime,
f.BusinessTravel,
f.MonthlyIncome,
f.SalaryBand,
f.PercentSalaryHike,
f.StockOptionLevel,
f.YearsAtCompany,
f.TenureBand,
f.YearsInCurrentRole,
f.YearsSinceLastPromotion,
f.NumCompaniesWorked,
f.JobSatisfaction,
f.EnvironmentSatisfaction,
f.WorkLifeBalance,
f.RelationshipSatisfaction,
f.PerformanceRating,
f.TrainingTimesLastYear
from fact_attrition f
join dim_employee e on e.EmployeeID = f.EmployeeID
join dim_job j on j.JobID = f.JobID;

-- Q1. Overall attrition rate
select count(*) as Total_Attrition,
sum(Attrition = 'Yes') as Attrition,
round(100 * Avg(Attrition = 'Yes') , 1 ) as Attrition_rate_pct
from fact_attrition;

-- Q2. Attrition rate by OverTime
select OverTime,
count(*) as Headcount,
round(100 * AVG(Attrition = 'Yes'),1) as Attrition_rate_pct
from fact_attrition
group by OverTime
order by Attrition_rate_pct desc;

-- Q3. Attrition rate by Age Group (join to dim_employee)
select AgeGroup ,
count(*) as Headcount,
round(100 * avg(Attrition = 'Yes'),1) as Attrition_rate_pct
from fact_attrition f
join dim_employee e on e.EmployeeID = f.EmployeeID
group by AgeGroup
order by field(e.AgeGroup, 18-25, 26-35, 35-45, 45-55, 56-60);

-- Q4. Attrition rate by Salary Band
select SalaryBand,
Count(*) as Headcount,
round(100 * avg(Attrition = 'Yes'), 1) as Attrition_rate_pct
from fact_attrition
group by SalaryBand
order by field(SalaryBand, 'Low', 'Medium', 'High', 'Very High' );

-- Q5. Attrition rate by Tenure Band
select TenureBand,
Count(*) as Headcount,
round(100 * avg(Attrition = 'Yes'),1) as Attrition_rate_pct
from fact_attrition
group by TenureBand
order by field(TenureBand, '0-2 yrs', '3-5 yrs', '6-10 yrs','10+ yrs');

-- Q6. Compounding risk: OverTime x SalaryBand
-- (Pivoted with conditional aggregation — the classic MySQL
--  substitute for PIVOT.)
Select 
SalaryBand,
round(100 * Avg(Case When OverTime ='No' Then Attrition = 'Yes' End),1) as No_Overtime_pct,
round(100 * Avg(Case When OverTime ='Yes' Then Attrition = 'Yes'End),1) as Yes_OverTime_pct
From fact_attrition
Group by SalaryBand
Order by field(SalaryBand,'Low', 'Medium', 'High', 'Very High');

-- Q7. Attrition by Department and Job Role (join to dim_job)
Select
j.Department,
j.JobRole,
count(*) as Headcount,
round(100 * Avg(Attrition ='Yes'),1) as Attrition_rate_pct
From fact_attrition f
Join dim_job j on j.JobID = f.JobID
Group by j.Department, j.JobRole
Order by Attrition_rate_pct Desc;

-- Q8. Window function: rank job roles within each department
--     by attrition rate (highest risk role per department).
With Role_rate as (
Select
j.Department,
j.JobRole,
count(*) as Headcount,
round(100 * Avg(Attrition = 'Yes'),1) as Attrition_rate_pct
From fact_attrition f
Join dim_job j on j.JobID = f.JobID
Group by j.Department,j.JobRole
)
Select 
Department, JobRole, headcount, Attrition_rate_pct,
Rank() Over(PARTITION BY Department) as risk_rank_in_dept
from Role_rate
Order by Department, risk_rank_in_dept;

-- Q9. CTE: define a "high-risk" segment and size it
--     (OverTime=Yes AND SalaryBand in Low/Medium AND tenure <= 2 yrs)
With High_risk as (
Select 
EmployeeID,
Attrition
from fact_attrition
Where OverTime = 'Yes'
AND SalaryBand In ('Low','Medium')
AND TenureBand = '0-2 yrs'
)
select
(Select count(*) from High_risk) as High_risk_Headcount,
round(100*(Select count(*) from High_risk) / (Select count(*)From fact_attrition),1) as pct_of_workforce,
round(100* Avg(Attrition ='Yes'),1) as Attrition_rate_pct
from High_risk;

-- Q10. Satisfaction & work-life balance vs attrition
Select
JobSatisfaction,
count(*) as Headcount,
round(100* Avg(Attrition ='Yes'),1) as Attrition_rate_pct
from fact_attrition
Group by JobSatisfaction
Order by JobSatisfaction;

Select
WorkLifeBalance,
count(*) as Headcount,
round(100* Avg(Attrition ='Yes'),1) as Attrition_rate_pct
from fact_attrition
Group by WorkLifeBalance
Order by WorkLifeBalance;

-- Q11. Correlation-style check: average tenure/income/age
--      split simply by attrition outcome (quick sanity check,
--      MySQL has no built-in CORR() so we compare group means).
Select
f.Attrition,
Avg(f.YearsAtCompany) as Avg_Tenure,
Avg(f.MonthlyIncome) as Avg_Income,
Avg(e.Age) as Avg_Age,
Avg(e.DistanceFromHome) as Avg_commute_distance
from fact_attrition f
Join dim_employee e ON e.EmployeeID = f.EmployeeID
Group by f.Attrition;

