drop table prereq;
drop table time_slot;
drop table advisor;
drop table takes;
drop table student;
drop table classroom;
drop table teaches;
drop table section;
drop table instructor;
drop table course;
drop table department;

create table department(
	dept_name varchar (30),
	building varchar (15),
	budget numeric (12,2),
	primary key (dept_name)
);

insert all 
	into department values ('Biology','Watson',90000)
	into department values ('Computer Science','Taylor',100000)
	into department values ('Electrical Engineering','Taylor',85000)
	into department values ('Finance','Painter',120000)
	into department values ('History','Painter',50000)
	into department values ('Music','Packard',80000)
	into department values ('Physics','Watson',70000)	
select * from dual;

create table course (
	course_id varchar (10),
	title varchar (50),
	dept_name varchar (30),
	credits numeric (2,0),
	primary key (course_id),
	foreign key (dept_name) references department
);

insert all 
	into course values ('BIO-101','Introduction to Biology','Biology',4)
	into course values ('BIO-301','Genetics','Biology',4)
	into course values ('BIO-399','Computational Biology','Biology',3)
	into course values ('CS-101','Introduction to Computer Science','Computer Science',4)
	into course values ('CS-190','Game Design','Computer Science',4)
	into course values ('CS-315','Robotics','Computer Science',3)
	into course values ('CS-319','Image Processing','Computer Science',3)
	into course values ('CS-347','Database Systems','Computer Science',3)
	into course values ('EE-181','Introduction to Digital Systems','Electrical Engineering',3)
	into course values ('FIN-201','Investment Banking','Finance',3)
	into course values ('HIS-351','World History','History',3)
	into course values ('MU-199','Music Video Production','Music',3)
	into course values ('PHY-101','Physical Principles','Physics',4)
select * from dual;

select * from course;

create table instructor (
	ID varchar (5),
	name varchar (20) not null,
	dept_name varchar (30),
	salary numeric (8,2),
	primary key (ID),
	foreign key (dept_name) references department
);

insert all
	into instructor values (10101,'Srinivasan','Computer Science',65000)
	into instructor values (12121,'Wu','Finance',90000)
	into instructor values (15151,'Mozart','Music',40000)
	into instructor values (22222,'Einstein','Physics',95000)
	into instructor values (32343,'El Said','History',60000)
	into instructor values (33456,'Gold','Physics',87000)
	into instructor values (45565,'Katz','Computer Science',75000)
	into instructor values (58583,'Califieri','History',62000)
	into instructor values (76543,'Singh','Finance',80000)
	into instructor values (76766,'Crick','Biology',72000)
	into instructor values (83821,'Brandt','Computer Science',92000)
	into instructor values (98345,'Kim','Electrical Engineering',80000)
select * from dual;

create table section (
	course_id varchar (10),
	sec_id varchar (8),
	semester varchar (6),
	year numeric (4,0),
	building varchar (15),
	room_number varchar (8),
	time_slot_id varchar (4),
	primary key (course_id, sec_id, semester, year),
	foreign key (course_id) references course
);

insert all
	into section values ('BIO-101',1,'Summer',2019,'Painter',514,'B')
 	into section values ('BIO-301',1,'Summer',2020,'Painter',514,'A')
	into section values ('CS-101',1,'Fall',2019,'Packard',101,'H')
	into section values ('CS-101',1,'Spring',2020,'Packard',101,'F')
	into section values ('CS-190',1,'Spring',2019,'Taylor',3128,'E')
	into section values ('CS-190',2,'Spring',2019,'Taylor',3128,'A')
	into section values ('CS-315',1,'Spring',2020,'Watson',120,'D')
	into section values ('CS-319',1,'Spring',2020,'Watson',100,'B')
	into section values ('CS-319',2,'Spring',2020,'Taylor',3128,'C')
	into section values ('CS-347',1,'Fall',2019,'Taylor',3128,'A')
	into section values ('EE-181',1,'Spring',2019,'Taylor',3128,'C')
	into section values ('FIN-201',1,'Spring',2020,'Packard',101,'B')
	into section values ('HIS-351',1,'Spring',2020,'Painter',514,'C')
	into section values ('MU-199',1,'Spring',2020,'Packard',101,'D')
	into section values ('PHY-101',1,'Fall',2019,'Watson',100,'A') 
