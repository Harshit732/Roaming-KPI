# Roaming Partner KPI Dashboard
 
## Business Question
Which of our 20 roaming partners have the worst IREG test pass rate,
and has performance improved or declined over the past 6 months?
 
## Tools Used
- Python (pandas, numpy) for data generation
- SQL analysis (6 queries including window functions)
- Power BI Desktop for dashboard and visualisation
 
## Key Findings
- Safaricom (Kenya) showed the steepest decline: 75% -> 62% pass rate
- 'Routing error - wrong IPX route' accounts for 28% of all failures
- VoLTE tests have the lowest pass rate (86%) vs Voice (94%)
- Europe region outperforms MEA by 15 percentage points on average
 
## Files
- generate_data.py  : Creates the dataset (67,000+ records)
- sql/analysis_queries.sql : All 6 SQL queries with comments
- powerbi/roaming_kpi.pbix : Power BI report file
 