-- Table EMPLOYEES created
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR2(50),
    basic_salary NUMBER,
    hra NUMBER,
    da NUMBER,
    deductions NUMBER
);

-- Table PAYROLL_LOG created
CREATE TABLE Payroll_Log (
    log_id INT PRIMARY KEY,
    emp_id INT,
    action VARCHAR2(50),
    log_date DATE
);
 
-- 20 rows inserted in EMPLOYEES Table
INSERT ALL
    INTO Employees VALUES (101, 'Aman',       30000, 5000, 4000, 2000)
    INTO Employees VALUES (102, 'Sneha',      32000, 6000, 4500, 2500)
    INTO Employees VALUES (103, 'Rahul',      28000, 4500, 3800, 1800)
    INTO Employees VALUES (104, 'Priya',      35000, 6500, 5000, 2700)
    INTO Employees VALUES (105, 'Karan',      40000, 7000, 5200, 3000)
    INTO Employees VALUES (106, 'Neha',       31000, 5200, 4100, 2100)
    INTO Employees VALUES (107, 'Manish',     36000, 6800, 4800, 2600)
    INTO Employees VALUES (108, 'Riya',       29000, 4800, 3900, 1900)
    INTO Employees VALUES (109, 'Sagar',      33000, 6000, 4600, 2400)
    INTO Employees VALUES (110, 'Vidhi',      34000, 6300, 4700, 2500)
    INTO Employees VALUES (111, 'Arjun',      37000, 7000, 5100, 2800)
    INTO Employees VALUES (112, 'Meera',      29500, 4900, 4000, 1950)
    INTO Employees VALUES (113, 'Nikhil',     31500, 5600, 4200, 2200)
    INTO Employees VALUES (114, 'Tanvi',      32500, 5800, 4300, 2250)
    INTO Employees VALUES (115, 'Viraj',      38500, 7200, 5400, 2900)
    INTO Employees VALUES (116, 'Ananya',     30500, 5300, 4100, 2050)
    INTO Employees VALUES (117, 'Harsh',      29500, 4700, 3800, 1800)
    INTO Employees VALUES (118, 'Zara',       34500, 6500, 4800, 2600)
    INTO Employees VALUES (119, 'Jay',        26500, 4200, 3500, 1600)
    INTO Employees VALUES (120, 'Simran',     35500, 6600, 4900, 2700)
SELECT 1 FROM dual;

-- 20 rows inserted in PAYROLL_LOG Table
INSERT ALL
    INTO Payroll_Log VALUES (1, 101, 'Salary Calculated', DATE '2025-01-01')
    INTO Payroll_Log VALUES (2, 102, 'Salary Updated', DATE '2025-01-02')
    INTO Payroll_Log VALUES (3, 103, 'Salary Viewed', DATE '2025-01-02')
    INTO Payroll_Log VALUES (4, 104, 'Bonus Added', DATE '2025-01-03')
    INTO Payroll_Log VALUES (5, 105, 'Salary Recalculated', DATE '2025-01-03')
    INTO Payroll_Log VALUES (6, 106, 'Salary Updated', DATE '2025-01-04')
    INTO Payroll_Log VALUES (7, 107, 'Deductions Modified', DATE '2025-01-04')
    INTO Payroll_Log VALUES (8, 108, 'Salary Viewed', DATE '2025-01-05')
    INTO Payroll_Log VALUES (9, 109, 'Salary Calculated', DATE '2025-01-05')
    INTO Payroll_Log VALUES (10, 110, 'Salary Updated', DATE '2025-01-06')
    INTO Payroll_Log VALUES (11, 111, 'Salary Recalculated', DATE '2025-01-06')
    INTO Payroll_Log VALUES (12, 112, 'Bonus Added', DATE '2025-01-07')
    INTO Payroll_Log VALUES (13, 113, 'Salary Viewed', DATE '2025-01-07')
    INTO Payroll_Log VALUES (14, 114, 'Salary Updated', DATE '2025-01-08')
    INTO Payroll_Log VALUES (15, 115, 'Deductions Modified', DATE '2025-01-08')
    INTO Payroll_Log VALUES (16, 116, 'Salary Calculated', DATE '2025-01-09')
    INTO Payroll_Log VALUES (17, 117, 'Bonus Added', DATE '2025-01-09')
    INTO Payroll_Log VALUES (18, 118, 'Salary Viewed', DATE '2025-01-10')
    INTO Payroll_Log VALUES (19, 119, 'Salary Updated', DATE '2025-01-10')
    INTO Payroll_Log VALUES (20, 120, 'Salary Recalculated', DATE '2025-01-11')
SELECT 1 FROM dual;

--------------------------- <<<<< PACKAGE SPEC >>>>>>> -------------------------------------

-- Package PAYROLL_PKG compiled
CREATE OR REPLACE PACKAGE payroll_pkg AS

    company_bonus CONSTANT := 500;

    FUNCTION calc_gross_salary(p_emp_id IN NUMBER) RETURN NUMBER;
    FUNCTION calc_net_salary(p_emp_id IN NUMBER) RETURN NUMBER;

    PROCEDURE update_salary(p_emp_id IN NUMBER, p_hra IN NUMBER, p_da IN NUMBER);
    PROCEDURE log_salary_action(p_emp_id IN NUMBER, p_action IN VARCHAR2);

    e_emp_not_found EXCEPTION;

END payroll_pkg;
/
--------------------------- <<<<< PACKAGE BODY >>>>>>> -------------------------------------

CREATE OR REPLACE PACKAGE BODY payroll_pkg AS

-- Fuction to calculate gross salary
    FUNCTION calc_gross_salary(p_emp_id IN NUMBER) RETURN NUMBER IS
        v_basic EMPLOYEES.BASIC_SALARY%TYPE;
        v_hra EMPLOYEES.HRA%TYPE;
        v_da EMPLOYEES.DA%TYPE;

    BEGIN
        SELECT BASIC_SALARY, HRA, DA 
        INTO v_basic, v_hra, v_da
        from EMPLOYEES
        where EMP_ID = p_emp_id;

        RETURN v_basic + v_hra + v_da + company_bonus;

    END calc_gross_salary;


-- Fuction to calculate gross salary
    FUNCTION calc_net_salary(p_emp_id IN NUMBER) RETURN NUMBER IS
    v_gross NUMBER;
    v_dedeuction EMPLOYEES.DEDUCTIONS%TYPE;
    
    BEGIN

        v_gross := calc_gross_salary(p_emp_id);

        SELECT DEDUCTIONS INTO v_dedeuction FROM EMPLOYEES
        WHERE EMP_ID = p_emp_id;

        RETURN v_gross - v_dedeuction;

    END calc_net_salary;

-- Procedure to update salary components
    PROCEDURE update_salary(p_emp_id IN NUMBER, p_hra IN NUMBER, p_da IN NUMBER) IS
    BEGIN

        UPDATE Employees
        SET hra = p_hra, da  = p_da
        WHERE emp_id = p_emp_id;

        log_salary_action(p_emp_id, 'Salary Updated');
    END update_salary;


-- Procedure to insert into payroll_log
    PROCEDURE log_salary_action(p_emp_id IN NUMBER, p_action IN VARCHAR2) IS
        v_log_id NUMBER;
    BEGIN
        SELECT NVL(MAX(log_id),0) + 1 INTO v_log_id FROM Payroll_Log;

        INSERT INTO Payroll_Log(log_id, emp_id, action, log_date)
        VALUES(v_log_id, p_emp_id, p_action, SYSDATE);
    END log_salary_action;









END payroll_pkg;
/