# South Florida Traffic Crash Analysis (2021–2023)

**A data analytics portfolio project by Sai Rathan Reddy Anumula**

---

## Problem Statement

South Florida (Broward, Miami-Dade, and Palm Beach counties) is consistently ranked among the most dangerous driving regions in the United States. This project analyzes 500 traffic crash records from 2021 to 2023 to identify: (1) which counties and years have the highest crash burden, (2) the peak danger windows by time of day and day of week, (3) the primary contributing causes, and (4) which age groups are most at risk — with actionable recommendations for transportation authorities and safety planners.

---

## Tools Used

| Tool | Purpose |
|---|---|
| Python (pandas, matplotlib, seaborn, scikit-learn) | Data cleaning, EDA, visualization, modeling |
| SQL (SQLite) | Structured queries and aggregation |
| Microsoft Excel | Cleaned dataset, pivot summaries |
| Power BI | Interactive dashboard |

---

## Dataset

- **Source:** South Florida traffic crash records (Broward, Miami-Dade, Palm Beach counties)
- **Period:** 2021–2023
- **Records:** 500 rows × 8 original columns
- **Columns:** county, year, day, accidents_count, reason, age_group, injury, time_range
- **File:** `data/florida_crashes_cleaned.xlsx`

---

## Project Structure

```
south-florida-crash-analysis/
│
├── README.md
├── South_Florida_Crash_Analysis.ipynb   ← Full Python analysis
│
├── data/
│   └── florida_crashes_cleaned.xlsx     ← Cleaned data + feature engineering
│
├── sql/
│   └── analysis_queries.sql             ← 12 SQL queries with results
│
└── charts/
    ├── chart1_county_year.png           ← Accidents by county per year
    ├── chart2_avg_by_reason.png         ← Avg accidents by cause
    ├── chart3_heatmap_day_time.png      ← Day × time heatmap
    ├── chart4_injury_by_reason.png      ← Injury vs no injury by cause
    ├── chart5_trend_line.png            ← Year trend per county
    ├── chart6_age_group.png             ← Accidents by age group
    ├── chart7_donut_reason.png          ← Share of accidents by cause
    ├── chart8_boxplot_county.png        ← Distribution by county
    └── chart9_weekday_weekend.png       ← Weekday vs weekend
```

---

## Data Analysis Workflow

| Step | What I Did |
|---|---|
| 1. Define Problem | Identified South Florida crash patterns as the focus |
| 2. Collect Data | Obtained crash records for 3 counties, 2021–2023 |
| 3. Understand Data | Audited 500 rows × 8 columns; confirmed dtypes and value ranges |
| 4. Clean Data | Validated zero nulls, zero duplicates; documented cleaning log |
| 5. Transform | Engineered 6 new features: day_order, day_type, time_label, hour_start, injury_binary, high_count_flag |
| 6. EDA | Analyzed distributions, averages, and cross-tabulations across all dimensions |
| 7. Analyze & Model | Ran pivot analysis, YoY trend, injury rate analysis, and Random Forest classifier |
| 8. Visualize | Built 9 charts in Python + 3-page Power BI dashboard |
| 9. Communicate | Wrote findings and recommendations backed by specific numbers |

---

## Key Findings

**Finding 1 — 2023 was the worst year for Broward and Miami-Dade**
- Broward: +55.7% increase in total accidents from 2021 to 2023 (11,757 → 18,308)
- Miami-Dade: +26.2% increase (14,418 → 18,202)
- Palm Beach peaked in 2022 (17,197) then declined in 2023 (13,374)

**Finding 2 — Early morning (5–8 AM) is the most dangerous time window**
- Average accidents count: 296.5 — the highest of all 6 time periods
- This is counterintuitive: more dangerous than evening rush hour (232.3 avg)
- Likely driven by drowsy driving and late-night DUI drivers

**Finding 3 — Drowsy driving is the top cause by average accident count**
- Drowsy: 268.2 avg | Speeding: 267.1 avg | DUI: 258.3 avg
- All causes have nearly equal injury rates (~44–49%)

**Finding 4 — Age 25–34 has the highest average accident involvement**
- 25–34: 273.1 avg | 20–24: 264.9 avg
- Young adults (20–34) are consistently the highest-risk demographic

**Finding 5 — 47.8% of all accident records resulted in injury**
- Consistent across all counties and causes — this is a systemic problem, not isolated

---

## Recommendations

1. **Increase DUI and drowsy-driving enforcement during 5–8 AM** — the peak danger window that most safety campaigns ignore.
2. **Target 20–34 age group** with digital safety campaigns on social media — they show the highest average accident involvement.
3. **Prioritize road safety investment in Broward** — it showed the steepest rise (+55.7%) and is the most urgent county for intervention.
4. **Investigate Palm Beach's 2022 spike** — a 75% increase from 2021 to 2022 (9,823 → 17,197) warrants further analysis.

---

## Charts

### Accidents by County per Year
![Chart 1](charts/chart1_county_year.png)

### Average Accidents by Cause
![Chart 2](charts/chart2_avg_by_reason.png)

### Day × Time of Day Heatmap
![Chart 3](charts/chart3_heatmap_day_time.png)

### Injury vs No Injury by Cause
![Chart 4](charts/chart4_injury_by_reason.png)

### Year Trend per County
![Chart 5](charts/chart5_trend_line.png)

### Accidents by Age Group
![Chart 6](charts/chart6_age_group.png)

### Share of Accidents by Cause
![Chart 7](charts/chart7_donut_reason.png)

### Distribution by County (Box Plot)
![Chart 8](charts/chart8_boxplot_county.png)

### Weekday vs Weekend
![Chart 9](charts/chart9_weekday_weekend.png)

---

## HTML DASHBOARD
file:///C:/Users/ratha/Downloads/florida_crash_dashboard.html
## About Me

Recent Master's graduate in Data Science from Florida Atlantic University (May 2025). This project was built to demonstrate end-to-end data analytics skills using real South Florida crash data.

- LinkedIn: www.linkedin.com/in/rathanreddy389
- GitHub: https://github.com/rathan389
