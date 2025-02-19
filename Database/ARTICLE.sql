DROP DATABASE IF EXISTS CodeCourses;
CREATE DATABASE CodeCourses;

use CodeCourses;


CREATE TABLE _USER
(ID INT NOT NULL AUTO_INCREMENT ,
USERNAME varchar(20) NOT NULL CHECK (LENGTH(USERNAME) >=3),
FNAME varchar(32) NOT NULL CHECK (FNAME NOT LIKE '%[^a-zA-Z]%' AND (LENGTH(FNAME) >=3)),
SNAME varchar(32) NOT NULL CHECK (SNAME NOT LIKE '%[^a-zA-Z]%' AND (LENGTH(SNAME)>=3)),
EMAIL varchar(32) NOT NULL CHECK (EMAIL LIKE '%@%.%'),
JOINDATE DATE DEFAULT NOW(),
ABOUT varchar(50000),
ISADMIN BIT NOT NULL DEFAULT 0,
_PASSWORD varchar(60) NOT NULL,
_IMAGE varchar(400),
PRIMARY KEY(ID),
UNIQUE (USERNAME), 
 UNIQUE (EMAIL)

);
CREATE TABLE STUDENT
(ID INT,
_RANK INT DEFAULT 0,
SCORE INT DEFAULT 0,
PRIMARY KEY (ID),
FOREIGN KEY (ID) REFERENCES _USER(ID)
ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE INSTRUCTOR
( ID INT,
RATING INT DEFAULT 0 CHECK (RATING >= 0 AND RATING <= 10),
PRIMARY KEY (ID),
FOREIGN KEY (ID) REFERENCES _USER(ID)
ON DELETE CASCADE  ON UPDATE CASCADE
);
CREATE TABLE ELEMENT
(ID INT AUTO_INCREMENT,
 CREATIONDATE DATE DEFAULT NOW(),
 TITLE VARCHAR(25) NOT NULL CHECK (length(TITLE)>=2),
 IMAGE varchar(400),
 DESCRIPTION varchar(800) not null CHECK (length(DESCRIPTION)>=20),
 PRIMARY KEY (ID));
CREATE TABLE ARTICLE
( ID INT AUTO_INCREMENT,
  BODY varchar(5000000) NOT NULL CHECK (length(BODY)>=20), 
 INSTRUCTORID INT,
 AUTHORFNAME VARCHAR(32)  CHECK (AUTHORFNAME NOT LIKE '%[^a-zA-Z]%' AND (LENGTH(AUTHORFNAME) >=3)),
 AUTHORSNAME VARCHAR(32)  CHECK (AUTHORSNAME NOT LIKE '%[^a-zA-Z]%' AND (LENGTH(AUTHORSNAME) >=3)),
  PRIMARY KEY(ID),
 FOREIGN KEY(INSTRUCTORID) REFERENCES INSTRUCTOR(ID)
 ON DELETE SET NULL ON UPDATE CASCADE,
 FOREIGN KEY (ID) REFERENCES ELEMENT(ID) 
 ON DELETE CASCADE  ON UPDATE CASCADE);
CREATE TABLE TOPIC 
(ID INT AUTO_INCREMENT,
NAME VARCHAR(30) NOT NULL CHECK (LENGTH(NAME)>=2),
PRIMARY KEY (ID),
UNIQUE(NAME));
CREATE TABLE READARTICLE
(SID INT,
 AID INT,#ARTICLE ID
 PRIMARY KEY(SID,AID),
 FOREIGN KEY (SID) REFERENCES STUDENT(ID)
 ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (AID) REFERENCES ARTICLE(ID)
 ON DELETE CASCADE ON UPDATE CASCADE);
 CREATE TABLE ARTICLE_TOPIC
 (AID INT,#ARTICLE ID
  TID INT,
  PRIMARY KEY (AID,TID),
  FOREIGN KEY (AID) REFERENCES ARTICLE(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (TID) REFERENCES TOPIC(ID) 
  ON DELETE CASCADE ON UPDATE CASCADE
 );
 CREATE TABLE LIKEONARTICLE #USER LIKED AN ARTICLE
 (UID INT,#USER ID
  AID INT,#ARTICLE ID
  PRIMARY KEY(UID,AID),
  FOREIGN KEY (UID) REFERENCES _USER(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (AID) REFERENCES ARTICLE(ID)
   ON UPDATE CASCADE ON DELETE CASCADE);

 CREATE TABLE _COMMENT#WEAK ENTITY
(ID INT AUTO_INCREMENT,
  AID INT ,#ARTICLE ID
  RID INT ,#REPLY ID
  UID INT NOT NULL,#USER ID   
  CREATIONDATENTIME DATETIME DEFAULT NOW(),
  BODY VARCHAR(1000) NOT NULL CHECK (length(BODY)>5),
  PRIMARY KEY (ID,AID),
  FOREIGN KEY (AID) REFERENCES ARTICLE(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (RID) REFERENCES _COMMENT(ID)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (UID) REFERENCES _USER(ID) 
  ON DELETE CASCADE ON UPDATE CASCADE   
 );  
 CREATE TABLE LIKEONCOMMENT #USER LIKED A COMMENT
 (UID INT,#USER ID
  CID INT,#COMMENT ID
  PRIMARY KEY(UID,CID),
  FOREIGN KEY (UID) REFERENCES _USER(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (CID) REFERENCES _COMMENT(ID)
   ON UPDATE CASCADE ON DELETE CASCADE);
 CREATE TABLE COURSE 
 (
  ID INT AUTO_INCREMENT,
  INSTRUCTORID INT,
  INSTRUCTORFNAME VARCHAR(32)  CHECK (INSTRUCTORFNAME NOT LIKE '%[^a-zA-Z]%' AND (LENGTH(INSTRUCTORFNAME) >=3)),
  INSTRUCTORSNAME VARCHAR(32)  CHECK (INSTRUCTORSNAME NOT LIKE '%[^a-zA-Z]%' AND (LENGTH(INSTRUCTORSNAME) >=3)),
  PREREQUISITES VARCHAR(256) DEFAULT NULL,
  FOREIGN KEY (INSTRUCTORID) REFERENCES INSTRUCTOR(ID)
  ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY (ID),
  FOREIGN KEY (ID) REFERENCES ELEMENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE
 );
