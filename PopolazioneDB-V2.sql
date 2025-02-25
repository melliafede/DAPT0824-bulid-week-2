-- Inserimento dati nei magazzini (Warehouses)
INSERT INTO Warehouses (Location) VALUES 
('Milano'),
('Roma'),
('Napoli'),
('Torino'),
('Firenze'),
('Bologna'),
('Genova'),
('Palermo'),
('Venezia'),
('Verona');

-- Inserimento dati nei negozi (Stores)
INSERT INTO Stores (Location, WarehouseID) VALUES 
('Negozio Centrale Milano', 1),
('Negozio Duomo Milano', 1),
('Negozio Navigli Milano', 1),
('Negozio Porta Roma', 2),
('Negozio Trastevere Roma', 2),
('Negozio Termini Roma', 2),
('Negozio Vesuvio Napoli', 3),
('Negozio Centro Storico Napoli', 3),
('Negozio Chiaia Napoli', 3),
('Negozio Mole Torino', 4),
('Negozio Porta Nuova Torino', 4),
('Negozio Quadrilatero Torino', 4),
('Negozio Ponte Vecchio Firenze', 5),
('Negozio Santa Croce Firenze', 5),
('Negozio Uffizi Firenze', 5),
('Negozio Due Torri Bologna', 6),
('Negozio Lanterna Genova', 7),
('Negozio Quattro Canti Palermo', 8),
('Negozio Canal Grande Venezia', 9),
('Negozio Arena Verona', 10);

-- Inserimento dati nelle categorie di prodotti (Category)
INSERT INTO Category (Name, Description, RestockLevel) VALUES 
('Elettronica', 'Dispositivi elettronici e accessori', 50),
('Abbigliamento', 'Vestiti e accessori di moda', 30),
('Alimentari', 'Cibo e bevande', 100),
('Giocattoli', 'Giochi per bambini di tutte le età', 20),
('Casa', 'Prodotti per la casa e arredamento', 40),
('Sport', 'Attrezzature e abbigliamento sportivo', 35),
('Bellezza', 'Prodotti per la cura della persona', 25);

-- Inserimento dati nei prodotti (Product)
INSERT INTO Product (Name, MaxUnitSalesPrice, CategoryID) VALUES 
('Smartphone', 799.99, 1),
('Laptop', 1299.99, 1),
('Auricolari Bluetooth', 99.99, 1),
('Jeans', 49.99, 2),
('Giacca in pelle', 199.99, 2),
('Scarpe da ginnastica', 89.99, 2),
('Pasta Artigianale', 5.99, 3),
('Vino Chianti', 15.99, 3),
('Olio oliva', 12.99, 3),
('Lego Set', 89.99, 4),
('Puzzle 1000 pezzi', 24.99, 4),
('Macchinina telecomandata', 39.99, 4),
('Lampada da Tavolo', 29.99, 5),
('Divano Moderno', 499.99, 5),
('Tavolino da caffè', 149.99, 5),
('Bicicletta da corsa', 799.99, 6),
('Pallone da calcio', 29.99, 6),
('Racchetta da tennis', 129.99, 6),
('Crema viso idratante', 19.99, 7),
('Shampoo biologico', 9.99, 7),
('Profumo di lusso', 79.99, 7);

-- Inserimento dati nei livelli di stock (StockLevels)
INSERT INTO StockLevels (ProductID, WarehouseID, Stock) VALUES 
(1, 1, 100),
(2, 1, 80),
(3, 1, 150),
(4, 2, 200),
(5, 2, 90),
(6, 2, 120),
(7, 3, 300),
(8, 3, 180),
(9, 3, 220),
(10, 4, 150),
(11, 4, 140),
(12, 4, 160),
(13, 5, 250),
(14, 5, 60),
(15, 5, 110),
(16, 6, 90),
(17, 6, 130),
(18, 6, 70),
(19, 7, 200),
(20, 7, 150),
(21, 7, 100);

-- Inserimento dati nelle vendite (Sales)
INSERT INTO Sales (ID, StoreID, LineID, ProductID, Quantity) VALUES 
(1, 1, 1, 1, 10),
(1, 1, 2, 3, 5),
(1, 1, 3, 5, 8),
(2, 2, 1, 2, 15),
(2, 2, 2, 5, 7),
(2, 2, 3, 8, 6),
(3, 3, 1, 3, 20),
(3, 3, 2, 6, 10),
(3, 3, 3, 9, 12),
(4, 4, 1, 4, 5),
(4, 4, 2, 8, 3),
(4, 4, 3, 10, 9),
(5, 5, 1, 5, 12),
(5, 5, 2, 10, 6),
(5, 5, 3, 12, 14),
(6, 6, 1, 6, 8),
(6, 6, 2, 12, 4),
(6, 6, 3, 14, 7),
(7, 7, 1, 7, 14),
(7, 7, 2, 14, 9),
(7, 7, 3, 16, 11),
(8, 8, 1, 8, 18),
(8, 8, 2, 16, 11),
(8, 8, 3, 18, 5),
(9, 9, 1, 9, 6),
(9, 9, 2, 18, 7),
(9, 9, 3, 20, 4),
(10, 10, 1, 10, 10),
(10, 10, 2, 20, 5),
(10, 10, 3, 21, 9);

INSERT INTO Sales (ID, StoreID, LineID, ProductID, Quantity) VALUES 
(11, 1, 1, 1, 10),
(11, 1, 2, 3, 5),
(11, 1, 3, 5, 8),
(12, 5, 1, 5, 12),
(12, 5, 2, 10, 6),
(12, 5, 3, 12, 14)
