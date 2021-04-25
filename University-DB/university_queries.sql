-- CMPSC 430 - HW5 Solutions

-- Q1:
-- number of classes an instructor has taught
select id, count(*) as num_classes
from teaches
group by id;

-- number of credits
select id, sum(credits) as num_credits
from teaches natural join course
group by id;

-- can combine into one statement
select id, count(*) as num_classes, sum(credits) as num_credits
from teaches natural join course
group by id;

-- Q2:

-- extract the courses of Spring 2020
select course_id, sec_id, semester, year, building, room_number, time_slot_ID 
from section
where semester = 'Spring' and year =2020;

-- extract the courses of Spring 2020, and change the year to 2021
select course_id, sec_id, semester, '2021' as year, building, room_number, time_slot_ID 
from section
where semester = 'Spring' and year = 2020;

-- insert the results to section
insert into section 
(select course_id, sec_id, semester, '2021' as year, building, room_number, time_slot_ID 
from section
where semester = 'Spring' and year =2020);

select * from section;

-- Q3:

-- To add a tuple into teaches relation, we need instructor id, course id, section id, semester, and year.

-- Extract id of Dr. Katz
select ID from instructor where name = 'Katz';

-- Extract the Computer Science classes of Spring 2021
select course_id, sec_id, semester, year from section natural join course
where course.dept_name = 'Computer Science' and semester='Spring' and year=2021;

-- Combine instructor id and classes
select (select ID from instructor where name = 'Katz') as ID,
course_id, sec_id, semester, year from section natural join course
where course.dept_name = 'Computer Science' and semester='Spring' and year=2021;

-- insert these results into teaches relation
insert into teaches
(select (select ID from instructor where name = 'Katz') as ID,
course_id, sec_id, semester, year from section natural join course
where course.dept_name = 'Computer Science' and semester='Spring' and year=2021);
--and (course_id, sec_id, semester, year) not in 
--(select course_id, sec_id, semester, year from teaches) ;

-- Q4:
-- To add a tuple into takes relation, we need student id, course id, section id, semester, and year (grade is null in this case).

-- Extract CS students who have not taken CS-347
select ID from student where dept_name = 'Computer Science'
minus
select ID from takes
where course_id = 'CS-347';

-- Adding other information
select ID, 'CS-347' as course_id, 1 as sec_id, 'Spring' as semester, '2021' as year, null as grade
from
(select ID from student where dept_name = 'Computer Science'
minus
select ID from takes where course_id = 'CS-347');

-- Insert these results into takes relation

-- Q5: 

-- Extract the classes that nobody enrolled or assigned to teaches

select distinct course_id, sec_id, semester, year from section
minus (
select distinct course_id, sec_id, semester, year from takes
union
select distinct course_id, sec_id, semester, year from teaches);


-- Delete those clases
delete from section
where (course_id, sec_id, semester, year) in
(select distinct course_id, sec_id, semester, year from section
minus (
select distinct course_id, sec_id, semester, year from takes
union
select distinct course_id, sec_id, semester, year from teaches));


-- Q6: 

-- Insert new tuples to section with sec_id += 1000, 2000, 3000
insert into section
	(select course_id, 
		  cast(sec_id as integer) + 1000*(year-2018) as sec_id, 
		  semester, year, building, room_number, time_slot_id
	from section
	where semester = 'Spring');

-- Change sec_id in takes and teaches relations
update takes
set sec_id = 
case 
   when semester = 'Spring' then cast(sec_id as integer) + 1000*(year - 2018)
   else cast(sec_id as integer)
end;

-- Delete tuples with old sec_id in section
delete from section
where semester = 'Spring' and sec_id in (1,2,3);




