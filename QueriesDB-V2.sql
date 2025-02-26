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
WHERE Stores.ID = 2;

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
                    

-- Creazione di un trigger automatico

DELIMITER //								 	-- Serve a modificare temporaneamente il simbolo che indica il termine di un comando, così che SQL non interpreti ; come la fine del comando ma usi //
CREATE TRIGGER update_stock_after_insert 		-- Definiamo un trigger con un nome
AFTER INSERT ON Sales 							-- Il trigger si attiverà ogni volta che viene effettuata una insert nella tabella Sales
FOR EACH ROW 									-- Il trigger verrà eseguito per ogni riga inserita nella tabella Sales
BEGIN											-- Identifica l'inizio del blocco di istruzioni
	UPDATE StockLevels							-- Update utilizzato per diminuire lo stock
    SET Stock = Stock - NEW.Quantity			-- NEW.Quantity identifica la quantità appena inserita nella tabella Sales nella riga per cui si è stato attivato il trigger
    WHERE ProductID = NEW.ProductID				-- NEW.ProductID identifica l'ID del prodotto appena inserito nella tabella Sales nella riga per cui si è attivato il trigger
    AND WarehouseID = (							
		SELECT Warehouses.ID					-- Subquery per recuperare il magazzino correlato allo store che è stato inserito nella vendita
        FROM Warehouses
        JOIN Stores ON Warehouses.ID = Stores.WarehouseID
        WHERE Stores.ID = NEW.StoreID			-- NEW.StoreID identifica l'ID dello store appena inserito nella tabella Sales nella riga per cui si è attivato il trigger
        LIMIT 1
	);
END;											-- Fine del blocco di istruzioni
//												-- Delimitatore di fine comando temporaneo impostato prima
DELIMITER ; -- Ripristina il delimitatore di fine comando a ;

-- Verifichiamo stock pre-vendita
SELECT * FROM StockLevels;

-- Effetuiamo una vendita
INSERT INTO Sales (ID, StoreID, LineID, ProductID, Quantity) VALUES
(17, 2, 1, 1, 10),
(17, 2, 2, 2, 5);

-- Verifichiamo lo stock post-vendita
SELECT * FROM StockLevels;


    

