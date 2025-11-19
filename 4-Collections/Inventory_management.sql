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

-- <<<<<<<<<< Associative Array >>>>>>>>> 
    TYPE name_map IS TABLE OF VARCHAR2(50) 
    INDEX BY PLS_INTEGER;
    names name_map;

-- <<<<<<<<<< Nested Table >>>>>>>>> 
    TYPE qty_nt IS TABLE OF NUMBER;
    quantities qty_nt := qty_nt();
    total_qty NUMBER := 0;

    idx PLS_INTEGER; 

-- <<<<<<<<<< VARRRAY >>>>>>>>> 
    TYPE product_varray_t IS VARRAY(5) OF VARCHAR2(50);
    v_products product_varray_t := product_varray_t();


BEGIN

 -- Populate & Print Associative Array 
    FOR rec IN (SELECT product_id, product_name FROM PRODUCTS) LOOP
        names(rec.product_id) := rec.product_name;
    END LOOP;

    idx := names.FIRST;
    WHILE idx IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE('Product id: ' || idx || ' | Name: ' || names(idx));
        idx := names.NEXT(idx);
    END LOOP;

-- Populate Nested Table & Calculate total quantity
    SELECT quantity BULK COLLECT INTO quantities
    FROM Products
    ORDER BY product_id;

     FOR i IN 1 .. quantities.COUNT LOOP
        total_qty := total_qty + NVL(quantities(i), 0);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total Quantity in Inventory: ' || total_qty);

-- collection methods
    DBMS_OUTPUT.PUT_LINE('Nested Table Count: ' || quantities.COUNT);

    quantities.EXTEND;
    quantities(quantities.COUNT) := 99;
    DBMS_OUTPUT.PUT_LINE('After EXTEND, New Count: ' || quantities.COUNT);

    quantities.DELETE(1);
    DBMS_OUTPUT.PUT_LINE('After DELETE(1), Count remains: ' || quantities.COUNT);

-- VARRAY of 5 product names
    v_products.EXTEND(5);
    v_products(1) := 'Laptop';
    v_products(2) := 'Keyboard';
    v_products(3) := 'Printer';
    v_products(4) := 'Monitor';
    v_products(5) := 'Webcam';

     FOR i IN 1 .. v_products.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('VARRAY[' || i || ']: ' || v_products(i));
    END LOOP;

-- Combine collections: Print products with quantity < 10
    DECLARE
        TYPE id_nt IS TABLE OF NUMBER;
        ids id_nt := id_nt();
        qtys qty_nt := qty_nt();
   
    BEGIN
        SELECT product_id, quantity BULK COLLECT INTO ids, qtys
        FROM Products
        ORDER BY product_id;
        
        FOR i IN 1 .. ids.COUNT LOOP
            IF qtys(i) < 10 THEN
                DBMS_OUTPUT.PUT_LINE(
                    'Product ID: ' || ids(i) ||
                    ' | Name: ' || names(ids(i)) ||
                    ' | Quantity: ' || qtys(i)
                );
            END IF;
        END LOOP;
    END;

END;
/


