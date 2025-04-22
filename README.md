# Clinic Management System - Database Backend

## 🏥 Project Description
This project provides a comprehensive database solution for managing a medical clinic's operations. The system is designed to handle:

- Patient records and demographics
- Doctor information and specializations
- Department management
- Appointment scheduling
- Medical records tracking

The database schema is normalized to **3NF** (Third Normal Form) to ensure data integrity and efficient query performance.

---

## 🛠️ Technical Features
- **MySQL** relational database.
- Properly normalized schema (**3NF**) for data consistency.
- Comprehensive constraints and relationships (e.g., foreign keys).
- Sample data for immediate testing.
- Timestamp tracking for all records.

---

## 📂 Project Structure
- `clinic.sql`: SQL script to create the database schema and populate it with sample data.
- `README.md`: Documentation for the database schema and usage.

---

## 🚀 Setup Instructions

### Prerequisites
- MySQL Server (8.0+ recommended).
- MySQL Workbench or any SQL client tool.

### Installation Steps
1. **Create the database**:
   ```sql
   CREATE DATABASE clinic_management;
   USE clinic_management;

2. Import the SQL schema:
   Execute the complete SQL script provided in clinic_management.sql
   This will create all tables, relationships, and sample data

3. Verify the setup: Run the following query to ensure the tables are created:
   SHOW TABLES;

## 📊 Database Schema (ERD)
Clinic Management ERD

Entity Relationship Diagram showing all tables and their relationships


## 🔍 Sample Queries
Get all appointments for a patient:
    SELECT * FROM appointments WHERE patient_id = 1;

Find available doctors in a department:
    SELECT d.* FROM doctors d
    JOIN doctor_departments dd ON d.doctor_id = dd.doctor_id
    WHERE dd.department_id = 1;



# Task Manager API

This project is a simple **Task Manager API** built using **FastAPI** and **MySQL**. It provides endpoints to create and retrieve tasks, enabling efficient task management. The database schema is defined in SQL and includes tables for users and tasks.

## Features

- RESTful API for managing tasks.
- **FastAPI** for building the backend.
- **Pydantic** for data validation.
- **MySQL** for database operations.
- Sample data for quick testing.

## Project Structure

- `main.py`: The FastAPI application that defines the API endpoints and connects to the MySQL database.
- `Taskmanager.sql`: The SQL script to set up the database schema and insert sample data.
- `README.md`: Documentation for the project.

## Endpoints

### 1. Create a Task
**POST** `/tasks/`

- **Request Body**:
  ```json
  {
    "task_name": "string",
    "description": "string",
    "status": "string",
    "due_date": "YYYY-MM-DD",
    "user_id": integer
  }

  Installation Steps 
1. Clone the repository:
   git clone <repository-url>
   cd Clinic-booking-system-database
2. Install dependencies:
   pip install fastapi pydantic mysql-connector-python uvicorn

3. Set up the database:
    Open MySQL and execute the Taskmanager.sql script

4. Run the FastAPI application:
   uvicorn main:app --reload

5. Access the API documentation at:
    Swagger UI: http://127.0.0.1:8000/docs
    ReDoc: http://127.0.0.1:8000/redoc

📝 License
This project is open-source and available under the MIT License.
