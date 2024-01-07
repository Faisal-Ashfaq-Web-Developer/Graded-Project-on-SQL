Table:- Doctor
Table keys:-
doctor_id => PK
doctor_name
email
contact_no
password
spl_id => FK


Table:- Appointments
Table keys:-
appointment_id => PK
date
patient_id => FK
doctor_id => FK
status
prescription


Table:- Patient
Table keys:-
patient_id => PK
patient_name
email
contact_no
password
appointment_id => FK

Table:- Specialty
Table keys:-
spl_id => PK
spl_name


Table:- Transaction
Table keys:-
transaction_id => PK
date
amount
appointment_id => FK


Table:- Reviews_appointments
Table keys:-
review_id => PK
description
review_score
appointment_id => FK


Table:- Reviews_doctor
Table keys:-
review_id => PK
description
review_score
patient_id => FK
doctor_id => FK


-- Create the Specialty table
CREATE TABLE Specialty (
    spl_id INT PRIMARY KEY AUTO_INCREMENT,
    spl_name VARCHAR(255) NOT NULL
);

-- Create the Doctor table
CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    contact_no VARCHAR(20) NOT NULL,
    password VARCHAR(255) NOT NULL,
    spl_id INT,
    FOREIGN KEY (spl_id) REFERENCES Specialty(spl_id)
);

-- Create the Patient table
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    contact_no VARCHAR(20) NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Create the Appointments table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    date DATETIME NOT NULL,
    patient_id INT,
    doctor_id INT,
    status VARCHAR(50) NOT NULL,
    prescription TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Create the Transaction table
CREATE TABLE Transaction (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    date DATETIME NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    appointment_id INT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Create the Reviews_appointments table
CREATE TABLE Reviews_appointments (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    description TEXT NOT NULL,
    review_score INT NOT NULL,
    appointment_id INT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Create the Reviews_doctor table
CREATE TABLE Reviews_doctor (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    description TEXT NOT NULL,
    review_score INT NOT NULL,
    patient_id INT,
    doctor_id INT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);