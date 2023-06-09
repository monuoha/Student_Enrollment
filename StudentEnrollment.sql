CREATE TABLE IF NOT EXISTS Courses (
	course_code	varchar(64) NOT NULL,
	course_desc	varchar(3000) NOT NULL,
	units	REAL NOT NULL,
	type	varchar(64) NOT NULL,
	PRIMARY KEY(course_code)
);
INSERT INTO Courses VALUES('CS 157A','Introduction to Database Management Systems',3.0,'Lecture');
INSERT INTO Courses VALUES('CS 160','Software Engineering',4.0,'Lecture');
INSERT INTO Courses VALUES('MATH 70','Mathematics for Business',3.0,'Seminar');
INSERT INTO Courses VALUES('MATH 161A','Probability & Statistics I',3.0,'Seminar');

CREATE TABLE IF NOT EXISTS Departments (
	department_name	varchar(64) NOT NULL,
	PRIMARY KEY(department_name)
);
INSERT INTO Departments VALUES('Economics Department');
INSERT INTO Departments VALUES('Mathematics Department');
INSERT INTO Departments VALUES('Computer Science Department');

CREATE TABLE IF NOT EXISTS Title (
	title	varchar(64),
	PRIMARY KEY(title)
);
INSERT INTO Title VALUES('Professor');
INSERT INTO Title VALUES('Associate Professor');
INSERT INTO Title VALUES('Department Chair');

CREATE TABLE IF NOT EXISTS Field (
	specialization	varchar(64),
	PRIMARY KEY(specialization)
);
INSERT INTO Field VALUES('Statistics');
INSERT INTO Field VALUES('Machine Learning');
INSERT INTO Field VALUES('Deep Learning');

CREATE TABLE IF NOT EXISTS Days (
	days	varchar(64) NOT NULL,
	PRIMARY KEY(days)
);
INSERT INTO Days VALUES('Monday');
INSERT INTO Days VALUES('Tuesday');
INSERT INTO Days VALUES('Wednesday');
INSERT INTO Days VALUES('Thursday');
INSERT INTO Days VALUES('Friday');

CREATE TABLE IF NOT EXISTS Semesters (
	semester	varchar(64) NOT NULL,
	PRIMARY KEY(semester)
);
INSERT INTO Semesters VALUES('Fall');
INSERT INTO Semesters VALUES('Spring');
INSERT INTO Semesters VALUES('Summer');
INSERT INTO Semesters VALUES('Winter');

CREATE TABLE IF NOT EXISTS Courses_1 (
	course_code	varchar(64) NOT NULL,
	course_desc	varchar(3000) NOT NULL,
	units	REAL NOT NULL,
	type	varchar(64) NOT NULL,
	PRIMARY KEY(course_code)
);
INSERT INTO Courses_1 VALUES('CS 157A','Introduction to Database Management Systems',3.0,'Lecture');
INSERT INTO Courses_1 VALUES('CS 146','Data Structures & Algorithms',4.0,'Lecture');
INSERT INTO Courses_1 VALUES('MATH 31','Calculus II',4.0,'Seminar');

CREATE TABLE IF NOT EXISTS Student (
	student_id	INTEGER NOT NULL,
	last_name	varchar(60) NOT NULL,
	first_name	varchar(64) NOT NULL,
	street	varchar(64) NOT NULL,
	city	varchar(64) NOT NULL,
	state	varchar(64) NOT NULL,
	zip_code	INTEGER NOT NULL,
	phone	varchar(16) NOT NULL,
	email	varchar(64) NOT NULL,
	PRIMARY KEY(student_id)
);
INSERT INTO Student VALUES(12041809,'Onuoha','Michael','88 E San Carlos St.','San Jose','California',95112,'9253845829','michael.onuoha@sjsu.edu');
INSERT INTO Student VALUES(28430321,'Wong','Nathan','39739 Taylor St.','San Jose','California',95112,'4083920384','nathan.wong@sjsu.edu');
INSERT INTO Student VALUES(92846283,'Alvaraz','Emmanuel','4928 Stevens Creek Blvd.','Cupertino','California',95112,'4152945729','emmanuel.alvaraz@sjsu.edu');



