-- Creating Tables


CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    salary NUMERIC(10,2),
    dept_id INT REFERENCES departments(dept_id),
    hire_date DATE
);

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(50),
    budget NUMERIC(12,2),
    start_date DATE,
    end_date DATE
);

CREATE TABLE employee_projects (
    emp_id INT REFERENCES employees(emp_id),
    project_id INT REFERENCES projects(project_id),
    hours_worked INT,
    PRIMARY KEY(emp_id, project_id)
);

-- Insert Sample Data
-- Departments
INSERT INTO departments (dept_name, location) VALUES
('HR', 'Karachi'),
('IT', 'Lahore'),
('Finance', 'Islamabad'),
('Marketing', 'Karachi');

-- Employees
INSERT INTO employees (emp_name, salary, dept_id, hire_date) VALUES
('Ali', 50000, 1, '2020-01-15'),
('Sara', 60000, 2, '2019-03-20'),
('Ahmed', 45000, NULL, '2021-06-10'), -- no department
('Fatima', 70000, 3, '2018-11-05'),
('Usman', 40000, 2, '2022-05-01');

-- Projects
INSERT INTO projects (project_name, budget, start_date, end_date) VALUES
('Website Upgrade', 200000, '2023-01-01', '2023-12-31'),
('HR Management System', 150000, '2022-06-01', '2023-06-01'),
('Financial Audit', 100000, '2023-03-01', '2023-09-30');

-- Employee_Projects
INSERT INTO employee_projects (emp_id, project_id, hours_worked) VALUES
(1, 2, 120),
(2, 1, 200),
(2, 3, 50),
(4, 3, 90);

-- Part 1: Basic Joins

-- Q1: Display all employees with their department names (include employees without departments).
SELECT e.emp_id, e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- Q2: Show all departments and their employees (include departments without employees).
SELECT d.dept_id, d.dept_name, e.emp_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

-- Q3: Find employees who are not assigned to any department.
SELECT emp_id, emp_name
FROM employees
WHERE dept_id IS NULL;

-- Part 2: Complex Joins

-- Q4: Display all projects with the names of employees working on them (include projects with no employees).
SELECT p.project_name, e.emp_name
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
LEFT JOIN employees e ON ep.emp_id = e.emp_id;

-- Q5: Calculate total hours worked per department (include departments with no hours worked).
SELECT d.dept_name, COALESCE(SUM(ep.hours_worked),0) AS total_hours
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY d.dept_name;

-- Q6: Find employees who are not working on any projects.
SELECT e.emp_id, e.emp_name
FROM employees e
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
WHERE ep.project_id IS NULL;

-- Part 3: Analysis Questions

-- Q7: Difference between INNER JOIN and LEFT JOIN?
-- INNER JOIN only returns rows that match in both tables.
-- LEFT JOIN returns all rows from the left table, even if there is no match in the right table.
-- Example: If we want only employees with departments → use INNER JOIN.
-- If we also want employees without departments → use LEFT JOIN.

-- Q8: Why RIGHT JOIN is less commonly used?
-- Because LEFT JOIN is easier and more readable (just switch table order if needed).
-- RIGHT JOIN does the same as LEFT JOIN but in reverse. That’s why LEFT JOIN is preferred.

