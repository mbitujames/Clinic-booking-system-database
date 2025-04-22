# This is a simple FastAPI application that connects to a MySQL database to manage tasks.
# It allows creating and retrieving tasks with a Restful API.
# It uses Pydantic for data validation and Mysql Connector for database operations.

# import necessary libraries
from fastapi import FastAPI
from pydantic import BaseModel
import mysql.connector

app = FastAPI()

# MySQL Database Connection
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="task_manager"
)

cursor = db.cursor()

# Pydantic model for task
class Task(BaseModel):
    task_name: str
    description: str
    status: str
    due_date: str
    user_id: int

@app.post("/tasks/")
def create_task(task: Task):
    cursor.execute("INSERT INTO Tasks (TaskName, Description, Status, DueDate, UserID) VALUES (%s, %s, %s, %s, %s)", 
                   (task.task_name, task.description, task.status, task.due_date, task.user_id))
    db.commit()
    return {"message": "Task created successfully"}

@app.get("/tasks/")
def get_tasks():
    cursor.execute("SELECT * FROM Tasks")
    tasks = cursor.fetchall()
    return {"tasks": tasks}