CREATE TABLE IF NOT EXISTS Department_Courses (
	course_code	varchar(64) NOT NULL,
	department_name	varchar(64) NOT NULL,
	PRIMARY KEY(course_code,department_name),
	FOREIGN KEY(department_name) REFERENCES Departments(department_name),
	FOREIGN KEY(course_code) REFERENCES Courses(course_code)
);
INSERT INTO Department_Courses VALUES('CS 157A','Computer Science Department');
INSERT INTO Department_Courses VALUES('CS 160','Computer Science Department');
INSERT INTO Department_Courses VALUES('MATH 70','Mathematics Department');
INSERT INTO Department_Courses VALUES('MATH 161A','Mathematics Department');

CREATE TABLE IF NOT EXISTS Majors (
	major_name	varchar(255) NOT NULL,
	degree_type	varchar(64) NOT NULL,
	min_units	REAL NOT NULL,
	min_gpa	REAL NOT NULL,
	PRIMARY KEY(major_name)
);
INSERT INTO Majors VALUES('Data Science','MS',36.0,3.0);
INSERT INTO Majors VALUES('Software Engineering','BS',120.0,3.0);
INSERT INTO Majors VALUES('Applied Mathematics','BS',120.0,3.0);
INSERT INTO Majors VALUES('Economics','BS',120.0,3.0);

CREATE TABLE IF NOT EXISTS Advisors (
	faculty_member	varchar(64) NOT NULL,
	phone	varchar(64) NOT NULL,
	office	varchar(64) NOT NULL,
	email	varchar(64) NOT NULL,
	department	varchar(64) NOT NULL,
	PRIMARY KEY(faculty_member),
	FOREIGN KEY(department) REFERENCES Departments(department_name)
);
INSERT INTO Advisors VALUES('Guangliang Chen','4089245934','MacQuarrie Hall 417','guangliang.chen@sjsu.edu','Mathematics Department');
INSERT INTO Advisors VALUES('Steven Crunk','4089245104','MacQuarrie Hall 308','steven.crunk@sjsu.edu','Mathematics Department');
INSERT INTO Advisors VALUES('Thomas Austin','4089245045','MacQuarrie Hall 200','thomas.austin@sjsu.edu','Mathematics Department');

CREATE TABLE IF NOT EXISTS Student_Academics (
	student_id	INTEGER NOT NULL,
	remaining_units	REAL NOT NULL,
	degree	varchar(64) NOT NULL,
	gpa	REAL NOT NULL,
	advisor	varchar(64) NOT NULL,
	PRIMARY KEY(student_id),
	FOREIGN KEY(advisor) REFERENCES Advisors(faculty_member),
	FOREIGN KEY(student_id) REFERENCES Student(student_id)
);
INSERT INTO Student_Academics VALUES(12041809,3.0,'Master of Science',3.0750000000000001776,'Guangliang Chen');
INSERT INTO Student_Academics VALUES(28430321,6.0,'Bachelor of Science',3.5,'Thomas Austin');
INSERT INTO Student_Academics VALUES(92846283,3.0,'Bachelor of Science',3.0,'Steven Crunk');


CREATE TABLE IF NOT EXISTS Department_Major (
	major_name	varchar(64) NOT NULL,
	department_name	varchar(64) NOT NULL,
	FOREIGN KEY(department_name) REFERENCES Departments(department_name),
	FOREIGN KEY(major_name) REFERENCES Majors(major_name),
	PRIMARY KEY(major_name,department_name)
);
INSERT INTO Department_Major VALUES('Data Science','Computer Science Department');
INSERT INTO Department_Major VALUES('Data Science','Mathematics Department');
INSERT INTO Department_Major VALUES('Software Engineering','Computer Science Department');
INSERT INTO Department_Major VALUES('Economics','Mathematics Department');
INSERT INTO Department_Major VALUES('Economics','Economics Department');

