DROP TABLE students;

SELECT * FROM students;

CREATE TABLE students(
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(512),
	age BIGINT,
	group_id BIGINT,
	email TEXT,
	login TEXT,
	phone TEXT,
	created_at TIMESTAMP
);

--------------------------------------------------------

CREATE FUNCTION check_email()
RETURNS TRIGGER AS $$
DECLARE new_email BOOLEAN;
BEGIN
	SELECT EXISTS (SELECT 1 FROM students WHERE email = NEW.email) INTO new_email;
	IF new_email THEN
		RAISE EXCEPTION 'Этот email уже используется';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;	

CREATE TRIGGER trg_check_email
BEFORE INSERT ON students
FOR EACH ROW
EXECUTE FUNCTION check_email();

--------------------------------------------------------

CREATE FUNCTION check_name()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.name IS NULL OR LENGTH(TRIM(NEW.name)) = 0 THEN
		RAISE EXCEPTION 'Имя обязательно';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;	

CREATE TRIGGER trg_check_name
BEFORE INSERT ON students
FOR EACH ROW
EXECUTE FUNCTION check_name();

--------------------------------------------------------

CREATE FUNCTION check_age_2()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.age < 16 OR NEW.age > 100 THEN
		RAISE EXCEPTION 'возраст не подходит';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;	

CREATE TRIGGER trg_check_age_2
BEFORE INSERT OR UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION check_age_2();

--------------------------------------------------------

CREATE FUNCTION check_login()
RETURNS TRIGGER AS $$
BEGIN
	IF OLD.login = 'admin' THEN
		RAISE EXCEPTION 'вы не можете поменять логин';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;	

CREATE OR REPLACE TRIGGER trg_check_login
BEFORE UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION check_login();

--------------------------------------------------------

CREATE OR REPLACE FUNCTION check_phone()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.phone NOT LIKE '+998%' THEN
		RAISE EXCEPTION 'Телефон долженначинаться с +998';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;	

CREATE OR REPLACE TRIGGER trg_check_phone
BEFORE INSERT OR UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION check_phone();


--------------------------------------------------------

CREATE OR REPLACE FUNCTION lower_email()
RETURNS TRIGGER AS $$
BEGIN
	NEW.email := LOWER(NEW.email);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;	

CREATE OR REPLACE TRIGGER trg_lower_email
BEFORE INSERT OR UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION lower_email();

--------------------------------------------------------

CREATE OR REPLACE FUNCTION check_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.created_at IS NULL THEN
		NEW.created_at := CURRENT_TIMESTAMP;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;	

CREATE OR REPLACE TRIGGER trg_check_timestamp
BEFORE INSERT OR UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION check_timestamp();

--------------------------------------------------------

CREATE OR REPLACE FUNCTION cap_name()
RETURNS TRIGGER AS $$
BEGIN
	NEW.name := INITCAP(TRIM(NEW.name));
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;	

CREATE OR REPLACE TRIGGER trg_cap_name
BEFORE INSERT OR UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION cap_name();

--------------------------------------------------------

CREATE OR REPLACE FUNCTION check_group()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.group_id IS NULL THEN
		NEW.group_id := 1;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;	

CREATE OR REPLACE TRIGGER trg_check_group
BEFORE INSERT OR UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION check_group();








