DROP TABLE student_logs;
DROP TABLE students;

SELECT * FROM students;
SELECT * FROM student_logs


CREATE TABLE students(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(512),
	age BIGINT,
	group_id BIGINT,
	payments BIGINT,
	status VARCHAR(200),
	is_active BOOLEAN
);

CREATE TABLE student_logs(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	student_id BIGINT REFERENCES students(id),
	action VARCHAR(512),
	old_group BIGINT,
	new_group BIGINT,
	timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO students(name, age, group_id, payments, status, is_active)
VALUES
('BOB', 10, 2, 0, 'studying', true)

delete from students
where id = 2;

------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION capitilize_name()
RETURNS TRIGGER AS $$
BEGIN
	NEW.name := INITCAP(NEW.name);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_capitilize_name
BEFORE INSERT ON students
FOR EACH ROW
EXECUTE FUNCTION capitilize_name();

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION student_logs_add()
RETURNS TRIGGER AS  $$
BEGIN
	INSERT INTO student_logs(student_id, action)
	VALUES(NEW.id, 'add');
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_student_logs_add
AFTER INSERT ON students
FOR EACH ROW
EXECUTE FUNCTION student_logs_add();

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION check_age()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.age < OLD.age THEN
		RAISE NOTICE 'you cannot decrease your age';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_age
BEFORE UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION check_age();


------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION change_group()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO student_logs(student_id, action, old_group, new_group)
	VALUES (NEW.id, 'change group', OLD.group_id, NEW.group_id);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_change_group
AFTER UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION change_group();

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION check_payments()
RETURNS TRIGGER AS $$
BEGIN
	IF OLD.payments > 0 THEN
		RAISE EXCEPTION  'payments should be paid';
	END IF;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_payments
BEFORE DELETE ON students
FOR EACH ROW
EXECUTE FUNCTION check_payments();

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION student_logs_delete()
RETURNS TRIGGER AS  $$
BEGIN
	INSERT INTO student_logs(student_id, action)
	VALUES(OLD.id, 'delete');
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_student_logs_delete
AFTER DELETE ON students
FOR EACH ROW
EXECUTE FUNCTION student_logs_delete();


------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION check_graduated()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.status = 'graduated' THEN
		NEW.is_active = false;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_graduated
BEFORE UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION check_graduated();

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION student_logs_insert()
RETURNS TRIGGER AS  $$
BEGIN
	INSERT INTO student_logs( action)
	VALUES('Добавлены студенты');
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_student_logs_insert
AFTER INSERT ON students
FOR EACH STATEMENT
EXECUTE FUNCTION student_logs_insert();

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION student_logs_action()
RETURNS TRIGGER AS  $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		INSERT INTO student_logs(action)
		VALUES('INSERT выполнен');
	ELSIF TG_OP = 'UPDATE' THEN
		INSERT INTO student_logs(action)
		VALUES('UPDATE выполнен');
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO student_logs(action)
		VALUES('DELETE выполнен');
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_student_logs_action
AFTER INSERT OR UPDATE OR DELETE ON students
FOR EACH ROW
EXECUTE FUNCTION student_logs_action();


