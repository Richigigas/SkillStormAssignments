USE retail_db

-- Exercise 1 - Customer order count
SELECT 
	c.customer_id, 
	c.customer_fname [customer_first_name], 
	c.customer_lname [customer_last_name],
	COUNT(*) AS [customer_order_count] 
FROM customers c 
	JOIN orders o ON c.customer_id = o.order_customer_id
WHERE o.order_date BETWEEN '2014-01-01' AND '2014-01-31'
GROUP BY o.order_customer_id, c.customer_id, c.customer_fname, c.customer_lname
ORDER BY customer_order_count DESC, c.customer_id ASC;
GO

-- Exercise 2 - Dormant Customers
SELECT *
FROM customers c
WHERE c.customer_id NOT IN (
	SELECT c.customer_id 
	FROM customers c 
		JOIN orders o ON c.customer_id = o.order_customer_id
	WHERE o.order_date BETWEEN '2014-01-01' AND '2014-01-31'
	GROUP BY c.customer_id
);
GO

-- Exercise 3 - Revenue Per Customer
SELECT 
	c.customer_id,
	c.customer_fname [customer_first_name],
	c.customer_lname [customer_last_name],
	SUM(oi.order_item_subtotal) [customer_revenue]
FROM customers c
	JOIN orders o ON c.customer_id = o.order_customer_id
	LEFT JOIN order_items oi ON o.order_id = oi.order_item_order_id
WHERE o.order_date BETWEEN '2014-01-01' AND '2014-01-31' AND (o.order_status = 'COMPLETE' OR o.order_status = 'CLOSED')
GROUP BY c.customer_id, c.customer_fname, c.customer_lname
ORDER BY customer_revenue DESC, c.customer_id ASC;
GO

-- Exercise 4 - Revenue Per Category
SELECT 
	c.category_id,
	c.category_department_id,
	c.category_name,
	SUM(order_item_subtotal) AS [category_revenue]
FROM orders o
	JOIN order_items oi ON order_id = order_item_order_id
	JOIN products p ON product_id = order_item_product_id
	JOIN categories c ON category_id = product_category_id
WHERE o.order_date BETWEEN '2014-01-01' AND '2014-01-31' AND (o.order_status = 'COMPLETE' OR o.order_status = 'CLOSED')
GROUP BY c.category_id, c.category_department_id, c.category_name
ORDER BY c.category_id ASC;
GO

-- Exercise 5 - Product Count Per Department
SELECT 
	d.department_id,
	d.department_name,
	COUNT(product_id) AS [product_count]
FROM departments d
	LEFT JOIN categories c ON department_id = category_department_id
	LEFT JOIN products p ON category_id = product_category_id
GROUP BY d.department_name, d.department_id
ORDER BY d.department_id ASC;
GO