CREATE TABLE IF NOT EXISTS Major_Course (
	major_name	varchar(64) NOT NULL,
	course_code	varchar(64) NOT NULL,
	FOREIGN KEY(course_code) REFERENCES Courses(course_code),
	FOREIGN KEY(major_name) REFERENCES Majors(major_name),
	PRIMARY KEY(major_name,course_code)
);
INSERT INTO Major_Course VALUES('Data Science','CS 157A');
INSERT INTO Major_Course VALUES('Data Science','MATH 161A');
INSERT INTO Major_Course VALUES('Software Engineering','CS 157A');
INSERT INTO Major_Course VALUES('Software Engineering','CS 160');
INSERT INTO Major_Course VALUES('Economics','MATH 70');
INSERT INTO Major_Course VALUES('Economics','MATH 161A');

CREATE TABLE IF NOT EXISTS Remaining_Courses (
	course_code	varchar(64) NOT NULL,
	student_id	INTEGER NOT NULL,
	PRIMARY KEY(course_code,student_id),
	FOREIGN KEY(student_id) REFERENCES Student_Academics(student_id),
	FOREIGN KEY(course_code) REFERENCES Courses(course_code)
);
INSERT INTO Remaining_Courses VALUES('CS 157A',12041809);
INSERT INTO Remaining_Courses VALUES('CS 157A',28430321);
INSERT INTO Remaining_Courses VALUES('CS 160',28430321);
INSERT INTO Remaining_Courses VALUES('MATH 70',92846283);
INSERT INTO Remaining_Courses VALUES('MATH 161A',92846283);


CREATE TABLE IF NOT EXISTS Student_Major (
	major_name	varchar(255) NOT NULL,
	student_id	INTEGER NOT NULL,
	FOREIGN KEY(student_id) REFERENCES Student_Academics(student_id),
	FOREIGN KEY(major_name) REFERENCES Majors(major_name),
	PRIMARY KEY(major_name,student_id)
);
INSERT INTO Student_Major VALUES('Data Science',12041809);
INSERT INTO Student_Major VALUES('Applied Mathematics',12041809);
INSERT INTO Student_Major VALUES('Software Engineering',28430321);
INSERT INTO Student_Major VALUES('Economics',92846283);
INSERT INTO Student_Major VALUES('Applied Mathematics',92846283);
CREATE TABLE IF NOT EXISTS Course_Section (
	course_code	varchar(64) NOT NULL,
	section_code	INTEGER NOT NULL,
	section	varchar(16) NOT NULL,
	instructor	varchar(64),
	location	varchar(64) NOT NULL,
	capacity	INTEGER NOT NULL,
	start_time	time NOT NULL,
	end_time	time NOT NULL,
	FOREIGN KEY(course_code) REFERENCES Courses(course_code),
	PRIMARY KEY(course_code,section_code)
);
INSERT INTO Course_Section VALUES('CS 157A',93845,'1','Jahan Ghofraniha','Boccardo Business Center 204',100,'13:30:00','14:45:00');
INSERT INTO Course_Section VALUES('CS 157A',19305,'2','Jahan Ghofraniha','Science Building 319',25,'10:30:00','11:45:00');
INSERT INTO Course_Section VALUES('CS 160',93108,'1','Ron Mak','MacQuarrie Hall 204',40,'12:00:00','13:15:00');
INSERT INTO Course_Section VALUES('CS 160',64902,'2','Katrina Pokita','MacQuarrie Hall 224',30,'12:00:00','13:15:00');
INSERT INTO Course_Section VALUES('MATH 70',39452,'5','Michael Onuoha','Science Building 321',35,'15:30:00','16:15:00');
INSERT INTO Course_Section VALUES('MATH 161A',58034,'1','Steven Crunk','MacQuarrie Hall 324',60,'16:30:00','17:45:00');
CREATE TABLE IF NOT EXISTS Course_Semester (
	course_code	varchar(64) NOT NULL,
	semester	varchar(16) NOT NULL,
	FOREIGN KEY(semester) REFERENCES Semesters(semester),
	PRIMARY KEY(course_code,semester),
	FOREIGN KEY(course_code) REFERENCES Courses(course_code)
);
INSERT INTO Course_Semester VALUES('CS 157A','Fall');
INSERT INTO Course_Semester VALUES('CS 157A','Spring');
INSERT INTO Course_Semester VALUES('CS 160','Fall');
INSERT INTO Course_Semester VALUES('CS 160','Spring');
INSERT INTO Course_Semester VALUES('MATH 70','Fall');
INSERT INTO Course_Semester VALUES('MATH 70','Spring');
INSERT INTO Course_Semester VALUES('MATH 161A','Fall');
INSERT INTO Course_Semester VALUES('MATH 161A','Spring');
CREATE TABLE IF NOT EXISTS Prerequisites (
	course_code	varchar(64) NOT NULL,
	prereq_code	varchar(64) NOT NULL,
	FOREIGN KEY(course_code) REFERENCES Courses(course_code),
	PRIMARY KEY(course_code,prereq_code),
	FOREIGN KEY(prereq_code) REFERENCES Courses_1(course_code)
);
INSERT INTO Prerequisites VALUES('CS 157A','CS 146');
INSERT INTO Prerequisites VALUES('CS 160','CS 146');
INSERT INTO Prerequisites VALUES('CS 160','CS 157A');
INSERT INTO Prerequisites VALUES('MATH 70','MATH 31');
INSERT INTO Prerequisites VALUES('MATH 161A','MATH 31');

