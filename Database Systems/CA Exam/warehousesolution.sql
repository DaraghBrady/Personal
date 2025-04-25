CREATE TABLE order_details (
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Quantity int,
	FOREIGN KEY (OrderID) REFERENCES orders(OrderID),
	FOREIGN KEY (ProductID) REFERENCES products(ProductID));


INSERT INTO order_details (OrderID, ProductID, Quantity) VALUES
(1,1,2),
(1,4,5),
(1,8,3),
(2,2,3),
(2,5,1),
(3,1,1),
(4,2,3),
(4,5,3),
(4,8,2),
(4,9,1),
(5,4,2),
(5,5,1),
(6,2,3),
(6,4,1),
(6,7,2);

SELECT CustomerName, Address FROM customers WHERE City LIKE "%Dublin%"

SELECT CustomerName, OrderDate FROM customers, orders WHERE customers.CustomerID = orders.CustomerID

SELECT ProductName, UnitPrice FROM products WHERE UnitPrice >= 5.00 AND UnitPrice <= 10.00

SELECT OrderID, COUNT(ProductID) AS total_products FROM order_details GROUP BY OrderID

SELECT SUM(UnitPrice) / COUNT(*) AS average_unit_price FROM products

SELECT SUM(UnitPrice * UnitsInStock) AS total_stock_value FROM products

SELECT CustomerName, orders.OrderID, SUM(UnitPrice * Quantity) AS order_total FROM customers, orders, order_details, products WHERE customers.CustomerID = orders.CustomerID AND orders.OrderID = order_details.OrderID AND order_details.ProductID = products.ProductID AND CustomerName = 'Janet Malone'

SELECT ProductName, OrderDate FROM products, orders, order_details WHERE products.ProductID = order_details.ProductID AND orders.OrderID = order_details.OrderID AND MONTH(OrderDate) = 7

SELECT ProductName, (ReorderLevel - UnitsInStock) AS Shortfall FROM products WHERE UnitsInStock < ReorderLevel

SELECT ProductName, UnitPrice, (UnitsInStock > ReorderLevel) * 0.2 * UnitPrice AS discount, (UnitsInStock > ReorderLevel) * (1 - 0.2) * UnitPrice AS new_unit_price FROM products WHERE UnitsInStock > ReorderLevel