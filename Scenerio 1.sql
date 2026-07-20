/* The regional manager wants to know which stores are performing the best.
They need a report showing:

Store name
Total revenue
Total units sold
Number of distinct products sold
Number of distinct orders

Requirements:

Include every store that has made sales.
Sort from the highest revenue to the lowest.
Show only the top 5 stores.*/

SELECT *
FROM sales.orders o
JOIN sales.order_items oi
	ON o.order_id = oi.order_id
JOIN sales.stores st
	ON o.store_id = st.store_id;


SELECT 
	st.store_name,
	SUM(oi.quantity * (oi.list_price - (oi.list_price * oi.discount))) As Total_revenue,
	SUM(oi.quantity) As Total_units,
	COUNT(DISTINCT(oi.product_id)) As NrOfUniqueProduct,
	COUNT(DISTINCT(o.order_id)) AS NrOfUniqueOrders
FROM sales.orders o
JOIN sales.order_items oi
	ON o.order_id = oi.order_id
JOIN sales.stores st
	ON o.store_id = st.store_id
GROUP BY st.store_name
ORDER BY Total_revenue DESC;
