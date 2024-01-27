create database mydatabase;
use mydatabase;

CREATE TABLE teacher (/*教师表*/

t_name char(20)   NOT NULL,/*教师名字*/
t_salary_number int(20) NOT NULL unique,/*工资号*/
t_title char(10)check(t_title in('助教', '讲师', '副教授', '教授')) NOT NULL,/*职称*/

PRIMARY KEY (t_name)/*将教师名字设为主键*/
) ;

CREATE TABLE student(/*学生表*/

stu_name char(20) NOT NULL,/*学生名字*/
stu_id int(20) NOT NULL,/*学号*/
stu_major char(20),/*学生专业*/
stu_sex char  check(stu_sex in('男','女'))not null,/*学生性别限制男女两个选择*/

PRIMARY KEY (stu_id)/*将学号设为主键*/
);

CREATE TABLE total_score (/*总的成绩*/

ts_homework decimal(5,2) ,/*平时作业*/
ts_presence decimal(5,2) ,/*签到*/
ts_exam decimal(5,2) ,/*考试*/
ts_project decimal(5,2) ,/*大作业*/
ts_pingshi decimal(5,2) as (0.6*ts_project+0.2*ts_homework+0.2*ts_presence),
/*平时成绩由0.6*大作业+0.2*平时作业+0.2*考勤构成*/
ts_toatal decimal(5,2) as (0.5*ts_exam+0.5*ts_pingshi)stored,
/*总成绩由0.5*考试成绩+0.5*平时成绩构成*/
ts_id int (20) not null, /*学号*/

primary key (ts_id),
foreign key (ts_id) references student(stu_id)
 );
 
 CREATE TABLE course (/*课程表*/

c_id char(50) NOT NULL,/*课程号*/
c_name char(50) not null,/*课程名*/
c_type char(10) check(c_type in('必修课','限选课','任选')) not null ,/*课程类型*/
c_periodx int(20) not null,/*学时X*/
c_periody int(20) not null,/*学时Y*/
c_character char(20) check(c_character in('研究生课程','本科生课程'))  not null ,/*课程性质*/
c_property int (20)  not null,/*学分*/

primary key (c_id)
);

CREATE TABLE exam (/*考试成绩分析*/

e_topic int(20) NOT NULL,/*大题号*/
e_subtopic int(20),/*小题号*/
e_chacters char(50) not null,/*知识点（大纲第几章）*/
e_subtopic_score int(20) not null,/*标准题分*/
e_score int(20) not null,/*平均分*/
e_difficuity char(10) check(e_difficuityin('难' , '较难','适中','易')),/*难度*/
e_property char(12) check(e_property in('综合性题','基本知识题','提高性题')),/*题目性质*/
e_id int(20) not null,/*课程序号*/

foreign key (e_id) references course_implement(ci_serial)
);

CREATE TABLE course_implement (

ci_serial int (11),/*课程序号*/
ci_form char (20),/*课程形式*/
ci_content char (50),/*讲授内容*/
ci_year int(11),/*学年*/
ci_id char(50),/*课程号*/
ti_name char(20),/*教师名字*/

primary key (ci_serial),
foreign key (ci_id) references course(c_id),
foreign key (ti_name) references teacher(t_name)
);

create table learn(

c_id int (50) not null,
ss_id  int (50) not null,

foreign key (ss_id) references student(stu_id),
foreign key (c_id) references course_implement(ci_serial)
);

INSERT INTO teacher ( t_name,t_salary_number, t_title) 
VALUES
('大张三',11001, '助教'),
('大李四',11002, '讲师'),
('大王五',11003,  '副教授'),
('大赵六',11004,  '教授'),
('大钱七',11005,  '助教');

INSERT INTO student(stu_name,stu_id,stu_major,stu_sex) VALUES 
('熊大',100,'信息工程','女'),
('熊二',101,'信息工程','男'),
('张三',102,'计算机科学','男'),
('李四',103,'物联网工程','男'),
('王五',104,'软件工程','女'),
('赵六',105,'数学','男'),
('周七',106,'英语','女');

INSERT INTO total_score (ts_homework, ts_presence, ts_exam, ts_project, ts_id)
VALUES (90, 95, 85, 92, 100),
(80, 100, 90, 88, 101),
(95, 90, 88, 94, 102),
(82, 90, 79, 88, 103),
(81, 88, 90, 88, 104),
(33,23,86,25,105),
(42,98,34,75,106);

INSERT INTO course (c_id, c_name, c_type, c_periodx, c_periody, c_character, c_property)
VALUES 
(1, '数学', '必修课', 48, 0, '本科生课程', 4),
(2, '英语', '必修课', 32, 16, '本科生课程', 2),
(3, '计算机基础', '限选课', 32, 16, '本科生课程', 2),
(4, '马克思主义基本原理', '任选', 32,0, '研究生课程', 2),
(5, '体育', '任选',21, 48, '本科生课程', 2),
(6, '音乐', '限选课',21, 48, '研究生课程', 2),
(7, '舞蹈', '必修课', 21, 32, '本科生课程', 2),
(8, '编程思想', '任选', 32,12, '研究生课程', 2);

