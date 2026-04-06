CREATE DATABASE HealthcareDB;
USE HealthcareDB;

-- TABLE CREATION
-- DEPARTMENT

CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- STAFF

CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    Phone VARCHAR(15),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- DOCTOR

CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    Phone VARCHAR(15),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- PATIENT

CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT CHECK (Age > 0),
    Gender VARCHAR(10),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

-- APPOINTMENT

CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

-- MEDICAL RECORD

CREATE TABLE Medical_Record (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentID INT,
    Diagnosis VARCHAR(255),
    Treatment VARCHAR(255),
    RecordDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

-- PRESCRIPTION

CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    RecordID INT,
    MedicineName VARCHAR(100),
    Dosage VARCHAR(50),
    Duration VARCHAR(50),
    FOREIGN KEY (RecordID) REFERENCES Medical_Record(RecordID)
);

-- BILLING

CREATE TABLE Billing (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    AppointmentID INT,
    Amount DECIMAL(10,2),
    PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Paid','Pending')),
    BillingDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

-- PAYMENT

CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BillID INT,
    AmountPaid DECIMAL(10,2),
    PaymentMethod VARCHAR(50),
    PaymentDate DATE,
    FOREIGN KEY (BillID) REFERENCES Billing(BillID)
);

-- SAMPLE DATA INSERTION

INSERT INTO Department (DepartmentName) VALUES
('Cardiology'),
('Neurology'),
('Orthopedics'),
('Pediatrics'),
('Dermatology'),
('Oncology'),
('Radiology'),
('General Medicine');


INSERT INTO Staff (Name, Role, Phone, DepartmentID) VALUES
('Amit Kumar', 'Nurse', '9000000001', 1),
('Priya Sharma', 'Receptionist', '9000000002', 2),
('Rohit Singh', 'Technician', '9000000003', 3),
('Neha Verma', 'Nurse', '9000000004', 4),
('Suresh Yadav', 'Admin', '9000000005', 5),
('Kiran Patel', 'Nurse', '9000000006', 6),
('Anil Gupta', 'Technician', '9000000007', 7),
('Meena Joshi', 'Receptionist', '9000000008', 8);

INSERT INTO Doctor (Name, Specialization, Phone, DepartmentID) VALUES
('Dr. Sharma', 'Cardiologist', '9111111111', 1),
('Dr. Mehta', 'Neurologist', '9222222222', 2),
('Dr. Rao', 'Orthopedic', '9333333333', 3),
('Dr. Khan', 'Pediatrician', '9444444444', 4),
('Dr. Das', 'Dermatologist', '9555555555', 5),
('Dr. Iyer', 'Oncologist', '9666666666', 6),
('Dr. Kapoor', 'Radiologist', '9777777777', 7),
('Dr. Singh', 'General Physician', '9888888888', 8);

INSERT INTO Patient (Name, Age, Gender, Phone, Address) VALUES
('Rahul Verma', 30, 'Male', '8000000001', 'Delhi'),
('Anita Singh', 25, 'Female', '8000000002', 'Mumbai'),
('Vikas Sharma', 40, 'Male', '8000000003', 'Jaipur'),
('Pooja Mehta', 35, 'Female', '8000000004', 'Pune'),
('Aman Gupta', 28, 'Male', '8000000005', 'Chandigarh'),
('Sneha Kapoor', 22, 'Female', '8000000006', 'Delhi'),
('Ravi Patel', 50, 'Male', '8000000007', 'Ahmedabad'),
('Kavita Joshi', 45, 'Female', '8000000008', 'Lucknow');

INSERT INTO Appointment (PatientID, DoctorID, AppointmentDate, AppointmentTime, Status) VALUES
(1, 1, '2026-04-01', '10:00:00', 'Completed'),
(2, 2, '2026-04-02', '11:00:00', 'Pending'),
(3, 3, '2026-04-03', '12:00:00', 'Completed'),
(4, 4, '2026-04-04', '09:30:00', 'Completed'),
(5, 5, '2026-04-05', '02:00:00', 'Pending'),
(6, 6, '2026-04-06', '03:00:00', 'Completed'),
(7, 7, '2026-04-07', '01:30:00', 'Pending'),
(8, 8, '2026-04-08', '04:00:00', 'Completed');

INSERT INTO Medical_Record (PatientID, DoctorID, AppointmentID, Diagnosis, Treatment, RecordDate) VALUES
(1, 1, 1, 'Heart Issue', 'Medication', '2026-04-01'),
(3, 3, 3, 'Fracture', 'Surgery', '2026-04-03'),
(4, 4, 4, 'Fever', 'Medication', '2026-04-04'),
(6, 6, 6, 'Cancer Check', 'Therapy', '2026-04-06'),
(8, 8, 8, 'General Checkup', 'Advice', '2026-04-08'),
(2, 2, 2, 'Migraine', 'Medication', '2026-04-02'),
(5, 5, 5, 'Skin Allergy', 'Ointment', '2026-04-05'),
(7, 7, 7, 'X-Ray Scan', 'Observation', '2026-04-07');

INSERT INTO Prescription (RecordID, MedicineName, Dosage, Duration) VALUES
(1, 'Aspirin', '1 tablet', '5 days'),
(2, 'Painkiller', '2 tablets', '7 days'),
(3, 'Paracetamol', '1 tablet', '3 days'),
(4, 'Chemo Drug', 'As prescribed', '30 days'),
(5, 'Vitamin D', '1 tablet', '10 days'),
(6, 'Migraine Tab', '1 tablet', '5 days'),
(7, 'Skin Cream', 'Apply twice', '7 days'),
(8, 'Calcium', '1 tablet', '15 days');

