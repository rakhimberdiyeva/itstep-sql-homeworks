--------------------------------------------------------------------------
CREATE TABLE students(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fullname VARCHAR(512)
)

CREATE PROCEDURE find_student(s_id BIGINT)
LANGUAGE plpgsql
AS $$
DECLARE students_count BIGINT; 
BEGIN
	SELECT count(*) INTO students_count FROM students WHERE s_id = id;
	IF students_count > 0 THEN
		RAISE NOTICE 'Студент найден';
	ELSE
		RAISE NOTICE 'Студент не найден';
	END IF;
END;
$$;

INSERT INTO students(fullname)
VALUES
('alex'),
('bree'),
('lily');

SELECT * FROM students
CALL find_student(5)


----------------------------------------------------------------------------
CREATE TABLE users(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(512)
);

INSERT INTO users(name)
VALUES 
('john'),
(NULL),
('chris'),
(' ');

CREATE PROCEDURE update_user_names(u_id BIGINT)
LANGUAGE plpgsql
AS $$
DECLARE user_name VARCHAR(512);
BEGIN
	SELECT name INTO user_name FROM users WHERE id = u_id;
	IF user_name IS NULL OR user_name = ' ' THEN
		UPDATE users
		SET name = 'Без имени'
		WHERE id = u_id;
	END IF;
END;
$$;


SELECT * FROM users
CALL update_user_names(4)


----------------------------------------------------------------------------
CREATE TABLE student_ages(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
	name VARCHAR(512),
	age BIGINT
);

CREATE PROCEDURE check_age(s_name VARCHAR(512), s_age BIGINT)
LANGUAGE plpgsql
AS $$
BEGIN
	IF s_age <= 16 THEN
		RAISE NOTICE 'Слишком молодой';
	ELSE
		INSERT INTO student_ages(name, age)
		VALUES
		(s_name, s_age);
	END IF;
END;
$$;

CALL check_age('mark', 19)
CALL check_age('alice', 25)
CALL check_age('bella', 15)

SELECT * FROM student_ages

--------------------------------------------------------------------------
CREATE TABLE student_gender_age(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
	name VARCHAR(512),
	age BIGINT,
	gender VARCHAR(1)
);

INSERT INTO student_gender_age(name, age, gender)
VALUES
('susan', 23, 'W'),
('stephen', 20, 'M'),
('justin', 16, 'M');


CREATE PROCEDURE check_gender_age(s_id BIGINT)
LANGUAGE plpgsql
AS $$
DECLARE student_age BIGINT;
DECLARE student_gender VARCHAR(1);
BEGIN
	SELECT age INTO student_age FROM student_gender_age WHERE s_id = id;
	SELECT gender INTO student_gender FROM student_gender_age WHERE s_id = id;
	IF student_age < 17 AND student_gender = 'M' THEN
		DELETE FROM student_gender_age WHERE s_id = id;
	ELSE
		RAISE NOTICE 'Удаление не требуется';
	END IF;
END;
$$;

CALL check_gender_age(1)
CALL check_gender_age(2)
CALL check_gender_age(3)

SELECT * FROM student_gender_age


-----------------------------------------------------------------------------
CREATE PROCEDURE discount(total_sum BIGINT, status VARCHAR(512))
LANGUAGE plpgsql
AS $$
BEGIN
	IF status = 'student' THEN
		RAISE NOTICE 'total sum with discount %', total_sum * 0.8;
	ELSEIF status = 'employee' THEN
		RAISE NOTICE 'total sum with discount %', total_sum * 0.9;
	ELSEIF status = 'guest' THEN
		RAISE NOTICE 'total sum with discount %', total_sum;
	ELSE
		RAISE NOTICE 'error';
	END IF;
END;
$$;

CALL discount(100, 'student');
CALL discount(150, 'employee');
CALL discount(120, 'guest');

-----------------------------------------------------------------------------
CREATE PROCEDURE check_num(n BIGINT)
LANGUAGE plpgsql
AS $$
BEGIN
	IF n >= 10 AND n <= 20 THEN
		RAISE NOTICE 'В пределах диапазона';
	ELSE
		RAISE NOTICE 'Вне диапазона"';
	END IF;
END;
$$;

CALL check_num(3);
CALL check_num(15);
CALL check_num(78);

-----------------------------------------------------------------------------
CREATE TABLE new_students(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
	name VARCHAR(512)
);

CREATE PROCEDURE add_student(s_name VARCHAR(512))
LANGUAGE plpgsql
AS $$
DECLARE students_count BIGINT; 
BEGIN
	SELECT count(*) INTO students_count FROM new_students;
	IF students_count = 0 THEN
		INSERT INTO new_students(name)
		VALUES
		(s_name);
	END IF;
END;
$$;

CALL add_student('jane')
SELECT * FROM new_students

DROP PROCEDURE add_student(VARCHAR)

-----------------------------------------------------------------------------
CREATE PROCEDURE compare_nums(n1 BIGINT, n2 BIGINT)
LANGUAGE plpgsql
AS $$
BEGIN
	IF n1 = n2 THEN
		RAISE NOTICE 'Равны';
	ELSEIF n1 > n2 THEN
		RAISE NOTICE 'Первое больше';
	ELSE
		RAISE NOTICE 'Второе больше';
	END IF;
END;
$$;

CALL compare_nums(11, 11);
CALL compare_nums(10, 11);
CALL compare_nums(11, 9);

-----------------------------------------------------------------------------
CREATE TABLE all_students(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
	name VARCHAR(512),
	age BIGINT,
	is_active boolean
);

INSERT INTO all_students(name, age, is_active)
VALUES 
('amy', 19, TRUE),
('bob', 20, FALSE),
('lisa', 15, FALSE)

CREATE PROCEDURE student_active(s_id BIGINT)
LANGUAGE plpgsql
AS $$
DECLARE s_age BIGINT; 
BEGIN
	SELECT age INTO s_age FROM all_students WHERE s_id = id;
	IF s_age >= 18 THEN
		UPDATE all_students
		SET is_active = TRUE
		WHERE s_id = id;
	END IF;
END;
$$;

CALL student_active(3)
SELECT * FROM all_students






