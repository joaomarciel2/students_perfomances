-- Criando o banco de dados
CREATE DATABASE study_database;

-- Usando o banco de dados 'study_database'
USE study_database;

-- Criando as tabelas
CREATE TABLE students_infos(
id_student VARCHAR(15) PRIMARY KEY NOT NULL,
parent_involvement VARCHAR(10),
access_to_resource VARCHAR(10),
extracurricular_atv VARCHAR(10),
motivation_level VARCHAR(10),
internet_access VARCHAR(10),
family_income VARCHAR(10),
teacher_quality VARCHAR(10),
peer_influence VARCHAR(20),
learning_disabilites VARCHAR(10),
parental_education VARCHAR(50),
distance_to_school VARCHAR(50),
school_type VARCHAR(50)
);

CREATE TABLE students_data(
id_student VARCHAR(15) PRIMARY KEY NOT NULL,
gender VARCHAR(20),
hours_studied INT,
attendance_percent INT,
sleep_hours INT,
previous_scores INT,
tutoring_sessions INT,
hours_physcial_atv INT,
exam_score INT NOT NULL
);

-- Carregando as infos na tabela 'students_infos'
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/study-infos.csv'
INTO TABLE students_infos
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Carregando as infos na tabela 'students_data'
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/study-data.csv'
INTO TABLE students_data
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT *
FROM students_data;



