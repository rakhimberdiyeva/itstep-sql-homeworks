CREATE TABLE students(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fullname VARCHAR(512) NOT NULL,
	birth_date DATE,
	email VARCHAR(100)
);

CREATE TABLE courses(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	title VARCHAR(512) NOT NULL,
	description TEXT
);

CREATE TABLE enrollments(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	student_id BIGINT REFERENCES students(id) ON DELETE CASCADE,
	course_id BIGINT REFERENCES courses(id) ON DELETE CASCADE,
	enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--------------------------------------------------------------------------------------

INSERT INTO students(fullname, birth_date, email)
VALUES
('monica', '03-02-2001', 'monikag'),
('bree', '14-01-2004', 'breevk'),
('gabi', '25-07-2007', 'gabrielle');


INSERT INTO courses(title, description)
VALUES
('english', 'advanced english'),
('biology', 'biology for beginners');


INSERT INTO enrollments(student_id, course_id)
VALUES
(3 , 1);

--------------------------------------------------------------------------------------
UPDATE students
SET email = 'monicag'
WHERE id = 1;

DELETE FROM students
WHERE id = 2;
--------------------------------------------------------------------------------------
SELECT 
	s.fullname,
	c.title,
	e.enrolled_at
FROM enrollments e
INNER JOIN students s ON s.id = e.student_id
INNER JOIN courses c ON c.id = e.course_id;
--------------------------------------------------------------------------------------
SELECT 
	s.fullname
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
WHERE e.id IS NULL;
--------------------------------------------------------------------------------------
SELECT 
	c.title,
	COUNT(e.id)
FROM enrollments e
FULL JOIN courses c ON c.id = e.course_id
GROUP BY c.title;
--------------------------------------------------------------------------------------
SELECT 
	e.enrolled_at,
	COUNT(s.id)
FROM enrollments e
INNER JOIN students s ON s.id = e.course_id
GROUP BY e.enrolled_at
ORDER BY COUNT(s.id) DESC
LIMIT 1;
--------------------------------------------------------------------------------------
SELECT 
	s.fullname,
	COUNT(e.id)
FROM students s
FULL JOIN enrollments e ON s.id = e.student_id
GROUP BY s.fullname

--------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION get_student_courses(s_id BIGINT)
RETURNS TABLE(c_title TEXT)
LANGUAGE sql
AS $$
	SELECT
		c.title
	FROM enrollments e
	INNER JOIN courses c ON c.id = e.course_id
	WHERE e.student_id = s_id;
$$;
SELECT  get_student_courses(3)

--------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE enroll_student(s_id BIGINT, c_id BIGINT)
LANGUAGE plpgsql
AS $$
BEGIN
	IF NOT EXISTS (SELECT 1 FROM enrollments s WHERE student_id = s_id AND course_id = c_id) THEN
		INSERT INTO enrollments(student_id, course_id)
		VALUES(s_id, c_id);
	END iF;
END;
$$;

CALL enroll_student(4, 2)

--------------------------------------------------------------------------------------

CREATE TABLE student_logs(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	student_id BIGINT REFERENCES students(id),
	course_id BIGINT REFERENCES courses(id),
	action VARCHAR(512),
	action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION enrollment_log()
RETURNS TRIGGER AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		INSERT INTO student_logs(action)
		VALUES('INSERT выполнен');
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO student_logs(action)
		VALUES('DELETE выполнен');
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_enrollment_log
AFTER INSERT OR DELETE ON enrollments
FOR EACH ROW
EXECUTE FUNCTION enrollment_log();





