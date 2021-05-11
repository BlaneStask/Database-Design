-- 1
SELECT name 
FROM student NATURAL INNER JOIN takes ON student.ID = takes.ID
FULL OUTER JOIN (instructor NATUAL INNER JOIN teaches ON teaches.ID = instructor.ID)
WHERE instructor.dept_name = 'Computer Science'
USING(student);

-- 2
with a AS (SELECT COUNT(*) i_count FROM instructor GROUP BY dept_name),
with b AS (SELECT COUNT(*) c_count FROM teaches ),
with c AS (SELECT t1.dept_name, t2.ID, COUNT(*) ct 
FROM teaches t1 JOIN instructor t2 
ON t1.ID - t2.ID 
GROUP BY t1.dept_name, t2.ID)
SELECT c.dept_name, COUNT(*) overworked_instructors 
FROM c 
WHERE c.ct > (SELECT (c_count/i_count) avg FROM a, b)
GROUP BY c.dept_name ORDER BY 2 desc;

-- 3
CREATE VIEW CS101Students AS
SELECT student.ID, student.name, student.dept_name, student.tot_cred, takes.grade, takes.course_id
FROM student INNER JOIN takes
ON student.ID = takes.ID
where takes.course_id = 'CS-101';

-- 4a
CREATE TRIGGER delete_student
ON student s
FOR DELETE
AS
   SET FEEDBACK OFF;
   DELETE FROM advisor
WHERE s.ID IN(SELECT deleted.ID FROM deleted)
   delete from takes
   where ID IN (SELECT deleted.ID FROM deleted)

-- 4b
DELETE * FROM student 
WHERE dept_name = 'Physics';

-- 5a
CREATE TRIGGER update_instructor
ON instructor i
FOR UPDATE
AS

BEGIN
   SET FEEDBACK OFF;
declare @ni_id int;
declare @oi_id int;
SELECT @ni_id = inserted.ID FROM INSERTED
SELECT @oi_id = deleted.ID FROM deleted
   update advisor SET i.ID = @ni_id
WHERE i.ID = @oi_id
   update teaches set ID = @ni_id
   WHERE ID = @oi_id

END

-- 5b
SELECT CAST(ID AS NUMBER)
FROM instructor
WHERE dept_name = 'Computer Science'
UPDATE instructor
SET CAST(ID = ID + 2 AS VARCHAR2);

-- 6a
create table Delta(
ID VARCHAR2(5),
timestamp DATE,
student_id NUMERIC(4,0),
course_id NUMERIC(4,0),
section_id NUMERIC(4,0),
semester varchar(10),
year NUMERIC(4,0),
old_grade VARCHAR2(1),
new_grade VARCHAR2(1),
primary key(ID)
);

-- 6b
CREATE TRIGGER changes_grade
AFTER UPDATE
ON takes FOR EACH ROW
BEGIN
IF old_grade <> new_grade THEN
INSERT INTO Delta VALUES(SUBSTRING_INDEX(USER(),'@',1),SYSDATE(), old.student_id, old.course_id, old.section_id, old.semester, old.year, old.grade, new.grade);
END IF;
END

-- 6c
UPDATE takes 
SET grade = 'A-'
WHERE ID = 23121
AND course_id = 'FIN-201';

-- 7
-- One way to get all the data from the instructor table is to
-- provide this string:   Computer Science " + "OR" + " 1 = 1
-- and AUTH_CODE string:  2134213 " + "OR" + " 1 = 1
-- Not only do we gain access to the auth_code/dept_name instructors
-- but we also get the rest of the table (OR 1 = 1)
-- Input validation is one way to help prevent these attacks, by
-- blacklisting certain SQL keywords that would allow attacks to change
-- the query. Like in this case^ the keyword "OR" would be blacklisted
-- The JDB programmer could iterate over the rset and check for the
-- blacklisted keywords