USE study_database;

-- Desempenho dos alunos no exame
SELECT 
CASE WHEN 
exam_score < 60 THEN 'F'
WHEN
exam_score < 70 THEN 'D'
WHEN 
exam_score < 80 THEN 'C'
WHEN
exam_score < 90 THEN 'B'
ELSE 'A'
END AS 'notas',
COUNT(id_student) AS 'nmr_students'
FROM students_data
GROUP BY notas;


-- 1. A distância entre a casa e a escola afeta o desempenho dos alunos?
SELECT
CASE WHEN 
I.distance_to_school IS NULL OR I.distance_to_school = '' THEN 'N/A'
ELSE I.distance_to_school
END AS 'distance_to_school',
COUNT(I.id_student) AS 'numbers',
MAX(D.exam_score) AS 'max_final_score',
MIN(D.exam_score) AS 'min_final_score',
AVG(D.exam_score) AS 'avg_final_score'
FROM students_infos I
INNER JOIN students_data D
ON I.id_student = D.id_student
GROUP BY I.distance_to_school
ORDER BY avg_final_score DESC;


-- 2. Há uma diferença significativa no desempenho entre alunos que frequentam escolas públicas e privadas?
SELECT
I.school_type,
COUNT(I.id_student) AS 'students',
AVG(D.exam_score) AS 'avg_final_score'
FROM students_infos I
INNER JOIN students_data D
ON I.id_student = D.id_student
GROUP BY I.school_type
ORDER BY avg_final_score DESC;

-- 3. Estudantes com acesso à internet têm melhor desempenho nas provas?
SELECT
I.internet_access,
COUNT(I.id_student) AS 'nmr_students',
AVG(D.exam_score) AS 'avg_final_score'
FROM students_infos I
INNER JOIN students_data D
ON I.id_student = D.id_student
GROUP BY I.internet_access
ORDER BY avg_final_score DESC;

-- 4. Há uma diferença das notas entre os gêneros?
SELECT
gender,
COUNT(id_student) AS 'nmr_students',
MAX(exam_score) AS 'max_final_score',
MIN(exam_score) AS 'min_final_score',
AVG(exam_score) AS 'avg_final_score'
FROM students_data
GROUP BY gender
ORDER BY avg_final_score DESC;

-- 5. Como o tempo médio de sono afeta a nota final?
SELECT
sleep_hours,
COUNT(sleep_hours) AS 'nmr_students',
AVG(exam_score) AS 'avg_final_score'
FROM students_data
GROUP BY sleep_hours
ORDER BY avg_final_score;

-- E há uma relação entre o tempo de sono com as horas estudadas?
SELECT
sleep_hours,
AVG(hours_studied) AS 'avg_hours_studied'
FROM students_data
GROUP BY sleep_hours;

-- 6. A participação dos pais impacta nas notas dos filhos?
SELECT
I.parent_involvement,
CASE WHEN
	I.parental_education IS NULL OR I.parental_education = '' THEN 'N/A'
	ELSE I.parental_education
END AS parental_education,
AVG(D.previous_scores) AS 'avg_previous_score',
AVG(D.exam_score) AS 'avg_final_score'
FROM students_infos I
INNER JOIN students_data D
ON I.id_student = D.id_student
GROUP BY I.parent_involvement, I.parental_education
ORDER BY avg_final_score DESC;

-- 7. Estudantes com mais horas de estudo têm notas mais altas?
SELECT 
CASE WHEN
hours_studied <= 9 THEN '01-09'
WHEN
hours_studied BETWEEN 10 AND 19 THEN '10-19'
WHEN
hours_studied BETWEEN 20 AND 29 THEN '20-29'
WHEN
hours_studied BETWEEN 30 AND 39 THEN '30-39'
ELSE '40+'
END AS 'hours_studied_students',
AVG(exam_score) AS 'avg_final_score'
FROM students_data
GROUP BY hours_studied_students
ORDER BY avg_final_score DESC;

-- 8. Qual a relação de tempo estudado e o tempo médio de sono?
SELECT 
CASE WHEN
hours_studied <= 9 THEN '09-'
WHEN
hours_studied BETWEEN 10 AND 19 THEN '10-19'
WHEN
hours_studied BETWEEN 20 AND 29 THEN '20-29'
WHEN
hours_studied BETWEEN 30 AND 39 THEN '30-39'
ELSE '40+'
END AS 'hours_studied_students',
AVG(sleep_hours) AS 'avg_sleep_hours'
FROM students_data
GROUP BY hours_studied_students
ORDER BY hours_studied_students DESC;

-- 9. Os alunos melhoraram a sua nota comparada com o primeiro exame realizado?
SELECT
SUM(CASE WHEN previous_scores > exam_score THEN 1 ELSE 0 END) / COUNT(id_student) * 100 AS 'Nota maior no primeiro exame (%)',
SUM(CASE WHEN exam_score > previous_scores THEN 1 ELSE 0 END) / COUNT(id_student) * 100 AS 'Nota maior no último exame (%)',
SUM(CASE WHEN exam_score = previous_scores THEN 1 ELSE 0 END) / COUNT(id_student) * 100 AS 'Nota igual em ambos os exames (%)'
FROM students_data;


-- 10. A qualidade dos professores auxilia na nota do aluno?
SELECT
CASE WHEN 
I.teacher_quality IS NULL OR I.teacher_quality = '' THEN 'N/A'
ELSE I.teacher_quality
END AS 'quality_of_teacher',
CASE WHEN 
D.exam_score < 60 THEN 'F'
WHEN
D.exam_score < 70 THEN 'D'
WHEN 
D.exam_score < 80 THEN 'C'
WHEN
D.exam_score < 90 THEN 'B'
ELSE 'A'
END AS 'notas',
COUNT(I.id_student) AS 'nmr_students'
FROM students_infos I
INNER JOIN students_data D
ON I.id_student = D.id_student
WHERE I.teacher_quality = 'High' -- Alterar para 'Low' para ver os professores de qualidade baixa | 'Medium' para ver os professores de qualidade mediana | 'High' para ver os professores de qualidade alta
GROUP BY quality_of_teacher
ORDER BY notas;

-- 11. O nível de motivação auxilia na nota dos alunos?
SELECT
I.motivation_level,
COUNT(I.id_student) AS 'nmr_students',
AVG(D.exam_score) AS 'avg_final_score'
FROM students_infos I
INNER JOIN students_data D
ON I.id_student = D.id_student
GROUP BY I.motivation_level;

-- 12. Qual a diferença da média de nota de um aluno que possui dificuldade para um que não possui?
SELECT
I.learning_disabilites,
COUNT(I.id_student) AS 'nmr_students',
MAX(D.exam_score) AS 'max_final_score',
MIN(D.exam_score) AS 'min_final_score',
AVG(D.exam_score) AS 'avg_final_score'
FROM students_infos I
INNER JOIN students_data D
ON I.id_student = D.id_student
GROUP BY I.learning_disabilites;

