USE retail_db

-- Exercise 1
SELECT MAX(order_id) FROM orders;
GO
SELECT MAX(order_item_id) FROM order_items;
GO
SELECT MAX(customer_id) FROM customers;
GO
SELECT MAX(product_id) FROM products;
GO
SELECT MAX(category_id) FROM categories;
GO
SELECT MAX(department_id) FROM departments;
GO

-- Exercise 2
ALTER TABLE orders
ADD FOREIGN KEY (order_customer_id) REFERENCES customer(customer_id);
GO
ALTER TABLE order_items
ADD FOREIGN KEY (order_item_order_id) REFERENCES orders(order_id);
GO
ALTER TABLE order_items
ADD FOREIGN KEY (order_item_product_id) REFERENCES products(product_id);
GO
ALTER TABLE products
ADD FOREIGN KEY (product_category_id) REFERENCES categories(category_id);
GO
ALTER TABLE categories
ADD FOREIGN KEY (category_department_id) REFERENCES departments(department_id);
GO

-- Exercise 3
SELECT * 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 