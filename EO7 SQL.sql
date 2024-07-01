USE retail_db

SELECT * FROM products
-- Exercise 1: Simple Subquery

SELECT sqcat.category_name FROM (
	SELECT
		c.category_name,
		COUNT(*) AS [cat_count]
	FROM categories c
		JOIN products p ON c.category_id = p.product_category_id
	GROUP BY category_name
	) sqcat
WHERE sqcat.cat_count > 5;
GO

-- Exercise 2: Subquery in WHERE Clause
-- Will want to use having to filter by count
SELECT 
	o.order_customer_id,
	o.order_id
FROM orders o
WHERE o.order_customer_id IN (
	SELECT o.order_customer_id
	FROM orders o
	GROUP BY o.order_customer_id
	HAVING COUNT(o.order_id) > 10
)
ORDER BY order_customer_id;
GO

-- Exercise 3: Subquery in SELECT Clause
SELECT p.product_name, (
	SELECT AVG(order_item_product_price)
	FROM orders o 
		JOIN order_items oi ON o.order_id = oi.order_item_order_id
	WHERE MONTH(o.order_date) = 10 AND YEAR(o.order_date) = 2013
	) AS [average_price]
FROM products p
GROUP BY p.product_name;
GO