CREATE TABLE IF NOT EXISTS Course_Days (
	course_code	varchar(64) NOT NULL,
	section_code	INTEGER NOT NULL,
	days	varchar(64) NOT NULL,
	PRIMARY KEY(section_code,days),
	FOREIGN KEY(days) REFERENCES Days(days)
);
INSERT INTO Course_Days VALUES('CS 157A',93845,'Monday');
INSERT INTO Course_Days VALUES('CS 157A',93845,'Wednesday');
INSERT INTO Course_Days VALUES('CS 157A',19305,'Monday');
INSERT INTO Course_Days VALUES('CS 157A',19305,'Wednesday');
INSERT INTO Course_Days VALUES('CS 160',93108,'Tuesday');
INSERT INTO Course_Days VALUES('CS 160',93108,'Thursday');
INSERT INTO Course_Days VALUES('CS 160',64902,'Monday');
INSERT INTO Course_Days VALUES('CS 160',64902,'Wednesday');
INSERT INTO Course_Days VALUES('MATH 70',39452,'Monday');
INSERT INTO Course_Days VALUES('MATH 70',39452,'Wednesday');
INSERT INTO Course_Days VALUES('MATH 161A',58034,'Tuesday');
INSERT INTO Course_Days VALUES('MATH 161A',58034,'Thursday');

CREATE TABLE IF NOT EXISTS Faculty_Field (
	faculty_member	varchar(64) NOT NULL,
	specialization	varchar(64) NOT NULL,
	PRIMARY KEY(faculty_member,specialization),
	FOREIGN KEY(faculty_member) REFERENCES Advisors(faculty_member),
	FOREIGN KEY(specialization) REFERENCES Field(specialization)
);
INSERT INTO Faculty_Field VALUES('Steven Crunk','Statistics');
INSERT INTO Faculty_Field VALUES('Guangliang Chen','Statistics');
INSERT INTO Faculty_Field VALUES('Guangliang Chen','Machine Learning');
INSERT INTO Faculty_Field VALUES('Thomas Austin','Deep Learning');

CREATE TABLE IF NOT EXISTS Advisor_Title (
	faculty_member	varchar(64),
	title	varchar(64),
	PRIMARY KEY(faculty_member,title),
	FOREIGN KEY(faculty_member) REFERENCES Advisors(faculty_member),
	FOREIGN KEY(title) REFERENCES Title(title)
);
INSERT INTO Advisor_Title VALUES('Guangliang Chen','Associate Professor');
INSERT INTO Advisor_Title VALUES('Steven Crunk','Professor');
INSERT INTO Advisor_Title VALUES('Steven Crunk','Department Chair');
INSERT INTO Advisor_Title VALUES('Thomas Austin','Professor');
COMMIT;

