CREATE DATABASE VendiCose;

USE VendiCose;

CREATE TABLE WAREHOUSES (
	WarehouseID INT AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR (20),
	Location VARCHAR (20),
	Email VARCHAR (45),
	PhoneNo VARCHAR (15)
    );
    
CREATE TABLE Category (
		 CategoryID INT PRIMARY KEY,
         CategoryName varchar (20),
         RestockLevel INT,
         Description TEXT
);

CREATE TABLE PRODUCT (
	ProductID VARCHAR(6) PRIMARY KEY,
    Name Varchar (45) NOT NULL,
    CategoryID INT,
    Description TEXT,
    MaxUnitSalesPrice DECIMAL(10,2),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
    );
    
ALTER TABLE Product
MODIFY COLUMN ProductID VARCHAR(10);

    
  
CREATE TABLE STOCKLEVEL (
    ProductID VARCHAR(7) NOT NULL,
    WarehouseID INT,
    Stock INT NOT NULL CHECK (Stock >= 0),
    RestockLevel INT,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (ProductID, WarehouseID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

CREATE TABLE STORES (
	StoreID VARCHAR (7) PRIMARY KEY,
    WarehouseID INT,
    StoreName VARCHAR(25) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    ManagerName VARCHAR(255),
    ContactNumber VARCHAR(20),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

CREATE TABLE SALES (
	StoreID VARCHAR (7),
    SalesID INT,
    LineID INT,
    ProductID VARCHAR(6),
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalPrice DECIMAL(10,2) GENERATED ALWAYS AS (Quantity * UnitPrice) STORED,
    SaleDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod ENUM('Cash', 'Credit Card', 'Debit Card', 'Online') NOT NULL,
    PRIMARY KEY (SalesID, LineID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
    );

INSERT INTO Warehouses (Name, Location, Email, PhoneNo) 
	VALUES
('Magazzino Nord', 'Milano', 'nord@warehouse.it', '0245678910'),
('Magazzino Sud', 'Napoli', 'sud@warehouse.it', '0815678910'),
('Magazzino Centro', 'Roma', 'centro@warehouse.it', '0645678910'),
('Magazzino Est', 'Venezia', 'est@warehouse.it', '0415678910'),
('Magazzino Ovest', 'Torino', 'ovest@warehouse.it', '0115678910'),
('Magazzino Sicilia', 'Palermo', 'sicilia@warehouse.it', '0915678910'),
('Magazzino Sardegna', 'Cagliari', 'sardegna@warehouse.it', '0705678910');

INSERT INTO Category (CategoryID, CategoryName, RestockLevel, Description) 
	VALUES
(1, 'Frutta e Verdura', 150, 'Prodotti freschi di frutta e verdura'),
(2, 'Latticini', 185, 'Latte, formaggi e derivati'),
(3, 'Carne e Pesce', 250, 'Carne, pesce e salumi'),
(4, 'Bevande', 214, 'Bibite, succhi e alcolici'),
(5, 'Pane e Pasticceria', 65, 'Pane fresco, dolci e prodotti da forno'),
(6, 'Alimenti in Scatola', 60, 'Conserve, legumi e alimenti confezionati'),
(7, 'Snack e Dolciumi', 140, 'Patatine, cioccolata e dolci vari'),
(8, 'Surgelati', 200, 'Prodotti surgelati di vario genere'),
(9, 'Cura della Casa', 15, 'Detersivi, detergenti e prodotti per la casa'),
(10, 'Cura della Persona', 65, 'Saponi, shampoo e prodotti igienici'),
(11, 'Pasta e Riso', 98, 'Pasta, riso e cereali'),
(12, 'Condimenti e Spezie', 74, 'Oli, aceti, spezie e condimenti vari'),
(13, 'Alimenti per Bambini', 32,'Omogeneizzati e prodotti per infanzia'),
(14, 'Salute e Benessere', 210, 'Integratori e prodotti per la salute'),
(15, 'Prodotti Biologici', 65,'Alimenti biologici e naturali');


INSERT INTO PRODUCT (ProductID, Name, CategoryID, Description, MaxUnitSalesPrice) 
	VALUES
('A1X3Y9', 'Mele Golden', 1, 'Mele Golden fresche al kg', 2.99),
('B7Z2W5', 'Banane', 1, 'Banane biologiche al kg', 1.89),
('C2X5Y8', 'Arance Tarocco', 1, 'Arance Tarocco siciliane al kg', 3.49),
('D3L7M2', 'Pere Williams', 1, 'Pere Williams fresche al kg', 2.79),
('E8P9Q4', 'Uva Bianca', 1, 'Uva bianca senza semi al kg', 3.99),
('F1K4T7', 'Latte intero', 2, 'Latte intero fresco 1L', 1.29),
('G5M9X2', 'Latte Parzialmente Scremato', 2, 'Latte parzialmente scremato 1L', 1.19),
('H8N2Y4', 'Yogurt Naturale', 2, 'Yogurt naturale intero 150g', 0.99),
('I3P7T6', 'Burro Tradizionale', 2, 'Burro tradizionale 250g', 2.49),
('J9X1L3', 'Mozzarella di Bufala', 2, 'Mozzarella di bufala campana 125g', 2.99),
('K1X9Y5', 'Petto di Pollo', 3, 'Petto di pollo fresco al kg', 7.99),
('L7Z2W8', 'Filetto di Salmone', 3, 'Filetto di salmone fresco al kg', 15.99),
('M3K6N1', 'Carne Macinata', 3, 'Carne macinata di bovino al kg', 9.49),
('N5P2Q9', 'Cosce di Pollo', 3, 'Cosce di pollo fresche al kg', 6.99),
('O4R8L2', 'Gamberi Freschi', 3, 'Gamberi freschi al kg', 19.99),
('P9T3V6', 'Acqua Naturale', 4, 'Bottiglia di acqua naturale 1.5L', 0.50),
('Q4R8L2', 'Succo di Arancia', 4, 'Succo di arancia senza zuccheri 1L', 2.49),
('R2J8V6', 'Tè Freddo Limone', 4, 'Tè freddo al limone 1.5L', 1.79),
('S7H3P9', 'Bevanda Vegetale di Soia', 4, 'Bevanda vegetale di soia 1L', 2.29),
('T1G5X7', 'Acqua Frizzante', 4, 'Bottiglia di acqua frizzante 1.5L', 0.55),
('U4F2N8', 'Pane Integrale', 5, 'Pane integrale fresco 500g', 1.99),
('V6E9K1', 'Croissant', 5, 'Croissant con crema 4 pezzi', 3.49),
('W3D7T2', 'Baguette', 5, 'Baguette francese 250g', 1.49),
('X2A7P5', 'Grissini', 5, 'Grissini stirati torinesi 200g', 1.29),
('Y5B3M8', 'Focaccia Genovese', 5, 'Focaccia genovese classica 300g', 3.79),
('Z9C1L4', 'Tonno in Scatola', 6, "Tonno in scatola all'olio d'oliva", 2.99),
('A3K9M4', 'Piselli in Scatola', 6, 'Piselli lessati in scatola', 1.79),
('B8T4Y1', 'Fagioli Cannellini', 6, 'Fagioli cannellini lessati 400g', 1.69),
('C7H3P9', 'Lenticchie in Scatola', 6, 'Lenticchie lessate 400g', 1.89),
('D2J8V6', 'Pomodori Pelati', 6, 'Pomodori pelati in scatola 500g', 2.49),
('E9T1V6', 'Cioccolato Fondente', 7, 'Tavoletta di cioccolato fondente 85%', 2.49),
('F4R7L8', 'Patatine Classiche', 7, 'Patatine croccanti classiche 150g', 1.99),
('G6N3X1', 'Biscotti Integrali', 7, 'Biscotti integrali senza zuccheri aggiunti 300g', 3.19),
('H2B5C7', 'Barrette di Cereali', 7, 'Barrette di cereali e miele 6x25g', 2.99),
('I8M4T2', 'Crackers Salati', 7, 'Crackers salati classici 250g', 1.79),
('J1X9Y5', 'Pizza Margherita Surgelata', 8, 'Pizza Margherita surgelata 400g', 3.99),
('K7Z2W8', 'Verdure Miste Surgelate', 8, 'Mix di verdure surgelate 1kg', 4.99),
('L3K6N1', 'Bastoncini di Pesce', 8, 'Bastoncini di pesce surgelati 300g', 3.49),
('M5P2Q9', 'Gelato alla Vaniglia', 8, 'Gelato alla vaniglia 500g', 4.49),
('N4R8L2', 'Lasagne Surgelate', 8, 'Lasagne alla bolognese surgelate 600g', 5.99),
('N4R8L1', 'Detersivo Piatti', 9, 'Detersivo liquido per piatti', 2.99),
('N4R8C2', 'Candeggina', 9, 'Candeggina per la pulizia della casa', 1.49),
('N4R8L3', 'Pulitore Multisuperficie', 9, 'Pulitore per tutte le superfici della casa', 3.29),
('N4R8L4', 'Sgrassatore', 9, 'Sgrassatore potente per cucina e bagno', 3.79),
('N4R8L5', 'Ammorbidente', 9, 'Ammorbidente per bucato', 2.59),
('N4R8L6', 'Sapone Liquido', 10, 'Sapone liquido per mani', 1.99),
('N4R8L7', 'Shampoo per Capelli Secchi', 10, 'Shampoo idratante per capelli secchi', 4.50),
('N4R8L8', 'Bagnoschiuma', 10, 'Bagnoschiuma profumato e delicato', 2.79),
('N4R8L9', 'Deodorante', 10, 'Deodorante per una protezione duratura', 3.99),
('N4R8L10', 'Crema Idratante', 10, 'Crema per il viso e corpo idratante', 5.29),
('N4R8L11', 'Spaghetti', 11, 'Pasta lunga, 500g', 1.29),
('N4R8L12', 'Riso Arborio', 11, 'Riso per risotti, 1kg', 2.50),
('N4R8L13', 'Cous Cous', 11, 'Cous cous precotto, 500g', 3.00),
('N4R8L14', 'Fusilli', 11, 'Pasta corta, 500g', 1.49),
('N4R8L15', 'Farina di Grano', 11, 'Farina tipo 00, 1kg', 1.09),
('N4R8L16', 'Olio Extra Vergine di Oliva', 12, 'Olio extra vergine di oliva, 500ml', 4.99),
('N4R8L17', 'Aceto Balsamico', 12, 'Aceto balsamico tradizionale, 250ml', 5.99),
('N4R8L18', 'Pepe Nero', 12, 'Pepe nero macinato, 50g', 1.59),
('N4R8L19', 'Sale Marino', 12, 'Sale marino grosso, 1kg', 0.99),
('N4R8L20', 'Origano', 12, 'Origano essiccato, 30g', 1.29),
('N4R8L21', 'Omogeneizzato di Carne', 13, 'Omogeneizzato di carne per bambini', 2.10),
('N4R8L22', 'Omogeneizzato di Frutta', 13, 'Omogeneizzato di frutta per bambini', 1.80),
('N4R8L23', 'Latte in Polvere', 13, 'Latte in polvere per neonati', 8.90),
('N4R8L24', 'Pappe per Bambini', 13, 'Pappa pronta per bambini', 3.50),
('N4R8L25', 'Biscotti per Infanzia', 13, 'Biscotti per bambini, 200g', 2.99),
('N4R8L26', 'Integratore Vitamine', 14, 'Integratore di vitamine per adulti', 12.99),
('N4R8L27', 'Omega 3', 14, 'Integratore Omega 3, 60 capsule', 15.49),
('N4R8L28', 'Magnesio', 14, 'Magnesio in compresse, 30 compresse', 7.99),
('N4R8L29', 'Probiotici', 14, 'Integratori probiotici per la digestione', 9.49),
('N4R8L30', 'Collagene', 14, 'Integratore di collagene, 90 capsule', 18.99),
('N4R8L31', 'Miele Biologico', 15, 'Miele biologico di alta qualità', 5.49),
('N4R8L32', 'Pasta Integrale', 15, 'Pasta integrale, 500g', 2.99),
('N4R8L33', 'Farina di Mais Biologica', 15, 'Farina di mais biologica, 1kg', 3.49),
('N4R8L34', 'Succhi di Frutta Biologici', 15, 'Succhi di frutta biologici, 250ml', 1.99),
('N4R8L35', 'Legumi Biologici', 15, 'Legumi biologici, 500g', 2.69);

-- Controllare che i nomi siano tutti distinti
SELECT COUNT(Name) FROM Product;
SELECT COUNT(DISTINCT Name) FROM Product;
    
    
INSERT INTO STORES (StoreID, WarehouseID, StoreName, Location, ManagerName, ContactNumber) 
	VALUES
('ST1542', 7, 'Esselunga Milano', 'Milano, Via Torino 12', 'Marco Rossi', '+39 02 1234567'),
('ST2584', 7, 'Carrefour Market Milano', 'Milano, Corso Buenos Aires 45', 'Laura Bianchi', '+39 02 9876543'),
('ST8574', 6, 'Conad Roma', 'Roma, Via del Corso 33', 'Giovanni Verdi', '+39 06 2222333'),
('ST1584', 6, 'Lidl Roma', 'Roma, Piazza Venezia 5', 'Francesca Neri', '+39 06 4444555'),
('ST1526', 5, 'Coop Napoli', 'Napoli, Via Toledo 99', 'Antonio Esposito', '+39 081 1111222'),
('ST7251', 5, 'Penny Market Napoli', 'Napoli, Corso Umberto I 25', 'Elisa De Luca', '+39 081 5555666'),
('ST9024', 4, 'Ipercoop Firenze', 'Firenze, Via de Tornabuoni 18', 'Paolo Ricci', '+39 055 7777888'),
('ST4433', 4, 'Pam Firenze', 'Firenze, Piazza della Repubblica 7', 'Anna Conti', '+39 055 3333444'),
('ST9800', 3, 'Eurospin Torino', 'Torino, Via Roma 120', 'Luca Martini', '+39 011 6666777'),
('ST3931', 3, 'Conad Torino', 'Torino, Corso Vittorio Emanuele 99', 'Giulia Ferri', '+39 011 2222333'),
('ST4121', 3, 'Esselunga Bologna', 'Bologna, Via Indipendenza 55', 'Matteo Galli', '+39 051 9999000'),
('ST7878', 3, 'Carrefour Bologna', 'Bologna, Piazza Maggiore 3', 'Sara Romano', '+39 051 8888777'),
('ST1499', 4, 'Lidl Palermo', 'Palermo, Via Libertà 88', 'Davide Greco', '+39 091 4444333'),
('ST0518', 4, 'Conad Palermo', 'Palermo, Corso Calatafimi 102', 'Martina Russo', '+39 091 1111222'),
('ST3474', 1, 'Supermercati Dok Venezia', 'Venezia, Campo San Polo 17', 'Federico Moretti', '+39 041 6666777'),
('ST2005', 2, 'Ipercoop Venezia', 'Venezia, Strada Nova 46', 'Valentina Sartori', '+39 041 8888999'),
('ST9747', 2, 'Penny Market Genova', 'Genova, Via Garibaldi 21', 'Roberto De Santis', '+39 010 7777888'),
('ST8500', 5, 'Carrefour Genova', 'Genova, Corso Italia 78', 'Alessia Bruno', '+39 010 9999000'),
('ST2140', 7, 'Conad Bari', 'Bari, Via Sparano 14', 'Pietro Romano', '+39 080 3333444'),
('ST4178', 2, 'Pam Bari', 'Bari, Corso Cavour 62', 'Elena Gatti', '+39 080 2222111');



-- Warehouse 1
INSERT INTO STOCKLEVEL (ProductID, WarehouseID, Stock, RestockLevel)
VALUES
('A1X3Y9', 1, 100, 20),
('B7Z2W5', 1, 150, 30),
('D3L7M2', 1, 200, 50),
('E8P9Q4', 1, 250, 50),
('F4R7L8', 1, 300, 75),
('G5M9X2', 1, 120, 25),
('H8N2Y4', 1, 80, 15),
('I3P7T6', 1, 50, 10),
('J9X1L3', 1, 90, 15),
('K7Z2W8', 1, 180, 35),
('L7Z2W8', 1, 220, 45),
('M3K6N1', 1, 60, 12),
('N4R8L12', 1, 40, 8),
('O4R8L2', 1, 70, 15),
('P9T3V6', 1, 300, 100),
('Q4R8L2', 1, 130, 25),
('R2J8V6', 1, 110, 20),
('S7H3P9', 1, 90, 20),
('T1G5X7', 1, 60, 10),
('V6E9K1', 1, 250, 60),
('W3D7T2', 1, 180, 40);

-- Warehouse 2
INSERT INTO STOCKLEVEL (ProductID, WarehouseID, Stock, RestockLevel)
VALUES
('A1X3Y9', 2, 100, 20),
('B7Z2W5', 2, 150, 30),
('D3L7M2', 2, 200, 50),
('E8P9Q4', 2, 250, 50),
('F4R7L8', 2, 300, 75),
('G5M9X2', 2, 120, 25),
('H8N2Y4', 2, 80, 15),
('I3P7T6', 2, 50, 10),
('J9X1L3', 2, 90, 15),
('K7Z2W8', 2, 180, 35),
('L7Z2W8', 2, 220, 45),
('M3K6N1', 2, 60, 12),
('N4R8L12', 2, 40, 8),
('O4R8L2', 2, 70, 15),
('P9T3V6', 2, 300, 100),
('Q4R8L2', 2, 130, 25),
('R2J8V6', 2, 110, 20),
('S7H3P9', 2, 90, 20),
('T1G5X7', 2, 60, 10),
('V6E9K1', 2, 250, 60),
('W3D7T2', 2, 180, 40);

-- Warehouse 3
INSERT INTO STOCKLEVEL (ProductID, WarehouseID, Stock, RestockLevel)
VALUES
('A1X3Y9', 3, 100, 20),
('B7Z2W5', 3, 150, 30),
('D3L7M2', 3, 200, 50),
('E8P9Q4', 3, 250, 50),
('F4R7L8', 3, 300, 75),
('G5M9X2', 3, 120, 25),
('H8N2Y4', 3, 80, 15),
('I3P7T6', 3, 50, 10),
('J9X1L3', 3, 90, 15),
('K7Z2W8', 3, 180, 35),
('L7Z2W8', 3, 220, 45),
('M3K6N1', 3, 60, 12),
('N4R8L12', 3, 40, 8),
('O4R8L2', 3, 70, 15),
('P9T3V6', 3, 300, 100),
('Q4R8L2', 3, 130, 25),
('R2J8V6', 3, 110, 20),
('S7H3P9', 3, 90, 20),
('T1G5X7', 3, 60, 10),
('V6E9K1', 3, 250, 60),
('W3D7T2', 3, 180, 40);

-- Warehouse 4
INSERT INTO STOCKLEVEL (ProductID, WarehouseID, Stock, RestockLevel)
VALUES
('A1X3Y9', 4, 110, 22),
('B7Z2W5', 4, 160, 32),
('D3L7M2', 4, 210, 52),
('E8P9Q4', 4, 260, 55),
('F4R7L8', 4, 310, 80),
('G5M9X2', 4, 130, 28),
('H8N2Y4', 4, 85, 18),
('I3P7T6', 4, 55, 12),
('J9X1L3', 4, 95, 17),
('K7Z2W8', 4, 190, 38),
('L7Z2W8', 4, 230, 48),
('M3K6N1', 4, 65, 13),
('N4R8L12', 4, 45, 9),
('O4R8L2', 4, 75, 16),
('P9T3V6', 4, 310, 105),
('Q4R8L2', 4, 140, 30),
('R2J8V6', 4, 120, 22),
('S7H3P9', 4, 95, 22),
('T1G5X7', 4, 65, 12),
('V6E9K1', 4, 260, 65),
('W3D7T2', 4, 190, 42);

-- Warehouse 5
INSERT INTO STOCKLEVEL (ProductID, WarehouseID, Stock, RestockLevel)
VALUES
('A1X3Y9', 5, 120, 24),
('B7Z2W5', 5, 170, 34),
('D3L7M2', 5, 220, 54),
('E8P9Q4', 5, 270, 57),
('F4R7L8', 5, 320, 85),
('G5M9X2', 5, 140, 30),
('H8N2Y4', 5, 90, 20),
('I3P7T6', 5, 60, 13),
('J9X1L3', 5, 100, 18),
('K7Z2W8', 5, 200, 40),
('L7Z2W8', 5, 240, 50),
('M3K6N1', 5, 70, 14),
('N4R8L12', 5, 50, 10),
('O4R8L2', 5, 80, 17),
('P9T3V6', 5, 320, 110),
('Q4R8L2', 5, 150, 32),
('R2J8V6', 5, 130, 25),
('S7H3P9', 5, 100, 23),
('T1G5X7', 5, 70, 14),
('V6E9K1', 5, 270, 70),
('W3D7T2', 5, 200, 45);

-- Warehouse 6
INSERT INTO STOCKLEVEL (ProductID, WarehouseID, Stock, RestockLevel)
VALUES
('A1X3Y9', 6, 130, 26),
('B7Z2W5', 6, 180, 36),
('D3L7M2', 6, 230, 56),
('E8P9Q4', 6, 280, 58),
('F4R7L8', 6, 330, 90),
('G5M9X2', 6, 150, 32),
('H8N2Y4', 6, 95, 21),
('I3P7T6', 6, 65, 14),
('J9X1L3', 6, 105, 19),
('K7Z2W8', 6, 210, 42),
('L7Z2W8', 6, 250, 52),
('M3K6N1', 6, 75, 15),
('N4R8L12', 6, 55, 11),
('O4R8L2', 6, 85, 18),
('P9T3V6', 6, 330, 115),
('Q4R8L2', 6, 160, 34),
('R2J8V6', 6, 140, 27),
('S7H3P9', 6, 105, 24),
('T1G5X7', 6, 75, 15),
('V6E9K1', 6, 280, 75),
('W3D7T2', 6, 210, 47);

-- Warehouse 7
INSERT INTO STOCKLEVEL (ProductID, WarehouseID, Stock, RestockLevel)
VALUES
('A1X3Y9', 7, 140, 28),
('B7Z2W5', 7, 190, 38),
('D3L7M2', 7, 240, 58),
('E8P9Q4', 7, 290, 60),
('F4R7L8', 7, 340, 95),
('G5M9X2', 7, 160, 34),
('H8N2Y4', 7, 100, 22),
('I3P7T6', 7, 70, 15),
('J9X1L3', 7, 110, 20),
('K7Z2W8', 7, 220, 44),
('L7Z2W8', 7, 260, 54),
('M3K6N1', 7, 80, 16),
('N4R8L12', 7, 60, 12),
('O4R8L2', 7, 90, 19),
('P9T3V6', 7, 340, 120),
('Q4R8L2', 7, 170, 35),
('R2J8V6', 7, 150, 30),
('S7H3P9', 7, 110, 25),
('T1G5X7', 7, 80, 16),
('V6E9K1', 7, 290, 80),
('W3D7T2', 7, 220, 50);



DELIMITER //								 	-- Serve a modificare temporaneamente il simbolo che indica il termine di un comando, così che SQL non interpreti ; come la fine del comando ma usi //
CREATE TRIGGER update_stock_after_insert 		-- Definiamo un trigger con un nome
AFTER INSERT ON Sales 							-- Il trigger si attiverà ogni volta che viene effettuata una insert nella tabella Sales
FOR EACH ROW 									-- Il trigger verrà eseguito per ogni riga inserita nella tabella Sales
BEGIN											-- Identifica l'inizio del blocco di istruzioni
	UPDATE StockLevel							-- Update utilizzato per diminuire lo stock
    SET Stock = Stock - NEW.Quantity			-- NEW.Quantity identifica la quantità appena inserita nella tabella Sales nella riga per cui si è stato attivato il trigger
    WHERE ProductID = NEW.ProductID				-- NEW.ProductID identifica l'ID del prodotto appena inserito nella tabella Sales nella riga per cui si è attivato il trigger
    AND WarehouseID = (							
		SELECT Warehouses.WarehouseID					-- Subquery per recuperare il magazzino correlato allo store che è stato inserito nella vendita
        FROM Warehouses
        JOIN Stores ON Warehouses.warehouseID = Stores.WarehouseID
        WHERE Stores.StoreID = NEW.StoreID			-- NEW.StoreID identifica l'ID dello store appena inserito nella tabella Sales nella riga per cui si è attivato il trigger
	);
END;											-- Fine del blocco di istruzioni
//												-- Delimitatore di fine comando temporaneo impostato prima

DELIMITER ; -- Ripristina il delimitatore di fine comando a ;

SHOW TRIGGERS;

SELECT * FROM StockLevel ORDER BY WarehouseID;

-- Creazione tabella allarmi sottosoglia
CREATE TABLE StockAlerts (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID VARCHAR(10),
    AlertMessage TEXT,
    AlertDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

ALTER TABLE StockAlerts
ADD COLUMN WarehouseID INT;

ALTER TABLE StockAlerts
ADD CONSTRAINT fk_warehouse
FOREIGN KEY (WarehouseID)
REFERENCES Warehouses(WarehouseID);

ALTER TABLE StockAlerts
MODIFY COLUMN AlertDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

DROP TRIGGER check_stock_level;
SHOW TRIGGERS;


-- Creazione trigger per generazione allarme quando prodotto va sottosoglia
DELIMITER $$

CREATE TRIGGER check_stock_level
AFTER UPDATE ON StockLevel
FOR EACH ROW
BEGIN
	IF NEW.Stock < (SELECT Category.RestockLevel
					FROM Category
					JOIN Product ON Category.CategoryID = Product.CategoryID
                    WHERE Product.ProductID = NEW.ProductID) THEN
		INSERT INTO StockAlerts (ProductID, WarehouseID, AlertMessage)
		VALUES (NEW.ProductID, NEW.WarehouseID , "La quantità in stock è sottosoglia");
	END IF;
END;
$$

DELIMITER ;

SHOW TRIGGERS;

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









-- Ogni qual volta un prodotto viene venduto in un negozio, qual è la query da eseguire per aggiornare le tabelle di riferimento?

SELECT *
FROM StockLevel JOIN Warehouses ON StockLevel.WarehouseID = Warehouses.WarehouseID
JOIN Stores ON Stores.WarehouseID = Warehouses.WarehouseID
WHERE Stores.StoreID = 'ST2140';

-- viene effetuata la vendita 25552 nello store ST2140 del prodotto Pupazzo di neve(K1L2M3)
INSERT INTO SALES (StoreID, ProductID, Quantity, UnitPrice, PaymentMethod) 
	VALUES
		('ST2140', 'K1L2M3', 3, 12.99, 'Credit Card');
        
DELETE FROM SALES  
	WHERE StoreID = 'ST2140'  
		AND ProductID = 'E4F5G6'  
			AND Quantity = 3  
				AND UnitPrice = 12.99  
					AND PaymentMethod = 'Credit Card'  
	ORDER BY SalesID DESC  
	LIMIT 1;

        
SELECT * FROM SALES;
SELECT * FROM STOCKLEVEL WHERE ProductID = 'K1L2M3';

  -- Aggiornamento con una sola query per mezzo di un id vendita e di un store id
START TRANSACTION;
UPDATE STOCKLEVEL
SET STock = Stock - (SELECT Quantity FROM Sales WHERE Sales.SalesID = 25552 AND Sales.ProductID = StockLevel.ProductID)
WHERE ProductID IN 
(SELECT ProductID FROM Sales WHERE Sales.SalesID = 25552) AND WarehouseID = (SELECT WarehouseID	FROM Stores WHERE StoreID = 'ST2140'); 

 -- Aggiornamento con una sola query per mezzo di un id vendita
UPDATE StockLevel
SET Stock = Stock - (SELECT Quantity FROM Sales WHERE Sales.SalesID = 25552 AND Sales.ProductID = StockLevel.ProductID)
WHERE ProductID IN (SELECT ProductID FROM Sales WHERE Sales.SalesID = 25552) 
AND WarehouseID = (	SELECT Warehouses.WarehouseID FROM Warehouses 
					JOIN Stores ON Warehouses.WarehouseID = Stores.WarehouseID
					JOIN Sales ON Stores.StoreID = Sales.StoreID
					WHERE Sales.SalesID = 25552 LIMIT 1);
                    
SELECT *
FROM StockLevel JOIN Warehouses ON StockLevel.WarehouseID = Warehouses.WarehouseID
JOIN Stores ON Stores.WarehouseID = Warehouses.WarehouseID
WHERE Stores.StoreID = 'ST2140';

UPDATE STOCKLEVEL
JOIN warehouses ON Stocklevel.warehouseID = warehouses.warehouseid
		JOIN Stores ON warehouses.warehouseid = stores.WarehouseID
			 JOIN sales ON sales.storeID = stores.storeid
SET stocklevel.Stock = stocklevel.Stock - sales.quantity
WHERE Stocklevel.ProductID IN (SELECT ProductID FROM SALES WHERE SalesID = '25552')
	AND Warehouses.WarehouseID  = (SELECT WarehouseID 
				FROM STORES 
					WHERE StoreID = 'ST2140'
                    LIMIT 1);
                    
 
  -- Aggiornamento dello stock con una sola query per mezzo dell'id vendita 14
UPDATE StockLevel
SET Stock = Stock - (SELECT Quantity FROM Sales WHERE Sales.SalesID = 25552 AND Sales.ProductID = StockLevel.ProductID)
WHERE ProductID IN (SELECT ProductID FROM Sales WHERE Sales.SalesID = 25552) 
AND WarehouseID = (	SELECT Warehouses.WarehouseID FROM Warehouses 
					JOIN Stores ON Warehouses.WarehouseID = Stores.WarehouseID
					JOIN Sales ON Stores.StoreID = Sales.StoreID
					WHERE Sales.SalesID = 25552 LIMIT 1);

SELECT Stock FROM Stocklevel WHERE ProductID = 'N6M2X9';

SELECT * FROM Stocklevel;
-- Quali sono le query da eseguire per verificare quante unità di un prodotto ci sono in un dato magazzino e per monitorare le soglie di restock?

CREATE VIEW ProductsToRestock AS 
SELECT DISTINCT
    Product.ProductID AS ProductID, 
    Product.Name AS Product, 
    Product.CategoryID AS CategoryID, 
    Stores.WarehouseID AS WarehouseID, 
    Stocklevel.Stock AS LowStock, 
    Stocklevel.RestockLevel AS RestockThreshold
FROM Stocklevel
JOIN Product ON Stocklevel.ProductID = Product.ProductID
JOIN Stores ON Stocklevel.WarehouseID = Stores.WarehouseID
LEFT JOIN Sales ON Sales.ProductID = Stocklevel.ProductID AND Sales.StoreID = Stores.StoreID
WHERE Stocklevel.Stock <= Stocklevel.RestockLevel;


SELECT * FROM Stocklevel;

SELECT * FROM ProductsToRestock;

CREATE VIEW RestockNeed AS
SELECT 
    Category.CategoryName AS CategoryName,
    SUM(stocklevel.Stock) AS TotalStockInWarehouses,
    Category.RestockLevel AS RestockLevel,
    (Category.RestockLevel - SUM(StockLevel.Stock)) AS NeedForRestock
FROM 
    Category
JOIN 
    Product ON Category.CategoryID = Product.CategoryID
JOIN 
    StockLevel ON Product.ProductID = StockLevel.ProductID
GROUP BY 
    Category.CategoryID;
    
    SELECT * FROM RestockNeed;
    
    CREATE VIEW Products AS 
SELECT DISTINCT
    Product.ProductID AS ProductID, 
    Product.Name AS Product, 
    Stores.WarehouseID AS WarehouseID, 
    Stocklevel.Stock AS InStock, 
    Stocklevel.RestockLevel AS RestockThreshold
FROM Stocklevel
JOIN Product ON Stocklevel.ProductID = Product.ProductID
JOIN Stores ON Stocklevel.WarehouseID = Stores.WarehouseID;

SELECT * FROM Products;

DROP VIEW Products;

   -- Verificare 
   UPDATE STOCKLEVEL
SET Stock = Stock - (
    SELECT SUM(Quantity) FROM Sales 
    WHERE Sales.SalesID IN (25555, 25554) 
    AND Sales.ProductID = StockLevel.ProductID
)
WHERE ProductID IN (
    SELECT ProductID FROM Sales WHERE Sales.SalesID IN (25555, 25554)
) 
AND WarehouseID = (
    SELECT WarehouseID FROM Stores WHERE StoreID = 'ST2140'
);

   INSERT INTO SALES (StoreID, ProductID, Quantity, UnitPrice, PaymentMethod) 
	VALUES
		('ST2140', 'K1L2M3', 6, 12.99, 'Credit Card'),
        ('ST2584', 'K1L2M3', 2, 12.99, 'Cash');




INSERT INTO SALES (StoreID, ProductID, Quantity, UnitPrice, PaymentMethod) 
	VALUES
		('ST2005', 'N6M2X9', 2, 59.99, 'Credit Card');
        
          INSERT INTO SALES (StoreID, ProductID, Quantity, UnitPrice, PaymentMethod) 
	VALUES
		('ST2140', 'K1L2M3', 6, 12.99, 'Credit Card'),
        ('ST2584', 'K1L2M3', 2, 12.99, 'Cash');
        
SHOW TRIGGERS;

SELECT * FROM Restockneed ;

SELECT * FROM productstorestock;

SELECT * FROM Products;
     
   