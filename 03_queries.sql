-- =========================================
-- Company Management System
-- File: 03_queries.sql
-- Description: SQL Query Examples
-- =========================================

USE company_db;

-- =========================================
-- 1. Employees with Departments and Positions
-- =========================================

SELECT
    e.employee_id,
    e.name,
    d.department_name,
    j.position_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
JOIN job_positions j
    ON e.position_id = j.position_id
ORDER BY e.employee_id;


-- =========================================
-- 2. Employees Assigned to Projects
-- =========================================

SELECT
    e.name AS employee_name,
    p.project_name
FROM employees e
JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
JOIN projects p
    ON ep.project_id = p.project_id
ORDER BY e.name;


-- =========================================
-- 3. Employee Attendance and Leave Records
-- =========================================

SELECT
    e.name,
    a.attendance_date,
    a.check_in,
    a.check_out,
    a.status AS attendance_status,
    l.leave_type,
    l.status AS leave_status
FROM employees e
JOIN attendance a
    ON e.employee_id = a.employee_id
JOIN leaves l
    ON e.employee_id = l.employee_id
ORDER BY e.employee_id;


-- =========================================
-- 4. Record Counts
-- =========================================

SELECT 'payroll' AS table_name, COUNT(*) AS total
FROM payroll

UNION ALL

SELECT 'performance_reviews', COUNT(*)
FROM performance_reviews

UNION ALL

SELECT 'project_tasks', COUNT(*)
FROM project_tasks;


-- =========================================
-- 5. Employees Outside Salary Range
-- =========================================

SELECT
    e.name,
    j.position_name,
    e.salary,
    j.min_salary,
    j.max_salary
FROM employees e
JOIN job_positions j
    ON e.position_id = j.position_id
WHERE e.salary < j.min_salary
   OR e.salary > j.max_salary;


-- =========================================
-- 6. Total Employees
-- =========================================

SELECT COUNT(*) AS total_employees
FROM employees;


-- =========================================
-- 7. Total Project Tasks
-- =========================================

SELECT COUNT(*) AS total_tasks
FROM project_tasks;


-- =========================================
-- 8. Employees per Project
-- =========================================

SELECT
    p.project_name,
    COUNT(ep.employee_id) AS total_employees
FROM projects p
LEFT JOIN employee_projects ep
    ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name
ORDER BY total_employees DESC;


-- =========================================
-- 9. Employees Without Projects
-- =========================================

SELECT
    COUNT(*) AS employees_without_projects
FROM employees e
LEFT JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL;


-- =========================================
-- 10. Monthly Payroll Summary
-- =========================================

SELECT
    DATE_FORMAT(pay_month, '%Y-%m') AS salary_month,
    COUNT(*) AS total_employees,
    SUM(base_salary) AS total_base_salary,
    SUM(bonus) AS total_bonus,
    SUM(deductions) AS total_deductions,
    SUM(base_salary + bonus - deductions) AS total_net_salary
FROM payroll
GROUP BY pay_month
ORDER BY pay_month;


-- =========================================
-- 11. September 2026 Attendance Summary
-- =========================================

SELECT
    COUNT(*) AS total_attendance,
    COUNT(DISTINCT employee_id) AS total_employees,
    COUNT(DISTINCT attendance_date) AS work_days
FROM attendance
WHERE attendance_date BETWEEN '2026-09-01'
                          AND '2026-09-30';