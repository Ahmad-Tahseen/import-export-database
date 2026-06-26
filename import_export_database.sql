-- ============================================================================
-- IMPORT & EXPORT COMPANY — RELATIONAL DATABASE
-- ============================================================================
-- Al-Hussien Bin Talal University | Database Systems Course Project
-- Supervised by: Dr. Hamed Al Talhouni
--
-- Team Members:
--   Ahmad Tahseen Ali
-- ============================================================================

-- ============================================================================
-- SECTION 1: TABLE CREATION (DDL)
-- ============================================================================

CREATE TABLE Company (
    CompanyNumber INT,
    Type          VARCHAR(50)  NOT NULL,
    Name          VARCHAR(100) NOT NULL,
    Address       VARCHAR(100) NOT NULL,
    Email         VARCHAR(100),
    Country       VARCHAR(50)  NOT NULL,
    PRIMARY KEY (CompanyNumber)
);

CREATE TABLE Manager (
    Manager_ID INT,
    Fname      VARCHAR(30) NOT NULL,
    Mname      CHAR(1)     NOT NULL,
    Lname      VARCHAR(30) NOT NULL,
    Bdate      DATE,
    Address    VARCHAR(100) NOT NULL,
    Gender     CHAR(1)     NOT NULL,
    PRIMARY KEY (Manager_ID)
);

CREATE TABLE Customer (
    Customer_ID INT,
    Fname       VARCHAR(30) NOT NULL,
    Mname       CHAR(1)     NOT NULL,
    Lname       VARCHAR(30) NOT NULL,
    Gender      CHAR(1)     NOT NULL,
    Bdate       DATE,
    PhoneNo     CHAR(10)    NOT NULL,
    Address     VARCHAR(100) NOT NULL,
    CompNumber  INT,
    PRIMARY KEY (Customer_ID),
    FOREIGN KEY (CompNumber) REFERENCES Company (CompanyNumber)
);

CREATE TABLE Employee (
    SSN     CHAR(9),
    Fname   VARCHAR(30) NOT NULL,
    Mname   CHAR(1)     NOT NULL,
    Lname   VARCHAR(30) NOT NULL,
    Gender  CHAR(1)     NOT NULL,
    Bdate   DATE,
    PhoneNo CHAR(10)    NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Mgr_ID  INT,
    PRIMARY KEY (SSN),
    FOREIGN KEY (Mgr_ID) REFERENCES Manager (Manager_ID)
);

CREATE TABLE Supplier (
    Supplier_ID INT,
    ContactName VARCHAR(100) NOT NULL,
    Email       VARCHAR(100),
    PhoneNo     CHAR(10)     NOT NULL,
    CompNum     INT          NOT NULL,
    PRIMARY KEY (Supplier_ID),
    FOREIGN KEY (CompNum) REFERENCES Company (CompanyNumber)
);

CREATE TABLE Warehouse (
    Warehouse_ID INT,
    Location     VARCHAR(100) NOT NULL,
    Magr_ID      INT,
    PRIMARY KEY (Warehouse_ID),
    FOREIGN KEY (Magr_ID) REFERENCES Manager (Manager_ID)
);

CREATE TABLE Product (
    SerialNo INT,
    Name     VARCHAR(50)   NOT NULL,
    Weight   DECIMAL(10,2) NOT NULL,
    Type     VARCHAR(50)   NOT NULL,
    PRIMARY KEY (SerialNo)
);

CREATE TABLE Transport (
    Transport_ID  INT,
    TrakingNumber INT         NOT NULL,
    Type          VARCHAR(50) NOT NULL,
    Name          VARCHAR(50) NOT NULL,
    Capacity      INT,
    PRIMARY KEY (Transport_ID)
);

CREATE TABLE Port (
    Port_ID INT,
    Type    VARCHAR(50)  NOT NULL,
    Name    VARCHAR(100) NOT NULL,
    Country VARCHAR(50)  NOT NULL,
    PRIMARY KEY (Port_ID)
);

CREATE TABLE Store (
    Whse_ID          INT,
    P_serial_Number  INT,
    PRIMARY KEY (Whse_ID, P_serial_Number),
    FOREIGN KEY (Whse_ID)         REFERENCES Warehouse (Warehouse_ID),
    FOREIGN KEY (P_serial_Number) REFERENCES Product (SerialNo)
);

