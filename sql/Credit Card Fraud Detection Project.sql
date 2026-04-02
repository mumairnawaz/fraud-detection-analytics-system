CREATE DATABASE FraudDetectionDB;
USE FraudDetectionDB;

CREATE TABLE Transactions (
    Transaction_ID VARCHAR(50) PRIMARY KEY,
    Transaction_Date DATE NOT NULL,
    Transaction_Time TIME NOT NULL,
    Time INT NOT NULL,
    Amount FLOAT NOT NULL,
    Card_Type VARCHAR(20) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    City VARCHAR(100),
    IP_Address VARCHAR(50),
    Merchant_ID VARCHAR(50),
    Merchant_Category VARCHAR(50),
    Transaction_Mode VARCHAR(20),
    Auth_Method VARCHAR(20),
    Device_Type VARCHAR(20),
    Transaction_Status VARCHAR(20),
    Currency VARCHAR(10),
    Card_Issuer VARCHAR(50),
    Customer_Segment VARCHAR(20),
    Fraud_Score FLOAT,
    Previous_Fraud_Flag INT CHECK (Previous_Fraud_Flag IN (0, 1)),
    Is_Fraud INT CHECK (Is_Fraud IN (0, 1))
);

/* Adding the fraud_detection_final_dataset file */

select TOP 10 * from fraud_detection_final_dataset;

-- Check structure of fraud_detection_final_dataset
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'fraud_detection_final_dataset';

-- Check structure of Transactions table
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Transactions';

-- Inserting Data from fraud_detection_final_dataset to transactions table
INSERT INTO Transactions (
    Transaction_ID, Transaction_Date, Transaction_Time, Time, Amount, Card_Type, 
    Country, City, IP_Address, Merchant_ID, Merchant_Category, Transaction_Mode, 
    Auth_Method, Device_Type, Transaction_Status, Currency, Card_Issuer, 
    Customer_Segment, Fraud_Score, Previous_Fraud_Flag, Is_Fraud
)
SELECT 
    Transaction_ID, 
    Transaction_Date, 
    Transaction_Time, 
    Time, 
    Amount, 
    Card_Type, 
    Country, 
    City, 
    IP_Address, 
    Merchant_ID, 
    Merchant_Category, 
    Transaction_Mode, 
    Auth_Method, 
    Device_Type, 
    Transaction_Status, 
    Currency, 
    Card_Issuer, 
    Customer_Segment, 
    Fraud_Score, 
    Previous_Fraud_Flag, 
    Is_Fraud
FROM fraud_detection_final_dataset;


SELECT COUNT(*) AS Total_Records FROM Transactions;

SELECT * FROM Transactions;
-- Identify Missing Values

SELECT 
    SUM(CASE WHEN Transaction_Date IS NULL THEN 1 ELSE 0 END) AS Missing_Transaction_Date,
    SUM(CASE WHEN Transaction_Time IS NULL THEN 1 ELSE 0 END) AS Missing_Transaction_Time,
    SUM(CASE WHEN Amount IS NULL THEN 1 ELSE 0 END) AS Missing_Amount,
    SUM(CASE WHEN Card_Type IS NULL THEN 1 ELSE 0 END) AS Missing_Card_Type,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Missing_Country,
    SUM(CASE WHEN Merchant_Category IS NULL THEN 1 ELSE 0 END) AS Missing_Merchant_Category,
    SUM(CASE WHEN Transaction_Mode IS NULL THEN 1 ELSE 0 END) AS Missing_Transaction_Mode,
    SUM(CASE WHEN Auth_Method IS NULL THEN 1 ELSE 0 END) AS Missing_Auth_Method
FROM Transactions;

/* Fill Missing Values
Numerical Columns: Replace with the median value.
Categorical Columns: Replace with the most frequent value (mode) */

-- Fill NULL Amount with the median value
UPDATE Transactions
SET Amount = (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) 
    OVER () 
    FROM Transactions
) 
WHERE Amount IS NULL;

-- Fill NULL Merchant_Category with most frequent value
UPDATE Transactions
SET Merchant_Category = (SELECT TOP 1 Merchant_Category FROM Transactions GROUP BY Merchant_Category ORDER BY COUNT(*) DESC)
WHERE Merchant_Category IS NULL;

-- Fill NULL Transaction_Mode with most frequent value
UPDATE Transactions
SET Transaction_Mode = (SELECT TOP 1 Transaction_Mode FROM Transactions GROUP BY Transaction_Mode ORDER BY COUNT(*) DESC)
WHERE Transaction_Mode IS NULL;

-- Fill NULL Auth_Method with most frequent value
UPDATE Transactions
SET Auth_Method = (SELECT TOP 1 Auth_Method FROM Transactions GROUP BY Auth_Method ORDER BY COUNT(*) DESC)
WHERE Auth_Method IS NULL;

-- Convert all categorical values to proper case
UPDATE Transactions SET Card_Type = UPPER(Card_Type);
UPDATE Transactions SET Country = UPPER(Country);
UPDATE Transactions SET Merchant_Category = UPPER(Merchant_Category);
UPDATE Transactions SET Transaction_Mode = UPPER(Transaction_Mode);
UPDATE Transactions SET Auth_Method = UPPER(Auth_Method);
UPDATE Transactions SET Card_Issuer = UPPER(Card_Issuer);

-- Removing Duplicates
WITH DuplicateTransactions AS (
    SELECT 
        Transaction_ID, 
        ROW_NUMBER() OVER (PARTITION BY Transaction_ID ORDER BY Transaction_Date DESC) AS RowNum
    FROM Transactions
)
DELETE FROM Transactions WHERE Transaction_ID IN (
    SELECT Transaction_ID FROM DuplicateTransactions WHERE RowNum > 1
);

-- Remove transactions with negative or zero amounts
DELETE FROM Transactions WHERE Amount <= 0;

-- Remove transactions with invalid fraud labels
DELETE FROM Transactions WHERE Is_Fraud NOT IN (0, 1);

-- Check for remaining missing values
SELECT * FROM Transactions WHERE Amount IS NULL OR Merchant_Category IS NULL OR Transaction_Mode IS NULL;

-- Check if duplicates exist
SELECT Transaction_ID, COUNT(*) FROM Transactions GROUP BY Transaction_ID HAVING COUNT(*) > 1;

-- Check for invalid amounts
SELECT * FROM Transactions WHERE Amount <= 0;

-- Check unique values of Is_Fraud
SELECT DISTINCT Is_Fraud FROM Transactions;
SELECT @@SERVERNAME AS Server_Name;


select * from transactions;
SELECT DISTINCT transaction_mode FROM Transactions;


INSERT INTO OPENROWSET(
    BULK 'C:\Users\Umair Nawaz\fraud_data.csv',
    DATA_SOURCE = 'YourDataSource',
    FORMAT = 'CSV',
    FIRSTROW = 2
) 
SELECT * FROM Transactions;


