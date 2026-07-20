/*
We've been selling a lot of bikes,
but I don't know which brands are actually making us the most money. 
I need a report for tomorrow."
Why can a brand have more revenue than another brand even if it sold fewer units?z
*/

-- Before the query
SELECT 
	p.product_id,
	p.product_name,
	b.brand_id,
	b.brand_name,
	oi.*
FROM production.products p
JOIN sales.order_items oi
	ON p.product_id = oi.product_id
JOIN production.brands b
	ON p.brand_id = b.brand_id;

-- Main query
SELECT 
	p.brand_id,
	b.brand_name,
	SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))) As Total_revenue,
	SUM(oi.quantity) As  Total_quantity
FROM production.products p
JOIN sales.order_items oi
	ON p.product_id = oi.product_id
JOIN production.brands b
	ON p.brand_id = b.brand_id
GROUP BY p.brand_id, b.brand_name
ORDER BY Total_revenue DESC;

-- Data validatiion
SELECT
    SUM(oi.quantity * (oi.list_price - oi.list_price * oi.discount)) AS Total_Revenue,
    SUM(oi.quantity) AS Total_Quantity
FROM production.products p
JOIN sales.order_items oi
    ON p.product_id = oi.product_id
JOIN production.brands b
    ON p.brand_id = b.brand_id
WHERE b.brand_name = 'Trek';