insert into exam(e_topic,e_subtopic,e_chacters,e_subtopic_score,e_score,e_difficuity,e_property,e_id) values
(1,1,'1、2、3、9、10',10,5,'适中','基本知识题',1011),
(1,2,'1、2、3',10,4,'较难','综合性题',1011),
(2,1,'2',2,1,'难','提高性题',1011),
(3,1,'1、9、10',10,3,'适中','基本知识题',1011),
(3,2,'1、2、3、4、8',10,9,'易','综合性题',1011),
(4,1,'2',2,1,'适中','提高性题',1011);

INSERT INTO course_implement (ci_serial, ci_form, ci_content, ci_year, ci_id, ti_name) VALUES 
(1011, '讲授', '数学',2022,1,'大张三'),
(1012,'随堂测试','英语', 2021,2,'大王五'),
(1013,'复习课程','计算机基础', 2022,3,'大张三'),
(1014,'线下课','马克思主义基本原理',2023,4,'大王五'),
(1015,'线上课','体育',2022,5,'大赵六');

INSERT INTO learn (c_id,ss_id) VALUES 
(1011,100),(1011, 101),(1011, 102),
(1011, 103),(1011, 104),(1011, 105),(1011,106),
(1012,102),(1012,103),(1012,105),
(1013,103),
(1014,100),(1014,101),(1014,106);

create view teacher_view as 
select t_name,t_title,t_salary_number,
ci_content 
from teacher,course_implement 
where teacher.t_name = course_implement.ti_name;/*建立视图查看老师授课情况*/

CREATE VIEW student_courses_view AS 
SELECT stu_name,ss_id,stu_sex,stu_major,ci_content 
FROM student,course_implement,learn 
where student.stu_id = learn.ss_id  
AND course_implement.ci_serial = learn.c_id;/*建立视图查看学生选课信息*/

create view totalscore_view as 
select stu_name,stu_sex,stu_id,ts_homework,ts_presence,ts_exam,ts_project,ts_pingshi,ts_toatal 
from student,total_score 
where student.stu_id=total_score.ts_id;/*建立视图查看学生成绩信息*/

create view course_view as 
select c_name,c_type,c_periodx,c_periody,c_character,c_property,
ci_year,ci_form 
from course,course_implement 
where course.c_id = course_implement.ci_id;/*建立视图查看课程信息*/

create view exam_view as 
select ci_content,ci_serial,
e_topic,e_subtopic,e_chacters,e_subtopic_score,e_score,e_difficuity,e_property 
from course_implement,exam 
where course_implement.ci_serial = exam.e_id;/*建立视图查看考试成绩分析*/

SELECT COUNT(DISTINCT e_topic) FROM exam_view WHERE ci_content = '数学';/*大题数量*/
SELECT COUNT(e_subtopic) from exam_view where ci_content = '数学';/*小题数*/


select ci_content,ci_serial,
e_topic,e_subtopic,e_chacters,e_subtopic_score,e_score,e_difficuity,e_property ,
((LENGTH(e_chacters) - LENGTH(REPLACE(e_chacters, '、', ' ')))/2 + 1 )/10 AS bili 
from exam_view;/*求知识点覆盖比例*/

SELECT COUNT(e_difficuity)/ (SELECT COUNT(e_difficuity) FROM exam_view where ci_content = '数学')  AS percentage 
FROM exam_view 
WHERE ci_content = '数学' and e_difficuity = '难';/*难题占比*/

SELECT COUNT(e_difficuity)/ (SELECT COUNT(e_difficuity) FROM exam_view where ci_content = '数学')  AS percentage 
FROM exam_view 
WHERE ci_content = '数学' and e_difficuity = '适中';/*适中题占比*/

SELECT COUNT(e_property)/ (SELECT COUNT(e_property) FROM exam_view where ci_content = '数学') * 100 AS percentage 
FROM exam_view 
WHERE ci_content = '数学' and e_property = '基本知识题';/*基本知识题占比*/

SELECT COUNT(e_property)/ (SELECT COUNT(e_property) FROM exam_view where ci_content = '数学') * 100 AS percentage 
FROM exam_view 
WHERE ci_content = '数学' and (e_property = '综合性题' or e_property = '提高性题');/*综合性与提高性题占比*/

SELECT SUM(e_score) / SUM(e_subtopic_score) As percent  
FROM exam_view 
where ci_content = '数学' and e_difficuity = '难';/*做对难题人占比*/

SELECT SUM(e_score) / SUM(e_subtopic_score) As percent  
FROM exam_view 
where ci_content = '数学' and e_property = '基本知识题';/*做对难题人占比*/

SELECT SUM(e_score) / SUM(e_subtopic_score) As percent  
FROM exam_view 
where ci_content = '数学' and e_property = '';/*做对难题人占比*/