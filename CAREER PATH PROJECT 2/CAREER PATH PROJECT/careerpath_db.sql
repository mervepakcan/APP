-- CREATE DATABASE career_guidance_db;
USE career_guidance_db;

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(200),
    Email VARCHAR(200),
    Password VARCHAR(100),
    UserRole VARCHAR(50),
    UserStatus VARCHAR(50)
);

CREATE TABLE Admins (
    ID INT PRIMARY KEY,
    AdminID INT,
    AdminUserID INT,
    AdminRoles VARCHAR(100),
    FOREIGN KEY (AdminUserID) REFERENCES Users(UserID)
);

CREATE TABLE Profiles (
    ProfileID INT PRIMARY KEY,
    UserID INT,
    Name VARCHAR(200),
    Surname VARCHAR(200),
    Education TEXT,
    Experience TEXT,
    Interests TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Skills (
    SkillID INT AUTO_INCREMENT PRIMARY KEY,
    SkillName VARCHAR(100),
    Description TEXT
);

CREATE TABLE UserSkills (
    UserSkillID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    SkillID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID)
);

CREATE TABLE CareerRoles (
    RoleID INT AUTO_INCREMENT PRIMARY KEY,
    RoleName VARCHAR(100),
    Description TEXT
);

CREATE TABLE RoleSkills (
    RoleSkillID INT AUTO_INCREMENT PRIMARY KEY,
    SkillID INT,
    RoleID INT,
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID),
    FOREIGN KEY (RoleID) REFERENCES CareerRoles(RoleID)
);

CREATE TABLE LearningRoadmap (
    LearningRoadmapID INT AUTO_INCREMENT PRIMARY KEY,
    RoleID INT,
    Description TEXT,
    FOREIGN KEY (RoleID) REFERENCES CareerRoles(RoleID)
);

CREATE TABLE UserRoadmap (
    UserRoadmapID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    RoleID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES CareerRoles(RoleID)
);

INSERT INTO Users (Username, Email, Password, UserRole, UserStatus) VALUES
('user1','u1@mail.com','p1','User','Active'),
('user2','u2@mail.com','p2','User','Active'),
('user3','u3@mail.com','p3','User','Active'),
('user4','u4@mail.com','p4','User','Active'),
('user5','u5@mail.com','p5','User','Active'),
('user6','u6@mail.com','p6','User','Active'),
('user7','u7@mail.com','p7','User','Inactive'),
('user8','u8@mail.com','p8','User','Active'),
('user9','u9@mail.com','p9','User','Active'),
('user10','u10@mail.com','p10','User','Active');

INSERT INTO Admins (ID, AdminID, AdminUserID, AdminRoles) VALUES
(1,1,3,'Main Admin'),
(2,1,7,'Main Admin'),
(3,1,5,'Main Admin'),
(4,1,5,'Main Admin'),
(5,1,2,'Main Admin'),
(6,2,4,'Secondary Admin'),
(7,2,8,'Secondary Admin'),
(8,2,6,'Secondary Admin'),
(9,2,10,'Secondary Admin'),
(10,2,9,'Secondary Admin');

INSERT INTO Profiles VALUES
(1,1,'John','Doe','CS','1 year','AI'),
(2,1,'John','Doe','CS','2 years','ML'),
(3,2,'Jane','Smith','IT','1 year','Web'),
(4,2,'Jane','Smith','IT','2 years','UX'),
(5,3,'Mike','Brown','CS','3 years','Data'),
(6,4,'Anna','Taylor','Engineering','2 years','Cloud'),
(7,4,'Anna','Taylor','Engineering','3 years','DevOps'),
(8,5,'Paul','White','CS','1 year','Security'),
(9,6,'Laura','Green','IT','2 years','Automation'),
(10,6,'Laura','Green','IT','3 years','Cloud'),
(11,7,'Tom','Black','CS','4 years','AI'),
(12,8,'Emma','Stone','Engineering','1 year','Design'),
(13,9,'Chris','Hall','CS','2 years','Backend'),
(14,9,'Chris','Hall','CS','3 years','Databases'),
(15,10,'Sara','King','IT','3 years','Mobile'),
(16,10,'Sara','King','IT','4 years','Android'),
(17,3,'Mike','Brown','CS','5 years','Big Data');

