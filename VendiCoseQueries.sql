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
-- ------------------

-- ------------------
-- !!! Vendita 1002 !!!
-- -------------------

-- Eseguiamo una vendita 
INSERT INTO Sales (StoreID, SalesID, LineID, ProductID, Quantity, UnitPrice, PaymentMethod)
VALUES
('ST3474', 1002, 1, 'A1X3Y9', 10, 1.89, 'Debit Card');

-- Controlliamo vendita generata
SELECT * FROM Sales;

-- Ricontrolliamo stock
SELECT * FROM VistaStoreStock WHERE CodiceProdotto = "A1X3Y9" AND CodiceStore = "ST3474";

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


                                                                    
