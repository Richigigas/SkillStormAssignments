USE retail_db

-- Exercise 1
CREATE PARTITION FUNCTION monthRangePF (datetime2(0))  
    AS RANGE RIGHT FOR VALUES ('2013-07-01', '2013-08-01', '2013-09-01', '2013-10-01', '2013-11-01', '2013-12-01',
		'2014-01-01', '2014-02-01', '2014-03-01', '2014-04-01', '2014-05-01', '2014-06-01', '2014-07-01');  
GO

CREATE PARTITION SCHEME monthRangePS
	AS PARTITION monthRangePF
	ALL TO ('PRIMARY');
GO

CREATE TABLE order_part(
	order_part_id INT IDENTITY PRIMARY KEY,
	order_date DATETIME NOT NULL,
	order_customer_id INT NOT NULL,
	order_status VARCHAR(45) NOT NULL
)
ON monthRangePS(order_date);
GO

-- Exercise 2
INSERT INTO order_part
SELECT * FROM orders;
GO

SELECT COUNT(*) FROM order_part;
GO


