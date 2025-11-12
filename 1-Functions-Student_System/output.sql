BEGIN
    DBMS_OUTPUT.PUT_LINE('====================>>>>>> COURSE TOPPERS <<<<<<====================');
    DBMS_OUTPUT.PUT_LINE('Computer Science : ' || course_topper('Computer Science'));
    DBMS_OUTPUT.PUT_LINE('Mechanical       : ' || course_topper('Mechanical'));
    DBMS_OUTPUT.PUT_LINE('Electrical       : ' || course_topper('Electrical'));
    DBMS_OUTPUT.PUT_LINE('Civil            : ' || course_topper('Civil'));
    DBMS_OUTPUT.PUT_LINE('Electronics      : ' || course_topper('Electronics'));
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('====================>>>>>> STUDENT DETAILS TABLE <<<<<<====================');
    FOR rec IN (
        SELECT 
            s.student_id,
            s.student_name,
            s.course,
            get_student_total(s.student_id) AS total_marks,
            ROUND(get_student_average(s.student_id), 2) AS avg_marks,
            get_grade(s.student_id) AS grade
        FROM Students s
        ORDER BY s.course, s.student_id
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            RPAD(rec.student_id,4) || ' | ' ||
            RPAD(rec.student_name,10) || ' | ' ||
            RPAD(rec.course,18) || ' | Total: ' ||
            RPAD(rec.total_marks,4) || ' | Avg: ' ||
            RPAD(rec.avg_marks,5) || ' | Grade: ' ||
            rec.grade
        );
    END LOOP;
END;
/
