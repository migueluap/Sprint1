-- TODO: This query will return a table with the top 10 least revenue categories 
-- in English, the number of orders and their total revenue. The first column 
-- will be Category, that will contain the top 10 least revenue categories; the 
-- second one will be Num_order, with the total amount of orders of each 
-- category; and the last one will be Revenue, with the total revenue of each 
-- catgory.
-- HINT: All orders should have a delivered status and the Category and actual 
-- delivery date should be not null.

SELECT 
	 cnt.product_category_name_english AS Category
	,COUNT(DISTINCT o.order_id) AS Num_order
	,SUM(pa.payment_value) AS Revenue
FROM olist_orders o
	INNER JOIN olist_order_items i ON o.order_id = i.order_id
		AND o.order_status = 'delivered'
		AND o.order_delivered_customer_date IS NOT NULL
	INNER JOIN olist_products p ON i.product_id  = p.product_id 
		AND p.product_category_name IS NOT NULL
	INNER JOIN product_category_name_translation cnt ON p.product_category_name = cnt.product_category_name 
	INNER JOIN olist_order_payments pa ON o.order_id = pa.order_id 
GROUP BY cnt.product_category_name_english
ORDER BY Revenue ASC 
LIMIT 10
