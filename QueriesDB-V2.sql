-- Ogni qual volta un prodotto viene venduto in un negozio, qual è la query da eseguire per aggiornare le tabelle di riferimento?

-- Viene effettuata la vendita 13 nello store 'Negozio Centrale Milano', che comprende 5 smartphone, 3 laptop
INSERT INTO Sales (ID, StoreID, LineID, ProductID, Quantity) VALUES
(13, 1, 1, 1, 5),
(13, 1, 2, 2, 3);

-- Lista dei prodotti venduta con la vendita 13 nello store 1
SELECT ProductID
FROM Sales
WHERE Sales.ID = 13 AND Sales.StoreID = 1;

-- Aggiornamento stock del prodotto 1
UPDATE StockLevels
SET Stock = Stock - 
	(SELECT Quantity FROM Sales WHERE Sales.ID = 13 AND Sales.ProductID = 1)
WHERE ProductID = 1 AND WarehouseID = (SELECT Warehouses.ID
	FROM Warehouses JOIN Stores ON Warehouses.ID = Stores.WarehouseID
	JOIN Sales ON Stores.ID = Sales.StoreID
	WHERE Sales.ID = 13 AND Sales.StoreID = 1 LIMIT 1);
    
-- Aggiornamento stock del prodotto 2
UPDATE StockLevels
SET Stock = Stock - 
	(SELECT Quantity FROM Sales WHERE Sales.ID = 13 AND Sales.ProductID = 2)
WHERE ProductID = 2 AND WarehouseID = (SELECT Warehouses.ID
	FROM Warehouses JOIN Stores ON Warehouses.ID = Stores.WarehouseID
	JOIN Sales ON Stores.ID = Sales.StoreID
	WHERE Sales.ID = 13 AND Sales.StoreID = 1 LIMIT 1);
 
 -- Aggiornamento con una sola query per mezzo di un id vendita e di un store id
UPDATE StockLevels
SET Stock = Stock - (SELECT Quantity FROM Sales WHERE Sales.ID = 13 AND Sales.ProductID = StockLevels.ProductID)
WHERE ProductID IN 
(SELECT ProductID FROM Sales WHERE Sales.ID = 13) AND WarehouseID = (SELECT WarehouseID	FROM Stores WHERE ID = 1);

 -- Aggiornamento con una sola query per mezzo di un id vendita
UPDATE StockLevels
SET Stock = Stock - (SELECT Quantity FROM Sales WHERE Sales.ID = 13 AND Sales.ProductID = StockLevels.ProductID)
WHERE ProductID IN (SELECT ProductID FROM Sales WHERE Sales.ID = 13) 
AND WarehouseID = (	SELECT Warehouses.ID FROM Warehouses 
					JOIN Stores ON Warehouses.ID = Stores.WarehouseID
					JOIN Sales ON Stores.ID = Sales.StoreID
					WHERE Sales.ID = 13 LIMIT 1);

-- Numero vendita 14 nello store 5
-- Che prodotti ci sono nello store 5?
SELECT StockLevels.ProductID 
FROM StockLevels JOIN Warehouses ON StockLevels.WarehouseID = Warehouses.ID
JOIN Stores ON Stores.WarehouseID = Warehouses.ID
WHERE Stores.ID = 5;

-- Vengono venduti i prodotti 4 e 6
INSERT INTO Sales (ID, StoreID, LineID, ProductID, Quantity) VALUES
(14, 5, 1, 4, 10),
(14, 5, 2, 6, 5);

 -- Aggiornamento dello stock con una sola query per mezzo dell'id vendita 14
UPDATE StockLevels
SET Stock = Stock - (SELECT Quantity FROM Sales WHERE Sales.ID = 14 AND Sales.ProductID = StockLevels.ProductID)
WHERE ProductID IN (SELECT ProductID FROM Sales WHERE Sales.ID = 14) 
AND WarehouseID = (	SELECT Warehouses.ID FROM Warehouses 
					JOIN Stores ON Warehouses.ID = Stores.WarehouseID
					JOIN Sales ON Stores.ID = Sales.StoreID
					WHERE Sales.ID = 14 LIMIT 1);




    

