-- Author: Lindokuhle Nkosi
-- Student Number: EDUV10933182
-- Date: 17/03/2026
-- Module: Database Management (MySQL)
-- Module Code: ITMDAO
-- Purpose: Coding Bootcamp Platform Database
-- ER Diagram attached separately as ER_Diagram.png

DROP DATABASE IF EXISTS Edu_Bootcamp_Project;
CREATE DATABASE Edu_Bootcamp_Project;
USE Edu_Bootcamp_Project;
 
-- Create learners table
CREATE TABLE learners (
    learner_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    account_status ENUM('Active','Blocked') DEFAULT 'Active',
    subscription_expiry DATE NOT NULL,
    storage_limit INT NOT NULL CHECK (storage_limit > 0),
    id_number CHAR(13) UNIQUE NOT NULL
);
 
-- Create mentors table
CREATE TABLE mentors (
    mentor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    specialization VARCHAR(100)
);
 
-- Create bootcamps table
CREATE TABLE bootcamps (
    bootcamp_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    level ENUM('Beginner','Intermediate','Advanced'),
    capacity INT CHECK (capacity > 0),
    mentor_id INT,
    bootcamp_code VARCHAR(10) UNIQUE,
    FOREIGN KEY (mentor_id) REFERENCES mentors(mentor_id)
);
 
-- Create enrollments table
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    learner_id INT,
    bootcamp_id INT,
    UNIQUE (learner_id, bootcamp_id),
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
    FOREIGN KEY (bootcamp_id) REFERENCES bootcamps(bootcamp_id)
);
 
-- Create modules table
CREATE TABLE modules (
    module_id INT AUTO_INCREMENT PRIMARY KEY,
    bootcamp_id INT,
    title VARCHAR(100),
    module_code VARCHAR(20) UNIQUE,
    FOREIGN KEY (bootcamp_id) REFERENCES bootcamps(bootcamp_id)
);
 
-- Create progress table
CREATE TABLE progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    learner_id INT,
    module_id INT,
    status ENUM('Not Started','In Progress','Completed'),
    progress_percent INT CHECK (progress_percent BETWEEN 0 AND 100),
    skill_points INT DEFAULT 0,
    UNIQUE (learner_id, module_id),
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);
 
-- Create assessments table
CREATE TABLE assessments (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    bootcamp_id INT,
    title VARCHAR(100),
    assessment_code VARCHAR(20) UNIQUE,
    FOREIGN KEY (bootcamp_id) REFERENCES bootcamps(bootcamp_id)
);
 
-- Create results table
CREATE TABLE results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    learner_id INT,
    assessment_id INT,
    marks INT CHECK (marks BETWEEN 0 AND 100),
    skill_score INT,
    result_status ENUM('Pass','Fail'),
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
    FOREIGN KEY (assessment_id) REFERENCES assessments(assessment_id)
);
 
-- Create resources table
CREATE TABLE resources (
    resource_id INT AUTO_INCREMENT PRIMARY KEY,
    learner_id INT,
    type VARCHAR(50),
    size_mb INT CHECK (size_mb > 0),
    downloads INT DEFAULT 0,
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id)
);
 
 -- Create error_logs table
CREATE TABLE error_logs (
    error_id INT AUTO_INCREMENT PRIMARY KEY,
    learner_id INT,
    category VARCHAR(50),
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id)
);
 
 -- Insert into learners table
