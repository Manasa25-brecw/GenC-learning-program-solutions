-- Create customers table
CREATE TABLE customers (
    customer_id     NUMBER PRIMARY KEY,
    name            VARCHAR2(100),
    age             NUMBER,
    balance         NUMBER(10, 2),
    is_vip          CHAR(1) DEFAULT 'N' -- 'Y' for VIP, 'N' for normal
);
-- Create loans table
CREATE TABLE loans (
    loan_id         NUMBER PRIMARY KEY,
    customer_id     NUMBER,
    amount          NUMBER(10, 2),
    interest_rate   NUMBER(5, 2),
    due_date        DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
-- Insert customers
INSERT INTO customers VALUES (1, 'John Doe', 65, 12000.00, 'N');
INSERT INTO customers VALUES (2, 'Jane Smith', 45, 8000.00, 'N');
INSERT INTO customers VALUES (3, 'Mike Ross', 70, 15000.00, 'N');
INSERT INTO customers VALUES (4, 'Rachel Zane', 30, 9500.00, 'N');
-- Insert loans
INSERT INTO loans VALUES (101, 1, 5000.00, 7.5, SYSDATE + 10);  -- Due in 10 days
INSERT INTO loans VALUES (102, 2, 6000.00, 8.0, SYSDATE + 40);  -- Due in 40 days
INSERT INTO loans VALUES (103, 3, 7000.00, 6.5, SYSDATE + 5);   -- Due in 5 days
INSERT INTO loans VALUES (104, 4, 4000.00, 9.0, SYSDATE + 25);  -- Due in 25 days
COMMIT;
SELECT * FROM loans;


--Scenario 1:Apply 1% Discount to Customers Over 60
BEGIN
  FOR cust IN (SELECT customer_id FROM customers WHERE age > 60) LOOP
    UPDATE loans
    SET interest_rate = interest_rate - 1
    WHERE customer_id = cust.customer_id;
  END LOOP;
  COMMIT;
END;
--Scenario 2: Promote Customers to VIP with Balance > $10,000
BEGIN
  FOR cust IN (SELECT customer_id FROM customers WHERE balance > 10000) LOOP
    UPDATE customers
    SET is_vip = 'Y'
    WHERE customer_id = cust.customer_id;
  END LOOP;

  COMMIT;
END;
--Scenario 3: Send Reminders for Loans Due in 30 Days
BEGIN
  FOR loan_rec IN (
    SELECT l.loan_id, c.name, l.due_date
    FROM loans l
    JOIN customers c ON l.customer_id = c.customer_id
    WHERE l.due_date BETWEEN SYSDATE AND SYSDATE + 30
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: ' || loan_rec.name ||
                         ' has a loan due on ' || TO_CHAR(loan_rec.due_date, 'DD-MON-YYYY'));
  END LOOP;
END;

-- Check updated interest rates
SELECT * FROM loans;

-- Check VIP status
SELECT * FROM customers WHERE is_vip = 'TRUE';

-- Manually verify loans due soon
SELECT * FROM loans WHERE due_date BETWEEN SYSDATE AND SYSDATE + 30;

--Scenario 1 output
SELECT customer_id, interest_rate
FROM loans
WHERE customer_id IN (SELECT customer_id FROM customers WHERE age > 60);

SELECT * FROM customers;

ALTER TABLE customers ADD IsVIP CHAR(1) DEFAULT 'N';
DESC customers;
UPDATE customers SET isvip = 'Y' WHERE balance > 10000;
SELECT * FROM customers WHERE isvip = 'Y';

SELECT c.name, c.age, l.loan_id, l.interest_rate
FROM customers c
JOIN loans l ON c.customer_id = l.customer_id;




