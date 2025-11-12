CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR2(50),
    course VARCHAR2(30)
);

CREATE TABLE Marks (
    student_id INT,
    subject VARCHAR2(30),
    score NUMBER,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);


INSERT ALL
    INTO Students VALUES (1, 'Amaan', 'Computer Science')
    INTO Students VALUES (2, 'Snehal', 'Computer Science')
    INTO Students VALUES (3, 'Ravi', 'Mechanical')
    INTO Students VALUES (4, 'Pooja', 'Mechanical')
    INTO Students VALUES (5, 'Arjun', 'Electrical')
    INTO Students VALUES (6, 'Neha', 'Electrical')
    INTO Students VALUES (7, 'Rahul', 'Civil')
    INTO Students VALUES (8, 'Simran', 'Civil')
    INTO Students VALUES (9, 'Irfan', 'Computer Science')
    INTO Students VALUES (10, 'Kavya', 'Electronics')
SELECT * FROM dual;

INSERT ALL
    INTO Marks VALUES (1, 'Maths', 95)
    INTO Marks VALUES (1, 'AI', 92)
    INTO Marks VALUES (1, 'DBMS', 88)
    INTO Marks VALUES (1, 'OS', 90)

    INTO Marks VALUES (2, 'Maths', 88)
    INTO Marks VALUES (2, 'AI', 84)
    INTO Marks VALUES (2, 'DBMS', 81)
    INTO Marks VALUES (2, 'OS', 79)

    INTO Marks VALUES (9, 'Maths', 91)
    INTO Marks VALUES (9, 'AI', 93)
    INTO Marks VALUES (9, 'DBMS', 87)
    INTO Marks VALUES (9, 'OS', 90)

    INTO Marks VALUES (3, 'Thermodynamics', 70)
    INTO Marks VALUES (3, 'Machine Design', 65)
    INTO Marks VALUES (3, 'Fluid Mechanics', 72)

    INTO Marks VALUES (4, 'Thermodynamics', 80)
    INTO Marks VALUES (4, 'Machine Design', 78)
    INTO Marks VALUES (4, 'Fluid Mechanics', 82)

    INTO Marks VALUES (5, 'Circuits', 85)
    INTO Marks VALUES (5, 'Electromagnetics', 88)
    INTO Marks VALUES (5, 'Control Systems', 84)

    INTO Marks VALUES (6, 'Circuits', 91)
    INTO Marks VALUES (6, 'Electromagnetics', 89)
    INTO Marks VALUES (6, 'Control Systems', 93)

    INTO Marks VALUES (7, 'Structural Analysis', 75)
    INTO Marks VALUES (7, 'Surveying', 78)
    INTO Marks VALUES (7, 'Concrete Technology', 80)

    INTO Marks VALUES (8, 'Structural Analysis', 68)
    INTO Marks VALUES (8, 'Surveying', 72)
    INTO Marks VALUES (8, 'Concrete Technology', 70)

    INTO Marks VALUES (10, 'Digital Electronics', 82)
    INTO Marks VALUES (10, 'Microprocessors', 87)
    INTO Marks VALUES (10, 'Analog Circuits', 80)
SELECT * FROM dual;


-------->>>>>>>>> Function to get Total score of a student across subjects <<<<<<<<-----------------

create or replace FUNCTION get_student_total(p_student_id IN NUMBER)
RETURN NUMBER
IS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(score), 0)
    INTO v_total
    FROM Marks
    WHERE student_id = p_student_id;

    RETURN v_total;
END;

-- Call the function inside PL/SQL Block
DECLARE
    v_total NUMBER;
BEGIN
    v_total := GET_STUDENT_TOTAL(1); 
    DBMS_OUTPUT.PUT_LINE('Total score of a student across subjects: ' || v_total);
END;
/


-------->>>>>>>>> Function to get Average marks of a student <<<<<<<<-----------------

create or replace FUNCTION get_student_average(p_student_id IN NUMBER)
RETURN NUMBER
IS
    v_avg NUMBER := 0;
BEGIN
    SELECT NVL(AVG(score), 0)
    INTO v_avg
    FROM Marks
    WHERE student_id = p_student_id;

    RETURN v_avg;
END;

-- Call the function inside PL/SQL Block
DECLARE
    v_avg NUMBER; 
BEGIN
    v_avg := GET_STUDENT_AVERAGE(9); 
    DBMS_OUTPUT.PUT_LINE('Average marks of a student : ' || v_avg);
END;
/

-------->>>>>>>>> Function to calculate grade based on average of a student <<<<<<<<-----------------

CREATE OR REPLACE FUNCTION get_grade(p_student_id IN NUMBER)
RETURN VARCHAR2
IS
    v_avg NUMBER;
    v_grade VARCHAR2(2);
BEGIN
    v_avg := GET_STUDENT_AVERAGE(P_STUDENT_ID);

    v_grade := CASE
        WHEN v_avg >= 90 THEN 'A+'
        WHEN v_avg >= 80 THEN 'A'
        WHEN v_avg >= 70 THEN 'B'
        WHEN v_avg >= 60 THEN 'C'
        ELSE 'F'

        END;
        RETURN v_grade;
END;
/

-- Call the function inside PL/SQL Block
BEGIN
    DBMS_OUTPUT.PUT_LINE('Grades of the student with id 1: ' || GET_GRADE(1));
    
END;
/



---->>>> Function that returns the student name with highest total marks in a given course. <<<<-----

CREATE OR REPLACE FUNCTION course_topper(p_course IN VARCHAR2)
RETURN VARCHAR2
IS
    v_topper_name VARCHAR2(50);
BEGIN
    SELECT s.student_name
    INTO v_topper_name
    FROM Students s
    JOIN (
        SELECT m.student_id, SUM(m.score) AS total_score
        FROM Marks m
        GROUP BY m.student_id
    ) totals
    ON s.student_id = totals.student_id
    WHERE s.course = p_course
    AND totals.total_score = (
        SELECT MAX(SUM(score))
        FROM Marks m
        JOIN Students s2 ON m.student_id = s2.student_id
        WHERE s2.course = p_course
        GROUP BY m.student_id
    );

    RETURN v_topper_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'No student found';
END;
/

-- Call the function inside PL/SQL Block
BEGIN
    DBMS_OUTPUT.PUT_LINE('Student name with highest total marks in a Computer science: ' ||COURSE_TOPPER('Computer Science'));
END;
/

-- Display student details with total, average, and grade
SELECT 
    s.student_id,
    s.student_name,
    get_student_total(s.student_id) AS total_marks,
    get_student_average(s.student_id) AS avg_marks,
    get_grade(s.student_id) AS grade
FROM Students s;