INSERT INTO learners (username, password, account_status, subscription_expiry, storage_limit, id_number)
	VALUES
		('Lindokuhle141','pass141','Active','2026-12-01',500,'0102115495081'),
		('Kai045','pass045','Blocked','2025-01-01',500,'6404050534081'),
		('Sharleen244','pass244','Active','2026-05-01',500,'0202115647789'),
		('Linamizulu166','pass166','Blocked','2024-12-01',500,'5487965471235'),
		('Mboshozi212','pass212','Blocked','2025-06-30',500,'0112547896325'),
        ('Lisa444','pass444','Active','2026-04-01',500,'0102115495456'),
		('Nathi475','pass475','Blocked','2016-01-01',500,'5502050534081'),
		('George045','pass045','Blocked','2020-05-01',500,'0002115647789'),
		('Linami001','pass001','Blocked','2024-11-01',500,'5587965471235'),
		('Wilson149','pass149','Blocked','2025-09-30',500,'7412547896325'),
        ('Lindo123','pass123','Blocked','2014-12-01',500,'9005115495081'),
		('Kaizer029','pass029','Active','2027-01-01',500,'7904050534081'),
		('Shasha789','pass789','Active','2026-05-01',500,'0404115647789'),
		('Zulu167','pass167','Active','2026-12-31',500,'5987965471235'),
		('December011','pass011','Blocked','2023-06-30',500,'0512547896325'),
        ('Lindo456','pass456','Active','2026-05-01',500,'0102225495081'),
		('Steve252','pass252','Active','2029-11-05',500,'7704050534081'),
		('Leen231','pass231','Blocked','2024-05-11',500,'0602115647789'),
		('Lina741','pass741','Active','2028-12-01',500,'9787965471235'),
		('Thendo252','pass252','Blocked','2026-03-23',500,'9903547896325'),
        ('Khensani396','pass396','Active','2026-12-01',500,'0802115495081'),
		('Kailethu753','pass753','Blocked','2018-01-01',500,'6004050534081'),
		('Messi031','pass031','Active','2027-05-01',500,'8502115647789'),
		('Chelsea037','pass037','Active','2026-12-01',500,'8887965471235'),
		('Nkosi518','pass518','Active','2027-06-30',500,'0902547896325');

-- Insert into mentors table
INSERT INTO mentors (name, email, specialization)
	VALUES
		('Alice','alice@edu.com','Web'),
		('Chris','chris@edu.com','Data Science'),
		('Asa','mukhwaa@edu.com','Mobile');

-- Insert into bootcamps table
INSERT INTO bootcamps (title, category, level, capacity, mentor_id, bootcamp_code)
	VALUES
		('Full Stack Web Dev','Web','Beginner',7,1, 'WEB001'),
		('Data Science Bootcamp','Data Science','Intermediate',7,2, 'DS002'),
		('Mobile App Development','Mobile','Beginner',7,3, 'MOB003'),
		('Advanced Java Programming','Web','Advanced',7,1, 'JAVA004'),
		('Python','Data Science','Advanced',7,2, 'Py005'),
        ('Data Analysis','Data Science','Beginner',7,3, 'DA002'),
		('CSS','Web','Beginner',7,1, 'CSS001'),
		('HTML','Data Science','Beginner',7,2, 'HTML001');
 
 -- Insert into enrollments table
INSERT INTO enrollments (learner_id, bootcamp_id)
	VALUES
		-- There is 8 Bootcamps, with the maximum of 7 learners each
		(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),
		(8,2),(9,2),(10,2),(11,2),(12,2),(13,2),(14,2),
		(15,3),(16,3),(17,3),(18,3),(19,3),(20,3),(21,3),
		(22,4),(23,4),(24,4),(25,4),(1,4),(2,4),
		(3,5),(4,5),(5,5),(6,5),(7,5),(8,5),
		(9,6),(10,6),(11,6),(12,6),(13,6),
		(14,7),(15,7),(16,7),(17,7),(18,7),
		(19,8),(20,8),(21,8),(22,8),(23,8);
 
 -- Insert into modules table
INSERT INTO modules (bootcamp_id, title, module_code)
	VALUES
		(1,'HTML Basics','HTML001'),
		(1,'CSS Fundamentals','CSS001'),
		(1,'JavaScript Intro','JS001'),

		(2,'Python Basics','PY001'),
		(2,'Data Analysis','DA002'),

		(3,'Android Studio Setup','AND001'),
		(3,'UI Design','UI002'),

		(4,'OOP in Java','JAVA001'),
		(4,'Advanced Threads','JAVA002'),

		(5,'Machine Learning','ML001'),
		(5,'Neural Networks','NN002');
 
 -- Insert into progress table
INSERT INTO progress (learner_id, module_id, status, progress_percent, skill_points)
	VALUES
		(1,1,'Completed',100,50),
		(2,1,'In Progress',60,20),
		(3,2,'Not Started',0,0),
		(4,4,'Completed',100,60),
		(5,6,'In Progress',50,25),
		(6,2,'Completed',100,50),
		(7,3,'In Progress',40,15),
		(8,5,'Completed',100,55),
		(9,6,'In Progress',70,30),
		(10,7,'Not Started',0,0),
		(11,1,'Completed',100,50),
		(12,2,'Completed',100,45),
		(13,3,'In Progress',60,25),
		(14,4,'Completed',100,60),
		(15,5,'In Progress',50,20),
		(16,6,'Completed',100,55),
		(17,7,'In Progress',30,10),
		(18,8,'Not Started',0,0),
		(19,1,'Completed',100,50),
		(20,2,'Completed',100,40),
		(21,3,'In Progress',65,30),
		(22,4,'Completed',100,60),
		(23,5,'In Progress',45,20),
		(24,6,'Completed',100,55),
		(25,7,'In Progress',55,25);
 
 -- Insert into Assessment table
