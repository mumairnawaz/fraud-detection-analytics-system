CREATE INDEX idx_fraud ON Transactions(Is_Fraud);
CREATE INDEX idx_country ON Transactions(Country);
CREATE INDEX idx_transaction_date ON Transactions(Transaction_Date);
CREATE INDEX idx_amount ON Transactions(Amount);