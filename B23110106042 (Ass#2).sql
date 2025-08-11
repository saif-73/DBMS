CREATE DATABASE CarShowroomDB;
USE CarShowroomDB;

CREATE TABLE Customers(
  CustomerID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerName VARCHAR(100),
  City VARCHAR(50),
  State VARCHAR(50),
  JoinDate DATE
);

CREATE TABLE Cars(
  CarID INT PRIMARY KEY AUTO_INCREMENT,
  Model VARCHAR(100),
  Brand VARCHAR(50),
  Year INT,
  Price DECIMAL(10,2),
  Color VARCHAR(30),
  InventoryCount INT
);

CREATE TABLE Salespersons(
  SalespersonID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Department VARCHAR(50),
  HireDate DATE
);

CREATE TABLE Sales(
  SaleID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT,
  CarID INT,
  SaleDate DATE,
  SalePrice DECIMAL(10,2),
  SalespersonID INT,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (CarID) REFERENCES Cars(CarID),
  FOREIGN KEY (SalespersonID) REFERENCES Salespersons(SalespersonID)
);

CREATE TABLE ServiceRecords(
  RecordID INT PRIMARY KEY AUTO_INCREMENT,
  CarID INT,
  ServiceDate DATE,
  ServiceType VARCHAR(50),
  Cost DECIMAL(10,2),
  TechnicianID INT,
  FOREIGN KEY (CarID) REFERENCES Cars(CarID)
);

-- insert customers
INSERT INTO Customers(CustomerName, City, State, JoinDate) VALUES
('John Smith','New York','NY','2021-05-10'),
('Alice Johnson','Los Angeles','CA','2020-07-15'),
('Bob Brown','Chicago','IL','2022-01-20'),
('David Wilson','Houston','TX','2023-03-05'),
('Emma Davis','Miami','FL','2021-09-09');

-- insert cars
INSERT INTO Cars(Model, Brand, Year, Price, Color, InventoryCount) VALUES
('Model S','Tesla',2023,80000,'Red',5),
('Model 3','Tesla',2022,50000,'Black',7),
('Civic','Honda',2021,22000,'Blue',10),
('Accord','Honda',2020,25000,'Black',4),
('CR-V','Honda',2023,30000,'White',6),
('Corolla','Toyota',2021,20000,'Silver',8),
('Camry','Toyota',2022,24000,'Black',5),
('Supra','Toyota',2023,55000,'Yellow',2),
('Mustang','Ford',2022,45000,'Red',3),
('F-150','Ford',2023,60000,'Blue',4);

-- insert salespersons
INSERT INTO Salespersons(Name, Department, HireDate) VALUES
('Michael Scott','Sales','2019-01-15'),
('Jim Halpert','Sales','2020-06-01'),
('Pam Beesly','Sales','2021-09-10');

-- insert sales
INSERT INTO Sales(CustomerID, CarID, SaleDate, SalePrice, SalespersonID) VALUES
(1,1,'2023-05-12',82000,1),
(2,2,'2023-06-15',51000,2),
(3,3,'2023-07-20',23000,2),
(4,4,'2023-08-01',25500,3),
(5,5,'2023-08-15',31000,1),
(1,8,'2023-09-05',56000,2),
(2,9,'2023-09-10',47000,3),
(3,10,'2023-09-15',61000,1),
(4,6,'2023-09-20',21000,2),
(5,7,'2023-09-25',24500,3);

-- insert service records
INSERT INTO ServiceRecords(CarID, ServiceDate, ServiceType, Cost, TechnicianID) VALUES
(1,'2023-05-20','Engine Check',600,101),
(2,'2023-06-18','Oil Change',150,102),
(3,'2023-07-22','Tire Replacement',400,103),
(4,'2023-08-05','Engine Check',550,104),
(5,'2023-08-18','Brake Service',300,105);

-- Part 1
SELECT COUNT(*) FROM Customers;
SELECT AVG(SalePrice) FROM Sales;
SELECT MAX(SalePrice) FROM Sales;
SELECT SUM(InventoryCount) FROM Cars;
SELECT MIN(SaleDate), MAX(SaleDate) FROM Sales;

-- Part 2
SELECT Brand, COUNT(Model) FROM Cars GROUP BY Brand;
SELECT Salespersons.Name, SUM(Sales.SalePrice) FROM Salespersons
JOIN Sales ON Salespersons.SalespersonID = Sales.SalespersonID
GROUP BY Salespersons.Name;
SELECT Cars.Model, AVG(Sales.SalePrice) FROM Cars
JOIN Sales ON Cars.CarID = Sales.CarID
GROUP BY Cars.Model;
SELECT ServiceType, AVG(Cost) FROM ServiceRecords GROUP BY ServiceType;
SELECT Brand, Color, COUNT(*) FROM Cars GROUP BY Brand, Color;

-- Part 3
SELECT Brand, COUNT(Model) FROM Cars GROUP BY Brand HAVING COUNT(Model) > 5;
SELECT Cars.Model, COUNT(Sales.SaleID) FROM Cars
JOIN Sales ON Cars.CarID = Sales.CarID
GROUP BY Cars.Model HAVING COUNT(Sales.SaleID) > 10;
SELECT Salespersons.Name, AVG(Sales.SalePrice) FROM Salespersons
JOIN Sales ON Salespersons.SalespersonID = Sales.SalespersonID
GROUP BY Salespersons.Name HAVING AVG(Sales.SalePrice) > 50000;
SELECT DATE_FORMAT(SaleDate,'%Y-%m'), COUNT(*) FROM Sales
GROUP BY DATE_FORMAT(SaleDate,'%Y-%m') HAVING COUNT(*) > 20;
SELECT ServiceType, AVG(Cost) FROM ServiceRecords
GROUP BY ServiceType HAVING AVG(Cost) > 500;
