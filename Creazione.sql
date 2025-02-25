-- Creazione DB VendiCoseSPA
CREATE DATABASE vendi_cose_spa;
USE vendi_cose_spa;

-- Tabella Regione
CREATE TABLE Regione (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL
);

-- Tabella Citta
CREATE TABLE Citta (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    RegioneID INT,
    FOREIGN KEY (RegioneID) REFERENCES Regione(ID)
);

-- Tabella Magazzino
CREATE TABLE Magazzino (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    CittaID INT,
    FOREIGN KEY (CittaID) REFERENCES Citta(ID)
);

-- Tabella PuntoVendita
CREATE TABLE PuntoVendita (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    MagazzinoID INT,
    CittaID INT,
    FOREIGN KEY (MagazzinoID) REFERENCES Magazzino(ID),
    FOREIGN KEY (CittaID) REFERENCES Citta(ID)
);

-- Tabella Categoria di prodotto
CREATE TABLE Categoria (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL
);

-- Tabella Prodotto
CREATE TABLE Prodotto (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    PrezzoListino DECIMAL(10,2),
    CategoriaID INT,
    FOREIGN KEY (CategoriaID) REFERENCES Categoria(ID)
);

-- Tabella ordini verso magazzino
CREATE TABLE OrdiniMagazzino (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Data DATE NOT NULL,
    QuantitaRifornimento INT NOT NULL,
    PuntoVenditaID INT,
    ProdottoID INT,
    FOREIGN KEY (PuntoVenditaID) REFERENCES PuntoVendita(ID),
    FOREIGN KEY (ProdottoID) REFERENCES Prodotto(ID)
);

-- Stock Magazzino
CREATE TABLE StockMagazzino (
	MagazzinoID INT NOT NULL,
    ProdottoID INT NOT NULL,
    Quantita INT NOT NULL,
    PRIMARY KEY (MagazzinoID, ProdottoID),
    FOREIGN KEY (MagazzinoID) REFERENCES Magazzino(ID),
    FOREIGN KEY (ProdottoID) REFERENCES Prodotto(ID)
);

-- Tabella Stock Punto Vendita
CREATE TABLE StockPuntoVendita (
	ProdottoID INT NOT NULL,
    PuntoVenditaID INT NOT NULL,
    Quantita INT,
    PRIMARY KEY (ProdottoID, PuntoVenditaID),
    FOREIGN KEY (ProdottoID) REFERENCES Prodotto(ID),
    FOREIGN KEY (PuntoVenditaID) REFERENCES PuntoVendita(ID)
);

-- Tabella Vendita
CREATE TABLE Vendita (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Quantita INT,
    Data DATE,
    Prezzo DECIMAL(10,2),
    PuntoVenditaID INT,
    ProdottoID INT,
    FOREIGN KEY (PuntoVenditaID) REFERENCES PuntoVendita(ID),
    FOREIGN KEY (ProdottoID) REFERENCES Prodotto(ID)
);

-- Tabella Restock
CREATE TABLE Restock (
	CategoriaID INT,
    MagazzinoID INT,
    LivelloRestock INT,
    QuantitaRifornimento INT,
    PRIMARY KEY (CategoriaID, MagazzinoID),
    FOREIGN KEY (CategoriaID) REFERENCES Categoria(ID),
    FOREIGN KEY (MagazzinoID) REFERENCES Magazzino(ID)
);




