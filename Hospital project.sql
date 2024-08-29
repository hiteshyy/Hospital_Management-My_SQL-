create database hospital;

use hospital;


CREATE TABLE patients (
    PatientID INT  PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(50)
    
);

CREATE TABLE Doctors (
    DoctorID INT  PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(50),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(50),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);


CREATE TABLE Appointments (
    AppointmentID INT  PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME,
    Reason TEXT,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE MedicalRecords (
    RecordID INT  PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Diagnosis TEXT,
    Treatment TEXT,
    Prescription TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Staff (
    StaffID INT  PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Role VARCHAR(50),
    DepartmentID INT,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(50),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Billing (
    BillID INT  PRIMARY KEY,
    PatientID INT,
    AppointmentID INT,
    Amount DECIMAL(10, 2),
    BillingDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

CREATE TABLE Rooms (
    RoomID INT  PRIMARY KEY,
    RoomNumber VARCHAR(10) NOT NULL,
    RoomType VARCHAR(50),
    Status VARCHAR(20)
);

INSERT INTO Patients (PatientID,FirstName, LastName, DOB, Gender, Address, PhoneNumber, Email) VALUES
(1,'Rajesh', 'Yadav', '1980-01-01', 'Male', '123 kurla', '555-1234', 'rajesh.yadav@example.com'),
(2,'Maheshwari', 'Shetty', '1990-02-02', 'Female', '456 sion', '555-2345', 'maheshwarishetty@example.com'),
(3,'Kevin', 'Dsuza', '2000-03-03', 'Male', '789 parel', '555-3456', 'kevin.dsuza@example.com');

INSERT INTO Doctors (DoctorID,FirstName, LastName, Specialty, PhoneNumber, Email, DepartmentID) VALUES
(1,'Deepak ', 'Shukla', 'Cardiologist', '123-456-7890', 'deepak.shukla@hospital.com', 1),
(2,'John', 'Smith', 'Neurologist', '234-567-8901', 'john.smith@hospital.com', 2),
(3,'Sanjana', 'Patil', 'Pediatrician', '345-678-9012', 'sanjana.patil@hospital.com', 3),
(4,'Yasin', 'Khan', 'Orthopedic Surgeon', '456-789-0123', 'yasin.khan@hospital.com', 4);

INSERT INTO Departments (DepartmentID,DepartmentName, Location) VALUES
(1,'Cardiology', 'Building A'),
(2,'Neurology', 'Building B'),
(3,'Pediatrics', 'Building C'),
(4,'Orthopedics', 'Building D');

INSERT INTO Appointments (AppointmentID,PatientID, DoctorID, AppointmentDate, Reason, Status) VALUES
(1,1, 1, '2024-07-20 10:00:00', 'Regular Checkup', 'Scheduled'),
(2,2, 2, '2024-07-21 11:00:00', 'Headache', 'Scheduled'),
(3,3, 3, '2024-07-22 09:00:00', 'Child Vaccination', 'Scheduled');


INSERT INTO MedicalRecords (RecordID,PatientID, DoctorID, Date, Diagnosis, Treatment, Prescription) VALUES
(1,1, 1, '2024-01-10', 'Hypertension', 'Lifestyle changes and medication', 'Lisinopril'),
(2,2, 2, '2024-02-15', 'Migraine', 'Pain management and medication', 'Sumatriptan'),
(3,3, 3, '2024-03-20', 'Asthma', 'Inhaler and medication', 'Albuterol');

INSERT INTO Staff (StaffID,FirstName, LastName, Role, DepartmentID, PhoneNumber, Email) VALUES
(1,'Vikrant', 'Clark', 'Nurse', 1, '555-4567', 'vikrant.clark@hospital.com'),
(2,'Aanand', 'Lee', 'Technician', 2, '555-5678', 'aanand.lee@hospital.com'),
(3,'Sophia', 'Walker', 'Receptionist', 3, '555-6789', 'sophia.walker@hospital.com');


INSERT INTO Billing (BillID,PatientID, AppointmentID, Amount, BillingDate, Status) VALUES
(1,1, 1, 150.00, '2024-07-20', 'Unpaid'),
(2,2, 2, 200.00, '2024-07-21', 'Paid'),
(3,3, 3, 100.00, '2024-07-22', 'Unpaid');

INSERT INTO Rooms (RoomID,RoomNumber, RoomType, Status) VALUES
(1,'101', 'Single', 'Available'),
(2,'102', 'Double', 'Occupied'),
(3,'103', 'ICU', 'Available');

SELECT a.AppointmentID, a.AppointmentDate, a.Reason, a.Status, 
       p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, 
       d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID;

SELECT d.DoctorID, d.FirstName, d.LastName, d.Specialty, dep.DepartmentName
FROM Doctors d
JOIN Departments dep ON d.DepartmentID = dep.DepartmentID;

