CREATE TABLE sales(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	product VARCHAR(512),
	category VARCHAR(512),
	price NUMERIC(10, 2),
	quantity INT,
	sale_date DATE
);

INSERT INTO sales(product, category, price, quantity, sale_date)
VALUES
('Apple', 'Fruit', 50, 3, '2024-05-01'),
('Banana', 'Fruit', 30, 5, '2024-05-01'),
('Milk', 'Dairy', 70, 2, '2024-05-02'),
('Cheese', 'Dairy', 120, 1, '2024-05-03'),
('Carrot', 'Vegetable', 40, 4, '2024-05-03'),
('Apple', 'Fruit', 50, 2, '2024-05-04');


SELECT 
	COUNT(id)
FROM sales; 


SELECT 
	SUM(quantity)
FROM sales; 


SELECT 
	AVG(price)
FROM sales;


SELECT 
	MAX(quantity),
	MIN(quantity)
FROM sales;


SELECT 
	SUM(price * quantity)
FROM sales;


SELECT 
	category,
	SUM(price * quantity)
FROM sales 
GROUP BY category;


SELECT 
	product,
	SUM(quantity)
FROM sales 
GROUP BY product;


SELECT 
	category,
	AVG(price)
FROM sales 
GROUP BY category;


SELECT 
	sale_date,
	SUM(quantity)
FROM sales 
GROUP BY sale_date
ORDER BY SUM(quantity) DESC
LIMIT 1;



SELECT 
	product,
	SUM(quantity * price)
FROM sales 
GROUP BY product
ORDER BY SUM(quantity * price) DESC
LIMIT 1;





