drop table if exists order_details, orders, customers, products;

CREATE TABLE customers (
  CustomerID varchar(5) NOT NULL,
  CustomerName varchar(40),
  Address varchar(60),
  City varchar(15),
  PRIMARY KEY  (CustomerID)); 

INSERT INTO customers (CustomerID, CustomerName, Address, City) VALUES
("ADMUR", "Adam Murphy", "72 Canal Street", "Dublin"),
("BITOM", "Bill Tompson", "21 Quay Street", "Dublin"),
("FRMCG", "Frank McGill", "57 Cherry Lane", "Cork"),
("HACLA", "Harry Clarke", "184 High Street", "Limerick"),
("HEONE", "Helen ONeill", "89 Harbour View", "Galway"),
("JAMAL", "Janet Malone", "44 Castle Close", "Kilkenny"),
("SIPHI", "Simon Phillips", "36 Market Street", "Cork"),
("CAKEN", "Cathy Kenny", "35 Oak Lane", "Dublin"),
("PAWIL", "Paula Wilson", "60 River Drive", "Cork"),
("PESIM", "Peter Simpson", "11 Coach Hill", "Dublin"),
("JUMOR", "Julie Morris", "29 Ashtree Park", "Limerick"),
("SATAY", "Sarah Taylor", "77 Lonsdale Road", "Dublin");


CREATE TABLE orders (
  OrderID int NOT NULL,
  CustomerID varchar(5),
  OrderDate date,
  PRIMARY KEY  (OrderID),
  FOREIGN KEY (Customerid) REFERENCES customers(Customerid));

INSERT INTO orders (OrderID, CustomerID, OrderDate) VALUES
(1, "ADMUR", "2012-07-26"),
(2, "BITOM", "2012-04-12"),
(3, "FRMCG", "2012-07-01"),
(4, "JAMAL", "2012-09-20"),
(5, "JUMOR", "2012-08-19"),
(6, "SATAY", "2012-10-17");


CREATE TABLE products (
  ProductID int NOT NULL,
  ProductName varchar(40),
  UnitPrice decimal(10,2),
  UnitsInStock int,
  ReorderLevel int,
  PRIMARY KEY  (ProductID));
  
INSERT INTO products (ProductID, ProductName, UnitPrice, UnitsInStock, ReorderLevel) VALUES
(1, "Aniseed Syrup", 5.50, 10, 15),
(2, "Cajun Seasoning", 3.60, 82, 50),
(3, "Organic Dried Pears", 1.90, 25, 30),
(4, "Teatime Chocolate", 9.80, 23, 40),
(5, "Boston Crab Meat", 9.10, 8, 20),
(6, "New England Clam Chowder", 8.70, 18, 20),
(7, "Ravioli Angelo", 6.70, 15, 20),
(8, "Hot Pepper Sauce", 2.30, 12, 10),
(9, "Longbreads", 3.30, 30, 40);