-- Fill missing Merchant_Category
UPDATE Transactions
SET Merchant_Category = 'UNKNOWN'
WHERE Merchant_Category IS NULL;

-- Normalize Currency
UPDATE Transactions
SET Currency = 'USD'
WHERE Currency IS NULL;

-- Cap extreme outliers
UPDATE Transactions
SET Amount = 10000
WHERE Amount > 10000;

-- Standardize Customer Segment
UPDATE Transactions
SET Customer_Segment = UPPER(Customer_Segment);