CREATE TABLE Comp_Location (
    Comp_location VARCHAR(100),
    CompN         INT,
    PRIMARY KEY (Comp_location, CompN),
    FOREIGN KEY (CompN) REFERENCES Company (CompanyNumber)
);

CREATE TABLE Supply (
    Supp_ID INT,
    SerialN INT,
    PRIMARY KEY (Supp_ID, SerialN),
    FOREIGN KEY (Supp_ID) REFERENCES Supplier (Supplier_ID),
    FOREIGN KEY (SerialN) REFERENCES Product (SerialNo)
);

CREATE TABLE Shipment (
    Shipment_ID    INT,
    DepartureDate  DATE        NOT NULL,
    ArrivalDate    DATE        NOT NULL,
    OriginCountry  VARCHAR(50) NOT NULL,
    Pt_ID          INT,
    Trnsp_ID       INT,
    Mgrr_ID        INT,
    CompNu         INT,
    PRIMARY KEY (Shipment_ID),
    FOREIGN KEY (Mgrr_ID)  REFERENCES Manager (Manager_ID),
    FOREIGN KEY (CompNu)   REFERENCES Company (CompanyNumber),
    FOREIGN KEY (Trnsp_ID) REFERENCES Transport (Transport_ID),
    FOREIGN KEY (Pt_ID)    REFERENCES Port (Port_ID)
);

CREATE TABLE Orders (
    Order_ID     INT,
    OrderDate    DATE,
    RequiredDate DATE,
    ShippedDate  DATE,
    CompNo       INT NOT NULL,
    PRIMARY KEY (Order_ID),
    FOREIGN KEY (CompNo) REFERENCES Company (CompanyNumber)
);

CREATE TABLE Order_Item (
    Order_ID   INT,
    SerialNum  INT,
    Unit_Price DECIMAL(10,3) NOT NULL,
    Quantity   INT           NOT NULL,
    PRIMARY KEY (Order_ID, SerialNum),
    FOREIGN KEY (Order_ID)  REFERENCES Orders (Order_ID),
    FOREIGN KEY (SerialNum) REFERENCES Product (SerialNo)
);

-- ============================================================================
-- SECTION 2: SAMPLE DATA (DML)
-- ============================================================================

INSERT INTO Company (Type, Name, Address, Email, CompanyNumber, Country)
VALUES
    ('export', 'HarborLine Trading', '200 Bay Street', 'enquiries@harborlinetrade.com', 5, 'Canada'),
    ('Import and export', 'Al-Noor', 'Trade Zone', 'info@alnoorexportjo.com', 4, 'jordan'),
    ('import', 'Al-Fajr International Trade', 'King Abdullah II Street', 'contact@alfajirtrade.com', 1, 'jordan');

INSERT INTO Manager (Manager_ID, Fname, Mname, Lname, Bdate, Address, Gender)
VALUES
    (11111, 'Abdelrahman', 'B', 'AL-Musa',    '2005-01-24', 'Aqaba',  'M'),
    (22222, 'Sadeen',      'R', 'Al-Musadeen','2005-01-19', 'Tafilah','F'),
    (33333, 'Rama',        'A', 'Al-Qaramsah','2005-05-02', 'Maan',   'F'),
    (44444, 'Ahmad',       'T', 'Ali',        '2004-12-25', 'Amman',  'M'),
    (55555, 'Razan',       'A', 'Shakor',     '2005-06-24', 'Karak',  'F');

INSERT INTO Supplier (Supplier_ID, ContactName, Email, PhoneNo, CompNum)
VALUES
    (2023614, 'Eric',  'contact@ericusa.com',  '0625412', 1),
    (2025123, 'Hamad',  'contact@hamadksa.com', '0623618', 4),
    (2021478, 'Ahmed',  'contact@ahmedjo.com',  '0647585', 5);

INSERT INTO Product (SerialNo, Name, Weight, Type)
VALUES
    (23005, 'Solar Panels',   25.50, 'Electronics'),
    (50116, 'Woven Carpet',   30.00, 'Home Decor'),
    (67999, 'Jordanian Dates',10.00, 'Food'),
    (43111, 'Smart Phone',     0.25, 'Electronics');

-- ============================================================================
-- END OF SCRIPT
-- ============================================================================
