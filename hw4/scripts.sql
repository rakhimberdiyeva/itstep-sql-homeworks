SELECT * FROM departments
SELECT * FROM employees
SELECT * FROM projects

--1
SELECT
e.name,
d.name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

--2
SELECT
e.name,
d.name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

--3
SELECT
d.name,
e.name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id
ORDER BY d.name ASC;

--4
SELECT
e.name,
d.name
FROM employees e
FULL JOIN departments d ON e.department_id = d.id;

--5
SELECT
e.name,
d.name,
p.name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
INNER JOIN projects p ON p.department_id = d.id
ORDER BY e.name ASC;

--6
SELECT
e.name
FROM employees e
WHERE e.department_id IS NULL

--7
SELECT
p.name
FROM projects p
WHERE p.department_id IS NULL

--8
SELECT
d.name,
COUNT(e.name)
FROM departments d
INNER JOIN employees e ON e.department_id = d.id
GROUP BY d.name;

--9
SELECT 
p.name,
d.name
FROM projects p
LEFT JOIN departments d ON p.department_id = d.id

--10
SELECT
d.name,
COUNT(p.name)
FROM departments d
INNER JOIN projects p ON p.department_id = d.id
GROUP BY d.name






















