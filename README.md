# HR Attrition Analytics — Power BI + SQL

## Project Overview
An end-to-end HR analytics project identifying which employee segments are at the highest risk of attrition, using SQL for analysis and Power BI for interactive visualization.

## Business Problem
Employee attrition is expensive every departure costs the company in hiring, onboarding, and lost institutional knowledge. 
But not all attrition risk is equal. This project answers a key HR question:

## Tools & Techniques
 - SQL (MySQL) — joins across fact/dimension tables, CTEs, window functions (RANK() OVER PARTITION BY), conditional aggregation function.
 - Power BI Desktop — KPI cards, interactive filters (Department, OverTime), grouped bar charts, donut chart, and a drillable department/role table.

## key KPIs
 - Headcount	Total employees in the dataset (1.0K / 1,000)
 - Total Attrition	Total number of employees who left the company (203)
 - Attrition Rate: Percentage of employees who left the company, calculate  = Total Attrition ÷ Headcount (20.3%)
 - High Risk Segment	Employees matching the risk profile: Overtime = Yes + Salary Band = Low/Medium + Tenure = 0–2 yrs (150 employees) — this is a custom-defined segment, not a standard field
 - Avg Monthly Income	Average monthly salary across all employees ($5.57K) — used as context to compare against attrition trends

## Dashboard
### HR Attrition Overview
![HR Attrition Overview](https://github.com/deepakrajput2622a-dotcom/HR-Attrition-Analytics-Power-BI-SQL/blob/main/HR%20Attrition%20dashboard%20overview.png)

## SQL Analysis
All SQL queries used for the analysis are available here:
[View SQL Queries](https://github.com/deepakrajput2622a-dotcom/HR-Attrition-Analytics-Power-BI-SQL/blob/main/HR%20Attrition%20SQL%20Queries%20data.sql)

The SQL analysis includes:
- Overall attrirtion rate
- Attrition by Overtime 
- Attrition by age group
- Attrition by salary band
- Attrition by tenure
- High-risk employee segement
- Job role risk ranking
- Satisfaction and work-life balance analysis

## Key Insights
Overall attrition rate: 20.3% (203 of 1,000 employees) — above the typical industry benchmark of ~15%.
Overtime is the strongest risk driver. Across every salary band, employees working overtime have 2–3x higher attrition than those who don't (e.g., Low salary band: 20.5% without overtime vs. 38.5% with overtime).
New employees are the highest risk group. Overtime attrition is highest in the 0–2 year tenure band and steadily declines as tenure increases — pointing to onboarding/early-career experience as a retention lever.
A defined high-risk segment of 150 employees (overtime = Yes, salary band = Low/Medium, tenure = 0–2 years) gives HR a concrete, targetable group instead of guessing.
Role-level hotspots: Within Research & Development, Research Scientist (24.6%) and Healthcare Representative (22.4%) roles show the highest attrition — useful for role-specific interventions.

## Conclusion 
The analysis helps HR teams identify high-risk employee segement and focuse retention strategies on the areas with the highest attrition.


  


