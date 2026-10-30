-- Project 1: Health & Welfare Benefits Analytics
-- MySQL 8.0+ | All data is synthetic.
CREATE DATABASE IF NOT EXISTS benefits_analytics;
USE benefits_analytics;

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS eligibility;
DROP TABLE IF EXISTS plans;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS clients;

CREATE TABLE clients (
  client_id VARCHAR(10) PRIMARY KEY,
  client_name VARCHAR(100) NOT NULL,
  industry VARCHAR(60),
  client_location VARCHAR(60)
);

CREATE TABLE employees (
  employee_id VARCHAR(10) PRIMARY KEY,
  client_id VARCHAR(10) NOT NULL,
  department VARCHAR(60),
  location VARCHAR(60),
  hire_date DATE,
  employment_status VARCHAR(30),
  CONSTRAINT fk_employees_client FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE TABLE plans (
  plan_id VARCHAR(10) PRIMARY KEY,
  client_id VARCHAR(10) NOT NULL,
  benefit_type VARCHAR(30) NOT NULL,
  plan_name VARCHAR(100) NOT NULL,
  vendor_name VARCHAR(100),
  effective_date DATE NOT NULL,
  end_date DATE NULL,
  CONSTRAINT fk_plans_client FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE TABLE eligibility (
  eligibility_id VARCHAR(12) PRIMARY KEY,
  employee_id VARCHAR(10) NOT NULL,
  plan_id VARCHAR(10) NOT NULL,
  eligibility_start_date DATE NOT NULL,
  eligibility_end_date DATE NOT NULL,
  eligibility_status VARCHAR(20) NOT NULL,
  CONSTRAINT fk_eligibility_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
  CONSTRAINT fk_eligibility_plan FOREIGN KEY (plan_id) REFERENCES plans(plan_id)
);

CREATE TABLE enrollments (
  enrollment_id VARCHAR(12) PRIMARY KEY,
  employee_id VARCHAR(10) NOT NULL,
  plan_id VARCHAR(10) NOT NULL,
  enrollment_status VARCHAR(30),
  coverage_start_date DATE,
  coverage_end_date DATE,
  CONSTRAINT fk_enrollments_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
  CONSTRAINT fk_enrollments_plan FOREIGN KEY (plan_id) REFERENCES plans(plan_id)
);
