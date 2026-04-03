INSERT INTO Transactions
SELECT 
    Transaction_ID,
    TRY_CAST(Transaction_Date AS DATE),
    TRY_CAST(Transaction_Time AS TIME),
    TRY_CAST(Time AS INT),
    TRY_CAST(Amount AS FLOAT),
    UPPER(Card_Type),
    UPPER(Country),
    City,
    IP_Address,
    Merchant_ID,
    UPPER(Merchant_Category),
    UPPER(Transaction_Mode),
    UPPER(Auth_Method),
    Device_Type,
    Transaction_Status,
    Currency,
    UPPER(Card_Issuer),
    Customer_Segment,
    TRY_CAST(Fraud_Score AS FLOAT),
    TRY_CAST(Previous_Fraud_Flag AS INT),
    TRY_CAST(Is_Fraud AS INT)
FROM stg_transactions
WHERE TRY_CAST(Amount AS FLOAT) > 0
  AND TRY_CAST(Is_Fraud AS INT) IN (0,1);