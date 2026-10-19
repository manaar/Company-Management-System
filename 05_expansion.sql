-- =========================================
-- Company Management System
-- File: 05_expansion.sql
-- Description: Additional Sample Data
-- =========================================

USE company_db;

-- =========================================
-- Additional Employees: 10-19
-- =========================================

INSERT INTO employees
(employee_id, name, salary, hire_date, department_id, position_id)
VALUES
(10, 'Noura', 9500, '2025-02-10', 1, 2),
(11, 'Khalid', 12000, '2024-06-15', 1, 3),
(12, 'Abeer', 10500, '2025-03-20', 1, 4),
(13, 'Fahad', 7500, '2025-07-01', 1, 1),
(14, 'Hind', 11500, '2024-11-12', 1, 5),
(15, 'Omar', 8000, '2025-01-25', 2, 6),
(16, 'Layan', 8500, '2025-04-18', 5, 7),
(17, 'Yousef', 16000, '2023-09-05', 4, 8),
(18, 'Rana', 11000, '2025-05-30', 1, 9),
(19, 'Abdullah', 9000, '2024-08-14', 1, 3);

-- =========================================
-- Additional Employees: 20-50
-- =========================================

INSERT INTO employees
(employee_id, name, salary, hire_date, department_id, position_id)
VALUES
(20, 'Hessa', 7800, '2025-02-12', 1, 1),
(21, 'Mohammed', 10500, '2024-03-18', 1, 2),
(22, 'Amal', 12500, '2023-11-05', 1, 3),
(23, 'Saud', 11000, '2024-07-21', 1, 4),
(24, 'Basma', 13000, '2023-06-14', 1, 5),
(25, 'Rayan', 6500, '2025-08-10', 2, 6),
(26, 'Jana', 7200, '2025-04-22', 5, 7),
(27, 'Faisal', 17500, '2022-09-01', 1, 8),
(28, 'Aseel', 11500, '2024-12-15', 1, 9),
(29, 'Turki', 8500, '2025-01-09', 1, 1),
(30, 'Dania', 9800, '2024-05-17', 1, 2),
(31, 'Nawaf', 13500, '2023-08-20', 1, 3),
(32, 'Raghad', 14500, '2023-02-11', 1, 4),
(33, 'Bader', 12000, '2024-06-30', 1, 5),
(34, 'Shahad', 8500, '2025-03-14', 2, 6),
(35, 'Ali', 9500, '2024-10-08', 5, 7),
(36, 'Mona', 16000, '2023-01-25', 4, 8),
(37, 'Ziyad', 12500, '2024-04-19', 1, 9),
(38, 'Rawan', 6800, '2025-06-12', 1, 1),
(39, 'Sultan', 11000, '2024-02-27', 1, 2),
(40, 'Lina', 10500, '2025-01-18', 1, 3),
(41, 'Hamad', 15000, '2022-11-09', 1, 4),
(42, 'Yara', 13500, '2023-07-16', 1, 5),
(43, 'Majed', 7800, '2025-05-06', 2, 6),
(44, 'Dalal', 8800, '2024-09-13', 5, 7),
(45, 'Ibrahim', 18500, '2022-04-21', 1, 8),
(46, 'Ghada', 10500, '2025-02-28', 1, 9),
(47, 'Waleed', 8000, '2024-12-03', 1, 1),
(48, 'Eman', 11500, '2023-10-15', 1, 2),
(49, 'Khaled', 12500, '2024-01-22', 1, 3),
(50, 'Nadine', 14000, '2023-05-11', 1, 4);


-- =========================================
-- Generate September 2026 Attendance
-- =========================================

INSERT INTO attendance
(attendance_id, employee_id, attendance_date,
 check_in, check_out, status)

WITH RECURSIVE dates AS (
    SELECT DATE('2026-09-01') AS work_date

    UNION ALL

    SELECT work_date + INTERVAL 1 DAY
    FROM dates
    WHERE work_date < '2026-09-30'
)

SELECT
    1000 + ROW_NUMBER() OVER (
        ORDER BY d.work_date, e.employee_id
    ) AS attendance_id,

    e.employee_id,
    d.work_date,

    CASE
        WHEN MOD(e.employee_id + DAY(d.work_date), 13) = 0
            THEN NULL
        WHEN MOD(e.employee_id + DAY(d.work_date), 5) = 0
            THEN '08:25:00'
        ELSE '07:55:00'
    END AS check_in,

    CASE
        WHEN MOD(e.employee_id + DAY(d.work_date), 13) = 0
            THEN NULL
        ELSE '16:00:00'
    END AS check_out,

    CASE
        WHEN MOD(e.employee_id + DAY(d.work_date), 13) = 0
            THEN 'Absent'
        WHEN MOD(e.employee_id + DAY(d.work_date), 5) = 0
            THEN 'Late'
        ELSE 'Present'
    END AS status

