# HR Attrition Analytics — Power BI + SQL

## Project Overview
An end-to-end HR analytics project identifying which employee segments are at the highest risk of attrition, using SQL for analysis and Power BI for interactive visualization.

## Business Problem
Employee attrition is expensive every departure costs the company in hiring, onboarding, and lost institutional knowledge. 
But not all attrition risk is equal. This project answers a key HR question:

## Tools & Techniques
 - SQL (MySQL) — joins across fact/dimension tables, CTEs, window functions (RANK() OVER PARTITION BY), conditional aggregation (pivot-style analysis).
 - Power BI Desktop — KPI cards, interactive filters (Department, OverTime), grouped bar charts, donut chart, and a drillable department/role table.

## key KPIs
 - Headcount	Total employees in the dataset (1.0K / 1,000)
 - Total Attrition	Total number of employees who left the company (203)
 - Attrition Rate %	% of workforce that left = Total Attrition ÷ Headcount (20.3%)
 - High Risk Segment	Employees matching the risk profile: Overtime = Yes + Salary Band = Low/Medium + Tenure = 0–2 yrs (150 employees) — this is a custom-defined segment, not a standard field
 - Avg Monthly Income	Average monthly salary across all employees ($5.57K) — used as context to compare against attrition trends

