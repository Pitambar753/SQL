USE feb26;
CREATE TABLE CONST_EX(
s_id INT PRIMARY KEY,
s_name varchar(30) NOT NULL
);
SELECT * FROM CONST_EX;

INSERT INTO CONST_EX VALUES(1,'ABC');
INSERT INTO CONST_EX (s_id) VALUES(2);  # Error Code: 1364. Field 's_name' doesn't have a default value
 #-------DROP TABLE CONST_EX;
 
 # -------------------------------- NEW TABLE 1
CREATE TABLE CONST_EX1(
s_id INT PRIMARY KEY  AUTO_INCREMENT,
s_name varchar(30) NOT NULL,
c_name VARCHAR(50) DEFAULT "PGCP -BDA",
c_start_date DATE DEFAULT "2026-02-25",
login_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP   # TIMESTAMP IS DATA TYPES AND CURRENT_ TIME IS GIVE BY default
);

INSERT INTO CONST_EX1(s_name) VALUES('Shubham');
SELECT * FROM const_ex1;


# ------------------------------ NEW TABLE 2
CREATE TABLE CONST_EX2(
s_id INT PRIMARY KEY  AUTO_INCREMENT,
s_name varchar(30) NOT NULL,
c_name VARCHAR(50) DEFAULT "PGCP -BDA",
c_start_date DATE DEFAULT "2026-02-25",
login_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   # TIMESTAMP IS DATA TYPES AND CURRENT_ TIME
mark INT DEFAULT 0,
m_num INT UNIQUE,
email VARCHAR(100) UNIQUE
);

INSERT INTO CONST_EX2(s_name,m_num) VALUES('Shubham',1234);
SELECT * FROM const_ex1;
INSERT INTO CONST_EX2(s_name,m_num) VALUES('RANVEER',1234);


# -----------------------------------NEW TAABLE 3
CREATE TABLE CONST_EX3(
s_id INT PRIMARY KEY  AUTO_INCREMENT,
s_name varchar(30) NOT NULL,
c_name VARCHAR(50) DEFAULT "PGCP -BDA",
c_start_date DATE DEFAULT "2026-02-25",
login_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   # TIMESTAMP IS DATA TYPES AND CURRENT_ TIME
mark INT DEFAULT 0,
m_num INT UNIQUE NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO CONST_EX3(s_name,m_num,email) VALUE ('RANVEER',1234,'A@G.C');
INSERT INTO CONST_EX3(s_name,m_num,email) VALUE ('PITU',1234,'A@G.C');
INSERT INTO CONST_EX3(s_name,email) VALUE ('PITU','A@G.C'); # Error Code: 1364. Field 'm_num' doesn't have a default value
DESC CONST_EX3;
SHOW indexes FROM CONST_EX3;


# ---------------------------- NEW TABLE4 CHECK CONIDITION  USED AGE
CREATE TABLE CONST_EX4(
s_id INT PRIMARY KEY  AUTO_INCREMENT,
s_name varchar(30) NOT NULL,
age INT NOT NULL CHECK(age>21)
);

INSERT INTO CONST_EX4 (s_name, age) VALUES ('pitu',23);
INSERT INTO CONST_EX4 (s_name, age) VALUES('pitu',13); # Error Code: 3819. Check constraint 'const_ex4_chk_1' is violated.
SELECT * FROM CONST_EX4;

# ------------------------------ NEW TABLE 5 CHECK CONDITION USED 
CREATE TABLE CONST_EX(
s_id INT PRIMARY KEY  AUTO_INCREMENT,
s_name varchar(30) NOT NULL,
age INT NOT NULL CHECK(age>21),
gender CHAR(10) CHECK(gender in ('male','female','other'))
);

INSERT INTO CONST_EX(s_name,gender,age) VALUE('PITU','male',23);
SELECT * FROM CONST_EX;
INSERT INTO CONST_EX(s_name,gender,age) VALUE('PITU','NP',23); # Error Code: 3819. Check constraint 'const_ex_chk_2' is violated.


# -------------------------- NEW TABLE 6 CHECK LENGHTH S_NAME GRETER THAN ONE 
CREATE TABLE CONST_EX6(
s_id INT PRIMARY KEY  AUTO_INCREMENT,
s_name varchar(30) NOT NULL,
age INT NOT NULL CHECK(age>21),
gender CHAR(10) CHECK(gender in ('male','female','other')),
CHECK (LENGTH(s_name)>1 AND age>21)
);

INSERT INTO CONST_EX6(s_name,gender,age) VALUE('P','male',23);
INSERT INTO CONST_EX(s_name,gender,age) VALUE('PI','male',23);


# ----------------------------- NEW TABLE 7
CREATE TABLE CONST_EX7(
s_id INT PRIMARY KEY  AUTO_INCREMENT,
s_name varchar(30) NOT NULL,
m_num INT ,
age INT NOT NULL ,
gender CHAR(10) CHECK(gender in ('male','female','other')),
CHECK (LENGTH(s_name)>1 AND age>21),
CHECK(m_num regexp '[0-9]')
);
INSERT INTO CONST_EX7(s_name,gender,age,m_num) VALUE('P','male',23,'JDHSFJJ');  # Error Code: 1366. Incorrect integer value: 'JDHSFJJ' for column 'm_num' at row 1
INSERT INTO CONST_EX7(s_name,gender,age,m_num) VALUE('P','male',23,91726613);   # Error Code: 3819. Check constraint 'const_ex7_chk_2' is violated.
INSERT INTO CONST_EX7(s_name,gender,age,m_num) VALUE('P','male',23,'917266137');

# ------------------------------ NEW TABLE 8
CREATE TABLE CONST_EX8(
s_id INT PRIMARY KEY  AUTO_INCREMENT,
s_name varchar(30) NOT NULL,
address VARCHAR(30),
zip_code INT,
NOT NULL(zip_code, address)
-- PRIMARY KEY(zip_code,address)

);