select * from dual;

create table teaches (
	ID varchar (5),
	course_id varchar (10),
	sec_id varchar (8),
	semester varchar (6),
	year numeric (4,0),
	primary key (ID, course_id, sec_id, semester, year),
	foreign key (course_id, sec_id, semester, year) references section,
	foreign key (ID) references instructor 
);

insert all
	into teaches values (10101,'CS-101',1,'Fall',2019)
	into teaches values (10101,'CS-315',1,'Spring',2020)
	into teaches values (10101,'CS-347',1,'Fall',2019)
	into teaches values (12121,'FIN-201',1,'Spring',2020)
	into teaches values (15151,'MU-199',1,'Spring',2020)
	into teaches values (22222,'PHY-101',1,'Fall',2019)
	into teaches values (32343,'HIS-351',1,'Spring',2020)
	into teaches values (45565,'CS-101',1,'Spring',2020)
	into teaches values (45565,'CS-319',1,'Spring',2020)
	into teaches values (76766,'BIO-101',1,'Summer',2019)
	into teaches values (76766,'BIO-301',1,'Summer',2020)
	into teaches values (83821,'CS-190',1,'Spring',2019)
	into teaches values (83821,'CS-190',2,'Spring',2019)
	into teaches values (83821,'CS-319',2,'Spring',2020)
	into teaches values (98345,'EE-181',1,'Spring',2019) 
select * from dual;

create table classroom (
	building varchar(15),
	room_number varchar(7),
	capacity numeric(4,0),
	primary key (building, room_number)
);
insert into classroom values ('Packard', '101', '500');
insert into classroom values ('Painter', '514', '10');
insert into classroom values ('Taylor', '3128', '70');
insert into classroom values ('Watson', '100', '30');
insert into classroom values ('Watson', '120', '50');

create table student(
	ID varchar(5), 
	name varchar(20) not null, 
	dept_name varchar(30), 
	tot_cred numeric(3,0) check (tot_cred >= 0),
	primary key (ID),
	foreign key (dept_name) references department
);

insert into student values ('00128', 'Zhang', 'Computer Science', '102');
insert into student values ('12345', 'Shankar', 'Computer Science', '32');
insert into student values ('19991', 'Brandt', 'History', '80');
insert into student values ('23121', 'Chavez', 'Finance', '110');
insert into student values ('44553', 'Peltier', 'Physics', '56');
insert into student values ('45678', 'Levy', 'Physics', '46');
insert into student values ('54321', 'Williams', 'Computer Science', '54');
insert into student values ('55739', 'Sanchez', 'Music', '38');
insert into student values ('70557', 'Snow', 'Physics', '0');
insert into student values ('76543', 'Brown', 'Computer Science', '58');
insert into student values ('76653', 'Aoi', 'Electrical Engineering', '60');
insert into student values ('98765', 'Bourikas', 'Electrical Engineering', '98');
insert into student values ('98988', 'Tanaka', 'Biology', '120');

create table takes(
	ID varchar(5), 
	course_id varchar(8),
	sec_id varchar(8), 
	semester varchar(6),
	year numeric(4,0),
	grade varchar(2),
	primary key (ID, course_id, sec_id, semester, year),
	foreign key (course_id,sec_id, semester, year) references section,
	foreign key (ID) references student
);

