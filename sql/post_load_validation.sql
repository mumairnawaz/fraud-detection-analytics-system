-- Record count reconciliation
SELECT 
    (SELECT COUNT(*) FROM stg_transactions) AS staging_count,
    (SELECT COUNT(*) FROM Transactions) AS production_count;

-- Rejected records
SELECT *
FROM stg_transactions
WHERE TRY_CAST(Amount AS FLOAT) <= 0
   OR TRY_CAST(Is_Fraud AS INT) NOT IN (0,1);

-- Duplicate check in production
SELECT Transaction_ID, COUNT(*)
FROM Transactions
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;

-- Data consistency check
SELECT 
    COUNT(*) AS mismatch_count
FROM stg_transactions s
LEFT JOIN Transactions t
ON s.Transaction_ID = t.Transaction_ID
WHERE t.Transaction_ID IS NULL;