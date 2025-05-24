-----------------------------------------------
CREATE TABLE customers (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fullname TEXT NOT NULL
);
CREATE TABLE orders (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	customer_id BIGINT REFERENCES customers(id),
	order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE PROCEDURE add_order(cust_name TEXT)
LANGUAGE plpgsql
AS $$
DECLARE new_customer_id BIGINT;
BEGIN
	INSERT INTO customers(fullname)
	VALUES(cust_name)
	RETURNING id INTO new_customer_id;

	INSERT INTO orders(customer_id)
	VALUES(new_customer_id);
END;
$$;

CALL add_order('peter parker')
SELECT * FROM customers
SELECT * FROM orders


-----------------------------------------------------

CREATE TABLE authors (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fullname TEXT NOT NULL
);
CREATE TABLE books (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	title TEXT NOT NULL,
	author_id BIGINT REFERENCES authors(id)
);

CREATE PROCEDURE add_book(b_title TEXT, author_name TEXT)
LANGUAGE plpgsql
AS $$
DECLARE new_author_id BIGINT;
BEGIN
	INSERT INTO authors(fullname)
	VALUES(author_name)
	RETURNING id INTO new_author_id;

	INSERT INTO books(title, author_id)
	VALUES(b_title, new_author_id);
END;
$$;

CALL add_book('1984', 'george orwell');
SELECT * FROM authors;
SELECT * FROM books;


---------------------------------------------------------


CREATE TABLE students (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fullname TEXT NOT NULL
);
CREATE TABLE courses (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	title TEXT NOT NULL
);
CREATE TABLE registrations (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	student_id BIGINT REFERENCES students(id),
	course_id BIGINT REFERENCES courses(id)
);


CREATE PROCEDURE register_student(name TEXT, course_title TEXT)
LANGUAGE plpgsql
AS $$
DECLARE new_student_id BIGINT; 
DECLARE new_course_id BIGINT; 
BEGIN
	INSERT INTO students(fullname)
	VALUES(name)
	RETURNING id INTO new_student_id;

	INSERT INTO courses(title)
	VALUES(course_title)
	RETURNING id INTO new_course_id;

	INSERT INTO registrations(student_id, course_id)
	VALUES(new_student_id, new_course_id);
END;
$$;


CALL register_student('anna', 'biology')

SELECT * FROM students;
SELECT * FROM courses;
SELECT
students.fullname,
courses.title
FROM registrations
INNER JOIN students ON registrations.student_id = students.id
INNER JOIN courses ON registrations.course_id = courses.id;


-----------------------------------------------------------------------


CREATE TABLE categories (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name TEXT NOT NULL
);
CREATE TABLE products (
	id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name TEXT NOT NULL,
	category_id BIGINT REFERENCES categories(id)
);

CREATE PROCEDURE add_product(p_name TEXT, c_name TEXT)
LANGUAGE plpgsql
AS $$
DECLARE new_catg_id BIGINT;
BEGIN
	INSERT INTO categories(name)
	VALUES (c_name)
	RETURNING id INTO new_catg_id;

	INSERT INTO products(name, category_id)
	VALUES (p_name, new_catg_id);
END;
$$;



CALL add_product('apple', 'fruits')
SELECT * FROM categories
SELECT * FROM products


