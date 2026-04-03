-- 1. Total Transactions & Fraud Rate
SELECT 
    COUNT(*) AS total_transactions,
    SUM(Is_Fraud) AS total_fraud,
    ROUND(100.0 * SUM(Is_Fraud) / COUNT(*), 2) AS fraud_percentage
FROM Transactions;

-- 2. Fraud vs Non-Fraud Distribution
SELECT 
    Is_Fraud,
    COUNT(*) AS transaction_count
FROM Transactions
GROUP BY Is_Fraud;

-- 3. Avg Transaction Amount (Fraud vs Non-Fraud)
SELECT 
    Is_Fraud,
    AVG(Amount) AS avg_amount
FROM Transactions
GROUP BY Is_Fraud;

-- 4. Top 10 Highest Fraud Transactions
SELECT TOP 10 *
FROM Transactions
WHERE Is_Fraud = 1
ORDER BY Amount DESC;

-- 5. Fraud by Amount Category
SELECT 
    CASE 
        WHEN Amount < 100 THEN 'Low'
        WHEN Amount BETWEEN 100 AND 500 THEN 'Medium'
        ELSE 'High'
    END AS amount_category,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY 
    CASE 
        WHEN Amount < 100 THEN 'Low'
        WHEN Amount BETWEEN 100 AND 500 THEN 'Medium'
        ELSE 'High'
    END;

-- 6. Fraud by Country
SELECT 
    Country,
    COUNT(*) AS total_transactions,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY Country
ORDER BY fraud_count DESC;

-- 7. Top Fraud Cities
SELECT TOP 10
    City,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY City
ORDER BY fraud_count DESC;

-- 8. Fraud Rate by Card Type
SELECT 
    Card_Type,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count,
    ROUND(100.0 * SUM(Is_Fraud) / COUNT(*),2) AS fraud_rate
FROM Transactions
GROUP BY Card_Type;

-- 9. Fraud by Card Issuer
SELECT 
    Card_Issuer,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY Card_Issuer
ORDER BY fraud_count DESC;

-- 10. Fraud by Device Type
SELECT 
    Device_Type,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY Device_Type;

-- 11. Fraud by Transaction Mode
SELECT 
    Transaction_Mode,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY Transaction_Mode;

-- 12. Fraud by Authentication Method
SELECT 
    Auth_Method,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY Auth_Method;

-- 13. Fraud by Hour of Day
SELECT 
    DATEPART(HOUR, Transaction_Time) AS hour,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY DATEPART(HOUR, Transaction_Time)
ORDER BY hour;

-- 14. Daily Fraud Trend
SELECT 
    Transaction_Date,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY Transaction_Date
ORDER BY Transaction_Date;

-- 15. Fraud Score Comparison
SELECT 
    Is_Fraud,
    AVG(Fraud_Score) AS avg_score
FROM Transactions
GROUP BY Is_Fraud;

-- 16. High Risk Transactions (Fraud Score > 80)
SELECT *
FROM Transactions
WHERE Fraud_Score > 80
ORDER BY Fraud_Score DESC;

-- 17. Previous Fraud Behavior Impact
SELECT 
    Previous_Fraud_Flag,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY Previous_Fraud_Flag;

-- 18. Fraud by Merchant Category
SELECT 
    Merchant_Category,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY Merchant_Category
ORDER BY fraud_count DESC;

-- 19. Top Fraud Merchant IDs
SELECT TOP 10
    Merchant_ID,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY Merchant_ID
ORDER BY fraud_count DESC;

-- 20. Fraud by Customer Segment
SELECT 
    Customer_Segment,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY Customer_Segment;

-- 21. Rolling 7-Day Fraud Trend
SELECT 
    Transaction_Date,
    SUM(Is_Fraud) AS daily_fraud,
    SUM(SUM(Is_Fraud)) OVER (
        ORDER BY Transaction_Date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS rolling_7_day_fraud
FROM Transactions
GROUP BY Transaction_Date;

-- 22. Fraud Contribution by Country
SELECT 
    Country,
    SUM(Is_Fraud) AS fraud_count,
    ROUND(100.0 * SUM(Is_Fraud) / SUM(SUM(Is_Fraud)) OVER (),2) AS contribution_pct
FROM Transactions
GROUP BY Country;

-- 23. Suspicious Rapid Transactions (Same Card Type)
SELECT 
    Transaction_ID,
    Card_Type,
    Transaction_Time,
    LAG(Transaction_Time) OVER (PARTITION BY Card_Type ORDER BY Transaction_Time) AS prev_time
FROM Transactions;

-- 24. Fraud Rate by Currency
SELECT 
    Currency,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count,
    ROUND(100.0 * SUM(Is_Fraud) / COUNT(*),2) AS fraud_rate
FROM Transactions
GROUP BY Currency;

-- 25. Fraud by Transaction Status
SELECT 
    Transaction_Status,
    COUNT(*) AS total,
    SUM(Is_Fraud) AS fraud_count
FROM Transactions
GROUP BY Transaction_Status;