INSERT INTO assessments (bootcamp_id, title, assessment_code)
	VALUES
		(1,'HTML Quiz','HTML-TEST-01'),
		(1,'CSS Project','CSS-PROJ-01'),
		(2,'Python Test','PY-TEST-01'),
		(3,'Mobile App Project','MOB-PROJ-01'),
		(5,'Database Final Exam','DATABASE-EXAM-01');
 
 -- Insert into results table
INSERT INTO results (learner_id, assessment_id, marks, skill_score)
	VALUES
		(1,1,85,40),
		(1,2,90,50),
		(2,1,70,30),
		(4,3,88,45),
		(5,4,60,25),
		(1,5,95,60),
        (6,1,55,25),
		(7,2,45,20),
		(8,3,75,35),
        (9,1,65,30),
		(10,2,50,25),
		(11,3,90,50),
		(12,4,80,40),
		(13,5,77,38),
		(14,1,68,32),
		(15,2,49,20),
		(16,3,92,50),
		(17,4,58,25),
		(18,5,61,30),
		(19,1,73,35),
		(20,2,88,45),
		(21,3,67,30),
		(22,4,95,60),
		(23,5,52,25),
		(24,1,84,40),
		(25,2,47,20);
 
 -- Insert into resources table
INSERT INTO resources (learner_id, type, size_mb, downloads)
	VALUES
		(1,'PDF',50,10),
		(1,'Video',200,25),
		(2,'Slides',30,5),
		(3,'Code Sample',20,8),
		(4,'Video',150,12),
		(5,'Video',150,12),
		(6,'PDF',40,7),
		(7,'Video',100,20),
		(8,'Slides',25,6),
		(9,'PDF',60,9),
		(10,'Video',180,30),
		(11,'Code Sample',15,4),
		(12,'PDF',55,11),
		(13,'Slides',35,7),
		(14,'Video',140,18),
		(15,'PDF',45,10),
		(16,'Video',160,22),
		(17,'Slides',20,5),
		(18,'Code Sample',25,6),
		(19,'PDF',50,9),
		(20,'Video',200,28),
		(21,'Slides',30,8),
		(22,'PDF',60,12),
		(23,'Video',170,24),
		(24,'Code Sample',22,6),
		(25,'PDF',48,9);
 
 -- Insert into error_logs table
INSERT INTO error_logs (learner_id, category, message)
	VALUES
		(1,'Payment Error','Subscription failed'),
		(2,'Login Failure','Incorrect password'),
		(3,'Submission Error','Code failed to compile'),
		(4,'System Error','Timeout occurred'),
		(5,'Validation Error','Invalid input'),
		(6,'Payment Error','Card declined'),
		(7,'Login Failure','Account locked'),
		(8,'Submission Error','Missing files'),
		(9,'System Error','Server unavailable'),
		(10,'Validation Error','Wrong format'),
		(11,'Payment Error','Transaction failed'),
		(12,'Login Failure','Too many attempts'),
		(13,'Submission Error','Syntax error'),
		(14,'System Error','Connection lost'),
		(15,'Validation Error','Empty fields'),
		(16,'Payment Error','Expired card'),
		(17,'Login Failure','User not found'),
		(18,'Submission Error','Runtime error'),
		(19,'System Error','Memory overflow'),
		(20,'Validation Error','Incorrect data'),
		(21,'Payment Error','Insufficient funds'),
		(22,'Login Failure','Session expired'),
		(23,'Submission Error','File corrupted'),
		(24,'System Error','Database crash'),
		(25,'Validation Error','Out of range');
 
 -- CREATE VIEWS
 
CREATE VIEW vwBlockedLearners AS
    SELECT * FROM learners
    WHERE subscription_expiry < curdate();

CREATE VIEW vwTopCoders AS
	SELECT learner_id, SUM(skill_score) AS total_score
	FROM results
	GROUP BY learner_id
	ORDER BY total_score DESC
	LIMIT 20;

CREATE VIEW vwMostDownloadedResources AS
	SELECT * FROM resources
	ORDER BY downloads DESC
	LIMIT 20;

