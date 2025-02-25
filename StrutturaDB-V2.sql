CREATE DATABASE vendicose_spa;
USE vendicose_spa;

CREATE TABLE Warehouses (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Location VARCHAR(50)
);

CREATE TABLE Stores (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Location VARCHAR(50),
    WarehouseID INT,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(ID)
);

CREATE TABLE Category (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    Description TEXT NOT NULL,
    RestockLevel INT
);

CREATE TABLE Product (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    MaxUnitSalesPrice DECIMAL(10,2),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(ID)
);

CREATE TABLE Sales (
	ID INT,
	StoreID INT,
    LineID	INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (ID, StoreID, LineID),
    FOREIGN KEY (StoreID) REFERENCES Stores(ID),
    FOREIGN KEY (ProductID) REFERENCES Product(ID)
);

CREATE TABLE StockLevels (
	ProductID INT,
    WarehouseID INT,
    Stock INT, -- Quantità di un prodotto in un magazzino specifico
    PRIMARY KEY (ProductID, WarehouseID),
    FOREIGN KEY (ProductID) REFERENCES Product(ID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(ID)
);