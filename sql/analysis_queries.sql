-- ==========================================
-- Query 1: Overall pass rate by partner
-- ==========================================
SELECT
    partner_name,
    ROUND(
        100.0 * SUM(CASE WHEN result = 'pass' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS pass_rate_pct
FROM roaming_tests
GROUP BY partner_name;


-- ==========================================
-- Query 2: Pass rate by region
-- ==========================================
SELECT
    region,
    ROUND(
        100.0 * SUM(CASE WHEN result = 'pass' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS pass_rate_pct
FROM roaming_tests
GROUP BY region;


-- ==========================================
-- Query 3: Failed tests by service
-- ==========================================
SELECT
    service_type,
    COUNT(*) AS failed_tests
FROM roaming_tests
WHERE result = 'fail'
GROUP BY service_type;


-- ==========================================
-- Query 4: Top partners by pass rate
-- ==========================================
SELECT
    partner_name,
    ROUND(
        100.0 * SUM(CASE WHEN result = 'pass' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS pass_rate_pct
FROM roaming_tests
GROUP BY partner_name
ORDER BY pass_rate_pct DESC;


-- ==========================================
-- Query 5: Rank partners within each region
-- ==========================================
SELECT
    region,
    partner_name,
    ROUND(
        100.0 * SUM(CASE WHEN result = 'pass' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS pass_rate_pct,
    RANK() OVER (
        PARTITION BY region
        ORDER BY
            ROUND(
                100.0 * SUM(CASE WHEN result = 'pass' THEN 1 ELSE 0 END) / COUNT(*),
                2
            ) DESC
    ) AS region_rank
FROM roaming_tests
GROUP BY region, partner_name;


-- ==========================================
-- Query 6: Month-over-month pass rate change
-- ==========================================
WITH monthly AS (
    SELECT
        partner_name,
        month,
        ROUND(
            100.0 * SUM(CASE WHEN result = 'pass' THEN 1 ELSE 0 END) / COUNT(*),
            2
        ) AS pass_rate_pct
    FROM roaming_tests
    GROUP BY partner_name, month
)
SELECT
    partner_name,
    month,
    pass_rate_pct,
    LAG(pass_rate_pct) OVER (
        PARTITION BY partner_name
        ORDER BY month
    ) AS previous_month_rate,
    ROUND(
        pass_rate_pct -
        LAG(pass_rate_pct) OVER (
            PARTITION BY partner_name
            ORDER BY month
        ),
        2
    ) AS change_pct
FROM monthly;