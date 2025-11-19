-- Table PRODUCTS created
CREATE TABLE Products (
  product_id   NUMBER PRIMARY KEY,
  product_name VARCHAR2(50),
  quantity     NUMBER,
  price        NUMBER
);

-- 10 rows inserted in PRODUCTS Table
INSERT ALL
  INTO Products (product_id, product_name, quantity, price) VALUES (1,  'Laptop',        15, 55000)
  INTO Products (product_id, product_name, quantity, price) VALUES (2,  'Mouse',         50,    700)
  INTO Products (product_id, product_name, quantity, price) VALUES (3,  'Keyboard',      40,   1200)
  INTO Products (product_id, product_name, quantity, price) VALUES (4,  'Monitor',       8,   8000)
  INTO Products (product_id, product_name, quantity, price) VALUES (5,  'Printer',       6,  12000)
  INTO Products (product_id, product_name, quantity, price) VALUES (6,  'Webcam',        25,  1500)
  INTO Products (product_id, product_name, quantity, price) VALUES (7,  'Headset',       9,   1800)
  INTO Products (product_id, product_name, quantity, price) VALUES (8,  'Speaker',       30,  2200)
  INTO Products (product_id, product_name, quantity, price) VALUES (9,  'UPS',           4,  5000)
  INTO Products (product_id, product_name, quantity, price) VALUES (10, 'External HDD',  20, 4500)
SELECT * FROM dual;

DECLARE

    TYPE name_map IS TABLE OF VARCHAR2(50) 
    INDEX BY PLS_INTEGER;

    names name_map;

    idx PLS_INTEGER; 
    
BEGIN
    
    FOR rec IN (SELECT product_id, product_name FROM PRODUCTS) LOOP
        names(rec.product_id) := rec.product_name;
    END LOOP;

    idx := names.FIRST;
    WHILE idx IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE('Product id: ' || idx || ' | Name: ' || names(idx));
        idx := names.NEXT(idx);
    END LOOP;
    
END;
/


