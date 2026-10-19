-- =========================================
-- Company Management System
-- File: 01_schema.sql
-- Description: Database Structure
-- =========================================

CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

-- =========================================
-- 1. Departments Table
-- =========================================

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- =========================================
-- 2. Job Positions Table
-- =========================================

CREATE TABLE job_positions (
    position_id INT PRIMARY KEY,
    position_name VARCHAR(50),
    min_salary DECIMAL(10,2),
    max_salary DECIMAL(10,2)
);

-- =========================================
-- 3. Employees Table
-- =========================================

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    department_id INT,
    position_id INT,

    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id),

    CONSTRAINT fk_employee_position
        FOREIGN KEY (position_id)
        REFERENCES job_positions(position_id)
);
-- =========================================
-- 4. Projects Table
-- =========================================

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    start_date DATE,
    end_date DATE,
    
    CONSTRAINT chk_project_dates
	CHECK (end_date >= start_date)
);

-- =========================================
-- 5. Employee Projects Table
-- =========================================

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,

    PRIMARY KEY (employee_id, project_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),

    FOREIGN KEY (project_id)
        REFERENCES projects(project_id)
);

-- =========================================
-- 6. Attendance Table
-- =========================================

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    employee_id INT,
    attendance_date DATE,
    check_in TIME,
    check_out TIME,
    status VARCHAR(50),
	CONSTRAINT uq_employee_attendance
    UNIQUE (employee_id, attendance_date),
    CONSTRAINT fk_attendance_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- =========================================
-- 7. Leaves Table
-- =========================================

CREATE TABLE leaves (
    leave_id INT PRIMARY KEY,
    employee_id INT,
    start_date DATE,
    end_date DATE,
    leave_type VARCHAR(50),
    status VARCHAR(50),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- =========================================
-- 8. Payroll Table
-- =========================================

CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY,
    employee_id INT,
    pay_month DATE,
    base_salary DECIMAL(10,2),
    bonus DECIMAL(10,2) DEFAULT 0,
    deductions DECIMAL(10,2) DEFAULT 0,
	CONSTRAINT uq_employee_payroll
    UNIQUE (employee_id, pay_month),
    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- =========================================
-- 9. Performance Reviews Table
-- =========================================

CREATE TABLE performance_reviews (
    review_id INT PRIMARY KEY,
    employee_id INT,
    review_date DATE,
    rating INT,
    comments VARCHAR(255),

    CHECK (rating BETWEEN 1 AND 5),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- =========================================
-- 10. Project Tasks Table
-- =========================================

CREATE TABLE project_tasks (
    task_id INT PRIMARY KEY,
    project_id INT,
    employee_id INT,
    task_name VARCHAR(100),
    due_date DATE,
    status VARCHAR(30),
    priority VARCHAR(30),

    FOREIGN KEY (project_id)
        REFERENCES projects(project_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);




