BULK INSERT stg_transactions
FROM 'C:\Users\Umair Nawaz\fraud_data.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);