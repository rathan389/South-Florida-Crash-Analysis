-- ============================================================
-- South Florida Traffic Crash Analysis — SQL Queries
-- Dataset: florida_crashes_cleaned (500 rows, 2021-2023)
-- Counties: Miami-Dade, Broward, Palm Beach
-- Tool: SQLite / DB Browser for SQLite (free)
-- ============================================================
-- HOW TO USE: Import florida_crashes_cleaned.xlsx (Cleaned Data sheet)
-- as a CSV into SQLiteOnline.com or DB Browser for SQLite.
-- The table name will be: florida_crashes_cleaned
-- ============================================================


-- ── QUERY 1: Total overview — row count and key stats ──────
SELECT
    COUNT(*)                          AS total_records,
    SUM(accidents_count)              AS total_accidents,
    ROUND(AVG(accidents_count), 2)    AS avg_accidents,
    MIN(accidents_count)              AS min_accidents,
    MAX(accidents_count)              AS max_accidents,
    MIN(year)                         AS earliest_year,
    MAX(year)                         AS latest_year
FROM florida_crashes_cleaned;


-- ── QUERY 2: Total & avg accidents by county ───────────────
SELECT
    county,
    COUNT(*)                          AS record_count,
    SUM(accidents_count)              AS total_accidents,
    ROUND(AVG(accidents_count), 2)    AS avg_per_record,
    SUM(CASE WHEN injury = 'Yes' THEN 1 ELSE 0 END) AS injury_records,
    ROUND(
        SUM(CASE WHEN injury = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1
    )                                 AS injury_rate_pct
FROM florida_crashes_cleaned
GROUP BY county
ORDER BY total_accidents DESC;


-- ── QUERY 3: Accidents by county × year (trend table) ──────
SELECT
    county,
    year,
    COUNT(*)                          AS record_count,
    SUM(accidents_count)              AS total_accidents,
    ROUND(AVG(accidents_count), 1)    AS avg_accidents
FROM florida_crashes_cleaned
GROUP BY county, year
ORDER BY county, year;


-- ── QUERY 4: Top causes — avg and total accidents ──────────
SELECT
    reason,
    COUNT(*)                          AS record_count,
    SUM(accidents_count)              AS total_accidents,
    ROUND(AVG(accidents_count), 2)    AS avg_per_record,
    SUM(CASE WHEN injury = 'Yes' THEN 1 ELSE 0 END) AS injury_records,
    ROUND(
        SUM(CASE WHEN injury = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1
    )                                 AS injury_rate_pct
FROM florida_crashes_cleaned
GROUP BY reason
ORDER BY avg_per_record DESC;


-- ── QUERY 5: Accidents by time of day ──────────────────────
SELECT
    time_range,
    CASE time_range
        WHEN '0-4'   THEN 'Late Night'
        WHEN '5-8'   THEN 'Early Morning'
        WHEN '9-12'  THEN 'Mid Morning'
        WHEN '13-16' THEN 'Afternoon'
        WHEN '17-20' THEN 'Evening Rush'
        WHEN '21-23' THEN 'Night'
    END                               AS time_period,
    COUNT(*)                          AS record_count,
    SUM(accidents_count)              AS total_accidents,
    ROUND(AVG(accidents_count), 2)    AS avg_per_record
FROM florida_crashes_cleaned
GROUP BY time_range
ORDER BY CAST(SUBSTR(time_range, 1, INSTR(time_range, '-') - 1) AS INTEGER);


-- ── QUERY 6: Most dangerous day of week ────────────────────
SELECT
    day,
    CASE day
        WHEN 'Mon' THEN 1 WHEN 'Tue' THEN 2 WHEN 'Wed' THEN 3
        WHEN 'Thu' THEN 4 WHEN 'Fri' THEN 5 WHEN 'Sat' THEN 6
        WHEN 'Sun' THEN 7
    END                               AS day_num,
    COUNT(*)                          AS record_count,
    SUM(accidents_count)              AS total_accidents,
    ROUND(AVG(accidents_count), 2)    AS avg_per_record
FROM florida_crashes_cleaned
GROUP BY day
ORDER BY day_num;


-- ── QUERY 7: Age group risk analysis ───────────────────────
SELECT
    age_group,
    COUNT(*)                          AS record_count,
    SUM(accidents_count)              AS total_accidents,
    ROUND(AVG(accidents_count), 2)    AS avg_per_record,
    ROUND(
        SUM(CASE WHEN injury = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1
    )                                 AS injury_rate_pct
FROM florida_crashes_cleaned
GROUP BY age_group
ORDER BY avg_per_record DESC;


-- ── QUERY 8: Weekday vs Weekend comparison ─────────────────
SELECT
    CASE WHEN day IN ('Sat','Sun') THEN 'Weekend' ELSE 'Weekday' END AS day_type,
    county,
    COUNT(*)                          AS record_count,
    SUM(accidents_count)              AS total_accidents,
    ROUND(AVG(accidents_count), 2)    AS avg_per_record
FROM florida_crashes_cleaned
GROUP BY day_type, county
ORDER BY day_type, county;


-- ── QUERY 9: Heatmap data — avg accidents by day × time ────
SELECT
    day,
    time_range,
    ROUND(AVG(accidents_count), 1)    AS avg_accidents,
    COUNT(*)                          AS record_count
FROM florida_crashes_cleaned
GROUP BY day, time_range
ORDER BY
    CASE day WHEN 'Mon' THEN 1 WHEN 'Tue' THEN 2 WHEN 'Wed' THEN 3
             WHEN 'Thu' THEN 4 WHEN 'Fri' THEN 5 WHEN 'Sat' THEN 6
             WHEN 'Sun' THEN 7 END,
    CAST(SUBSTR(time_range, 1, INSTR(time_range, '-') - 1) AS INTEGER);


-- ── QUERY 10: Year-over-year change per county ─────────────
WITH yearly AS (
    SELECT county, year, SUM(accidents_count) AS total
    FROM florida_crashes_cleaned
    GROUP BY county, year
),
lagged AS (
    SELECT
        a.county, a.year, a.total AS current_total,
        b.total                   AS prev_total
    FROM yearly a
    LEFT JOIN yearly b ON a.county = b.county AND a.year = b.year + 1
)
SELECT
    county, year, current_total,
    prev_total,
    CASE WHEN prev_total IS NOT NULL
         THEN ROUND((current_total - prev_total) * 100.0 / prev_total, 1)
         ELSE NULL
    END                           AS yoy_change_pct
FROM lagged
ORDER BY county, year;


-- ── QUERY 11: Top 10 highest accident records ──────────────
SELECT
    county, year, day, time_range,
    reason, age_group, injury,
    accidents_count
FROM florida_crashes_cleaned
ORDER BY accidents_count DESC
LIMIT 10;


-- ── QUERY 12: Injury rate by reason AND county ─────────────
SELECT
    county,
    reason,
    COUNT(*)                          AS records,
    SUM(CASE WHEN injury = 'Yes' THEN 1 ELSE 0 END) AS injured,
    ROUND(
        SUM(CASE WHEN injury = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1
    )                                 AS injury_rate_pct
FROM florida_crashes_cleaned
GROUP BY county, reason
ORDER BY county, injury_rate_pct DESC;
