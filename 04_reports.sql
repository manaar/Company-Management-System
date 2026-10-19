USE company_db;

-- =========================================
-- Report 1: Employee Attendance Summary
-- =========================================

SELECT
    e.employee_id,
    e.name,
    COUNT(*) AS total_days,

    SUM(CASE
        WHEN a.status = 'Present' THEN 1
        ELSE 0
    END) AS present_days,

    SUM(CASE
        WHEN a.status = 'Late' THEN 1
        ELSE 0
    END) AS late_days,

    SUM(CASE
        WHEN a.status = 'Absent' THEN 1
        ELSE 0
    END) AS absent_days,

    ROUND(
        SUM(CASE
            WHEN a.status IN ('Present', 'Late') THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS attendance_percentage

FROM employees e
JOIN attendance a
    ON e.employee_id = a.employee_id

WHERE a.attendance_date
    BETWEEN '2026-09-01' AND '2026-09-30'

GROUP BY e.employee_id, e.name

ORDER BY attendance_percentage DESC, e.name;

-- =========================================
-- Report 2: Department Payroll Summary
-- =========================================

SELECT
    d.department_name,
    COUNT(DISTINCT e.employee_id) AS total_employees,
    SUM(p.base_salary) AS total_base_salary,
    SUM(p.bonus) AS total_bonus,
    SUM(p.deductions) AS total_deductions,
    SUM(
        p.base_salary + p.bonus - p.deductions
    ) AS total_net_salary

FROM departments d

JOIN employees e
    ON d.department_id = e.department_id

JOIN payroll p
    ON e.employee_id = p.employee_id

WHERE p.pay_month = '2026-10-01'

GROUP BY d.department_id, d.department_name

ORDER BY total_net_salary DESC;


-- Report 3: Project Progress

SELECT
    p.project_name,
    COUNT(pt.task_id) AS total_tasks,
COALESCE(SUM(pt.status = 'Completed'), 0) AS completed_tasks,
COALESCE(SUM(pt.status = 'In Progress'), 0) AS in_progress_tasks,
COALESCE(SUM(pt.status = 'Pending'), 0) AS pending_tasks,
    ROUND(
        100.0 * SUM(pt.status = 'Completed')
        / NULLIF(COUNT(pt.task_id), 0),
        2
    ) AS completion_percentage
FROM projects p
LEFT JOIN project_tasks pt
    ON p.project_id = pt.project_id
GROUP BY p.project_id, p.project_name
ORDER BY completion_percentage DESC;


-- Report 4: Invalid Project Task Dates

SELECT
    p.project_name,
    p.start_date,
    p.end_date,
    pt.task_id,
    pt.task_name,
    pt.due_date
FROM projects p
JOIN project_tasks pt
    ON p.project_id = pt.project_id
WHERE pt.due_date < p.start_date
   OR pt.due_date > p.end_date
ORDER BY p.project_name, pt.due_date;

-- Report 5: Missing Employee Department or Position

SELECT
    e.employee_id,
    e.name,
    e.department_id,
    e.position_id
FROM employees e
WHERE e.department_id IS NULL
   OR e.position_id IS NULL;

-- Report 6: Duplicate Attendance Records

SELECT
    employee_id,
    attendance_date,
    COUNT(*) AS total_records
FROM attendance
GROUP BY employee_id, attendance_date
HAVING COUNT(*) > 1;

