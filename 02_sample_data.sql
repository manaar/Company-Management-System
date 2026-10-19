-- =========================================
-- Company Management System
-- File: 02_sample_data.sql
-- Description: Sample Data
-- =========================================

USE company_db;

-- =========================================
-- 1. Departments Data
-- =========================================

INSERT INTO departments
(department_id, department_name)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Accounting');

-- =========================================
-- 2. Job Positions Data
-- =========================================

INSERT INTO job_positions
(position_id, position_name, min_salary, max_salary)
VALUES
(1, 'IT Support Specialist', 5000, 9000),
(2, 'Data Analyst', 7000, 12000),
(3, 'Network Engineer', 8000, 14000),
(4, 'Cybersecurity Analyst', 9000, 16000),
(5, 'Database Administrator', 9000, 15000),
(6, 'HR Specialist', 5000, 10000),
(7, 'Accountant', 6000, 11000),
(8, 'Project Manager', 12000, 20000),
(9, 'Software Developer', 8000, 15000);

-- =========================================
-- 3. Employees Data
-- =========================================

INSERT INTO employees
(employee_id, name, salary, hire_date, department_id, position_id)
VALUES
(1, 'Sara', 8500, '2025-01-15', 1, 2),
(2, 'Manar', 8000, '2025-05-21', 1, 3),
(3, 'Taraf', 10500, '2025-05-26', 2, 4),
(4, 'Reem', 8500, '2025-08-10', 4, 1),
(5, 'Fouz', 11000, '2025-08-29', 1, 5),
(6, 'Maha', 8500, '2026-01-15', 5, 6),
(7, 'Rahaf', 11000, '2025-05-26', 2, 7),
(8, 'Deem', 15000, '2025-08-10', 4, 8),
(9, 'Lama', 9000, '2026-01-15', 5, 9);
-- =========================================
-- 4. Projects Data
-- =========================================

INSERT INTO projects
(project_id, project_name, start_date, end_date)
VALUES
(1, 'NEOM System', '2022-01-01', '2026-12-30'),
(2, 'Vision 2030 Platform', '2024-10-01', '2030-12-30'),
(3, 'Mimi Application', '2026-01-01', '2029-11-20'),
(4, 'SDAIA Analytics', '2024-05-08', '2026-10-05'),
(5, 'Noor Platform', '2024-08-08', '2026-05-05'),
(6, 'Aramco Network', '2024-05-08', '2026-12-07'),
(7, 'Fantasy Website', '2024-05-08', '2026-10-05'),
(8, 'Hope Application', '2020-01-05', '2020-05-08'),
(9, 'Sanwan System', '2021-05-18', '2023-10-15'),
(10, 'Crystal Platform', '2026-05-08', '2034-10-05');

-- =========================================
-- 5. Employee Projects Data
-- =========================================

INSERT INTO employee_projects
(employee_id, project_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(4, 6),
(5, 7),
(6, 5),
(7, 4),
(8, 3),
(9, 2);
-- =========================================
-- 6. Attendance Data
-- =========================================

INSERT INTO attendance
(attendance_id, employee_id, attendance_date, check_in, check_out, status)
VALUES
(1, 1, '2026-10-15', '07:55:00', '16:05:00', 'Present'),
(2, 2, '2026-10-15', '08:25:00', '16:10:00', 'Late'),
(3, 3, '2026-10-15', NULL, NULL, 'Absent'),
(4, 4, '2026-10-15', '07:45:00', '16:00:00', 'Present'),
(5, 5, '2026-10-15', '08:40:00', '16:20:00', 'Late'),
(6, 6, '2026-10-15', '07:58:00', '16:15:00', 'Present'),
(7, 7, '2026-10-15', '08:00:00', '16:05:00', 'Present'),
(8, 8, '2026-10-15', '08:15:00', '16:00:00', 'Late'),
(9, 9, '2026-10-15', '07:50:00', '16:10:00', 'Present');

-- =========================================
-- 7. Leaves Data
-- =========================================

INSERT INTO leaves
(leave_id, employee_id, start_date, end_date, leave_type, status)
VALUES
(1, 1, '2026-11-01', '2026-11-05', 'Annual', 'Pending'),
(2, 2, '2026-11-03', '2026-11-07', 'Annual', 'Approved'),
(3, 3, '2026-11-05', '2026-11-06', 'Sick', 'Approved'),
(4, 4, '2026-11-10', '2026-11-12', 'Emergency', 'Pending'),
(5, 5, '2026-11-15', '2026-11-20', 'Annual', 'Rejected'),
(6, 6, '2026-11-18', '2026-11-19', 'Sick', 'Approved'),
(7, 7, '2026-12-01', '2026-12-05', 'Annual', 'Pending'),
(8, 8, '2026-12-08', '2026-12-10', 'Emergency', 'Approved'),
(9, 9, '2026-12-15', '2026-12-20', 'Annual', 'Pending');

-- =========================================
-- 8. Payroll Data
-- =========================================

INSERT INTO payroll
(payroll_id, employee_id, pay_month, base_salary, bonus, deductions)
VALUES
(1, 1, '2026-10-01', 8500, 500, 100),
(2, 2, '2026-10-01', 8000, 0, 200),
(3, 3, '2026-10-01', 10500, 1000, 0),
(4, 4, '2026-10-01', 8500, 300, 150),
(5, 5, '2026-10-01', 11000, 700, 250),
(6, 6, '2026-10-01', 8500, 0, 100),
(7, 7, '2026-10-01', 11000, 500, 0),
(8, 8, '2026-10-01', 15000, 200, 300),
(9, 9, '2026-10-01', 9000, 1000, 400);
-- =========================================
-- 9. Performance Reviews Data
-- =========================================

INSERT INTO performance_reviews
(review_id, employee_id, review_date, rating, comments)
VALUES
(1, 1, '2026-10-15', 5, 'Excellent performance'),
(2, 2, '2026-10-15', 4, 'Very good technical skills'),
(3, 3, '2026-10-15', 5, 'Excellent problem solving'),
(4, 4, '2026-10-15', 3, 'Good performance'),
(5, 5, '2026-10-15', 4, 'Strong database skills'),
(6, 6, '2026-10-15', 3, 'Needs improvement in communication'),
(7, 7, '2026-10-15', 5, 'Outstanding performance'),
(8, 8, '2026-10-15', 4, 'Good project management'),
(9, 9, '2026-10-15', 3, 'Good progress');

-- =========================================
-- 10. Project Tasks Data
-- =========================================

INSERT INTO project_tasks
(task_id, project_id, employee_id, task_name, due_date, status, priority)
VALUES
(1, 1, 1, 'Database Design', '2026-11-05', 'Completed', 'High'),
(2, 1, 2, 'Network Configuration', '2026-11-10', 'In Progress', 'High'),
(3, 3, 3, 'Security Testing', '2026-11-15', 'Pending', 'High'),
(4, 6, 4, 'Technical Support', '2026-11-08', 'Completed', 'Medium'),
(5, 7, 5, 'Database Backup', '2026-09-12', 'In Progress', 'High'),
(6, 5, 6, 'Employee Training', '2026-11-18', 'Pending', 'Low'),
(7, 4, 7, 'Budget Analysis', '2026-09-20', 'In Progress', 'Medium'),
(8, 3, 8, 'Project Planning', '2026-11-25', 'Pending', 'High'),
(9, 2, 9, 'Application Development', '2026-11-30', 'Pending', 'Medium');















