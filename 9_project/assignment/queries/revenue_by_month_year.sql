-- TODO: This query will return a table with the revenue by month and year. It
-- will have different columns: month_no, with the month numbers going from 01
-- to 12; month, with the 3 first letters of each month (e.g. Jan, Feb);
-- Year2016, with the revenue per month of 2016 (0.00 if it doesn't exist);
-- Year2017, with the revenue per month of 2017 (0.00 if it doesn't exist) and
-- Year2018, with the revenue per month of 2018 (0.00 if it doesn't exist).
WITH RevenuePerMonth AS (
    SELECT 
    	o.order_id,--check
        STRFTIME('%m', o.order_delivered_customer_date) AS month_no,
        STRFTIME('%Y', o.order_delivered_customer_date) AS year,
        MIN(p.payment_value) AS revenue
    FROM olist_orders o
    	INNER JOIN olist_order_payments p ON o.order_id = p.order_id
    		AND o.order_delivered_customer_date IS NOT NULL
    		AND o.order_status IN ('delivered', 'shipped')  -- check
    GROUP BY o.order_id, year, month_no
),
RevenuePivot AS (
    SELECT 
        month_no,
        SUBSTR("--JanFebMarAprMayJunJulAugSepOctNovDec", CAST (month_no as integer)  * 3, 3)AS month,
        COALESCE(SUM(CASE WHEN year = '2016' THEN revenue END), 0.00) AS Year2016,
        COALESCE(SUM(CASE WHEN year = '2017' THEN revenue END), 0.00) AS Year2017,
        COALESCE(SUM(CASE WHEN year = '2018' THEN revenue END), 0.00) AS Year2018
    FROM RevenuePerMonth
    GROUP BY month_no, month
    ORDER BY month_no
)
SELECT * 
FROM RevenuePivot;


