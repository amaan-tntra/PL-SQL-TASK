-- PRODUCTS Table is already created in collection task

-- Table SUPPLIERS created
CREATE TABLE Suppliers (
  supplier_id   NUMBER PRIMARY KEY,
  supplier_name VARCHAR2(50),
  contact       VARCHAR2(20)
);

-- 10 rows inserted SUPPLIERS Table
INSERT ALL
  INTO Suppliers (supplier_id, supplier_name, contact) VALUES (1,  'Tech Distributors Pvt Ltd',    '9876543210')
  INTO Suppliers (supplier_id, supplier_name, contact) VALUES (2,  'Global IT Supplies',           '9823456712')
  INTO Suppliers (supplier_id, supplier_name, contact) VALUES (3,  'Prime Electronics Co.',        '9123456780')
  INTO Suppliers (supplier_id, supplier_name, contact) VALUES (4,  'Infinity Traders',             '9988776655')
  INTO Suppliers (supplier_id, supplier_name, contact) VALUES (5,  'Digital Solutions Hub',        '9001122334')
  INTO Suppliers (supplier_id, supplier_name, contact) VALUES (6,  'Star Components',              '9090909090')
  INTO Suppliers (supplier_id, supplier_name, contact) VALUES (7,  'NextGen Suppliers',            '9877001122')
  INTO Suppliers (supplier_id, supplier_name, contact) VALUES (8,  'Elite Electronics',            '9812345678')
  INTO Suppliers (supplier_id, supplier_name, contact) VALUES (9,  'Bright Tech Traders',          '9845612398')
  INTO Suppliers (supplier_id, supplier_name, contact) VALUES (10, 'Shree Infotech Supplies',      '9765432109')
SELECT * FROM dual;



DECLARE

-- Declare record variable for Products
    prod_rec PRODUCTS%ROWTYPE;
    
BEGIN

-- Fetch and print details of a product with PRODUCT_ID = 1
    SELECT * INTO prod_rec
    FROM PRODUCTS
    WHERE PRODUCT_ID = 1; 
    
    DBMS_OUTPUT.PUT_LINE('Product Name: ' || prod_rec.product_name || ' | Qauntity: ' || prod_rec.quantity ||
                        ' | Price: ' || prod_rec.Price);
END;
/
