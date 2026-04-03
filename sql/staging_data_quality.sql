-- Null checks
SELECT 
    COUNT(*) AS total_records,
    SUM(CASE WHEN Transaction_ID IS NULL THEN 1 ELSE 0 END) AS null_transaction_id,
    SUM(CASE WHEN Amount IS NULL THEN 1 ELSE 0 END) AS null_amount
FROM stg_transactions;

-- Invalid numeric values
SELECT *
FROM stg_transactions
WHERE TRY_CAST(Amount AS FLOAT) IS NULL;

-- Invalid date format
SELECT *
FROM stg_transactions
WHERE TRY_CAST(Transaction_Date AS DATE) IS NULL;

-- Duplicate detection
SELECT Transaction_ID, COUNT(*)
FROM stg_transactions
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;

-- Fraud flag validation
SELECT DISTINCT Is_Fraud
FROM stg_transactions
WHERE Is_Fraud NOT IN ('0','1');

-- Outlier detection
SELECT *
FROM stg_transactions
WHERE TRY_CAST(Amount AS FLOAT) > 10000;