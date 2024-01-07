-- 1. Write a SQL query to obtain doctor-name and spl-id.
-- query:-
SELECT doctor_name, spl_id FROM Doctor;


-- 2. Write a query to obtain a total number of appointments in a day.
-- query:-
SELECT COUNT(*) AS total_appointments
FROM Appointments
WHERE DATE(date) = '2023-10-14';  -- Replace with the date you're interested in


-- 3. Write a query to find out the peak day(having maximum number of appointments) in the week.
-- query:-
SELECT DATE(date) AS appointment_date, COUNT(*) AS total_appointments
FROM Appointments
WHERE WEEK(date) = WEEK(CURDATE())  -- Change this to the week you are interested in
GROUP BY DATE(date)
ORDER BY total_appointments DESC
LIMIT 1;


-- 4. Write a query to find the status of every appointment for today.
-- query:-
SELECT appointment_id, status
FROM Appointments
WHERE DATE(date) = CURDATE();


-- 5. Find out the contact-details for a specific doctor with name -xyz.
-- query:-
SELECT doctor_id, email, contact_no
FROM Doctor
WHERE doctor_name = 'xyz';  -- Replace 'xyz' with the actual name you're interested in


-- 6. Create a SQL query to count the number of patients who have scheduled appointments with a particular doctor.
-- query:-
SELECT doctor_id, COUNT(DISTINCT patient_id) AS total_patients
FROM Appointments
WHERE doctor_id = 1  -- Replace 1 with the actual doctor_id you're interested in
GROUP BY doctor_id;


-- 7. Create a SQL query to count the number of patients who have scheduled appointments with a particular doctor.
-- query:-
SELECT doctor_id, COUNT(DISTINCT patient_id) AS total_patients
FROM Appointments
WHERE doctor_id = 1  -- Replace 1 with the actual doctor_id you're interested in
GROUP BY doctor_id;


-- 8. Create a SQL query to figure out the total transactions happened for each speciality.
-- query:-
SELECT s.spl_id, s.spl_name, COUNT(t.transaction_id) AS total_transactions
FROM Transaction t
JOIN Appointments a ON t.appointment_id = a.appointment_id
JOIN Doctor d ON a.doctor_id = d.doctor_id
JOIN Specialty s ON d.spl_id = s.spl_id
GROUP BY s.spl_id, s.spl_name
ORDER BY total_transactions DESC;


-- 9. Create a query to count how many distinct specialities are there in the hospital.
-- query:-
SELECT COUNT(*) AS total_specialties
FROM Specialty;


-- 10. Create a stored procedure to update the password of a particular patient.
-- query:-
DELIMITER //
CREATE PROCEDURE UpdatePatientPassword(IN patientId INT, IN newPassword VARCHAR(255))
BEGIN
    UPDATE Patient
    SET password = newPassword
    WHERE patient_id = patientId;
END;
//
DELIMITER ;
CALL UpdatePatientPassword(1, 'new_password');  -- Replace 1 with the actual patient_id and 'new_password' with the new password


-- 11. Select name of patients who have taken appointment for a particular doctor for today.
-- query:-
SELECT p.patient_name
FROM Appointments a
JOIN Patient p ON a.patient_id = p.patient_id
WHERE a.doctor_id = 1  -- Replace 1 with the actual doctor_id you're interested in
AND DATE(a.date) = CURDATE();


-- 12. Select which patient appointments are in pending state.
-- query:-
SELECT p.patient_id, p.patient_name, a.appointment_id
FROM Appointments a
JOIN Patient p ON a.patient_id = p.patient_id
WHERE a.status = 'pending';


-- 13. Find out the prescription, doctor name and patient name of all the done appointments for today.
-- query:-
SELECT d.doctor_name, p.patient_name, a.prescription
FROM Appointments a
JOIN Doctor d ON a.doctor_id = d.doctor_id
JOIN Patient p ON a.patient_id = p.patient_id
WHERE a.status = 'done'  -- Adjust this value if your database uses a different term for done appointments
AND DATE(a.date) = CURDATE();


-- 14. Find out the amount paid by a particular patient in last 1 month.
-- query:-
SELECT SUM(t.amount) AS total_amount_paid
FROM Transaction t
JOIN Appointments a ON t.appointment_id = a.appointment_id
WHERE a.patient_id = 1  -- Replace 1 with the actual patient_id you're interested in
AND t.date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);


-- 15. Select doctor name, doctor speciality name and status of appointment for today.
-- query:-
SELECT d.doctor_name, s.spl_name, a.status
FROM Appointments a
JOIN Doctor d ON a.doctor_id = d.doctor_id
JOIN Specialty s ON d.spl_id = s.spl_id
WHERE DATE(a.date) = CURDATE();