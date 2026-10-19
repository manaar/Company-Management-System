# Company Management System

## Overview
A relational database portfolio project built with MySQL to manage company employees, departments, job positions, projects, attendance, leave records, payroll, and performance reviews.

The project demonstrates relational database design, SQL querying, data integrity, and reporting.

## Technologies
- MySQL
- MySQL Workbench
- SQL
- Entity Relationship Diagram (ERD)

## Database Structure
The database contains 10 related tables:

1. `departments`
2. `job_positions`
3. `employees`
4. `projects`
5. `employee_projects`
6. `attendance`
7. `leaves`
8. `payroll`
9. `performance_reviews`
10. `project_tasks`

## Features
- Manage employee and department information
- Track job positions and salaries
- Assign employees to projects and track tasks
- Record attendance and leave
- Maintain payroll and performance review records
- Generate reports with `JOIN`, `GROUP BY`, `HAVING`, and aggregate functions
- Enforce data integrity with primary keys, foreign keys, `UNIQUE`, and `CHECK` constraints

## Sample Dataset
After running the expansion script, the tested database contains:

| Item | Count |
|---|---:|
| Departments | 5 |
| Job positions | 9 |
| Employees | 50 |
| Projects | 10 |
| Employee-project assignments | 51 |
| Attendance records | 1,109 |
| Leave records | 9 |
| Payroll records | 150 |
| Performance reviews | 9 |
| Project tasks | 100 |

## How to Run
1. Open MySQL Workbench and connect to a MySQL server.
2. Create a database named `company_db` (or update the `USE` statement in each SQL script to use your chosen database).
3. Run these files **in order**, once each:
   1. `01_schema.sql` — Create tables and constraints.
   2. `02_sample_data.sql` — Insert initial records.
   3. `05_expansion.sql` — Generate the expanded dataset.
   4. `03_queries.sql` — Explore SQL queries.
   5. `04_reports.sql` — Run reports and data-quality checks.
4. Review the ERD image, if included, to understand the relationships.

**Note:** Run the insert scripts on a fresh database to avoid duplicate primary-key errors.

## Repository Files
| File | Purpose |
|---|---|
| `01_schema.sql` | Database tables, keys, and constraints |
| `02_sample_data.sql` | Initial sample records |
| `03_queries.sql` | SQL practice and analytical queries |
| `04_reports.sql` | Reports and validation queries |
| `05_expansion.sql` | Expanded dataset generation |
| `company_erd.png` | ERD image (if included) |
| `Company_Management_ERD.mwb` | MySQL Workbench model (if included) |
| `README.md` | Project documentation |

## Testing
The five SQL scripts were tested in sequence against a clean MySQL database. The resulting dataset counts were verified, and checks for invalid project assignments, task dates, and duplicate attendance records returned no violations.

## Skills Demonstrated
Relational database modeling, primary and foreign keys, SQL joins, grouping and aggregation, common table expressions, window functions, data validation, and reporting.