insert into takes values ('00128', 'CS-101', '1', 'Fall', '2019', 'A');
insert into takes values ('00128', 'CS-347', '1', 'Fall', '2019', 'A-');
insert into takes values ('12345', 'CS-101', '1', 'Fall', '2019', 'C');
insert into takes values ('12345', 'CS-190', '2', 'Spring', '2019', 'A');
insert into takes values ('12345', 'CS-315', '1', 'Spring', '2020', 'A');
insert into takes values ('12345', 'CS-347', '1', 'Fall', '2019', 'A');
insert into takes values ('19991', 'HIS-351', '1', 'Spring', '2020', 'B');
insert into takes values ('23121', 'FIN-201', '1', 'Spring', '2020', 'C+');
insert into takes values ('44553', 'PHY-101', '1', 'Fall', '2019', 'B-');
insert into takes values ('45678', 'CS-101', '1', 'Fall', '2019', 'F');
insert into takes values ('45678', 'CS-101', '1', 'Spring', '2020', 'B+');
insert into takes values ('45678', 'CS-319', '1', 'Spring', '2020', 'B');
insert into takes values ('54321', 'CS-101', '1', 'Fall', '2019', 'A-');
insert into takes values ('54321', 'CS-190', '2', 'Spring', '2019', 'B+');
insert into takes values ('55739', 'MU-199', '1', 'Spring', '2020', 'A-');
insert into takes values ('76543', 'CS-101', '1', 'Fall', '2019', 'A');
insert into takes values ('76543', 'CS-319', '2', 'Spring', '2020', 'A');
insert into takes values ('76653', 'EE-181', '1', 'Spring', '2019', 'C');
insert into takes values ('98765', 'CS-101', '1', 'Fall', '2019', 'C-');
insert into takes values ('98765', 'CS-315', '1', 'Spring', '2020', 'B');
insert into takes values ('98988', 'BIO-101', '1', 'Summer', '2019', 'A');
insert into takes values ('98988', 'BIO-301', '1', 'Summer', '2020', null);

create table advisor(
	s_ID varchar(5),
	i_ID varchar(5),
	primary key (s_ID),
	foreign key (i_ID) references instructor (ID),
	foreign key (s_ID) references student (ID)
);

insert into advisor values ('00128', '45565');
insert into advisor values ('12345', '10101');
insert into advisor values ('23121', '76543');
insert into advisor values ('44553', '22222');
insert into advisor values ('45678', '22222');
insert into advisor values ('76543', '45565');
insert into advisor values ('76653', '98345');
insert into advisor values ('98765', '98345');
insert into advisor values ('98988', '76766');

create table time_slot(
	time_slot_id varchar(4),
	day varchar(1),
	start_hr numeric(2),
	start_min numeric(2),
	end_hr numeric(2),
	end_min numeric(2),
	primary key (time_slot_id, day, start_hr, start_min)
);

insert into time_slot values ('A', 'M', '8', '0', '8', '50');
insert into time_slot values ('A', 'W', '8', '0', '8', '50');
insert into time_slot values ('A', 'F', '8', '0', '8', '50');
insert into time_slot values ('B', 'M', '9', '0', '9', '50');
insert into time_slot values ('B', 'W', '9', '0', '9', '50');
insert into time_slot values ('B', 'F', '9', '0', '9', '50');
insert into time_slot values ('C', 'M', '11', '0', '11', '50');
insert into time_slot values ('C', 'W', '11', '0', '11', '50');
insert into time_slot values ('C', 'F', '11', '0', '11', '50');
insert into time_slot values ('D', 'M', '13', '0', '13', '50');
insert into time_slot values ('D', 'W', '13', '0', '13', '50');
insert into time_slot values ('D', 'F', '13', '0', '13', '50');
insert into time_slot values ('E', 'T', '10', '30', '11', '45 ');
insert into time_slot values ('E', 'R', '10', '30', '11', '45 ');
insert into time_slot values ('F', 'T', '14', '30', '15', '45 ');
insert into time_slot values ('F', 'R', '14', '30', '15', '45 ');
insert into time_slot values ('G', 'M', '16', '0', '16', '50');
insert into time_slot values ('G', 'W', '16', '0', '16', '50');
insert into time_slot values ('G', 'F', '16', '0', '16', '50');
insert into time_slot values ('H', 'W', '10', '0', '12', '30');

create table prereq (
	course_id varchar(8), 
	prereq_id varchar(8),
	primary key (course_id, prereq_id),
	foreign key (course_id) references course,
	foreign key (prereq_id) references course
);

insert into prereq values ('BIO-301', 'BIO-101');
insert into prereq values ('BIO-399', 'BIO-101');
insert into prereq values ('CS-190', 'CS-101');
insert into prereq values ('CS-315', 'CS-101');
insert into prereq values ('CS-319', 'CS-101');
insert into prereq values ('CS-347', 'CS-101');
insert into prereq values ('EE-181', 'PHY-101');

