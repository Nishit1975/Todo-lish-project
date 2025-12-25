CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Users (UserName, Email, PasswordHash) VALUES
('admin', 'admin@gmail.com', 'admin123'),
('rahul', 'rahul@gmail.com', 'rahul123'),
('priya', 'priya@gmail.com', 'priya123'),
('amit', 'amit@gmail.com', 'amit123'),
('neha', 'neha@gmail.com', 'neha123');

CREATE TABLE Roles (
    RoleID INT AUTO_INCREMENT PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO Roles (RoleName) VALUES
('Admin'),
('User');

CREATE TABLE UserRoles (
    UserRoleID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    RoleID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

INSERT INTO UserRoles (UserID, RoleID) VALUES
(1, 1),  -- admin → Admin
(2, 2),
(3, 2),
(4, 2),
(5, 2);

CREATE TABLE Projects (
    ProjectID INT AUTO_INCREMENT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    CreatedBy INT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

INSERT INTO Projects (ProjectName, Description, CreatedBy) VALUES
('Todo App', 'Todo management system', 1),
('College Project', 'Final year project', 2),
('Office Work', 'Daily office tasks', 1);

CREATE TABLE TaskLists (
    ListID INT AUTO_INCREMENT PRIMARY KEY,
    ProjectID INT,
    ListName VARCHAR(100) NOT NULL,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

INSERT INTO TaskLists (ProjectID, ListName) VALUES
(1, 'Pending'),
(1, 'In Progress'),
(1, 'Completed'),
(2, 'Pending'),
(2, 'Completed');

CREATE TABLE Tasks (
    TaskID INT AUTO_INCREMENT PRIMARY KEY,
    ListID INT,
    AssignedTo INT,
    Title VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    Priority VARCHAR(10) CHECK (Priority IN ('Low','Medium','High')),
    Status VARCHAR(20) CHECK (Status IN ('Pending','In Progress','Completed')),
    DueDate DATE,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ListID) REFERENCES TaskLists(ListID),
    FOREIGN KEY (AssignedTo) REFERENCES Users(UserID)
);

INSERT INTO Tasks 
(ListID, AssignedTo, Title, Description, Priority, Status, DueDate)
VALUES
(1, 2, 'Login Page', 'Design login UI', 'High', 'Pending', '2025-12-25'),
(2, 3, 'Dashboard', 'Create dashboard page', 'Medium', 'In Progress', '2025-12-28'),
(3, 4, 'Testing', 'Test all modules', 'Low', 'Completed', '2025-12-20'),
(4, 5, 'Documentation', 'Prepare project docs', 'Medium', 'Pending', '2025-12-30'),
(5, 2, 'Submission', 'Submit project', 'High', 'Completed', '2025-12-22');

CREATE TABLE TaskComments (
    CommentID INT AUTO_INCREMENT PRIMARY KEY,
    TaskID INT,
    UserID INT,
    CommentText VARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

INSERT INTO TaskComments (TaskID, UserID, CommentText) VALUES
(1, 1, 'Start this task today'),
(2, 3, 'Work is going on'),
(3, 4, 'Task completed successfully'),
(4, 5, 'Documentation in progress'),
(5, 2, 'Submitted to client');

CREATE TABLE TaskHistory (
    HistoryID INT AUTO_INCREMENT PRIMARY KEY,
    TaskID INT,
    ChangedBy INT,
    ChangeType VARCHAR(50) NOT NULL,
    ChangeTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID),
    FOREIGN KEY (ChangedBy) REFERENCES Users(UserID)
);

INSERT INTO TaskHistory (TaskID, ChangedBy, ChangeType) VALUES
(1, 1, 'Task Created'),
(2, 3, 'Status Updated'),
(3, 4, 'Task Completed'),
(4, 5, 'Task Assigned'),
(5, 2, 'Task Closed');
