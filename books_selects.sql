SELECT 
	b.id AS "ид",
	b.name AS "название книги",
	a.fname || ' ' || a.lname AS "автор",
	b.year AS "год издания",
	b.rating AS "рейтинг"
FROM authors a
INNER JOIN books b ON a.id = b.author_id;

SELECT * FROM authors
ORDER BY id ASC;

SELECT * FROM books
WHERE rating > 5
ORDER BY rating ASC;

SELECT * FROM books
WHERE name = 'Мастер и Маргарита'

SELECT * FROM books
ORDER BY rating ASC;