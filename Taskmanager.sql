--QUESTION 2 USING A TASK MANAGER SCHEMA

-- Create database
CREATE DATABASE IF NOT EXISTS task_manager;
USE task_manager;

-- Create users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create tasks table
CREATE TABLE tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    status ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
    due_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
-- Sample Data for Users
INSERT INTO Users (Username, Email) VALUES
('John James', 'johnjames@gmail.com'),
('Jane Wanjiku', 'janewanjiku@gmail.com');

-- Sample Data for Tasks
INSERT INTO Tasks (TaskName, Description, Status, DueDate, UserID) VALUES
('Complete Homework', 'Complete math homework', 'In Progress', '2025-04-20', 1),
('Buy Groceries', 'Purchase weekly groceries', 'Pending', '2025-04-21', 2);