FROM employees e
CROSS JOIN dates d

-- Sunday to Thursday
WHERE DAYOFWEEK(d.work_date) BETWEEN 1 AND 5;

-- Generate payroll for September, October and November

INSERT INTO payroll
(payroll_id, employee_id, pay_month,
 base_salary, bonus, deductions)

SELECT
    2000 + ROW_NUMBER() OVER (
        ORDER BY m.pay_month, e.employee_id
    ) AS payroll_id,

    e.employee_id,
    m.pay_month,
    e.salary,

    CASE
        WHEN MOD(e.employee_id, 5) = 0 THEN 500
        WHEN MOD(e.employee_id, 3) = 0 THEN 300
        ELSE 0
    END AS bonus,

    CASE
        WHEN MOD(e.employee_id, 7) = 0 THEN 200
        ELSE 0
    END AS deductions

FROM employees e

CROSS JOIN (
    SELECT DATE('2026-09-01') AS pay_month
    UNION ALL
    SELECT DATE('2026-10-01')
    UNION ALL
    SELECT DATE('2026-11-01')
) m

WHERE NOT EXISTS (
    SELECT 1
    FROM payroll p
    WHERE p.employee_id = e.employee_id
      AND p.pay_month = m.pay_month
);

-- =========================================
-- Assign New Employees to Valid Projects
-- =========================================

INSERT INTO employee_projects
(employee_id, project_id)

WITH valid_projects AS (
    SELECT
        e.employee_id,
        p.project_id,
        ROW_NUMBER() OVER (
            PARTITION BY e.employee_id
            ORDER BY p.project_id
        ) AS project_rank,
        COUNT(*) OVER (
            PARTITION BY e.employee_id
        ) AS project_count
    FROM employees e
    JOIN projects p
        ON p.end_date >= e.hire_date
    WHERE e.employee_id BETWEEN 10 AND 50
)

SELECT
    vp.employee_id,
    vp.project_id

FROM valid_projects vp

WHERE vp.project_rank =
    MOD(vp.employee_id - 10, vp.project_count) + 1

AND NOT EXISTS (
    SELECT 1
    FROM employee_projects ep
    WHERE ep.employee_id = vp.employee_id
);


-- =========================================
-- Generate 91 Additional Project Tasks
-- =========================================

INSERT INTO project_tasks
(task_id, project_id, employee_id,
 task_name, due_date, status, priority)

WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 91
),
assignments AS (
    SELECT
        ep.employee_id,
        ep.project_id,
        ROW_NUMBER() OVER (
            ORDER BY ep.employee_id, ep.project_id
        ) AS rn
    FROM employee_projects ep
)

SELECT
    1000 + n.n AS task_id,
    a.project_id,
    a.employee_id,

    CASE MOD(n.n, 5)
        WHEN 0 THEN 'Database Design'
        WHEN 1 THEN 'Security Testing'
        WHEN 2 THEN 'Network Configuration'
        WHEN 3 THEN 'System Maintenance'
        ELSE 'Documentation'
    END AS task_name,

  DATE_ADD(
    GREATEST(p.start_date, e.hire_date),
    INTERVAL MOD(
        n.n * 3,
        DATEDIFF(
            p.end_date,
            GREATEST(p.start_date, e.hire_date)
        ) + 1
    ) DAY
) AS due_date,

    CASE MOD(n.n, 3)
        WHEN 0 THEN 'Completed'
        WHEN 1 THEN 'In Progress'
        ELSE 'Pending'
    END AS status,

    CASE MOD(n.n, 3)
        WHEN 0 THEN 'High'
        WHEN 1 THEN 'Medium'
        ELSE 'Low'
    END AS priority

FROM numbers n

JOIN assignments a
    ON a.rn = MOD(
        n.n - 1,
        (SELECT COUNT(*) FROM assignments)
    ) + 1

JOIN projects p
    ON a.project_id = p.project_id

JOIN employees e
    ON a.employee_id = e.employee_id;
    

UPDATE project_tasks pt
JOIN projects p
    ON pt.project_id = p.project_id
SET pt.due_date = CASE
    WHEN pt.due_date < p.start_date
        THEN p.start_date
    WHEN pt.due_date > p.end_date
        THEN p.end_date
    ELSE pt.due_date
END
WHERE pt.due_date < p.start_date
   OR pt.due_date > p.end_date;