INSERT INTO Billing (PatientID, AppointmentID, Amount, PaymentStatus, BillingDate) VALUES
(1, 1, 1500.00, 'Paid', '2026-04-01'),
(2, 2, 1200.00, 'Pending', '2026-04-02'),
(3, 3, 5000.00, 'Paid', '2026-04-03'),
(4, 4, 800.00, 'Paid', '2026-04-04'),
(5, 5, 600.00, 'Pending', '2026-04-05'),
(6, 6, 7000.00, 'Paid', '2026-04-06'),
(7, 7, 2000.00, 'Pending', '2026-04-07'),
(8, 8, 1000.00, 'Paid', '2026-04-08');

INSERT INTO Payment (BillID, AmountPaid, PaymentMethod, PaymentDate) VALUES
(1, 1500.00, 'Cash', '2026-04-01'),
(3, 5000.00, 'Card', '2026-04-03'),
(4, 800.00, 'UPI', '2026-04-04'),
(6, 7000.00, 'Net Banking', '2026-04-06'),
(8, 1000.00, 'Cash', '2026-04-08'),
(1, 1500.00, 'UPI', '2026-04-01'),
(3, 5000.00, 'Cash', '2026-04-03'),
(6, 7000.00, 'Card', '2026-04-06');


-- Query 1: Display All Patients

SELECT * FROM Patient;

-- Query 2: Display All Doctors with Department

SELECT d.Name, d.Specialization, dept.DepartmentName
FROM Doctor d
JOIN Department dept ON d.DepartmentID = dept.DepartmentID;

-- Query 3: Appointment Details (Patient + Doctor)

SELECT p.Name AS Patient, d.Name AS Doctor, a.AppointmentDate, a.Status
FROM Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Doctor d ON a.DoctorID = d.DoctorID;

-- Query 4: Total Appointments per Doctor

SELECT d.Name, COUNT(a.AppointmentID) AS TotalAppointments
FROM Doctor d
LEFT JOIN Appointment a ON d.DoctorID = a.DoctorID
GROUP BY d.Name;

-- Query 5: Total Billing per Patient

SELECT p.Name, SUM(b.Amount) AS TotalBill
FROM Patient p
JOIN Billing b ON p.PatientID = b.PatientID
GROUP BY p.Name;

-- Query 6: Find Pending Payments

SELECT * FROM Billing
WHERE PaymentStatus = 'Pending';

-- Query 7: Medical Records with Doctor Details

SELECT p.Name, d.Name AS Doctor, m.Diagnosis, m.Treatment
FROM Medical_Record m
JOIN Patient p ON m.PatientID = p.PatientID
JOIN Doctor d ON m.DoctorID = d.DoctorID;

-- Query 8: Prescription Details for Patients

SELECT p.Name, pr.MedicineName, pr.Dosage, pr.Duration
FROM Prescription pr
JOIN Medical_Record m ON pr.RecordID = m.RecordID
JOIN Patient p ON m.PatientID = p.PatientID;

-- Query 9: Total Revenue Generated

SELECT SUM(Amount) AS TotalRevenue FROM Billing;

-- Query 10: Update Payment Status

UPDATE Billing
SET PaymentStatus = 'Paid'
WHERE BillID = 2;

-- Query 11: Search Patients by Name

SELECT * FROM Patient
WHERE Name LIKE 'R%';


-- Query 12: Delete an Appointment 
DELETE FROM Appointment
WHERE AppointmentID = 9;

-- INDEX

CREATE INDEX idx_patient_name ON Patient(Name);

CREATE INDEX idx_appointment_date ON Appointment(AppointmentDate);

CREATE INDEX idx_doctor_name ON Doctor(Name);

-- VIEW

-- Patient Appointment View

CREATE VIEW Patient_Appointment_View AS
SELECT 
    p.PatientID,
    p.Name AS PatientName,
    d.Name AS DoctorName,
    d.Specialization,
    a.AppointmentDate,
    a.AppointmentTime,
    a.Status
FROM Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Doctor d ON a.DoctorID = d.DoctorID;

SELECT * FROM Patient_Appointment_View;

-- Billing Summary View

CREATE VIEW Billing_Summary_View AS
SELECT 
    p.Name AS PatientName,
    b.Amount,
    b.PaymentStatus,
    b.BillingDate
FROM Billing b
JOIN Patient p ON b.PatientID = p.PatientID;

SELECT * FROM Billing_Summary_View;

-- 3. STORED PROCEDURE (Reusable Logic)

--  Get Bills for a Patient

DELIMITER //

CREATE PROCEDURE GetPatientBills(IN pid INT)
BEGIN
    SELECT * 
    FROM Billing
    WHERE PatientID = pid;
END //

DELIMITER ;
CALL GetPatientBills(1);

-- TRIGGER

-- Auto-update Payment Status


DELIMITER //

CREATE TRIGGER trg_update_payment_status
AFTER INSERT ON Payment
FOR EACH ROW
BEGIN
    UPDATE Billing
    SET PaymentStatus = 'Paid'
    WHERE BillID = NEW.BillID;
END //

DELIMITER ;
