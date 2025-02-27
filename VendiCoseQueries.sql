-- 2 - Quali sono le query da eseguire per verificare quante unità di un prodotto ci sono in un dato magazzino e per monitorare le soglie di restock?
-- Per verificare quante unità di prodotto (ID 1) ci sono nel magazzino (ID 1)
CREATE VIEW VistaRestockProdotto AS
	SELECT Product.Name AS NomeProdotto, Product.ID AS CodiceProdotto, Warehouses.ID AS CodiceMagazzino, StockLevel.Stock, Category.RestockLevel AS SogliaDiRestock
	FROM Product JOIN StockLevel ON Product.ID = StockLevel.ProductID
	JOIN Warehouses ON Warehouses.ID = StockLevel.WarehouseID
	JOIN Category ON Product.CategoryID = Category.ID;
    
SELECT * FROM VistaRestockProdotto WHERE Stock < SogliaDiRestock;


-- Riapprovigionamento stock
UPDATE StockLevel
SET Stock =	(SELECT Category.RestockLevel
			 FROM Category
             JOIN Product ON Category.CategoryID = Product.CategoryID
			 WHERE Product.ProductID = StockLevel.ProductID) + 100
WHERE ProductID IN (SELECT ProductID FROM StockAlerts) AND Stock < (SELECT Category.RestockLevel
																	FROM Category
																	JOIN Product ON Category.CategoryID = Product.CategoryID
																	WHERE Product.ProductID = StockLevel.ProductID);
                                                                    
