-- Таблица отделов
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Таблица сотрудников
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT REFERENCES departments(id),
    position VARCHAR(100)
);

-- Таблица проектов
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT REFERENCES departments(id)
);

-- Вставка данных в departments
INSERT INTO departments (name) VALUES
('IT'),
('Sales'),
('Analytics'),
('Legal'),
('HR'),
('Marketing'),
('Finance');

-- Вставка данных в employees
INSERT INTO employees (name, department_id, position) VALUES
('Alisher Karimov', 1, 'Backend Developer'),
('Dildora Ismoilova', 2, 'Sales Manager'),
('Shaxzod Xolmatov', 3, 'Data Analyst'),
('Nodira Qodirova', NULL, 'Recruiter'),
('Temur Rasulov', 1, 'Frontend Developer'),
('Malika Toshpulatova', 5, 'HR Manager'),
('Javohir Ismatov', 6, 'Content Specialist'),
('Gulbahor Yusupova', 7, 'Accountant'),
('Sardorbek Turgunov', 3, 'BI Specialist'),
('Ziyoda Jalilova', NULL, 'Intern'),
('Azizbek Gapparov', 4, 'Legal Advisor'),
('Nilufar Isroilova', 6, 'Marketing Analyst');

-- Вставка данных в projects
INSERT INTO projects (name, department_id) VALUES
('CRM System', 1),
('Market Analysis', 3),
('HR Portal', 5),
('E-commerce Website', 1),
('Legal Automation', 4),
('Internal Newsletter', 6),
('Financial Audit', 7),
('AI Chatbot', 1),
('Recruitment System', NULL),
('Sales Dashboard', 2),
('Customer Survey', NULL);








  