CREATE VIEW vwPopularBootcamps AS
    SELECT 
        b.title, COUNT(e.enrollment_id) AS total_enrollments
    FROM
        bootcamps b
	JOIN
        enrollments e ON b.bootcamp_id = e.bootcamp_id
    GROUP BY b.bootcamp_id
    ORDER BY total_enrollments DESC
    LIMIT 5;
 
 -- STORED PROCEDURES
DELIMITER //

-- Procedure to register learners
CREATE PROCEDURE spRegisterLearner(
	IN p_username VARCHAR(50),
	IN p_password VARCHAR(100),
	IN p_expiry DATE,
	IN p_storage INT,
	IN p_id VARCHAR(13)
)
BEGIN
	IF EXISTS (SELECT 1 FROM learners WHERE username = p_username) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Username exists';
	ELSE
		INSERT INTO learners(username,password,subscription_expiry,storage_limit,id_number)
		VALUES(p_username,p_password,p_expiry,p_storage,p_id);
	END IF;
END //

-- Procedure to renew subscription
CREATE PROCEDURE spRenewSubscription(
	IN p_learner INT,
	IN p_days INT
)
BEGIN
	UPDATE learners
		SET subscription_expiry = date_add(subscription_expiry, INTERVAL p_days DAY),
		account_status = 'Active'
	WHERE learner_id = p_learner;
END //

-- Procedure to enroll learners
CREATE PROCEDURE spEnrollLearner(
	IN p_learner INT,
	IN p_bootcamp INT
)
BEGIN
	DECLARE total INT;
	DECLARE max_cap INT;

	SELECT COUNT(*) INTO total FROM enrollments WHERE bootcamp_id = p_bootcamp;
	SELECT capacity INTO max_cap FROM bootcamps WHERE bootcamp_id = p_bootcamp;

	IF total >= max_cap THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Bootcamp Full';
	ELSE
		INSERT INTO enrollments(learner_id,bootcamp_id)
		VALUES(p_learner,p_bootcamp);
		END IF;
END //

-- Procedure to add resources
CREATE PROCEDURE spAddResource(
	IN p_learner INT,
	IN p_type VARCHAR(50),
	IN p_size INT
)
BEGIN
	DECLARE used INT;
	DECLARE max_limit INT;

	SELECT IFNULL(SUM(size_mb),0) INTO used FROM resources WHERE learner_id = p_learner;
	SELECT storage_limit INTO max_limit FROM learners WHERE learner_id = p_learner;

	IF used + p_size > max_limit THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Storage exceeded';
	ELSE
		INSERT INTO resources(learner_id,type,size_mb)
		VALUES(p_learner,p_type,p_size);
	END IF;
END //

-- Procedure to send notices
CREATE PROCEDURE spSendNotice()
BEGIN
	SELECT learner_id, username,
		DATEDIFF(subscription_expiry, CURDATE()) AS days_left
		FROM learners;
END //

DELIMITER ;
 
 -- TRIGGERS
DELIMITER //

-- Trigger to block expired users
CREATE TRIGGER trg_block_expired
	BEFORE UPDATE ON learners
	FOR EACH ROW
    
	BEGIN
		IF NEW.subscription_expiry < CURDATE() THEN
			SET NEW.account_status = 'Blocked';
	END IF;
END //

-- Trigger to log enrollment
CREATE TRIGGER trg_log_enrollment
	AFTER INSERT ON enrollments
	FOR EACH ROW
    
	BEGIN
		INSERT INTO error_logs(learner_id,category,message)
		VALUES(NEW.learner_id,'INFO','Enrolled successfully');
END //

DELIMITER ;

DELIMITER //

-- Trigger to set result status
CREATE TRIGGER trg_result_status
	BEFORE INSERT ON results
	FOR EACH ROW
BEGIN
   IF NEW.marks >= 50 THEN
       SET NEW.result_status = 'Pass';
   ELSE
       SET NEW.result_status = 'Fail';
   END IF;
END //

DELIMITER ;
 
DELIMITER //

-- Trigger to block on insert
CREATE TRIGGER trg_block_on_insert
	BEFORE INSERT ON learners
	FOR EACH ROW
BEGIN
	IF NEW.subscription_expiry < CURDATE() THEN
		SET NEW.account_status = 'Blocked';
	END IF;
END //
DELIMITER ;
 
 -- Index for fast username search
CREATE INDEX idx_learners_username ON learners(username);
-- Index for bootcamp lookup
CREATE INDEX idx_bootcamp_code ON bootcamps(bootcamp_code);
-- Index for enrollment joins
CREATE INDEX idx_enrollments_lookup ON enrollments(learner_id, bootcamp_id);