INSERT INTO Skills (SkillName, Description) VALUES
('Python','Programming'),
('Java','Programming'),
('SQL','Databases'),
('HTML','Web'),
('CSS','Web'),
('JavaScript','Web'),
('Docker','Containers'),
('AWS','Cloud'),
('Machine Learning','AI'),
('Data Analysis','Data'),
('Cybersecurity','Security'),
('Git','Version Control');

INSERT INTO UserSkills (UserID, SkillID) VALUES
(1,1),(1,3),(1,9),
(2,4),(2,5),
(3,1),(3,10),(3,3),
(4,8),(4,7),
(5,11),(5,3),
(6,7),(6,8),(6,12),
(7,1),(7,9),(7,10),
(8,4),(8,5),
(9,2),(9,3),
(10,1),(10,6),(10,12);


INSERT INTO RoleSkills (SkillID, RoleID) VALUES
(1,1),(2,1),(3,1),(12,1),
(4,2),(5,2),(6,2),(12,2),
(1,3),(9,3),(10,3),(3,3),(12,3),
(7,4),(8,4),(3,4),
(7,5),(8,5),(12,5),(3,5),
(11,6),(3,6),(12,6),
(1,7),(6,7),(12,7);

INSERT INTO LearningRoadmap (RoleID, Description) VALUES
(1,'Core Programming'),
(1,'Advanced OOP'),
(2,'HTML & CSS'),
(2,'JavaScript'),
(2,'Backend APIs'),
(3,'Statistics'),
(3,'Machine Learning'),
(3,'Big Data'),
(4,'AWS Basics'),
(4,'Cloud Architecture'),
(5,'CI/CD'),
(5,'Automation'),
(6,'Network Security'),
(6,'Threat Analysis'),
(7,'Mobile UI/UX');

INSERT INTO UserRoadmap (UserID, RoleID) VALUES
(1,1),(1,3),
(2,2),(2,1),(2,3),
(3,3),(3,1),
(4,4),(4,5),
(5,6),(5,4),
(6,5),(6,4),(6,1),
(7,3),(7,6),
(8,2),(8,7),(8,3),
(9,1),(9,5),
(10,7),(10,2),(10,3),(10,1);

USE career_guidance_db;

INSERT INTO Profiles VALUES
(1,1,'John','Doe','CS','1 year','AI'),
(2,1,'John','Doe','CS','2 years','ML'),
(3,2,'Jane','Smith','IT','1 year','Web'),
(4,2,'Jane','Smith','IT','2 years','UX'),
(5,3,'Mike','Brown','CS','3 years','Data'),
(6,4,'Anna','Taylor','Engineering','2 years','Cloud'),
(7,4,'Anna','Taylor','Engineering','3 years','DevOps'),
(8,5,'Paul','White','CS','1 year','Security'),
(9,6,'Laura','Green','IT','2 years','Automation'),
(10,6,'Laura','Green','IT','3 years','Cloud'),
(11,7,'Tom','Black','CS','4 years','AI'),
(12,8,'Emma','Stone','Engineering','1 year','Design'),
(13,9,'Chris','Hall','CS','2 years','Backend'),
(14,9,'Chris','Hall','CS','3 years','Databases'),
(15,10,'Sara','King','IT','3 years','Mobile'),
(16,10,'Sara','King','IT','4 years','Android'),
(17,3,'Mike','Brown','CS','5 years','Big Data');


USE career_guidance_db;

INSERT INTO CareerRoles (RoleName, Description) VALUES
('Software Developer','General'),
('Web Developer','Web apps'),
('Data Scientist','ML & Data'),
('Cloud Engineer','Cloud infra'),
('DevOps Engineer','CI/CD'),
('Cybersecurity Analyst','Security'),
('Mobile Developer','Mobile apps');

SELECT RoleID, RoleName FROM CareerRoles;

INSERT INTO UserRoadmap (UserID, RoleID) VALUES
(1,1),(1,3),
(2,2),(2,1),(2,3),
(3,3),(3,1),
(4,4),(4,5),
(5,6),(5,4),
(6,5),(6,4),(6,1),
(7,3),(7,6),
(8,2),(8,7),(8,3),
(9,1),(9,5),
(10,7),(10,2),(10,3),(10,1);


USE career_guidance_db;

SELECT * FROM Users;
SELECT * FROM Admins;
SELECT * FROM Profiles;
SELECT * FROM UserRoadmap;


