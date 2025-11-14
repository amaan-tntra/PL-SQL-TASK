-- Create Books Table 
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    book_name VARCHAR2(50),
    available_qty NUMBER
);

-- Insert data into table
INSERT ALL
    INTO Books (book_id, book_name, available_qty) VALUES (101, 'Ikigai', 5)
    INTO Books (book_id, book_name, available_qty) VALUES (102, 'Atomic Habits', 7)
    INTO Books (book_id, book_name, available_qty) VALUES (103, 'The Alchemist', 4)
    INTO Books (book_id, book_name, available_qty) VALUES (104, 'Rich Dad Poor Dad', 6)
    INTO Books (book_id, book_name, available_qty) VALUES (105, 'The Psychology of Money', 8)
    INTO Books (book_id, book_name, available_qty) VALUES (106, 'Think and Grow Rich', 3)
    INTO Books (book_id, book_name, available_qty) VALUES (107, 'The Power of Your Subconscious Mind', 5)
    INTO Books (book_id, book_name, available_qty) VALUES (108, 'The 7 Habits of Highly Effective People', 2)
    INTO Books (book_id, book_name, available_qty) VALUES (109, 'Sapiens: A Brief History of Humankind', 4)
    INTO Books (book_id, book_name, available_qty) VALUES (110, 'The Monk Who Sold His Ferrari', 5)
    INTO Books (book_id, book_name, available_qty) VALUES (111, 'Deep Work', 3)
    INTO Books (book_id, book_name, available_qty) VALUES (112, 'Start With Why', 6)
    INTO Books (book_id, book_name, available_qty) VALUES (113, 'The Subtle Art of Not Giving a F*ck', 7)
    INTO Books (book_id, book_name, available_qty) VALUES (114, 'Can’t Hurt Me', 3)
    INTO Books (book_id, book_name, available_qty) VALUES (115, 'The Power of Now', 5)
    INTO Books (book_id, book_name, available_qty) VALUES (116, 'Man’s Search for Meaning', 4)
    INTO Books (book_id, book_name, available_qty) VALUES (117, 'Meditations', 2)
    INTO Books (book_id, book_name, available_qty) VALUES (118, 'Hooked: Habit-Forming Products', 6)
    INTO Books (book_id, book_name, available_qty) VALUES (119, 'The Lean Startup', 3)
    INTO Books (book_id, book_name, available_qty) VALUES (120, 'Zero to One', 8)
SELECT * FROM dual;


DECLARE
    p_book_id books.BOOK_ID%TYPE := 101;
    v_available books.AVAILABLE_QTY%TYPE;

    e_out_of_stock EXCEPTION;
    
BEGIN

    SELECT available_qty INTO v_available 
    FROM BOOKS 
    WHERE BOOK_ID = p_book_id;
    
-- Implementing user-defined exception (e_out_of_stock)	
    IF v_available = 0 THEN
        RAISE e_out_of_stock;
    END IF; 

-- Calculating dummy fine
    DECLARE
        v_dummy NUMBER;
    BEGIN
        v_dummy := 10 / v_available;   
    END;
    

    UPDATE BOOKS 
    SET AVAILABLE_QTY = AVAILABLE_QTY - 1
    WHERE book_id = p_book_id;
    DBMS_OUTPUT.PUT_LINE('Book issued successfully. Remaining qty = ' || (v_available - 1));

EXCEPTION
-- Using RAISE_APPLICATION_ERROR for displaying error message 
    WHEN e_out_of_stock THEN
        RAISE_APPLICATION_ERROR(-20001, 'Sorry, The Book is not available');

-- Simulate a division-by-zero error while calculating dummy fine
    WHEN ZERO_DIVIDE THEN 
        DBMS_OUTPUT.PUT_LINE('Division by zero occurred while calculating fine');

-- If the book ID doesn’t exist
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Book ID: ' || p_book_id || ' doesn''t exist');

END;
/