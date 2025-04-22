-- Clinic Booking System Database
-- Created: 2025-04-22
-- Author: Mbitu James

-- Create database
CREATE DATABASE IF NOT EXISTS clinic_management;
USE clinic_management;

-- Patients table
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE,
    address TEXT,
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%'),
    CONSTRAINT chk_phone CHECK (phone REGEXP '^[0-9]{10,15}$')
);

-- Doctors table
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    hire_date DATE NOT NULL,
    status ENUM('Active', 'On Leave', 'Inactive') DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Departments table
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    location VARCHAR(100),
    head_doctor_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (head_doctor_id) REFERENCES doctors(doctor_id) ON DELETE SET NULL
);

-- Doctor-Department relationship (M-M)
CREATE TABLE doctor_departments (
    doctor_id INT NOT NULL,
    department_id INT NOT NULL,
    PRIMARY KEY (doctor_id, department_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE
);

-- Appointments table
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    department_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled', 'No Show') DEFAULT 'Scheduled',
    reason TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT chk_appointment_time CHECK (end_time > start_time),
    CONSTRAINT unique_doctor_timeslot UNIQUE (doctor_id, appointment_date, start_time)
);

-- Medical records table
CREATE TABLE medical_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_id INT,
    diagnosis TEXT,
    treatment TEXT,
    prescription TEXT,
    notes TEXT,
    record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE SET NULL
);

-- Sample data insertion
INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone, email, blood_type) VALUES
('John', 'James', '1985-05-15', 'Male', '0712345678', 'jj@gmail.com', 'A+'),
('Sarah', 'Wangeci', '2005-12-09', 'Female', '0722334455', 'sarahw@gmail.com', 'B-'),
('Michael', 'Williams', '2010-11-30', 'Male', '0721436587', 'michaelwilliams@gmail.com', 'O+');

INSERT INTO doctors (first_name, last_name, specialization, phone, email, license_number, hire_date) VALUES
('Robert', 'Brown', 'Cardiology', '0712345678', 'drbrown@clinic.com', 'MD12345', '2015-06-10'),
('Emily', 'Kiptoo', 'Pediatrics', '0798765432', 'drdavis@clinic.com', 'MD67890', '2018-03-15'),
('David', 'Wilson', 'Orthopedics', '0721435678', 'drwilson@clinic.com', 'MD54321', '2020-01-20');

INSERT INTO departments (name, description, location, head_doctor_id) VALUES
('Cardiology', 'Heart and cardiovascular system', 'First Floor, West Wing', 1),
('Pediatrics', 'Child healthcare', 'Second Floor, East Wing', 2),
('Orthopedics', 'Musculoskeletal system', 'First Floor, East Wing', 3);

INSERT INTO doctor_departments (doctor_id, department_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 3); -- Dr. Brown also works in Orthopedics

INSERT INTO appointments (patient_id, doctor_id, department_id, appointment_date, start_time, end_time, status, reason) VALUES
(1, 1, 1, '2025-01-01', '09:00:00', '09:30:00', 'Scheduled', 'Annual heart checkup'),
(2, 2, 2, '2025-01-01', '10:00:00', '10:45:00', 'Scheduled', 'Child vaccination'),
(3, 3, 3, '2025-02-02', '14:00:00', '14:30:00', 'Scheduled', 'Knee pain consultation'),
(1, 3, 3, '2025-02-05', '11:00:00', '11:30:00', 'Scheduled', 'Back pain evaluation');

INSERT INTO medical_records (patient_id, doctor_id, appointment_id, diagnosis, treatment, prescription) VALUES
(1, 1, 1, 'Normal cardiac function', 'No treatment needed', 'None'),
(2, 2, 2, 'Routine vaccination', 'Administered MMR vaccine', 'None'),
(3, 3, 3, 'Mild knee osteoarthritis', 'Physical therapy recommended', 'Ibuprofen 200mg as needed for pain');

