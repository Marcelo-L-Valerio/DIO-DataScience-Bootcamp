-- -----------------------------------------------------
-- Schema  ecommerce
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS  ecommerce;
CREATE SCHEMA  ecommerce;
USE  ecommerce ;

-- -----------------------------------------------------
-- Table Users
-- -----------------------------------------------------
DROP TABLE IF EXISTS Users ;

CREATE TABLE Users (
  idUser INT NOT NULL AUTO_INCREMENT,
  complete_name VARCHAR(100) NOT NULL,
  is_pf boolean NOT NULL,
  cpf CHAR(11) NULL,
  cnpj CHAR(14) NULL,
  cellphone VARCHAR(11) NULL,
  email VARCHAR(45) NOT NULL,
  PRIMARY KEY (idUser),
  UNIQUE INDEX cpf_UNIQUE (cpf),
  UNIQUE INDEX cnpj_UNIQUE (cnpj)
);
-- -----------------------------------------------------
-- Table Orders
-- -----------------------------------------------------
DROP TABLE IF EXISTS Orders ;

CREATE TABLE Orders (
  idOrder INT NOT NULL AUTO_INCREMENT,
  payment_stt ENUM('Aguardando', 'Aprovado', 'Cancelado') NOT NULL DEFAULT 'Aguardando',
  shipping FLOAT NULL,
  payment_method ENUM('Pix', 'Boleto', 'Cartão') NOT NULL DEFAULT 'Pix',
  idUser INT NOT NULL,
  order_date DATE NOT NULL,
  PRIMARY KEY (idOrder, idUser),
  CONSTRAINT fk_orders_user
    FOREIGN KEY (idUser)
    REFERENCES Users (idUser)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table Products
-- -----------------------------------------------------
DROP TABLE IF EXISTS Products ;

CREATE TABLE Products (
  idProduct INT NOT NULL AUTO_INCREMENT,
  category VARCHAR(45) NOT NULL,
  prod_description VARCHAR(45) NOT NULL,
  price FLOAT NOT NULL,
  avaliation FLOAT NOT NULL,
  PRIMARY KEY (idProduct)
);
-- -----------------------------------------------------
-- Table Providers
-- -----------------------------------------------------
DROP TABLE IF EXISTS Providers ;

CREATE TABLE Providers (
  idProvider INT NOT NULL AUTO_INCREMENT,
  social_reazon VARCHAR(45) NOT NULL,
  cnpj VARCHAR(14) NOT NULL,
  PRIMARY KEY (idProvider),
  UNIQUE INDEX cnpj_UNIQUE (cnpj)
);
-- -----------------------------------------------------
-- Table Provides
-- -----------------------------------------------------
DROP TABLE IF EXISTS Provides ;

CREATE TABLE Provides (
  idProduct INT NOT NULL,
  idProvider INT NOT NULL,
  PRIMARY KEY (idProduct, idProvider),
  CONSTRAINT fk_Product_id
    FOREIGN KEY (idProduct)
    REFERENCES Products (idProduct)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Provider_id
    FOREIGN KEY (idProvider)
    REFERENCES Providers (idProvider)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table Inventory
-- -----------------------------------------------------
DROP TABLE IF EXISTS Inventory ;

CREATE TABLE Inventory (
  idInventory INT NOT NULL AUTO_INCREMENT,
  address VARCHAR(45) NOT NULL,
  PRIMARY KEY (idInventory)
);
-- -----------------------------------------------------
-- Table Esta estocado em
-- -----------------------------------------------------
DROP TABLE IF EXISTS Stocked_at ;

CREATE TABLE Stocked_at (
  idProduct INT NOT NULL,
  idInventory INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (idProduct, idInventory),
  CONSTRAINT fk_stocked_Product_id
    FOREIGN KEY (idProduct)
    REFERENCES Products (idProduct)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Inventory
    FOREIGN KEY (idInventory)
    REFERENCES Inventory (idInventory)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table Products_in_order
-- -----------------------------------------------------
DROP TABLE IF EXISTS Products_in_order ;

CREATE TABLE Products_in_order (
  idOrder INT NOT NULL,
  idProduct INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (idOrder, idProduct),
  CONSTRAINT fk_Order_id
    FOREIGN KEY (idOrder)
    REFERENCES Orders (idOrder)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Product_in_order_id
    FOREIGN KEY (idProduct)
    REFERENCES Products (idProduct)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table Sellers
-- -----------------------------------------------------
DROP TABLE IF EXISTS Sellers ;

CREATE TABLE Sellers (
  idSeller INT NOT NULL AUTO_INCREMENT,
  idUser INT NOT NULL,
  PRIMARY KEY (idSeller, idUser),
  CONSTRAINT fk_User_is_seller
    FOREIGN KEY (idUser)
    REFERENCES Users (idUser)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table Vendedor vende Products
-- -----------------------------------------------------
DROP TABLE IF EXISTS Seller_offers ;

CREATE TABLE Seller_offers (
  idSeller INT NOT NULL,
  idProduct INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (idSeller, idProduct),
  CONSTRAINT fk_Seller_id
    FOREIGN KEY (idSeller)
    REFERENCES Sellers (idSeller)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_seller_sells
    FOREIGN KEY (idProduct)
    REFERENCES Products (idProduct)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table Wallets
-- -----------------------------------------------------
DROP TABLE IF EXISTS Wallets ;

CREATE TABLE Wallets (
  idWallet INT NOT NULL auto_increment,
  idUser INT NOT NULL,
  INDEX fk_Users1_idx (idUser),
  PRIMARY KEY (idWallet, idUser),
  CONSTRAINT fk_Users_Wallet
    FOREIGN KEY (idUser)
    REFERENCES Users (idUser)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table Credit_cards
-- -----------------------------------------------------
DROP TABLE IF EXISTS Credit_cards ;

CREATE TABLE Credit_cards (
  idCredit_card INT NOT NULL AUTO_INCREMENT,
  credit_card_number CHAR(16) NOT NULL,
  due_date DATE NOT NULL,
  name_in_credit_card VARCHAR(100) NOT NULL,
  owner_cpf CHAR(11) NOT NULL,
  idWallet INT NOT NULL,
  UNIQUE INDEX credit_card_number_UNIQUE (credit_card_number),
  UNIQUE INDEX owner_cpf_UNIQUE (owner_cpf),
  PRIMARY KEY (idCredit_card, idWallet),
  CONSTRAINT fk_Credit_cards_Wallet
    FOREIGN KEY (idWallet)
    REFERENCES Wallets (idWallet)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table Address
-- -----------------------------------------------------
DROP TABLE IF EXISTS Address ;

CREATE TABLE Address (
  idAddress INT NOT NULL AUTO_INCREMENT,
  cep CHAR(8) NOT NULL,
  state CHAR(2) NOT NULL,
  city VARCHAR(45) NOT NULL,
  district VARCHAR(45) NOT NULL,
  public_place VARCHAR(100) NOT NULL,
  complement VARCHAR(45) NULL,
  idUser INT NOT NULL,
  PRIMARY KEY (idAddress, idUser),
  CONSTRAINT fk_Users_has_address
    FOREIGN KEY (idUser)
    REFERENCES Users (idUser)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table Delivery
-- -----------------------------------------------------
DROP TABLE IF EXISTS Delivery ;

CREATE TABLE Delivery (
  idDelivery  INT NOT NULL auto_increment,
  delivery_status ENUM('Posto de dist', 'A caminho', 'Efetivada') NOT NULL DEFAULT 'Posto de dist',
  tracking_code VARCHAR(10) NOT NULL,
  post_date DATE NOT NULL,
  delivery_date DATE NULL,
  idOrder INT NOT NULL,
  UNIQUE INDEX tracking_code_UNIQUE (tracking_code),
  UNIQUE INDEX idOrder_UNIQUE (idOrder),
  PRIMARY KEY (idDelivery, idOrder),
  CONSTRAINT fk_Delivery_Order
    FOREIGN KEY (idOrder)
    REFERENCES Orders (idOrder)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table Bank accounts
-- -----------------------------------------------------
DROP TABLE IF EXISTS Bank_accounts ;

CREATE TABLE Bank_accounts (
  idBank_account INT NOT NULL,
  bank VARCHAR(45) NOT NULL,
  agency VARCHAR(45) NOT NULL,
  account_number VARCHAR(45) NOT NULL,
  idWallet INT NOT NULL,
  PRIMARY KEY (idBank_account, idWallet),
  CONSTRAINT fk_Bank_accounts_Wallet
    FOREIGN KEY (idWallet)
    REFERENCES Wallets (idWallet)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);