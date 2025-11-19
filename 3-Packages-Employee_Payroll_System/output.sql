DECLARE
    v_gross NUMBER;
    v_net   NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('       PAYROLL MANAGEMENT SYSTEM – PACKAGE OUTPUT');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');


    DBMS_OUTPUT.PUT_LINE(CHR(10) || '1) Calculating Gross Salary for Employee ID: 101');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    v_gross := payroll_pkg.calc_gross_salary(101);

    DBMS_OUTPUT.PUT_LINE('Gross Salary: ' || v_gross);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');


    DBMS_OUTPUT.PUT_LINE(CHR(10) || '2) Calculating Net Salary for Employee ID: 101');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    v_net := payroll_pkg.calc_net_salary(101);

    DBMS_OUTPUT.PUT_LINE('Net Salary: ' || v_net);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');


    DBMS_OUTPUT.PUT_LINE(CHR(10) || '3) Updating Salary Components for Employee ID: 105');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    payroll_pkg.update_salary(105, 9000, 7000);

    DBMS_OUTPUT.PUT_LINE('Status: Salary Updated Successfully');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');


    DBMS_OUTPUT.PUT_LINE(CHR(10) || '4) Logging Salary Action');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    payroll_pkg.log_salary_action(105, 'Manual Log Entry');

    DBMS_OUTPUT.PUT_LINE('Log Entry Created: ✔');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');


    DBMS_OUTPUT.PUT_LINE(CHR(10) || '5) Handling Invalid Employee ID: 999');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    BEGIN
        v_gross := payroll_pkg.calc_gross_salary(999); 
    EXCEPTION
        WHEN payroll_pkg.e_emp_not_found THEN
            DBMS_OUTPUT.PUT_LINE('❌ Error: Employee does not exist.');
    END;

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

END;
/
