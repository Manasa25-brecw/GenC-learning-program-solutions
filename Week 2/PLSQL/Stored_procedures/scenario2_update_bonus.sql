--Savings accounts Table
CREATE TABLE savings_accounts (
    account_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    balance NUMBER
);

-- Employees Table
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    department_id NUMBER,
    salary NUMBER
);

-- Accounts Table (for fund transfer)
CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    balance NUMBER
);

-- Sample Savings Accounts
INSERT INTO savings_accounts VALUES (1, 1001, 5000);
INSERT INTO savings_accounts VALUES (2, 1002, 10000);

-- Sample Employees
INSERT INTO employees VALUES (1, 'Alice', 10, 3000);
INSERT INTO employees VALUES (2, 'Bob', 10, 4000);
INSERT INTO employees VALUES (3, 'Charlie', 20, 3500);

-- Sample Accounts for Transfer
INSERT INTO accounts VALUES (101, 1001, 8000);
INSERT INTO accounts VALUES (102, 1002, 2000);

-- Commit changes
COMMIT;

SELECT *FROM savings_accounts;
SELECT * FROM employees;
SELECT * FROM accounts;

-- Scenario 1: Process Monthly Interest
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    UPDATE savings_accounts
    SET balance = balance + (balance * 0.01);
END;
/
EXEC ProcessMonthlyInterest;

-- Scenario 2: Update Employee Bonus
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    dept_id IN NUMBER,
    bonus_pct IN NUMBER
) IS
BEGIN
    UPDATE employees
    SET salary = salary + (salary * bonus_pct / 100)
    WHERE department_id = dept_id;
    DBMS_OUTPUT.PUT_LINE('Bonus updated for department ' || dept_id);
END;
/

-- Scenario 3: Transfer Funds Between Accounts
CREATE OR REPLACE PROCEDURE TransferFunds (
    from_account_id IN NUMBER,
    to_account_id IN NUMBER,
    amount IN NUMBER
) IS
    insufficient_funds EXCEPTION;
    current_balance NUMBER;
BEGIN
    SELECT balance INTO current_balance FROM accounts WHERE account_id = from_account_id;

    IF current_balance < amount THEN
        RAISE insufficient_funds;
    END IF;

    UPDATE accounts
    SET balance = balance - amount
    WHERE account_id = from_account_id;

    UPDATE accounts
    SET balance = balance + amount
    WHERE account_id = to_account_id;

    DBMS_OUTPUT.PUT_LINE('Transferred ' || amount || ' from account ' || from_account_id || ' to account ' || to_account_id);

EXCEPTION
    WHEN insufficient_funds THEN
        DBMS_OUTPUT.PUT_LINE('Error: Insufficient balance in source account.');
END;
/

SELECT * FROM savings_accounts;

EXEC UpdateEmployeeBonus(10, 10);  -- Dept ID 10, Bonus 10%

SELECT * FROM employees;

BEGIN
    UpdateEmployeeBonus(10, 10);
END;
/

EXECUTE UpdateEmployeeBonus(10, 10);

UPDATE employees SET salary = 3000 WHERE emp_id = 1; -- Alice
UPDATE employees SET salary = 4000 WHERE emp_id = 2; -- Bob
UPDATE employees SET salary = 3500 WHERE emp_id = 3; -- Charlie
COMMIT;

BEGIN
    UpdateEmployeeBonus(10, 10);
END;
/

SELECT * FROM accounts;

EXEC TransferFunds(101, 102, 1000);



