-- 2 - Quali sono le query da eseguire per verificare quante unità di un prodotto ci sono in un dato magazzino e per monitorare le soglie di restock?
-- Per verificare quante unità di prodotto (ID 1) ci sono nel magazzino (ID 1)

-- ------------------
-- !!! Vendita 1001 !!!
-- -------------------

-- Verifichiamo quali stores sono associati al magazzino 2
SELECT ID
FROM Stores
WHERE WarehouseID = 2;

-- Scegliamo uno store "ST2005"
-- Che prodotti ci sono nel magazzino 2?
SELECT ProductID
FROM StockLevel
WHERE WarehouseID = 2;

-- Scegliamo un prodotto che vogliamo vendere "A1X3Y9"
-- Verifichiamo lo stock attuale e la soglia di restock della sua categoria
SELECT * FROM VistaRestockProdotto WHERE CodiceProdotto = "A1X3Y9" AND CodiceMagazzino = 2;

-- Eseguiamo una vendita per questo prodotto
INSERT INTO Sales (StoreID, SalesID, LineID, ProductID, Quantity, UnitPrice, PaymentMethod)
VALUES
('ST2005', 1001, 1, 'A1X3Y9', 10, 1.89, 'Debit Card');

-- Controlliamo vendita generata
SELECT * FROM Sales;

-- Ricontrolliamo stock
SELECT * FROM VistaRestockProdotto WHERE CodiceProdotto = "A1X3Y9" AND CodiceMagazzino = 2;

-- Verifichiamo se ci sono allarmi di prodotti sottosoglia
SELECT * FROM StockAlerts;

-- Riapprovigionamento stock dei prodotti sottosoglia
UPDATE StockLevel
SET Stock =	(SELECT Category.RestockLevel
			 FROM Category
             JOIN Product ON Category.ID = Product.CategoryID
			 WHERE Product.ID = StockLevel.ProductID) + 100
WHERE ProductID IN (SELECT ProductID FROM StockAlerts) AND Stock < (SELECT Category.RestockLevel
																	FROM Category
																	JOIN Product ON Category.ID = Product.CategoryID
																	WHERE Product.ID = StockLevel.ProductID);
                                                                    
-- Ricontrolliamo lo stock
SELECT * FROM VistaRestockProdotto WHERE CodiceProdotto = "A1X3Y9" AND CodiceMagazzino = 2;

-- ------------------
-- !!! Vendita 1008 !!!
-- -------------------
-- Quali stores sono presenti a Milano
CREATE VIEW AnagraficaSupermercati AS
SELECT Stores.Name AS NomeSupermercato, Stores.Location AS IndirizzoSupermercato , Stores.ID AS CodiceSupermercato, Warehouses.ID AS CodiceMagazzino
FROM Stores JOIN Warehouses ON Stores.WarehouseID = Warehouses.ID;
-- WHERE Stores.Location LIKE "Milano%";

-- Quali prodotti ci sono nel magazzino associato all'esselunga 'ST1542'
CREATE VIEW AnagraficaProdottiMagazzino AS
SELECT StockLevel.ProductID AS CodiceProdotto, Product.Name AS NomeProdotto, Category.Name AS NomeCategoria, Stores.ID AS CodiceSupermercato ,  StockLevel.Stock AS Stock, Category.RestockLevel AS LivelloRestock
FROM StockLevel JOIN Warehouses ON StockLevel.WarehouseID = Warehouses.ID
JOIN Product ON Product.ID = StockLevel.ProductID
JOIN Stores ON Stores.WarehouseID = Warehouses.ID
JOIN Category ON Category.ID = Product.CategoryID;
-- WHERE Stores.ID = 'ST1542';

SELECT * FROM anagraficasupermercati
WHERE IndirizzoSUpermercato LIKE "Milano%";

SELECT * FROM anagraficaprodottimagazzino
WHERE CodiceSupermercato = 'ST1542';

-- Vendita di mele golden e pere williams 'D3L7M2'
-- Eseguiamo una vendita per questo prodotto
INSERT INTO Sales (StoreID, SalesID, LineID, ProductID, Quantity, UnitPrice, PaymentMethod)
VALUES
('ST1542', 1008, 1, 'A1X3Y9', 50, 1.89, 'Debit Card'),
('ST1542', 1008, 2, 'D3L7M2', 30, 1.89, 'Debit Card');

SELECT * FROM anagraficaprodottimagazzino
WHERE CodiceSupermercato = 'ST1542' AND CodiceProdotto in ('A1X3Y9','D3L7M2')  ;

SELECT * FROM Sales;

SELECT * FROM stockalerts;

-- Riapprovigionamento stock dei prodotti sottosoglia
UPDATE StockLevel
SET Stock =	(SELECT Category.RestockLevel
			 FROM Category
             JOIN Product ON Category.ID = Product.CategoryID
			 WHERE Product.ID = StockLevel.ProductID) + 100
WHERE ProductID IN (SELECT ProductID FROM StockAlerts) AND Stock < (SELECT Category.RestockLevel
																	FROM Category
																	JOIN Product ON Category.ID = Product.CategoryID
																	WHERE Product.ID = StockLevel.ProductID);
                                                                    
SELECT * FROM anagraficaprodottimagazzino
WHERE CodiceSupermercato = 'ST1542' AND CodiceProdotto in ('A1X3Y9','D3L7M2')  ;






                                                                    
