-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:4306
-- Generation Time: Aug 26, 2026 at 08:28 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hms`
--

-- --------------------------------------------------------

--
-- Table structure for table `ambulance`
--

CREATE TABLE `ambulance` (
  `ambulance_id` int(11) NOT NULL,
  `vehicle_number` varchar(20) DEFAULT NULL,
  `type` enum('Basic','Advanced','ICU') DEFAULT NULL,
  `driver_name` varchar(100) DEFAULT NULL,
  `contact` varchar(15) DEFAULT NULL,
  `status` enum('Available','Busy','Maintenance') DEFAULT 'Available',
  `location` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ambulance`
--

INSERT INTO `ambulance` (`ambulance_id`, `vehicle_number`, `type`, `driver_name`, `contact`, `status`, `location`, `created_at`) VALUES
(1, 'DHAKA-1111', 'Basic', 'Rahman Ali', '01511111111', 'Available', 'Hospital Parking', '2026-08-15 01:39:28'),
(2, 'DHAKA-2222', 'Advanced', 'Karim Mia', '01522222222', 'Busy', 'Dhanmondi', '2026-08-15 01:39:28'),
(3, 'DHAKA-3333', 'ICU', 'Hasan Ahmed', '01533333333', 'Available', 'Hospital Parking', '2026-08-15 01:39:28'),
(4, 'DHAKA-4444', 'Basic', 'Sakib Khan', '01544444444', 'Maintenance', 'Garage', '2026-08-15 01:39:28');

-- --------------------------------------------------------

--
-- Table structure for table `ambulance_call`
--

CREATE TABLE `ambulance_call` (
  `call_id` int(11) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `ambulance_id` int(11) DEFAULT NULL,
  `call_date` date DEFAULT NULL,
  `call_time` time DEFAULT NULL,
  `pickup_location` varchar(200) DEFAULT NULL,
  `drop_location` varchar(200) DEFAULT NULL,
  `status` enum('Requested','Dispatched','Completed','Cancelled') DEFAULT 'Requested',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ambulance_call`
--

INSERT INTO `ambulance_call` (`call_id`, `patient_id`, `ambulance_id`, `call_date`, `call_time`, `pickup_location`, `drop_location`, `status`, `created_at`) VALUES
(1, 1, 1, '2026-08-01', '09:30:00', 'Mirpur', 'City Hospital', 'Completed', '2026-08-15 01:40:51');

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appointment_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `appointment_date` date DEFAULT NULL,
  `appointment_time` time DEFAULT NULL,
  `purpose` text DEFAULT NULL,
  `status` enum('Scheduled','Completed','Cancelled') DEFAULT 'Scheduled',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointment_id`, `patient_id`, `doctor_id`, `appointment_date`, `appointment_time`, `purpose`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-08-15', '10:00:00', 'Heart checkup', 'Scheduled', NULL, '2026-08-15 01:40:10', '2026-08-15 01:40:10'),
(6, 6, 4, '2026-08-17', NULL, NULL, 'Completed', 't', '2026-08-15 02:45:36', '2026-08-15 02:45:36');

-- --------------------------------------------------------

--
-- Table structure for table `bed`
--

CREATE TABLE `bed` (
  `bed_id` int(11) NOT NULL,
  `ward_id` int(11) NOT NULL,
  `bed_number` varchar(20) DEFAULT NULL,
  `status` enum('Available','Occupied','Maintenance') DEFAULT 'Available',
  `patient_id` int(11) DEFAULT NULL,
  `admission_date` date DEFAULT NULL,
  `discharge_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bed`
--

INSERT INTO `bed` (`bed_id`, `ward_id`, `bed_number`, `status`, `patient_id`, `admission_date`, `discharge_date`) VALUES
(1, 1, 'B-101', '', NULL, '2026-08-15', NULL),
(6, 2, 'uuu', '', NULL, '2026-08-13', '2026-08-15');

-- --------------------------------------------------------

--
-- Table structure for table `billing`
--

CREATE TABLE `billing` (
  `bill_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `bill_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `paid_amount` decimal(10,2) DEFAULT NULL,
  `payment_method` enum('Cash','Card','Mobile Banking','Insurance') DEFAULT NULL,
  `payment_status` enum('Paid','Pending','Partial') DEFAULT 'Pending',
  `insurance_claim_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `billing`
--

INSERT INTO `billing` (`bill_id`, `patient_id`, `appointment_id`, `bill_date`, `total_amount`, `paid_amount`, `payment_method`, `payment_status`, `insurance_claim_id`, `created_at`) VALUES
(1, 1, 1, '2026-08-15', '1500.00', '1500.00', 'Cash', 'Paid', NULL, '2026-08-15 01:41:27');

-- --------------------------------------------------------

--
-- Table structure for table `blood_donor`
--

CREATE TABLE `blood_donor` (
  `donor_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `blood_group` varchar(5) NOT NULL,
  `contact` varchar(20) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `last_donation_date` date DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blood_donor`
--

INSERT INTO `blood_donor` (`donor_id`, `name`, `blood_group`, `contact`, `phone`, `email`, `address`, `district`, `last_donation_date`, `status`, `created_at`) VALUES
(1, 'Q', 'A+', '01222222222', '12222222222', 'acb@gmail.com', 'Dhaka', 'Chapainawabganj', '2026-08-25', 'Active', '2026-08-26 11:15:33'),
(2, 'z', 'A-', '11111111111111111111', '11111111111', 'aaa@gmail.com', 'qq', 'Bagerhat', '2026-08-01', 'Active', '2026-08-26 11:23:01'),
(3, 'C', 'O-', '12345654327', '87654321654', 'qqqq@gmail.com', 'ggg', 'Chapainawabganj', '2026-08-16', 'Active', '2026-08-26 12:25:30'),
(4, 'd', 'O-', '55555555555', '55555555555', 'f@gmail.com', 'l', 'Cox\'s Bazar', '2026-08-13', 'Inactive', '2026-08-26 12:36:40');

-- --------------------------------------------------------

--
-- Table structure for table `blood_request`
--

CREATE TABLE `blood_request` (
  `request_id` int(11) NOT NULL,
  `patient_name` varchar(100) NOT NULL,
  `blood_group` varchar(5) NOT NULL,
  `quantity` int(11) NOT NULL,
  `hospital` varchar(150) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `request_date` date NOT NULL,
  `status` enum('Pending','Fulfilled','Cancelled') DEFAULT 'Pending',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blood_request`
--

INSERT INTO `blood_request` (`request_id`, `patient_name`, `blood_group`, `quantity`, `hospital`, `district`, `contact`, `phone`, `request_date`, `status`, `notes`, `created_at`) VALUES
(2, 'A', 'A+', 111, 'a', 'Bandarban', '01111111111', '11111111111', '2026-08-26', 'Fulfilled', 'aa', '2026-08-26 11:14:11'),
(3, 'B', 'A-', 222, 'as', 'Cox\'s Bazar', '9999999999999999', '33333333333', '2026-08-26', 'Fulfilled', 'xx', '2026-08-26 11:21:47'),
(5, 'C', 'O+', 77, 'ss', 'Moulvibazar', '11111111111', '11111111111', '2026-08-26', 'Fulfilled', 'gg', '2026-08-26 12:08:11');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `head_doctor` int(11) DEFAULT NULL,
  `floor` varchar(20) DEFAULT NULL,
  `contact` varchar(15) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_id`, `name`, `head_doctor`, `floor`, `contact`, `description`, `created_at`) VALUES
(1, 'Cardiology', 1, '1st Floor', 'N/A', 'Heart and cardiovascular department', '2026-08-15 01:38:17'),
(2, 'Neurology', 2, '2nd Floor', 'N/A', 'Brain and nervous system department', '2026-08-15 01:38:17'),
(3, 'Orthopedics', 3, '3rd Floor', 'N/A', 'Bone and joint department', '2026-08-15 01:38:17'),
(4, 'General Medicine', 4, '1st Floor', 'N/A', 'General medical treatment department', '2026-08-15 01:38:17'),
(5, 'Emergency', 5, 'Ground Floor', 'N/A', 'Emergency treatment department', '2026-08-15 01:38:17');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `doctor_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `contact` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `qualification` text DEFAULT NULL,
  `experience_years` int(11) DEFAULT NULL,
  `schedule` text DEFAULT NULL,
  `consultation_fee` decimal(10,2) DEFAULT NULL,
  `availability` enum('Available','Unavailable','On Leave') DEFAULT 'Available',
  `joined_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`doctor_id`, `name`, `specialization`, `dept_id`, `contact`, `email`, `qualification`, `experience_years`, `schedule`, `consultation_fee`, `availability`, `joined_date`) VALUES
(1, 'Dr. Rahim Ahmed', 'Cardiologist', 1, '01811111111', 'rahim@hospital.com', 'MBBS, FCPS', 12, '9:00 AM - 2:00 PM', '1000.00', 'Available', '2018-01-10'),
(2, 'Dr. Karim Hasan', 'Neurologist', 2, '01822222222', 'karim@hospital.com', 'MBBS, MD', 10, '10:00 AM - 3:00 PM', '1200.00', 'Available', '2019-03-15'),
(3, 'Dr. Tanvir Islam', 'Orthopedic Surgeon', 3, '01833333333', 'tanvir@hospital.com', 'MBBS, MS', 8, '9:00 AM - 1:00 PM', '900.00', 'Available', '2020-06-20'),
(4, 'Dr. Nusrat Jahan', 'General Physician', 4, '01844444444', 'nusrat@hospital.com', 'MBBS, FCPS', 7, '11:00 AM - 4:00 PM', '700.00', 'Available', '2021-02-12'),
(5, 'Dr. Fahim Chowdhury', 'Emergency Physician', 5, '01855555555', 'fahim@hospital.com', 'MBBS, FCPS', 9, '24 Hours', '800.00', 'Available', '2019-09-05');

-- --------------------------------------------------------

--
-- Table structure for table `insurance`
--

CREATE TABLE `insurance` (
  `insurance_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `provider` varchar(100) DEFAULT NULL,
  `policy_number` varchar(50) DEFAULT NULL,
  `coverage_type` enum('Full','Partial','Basic') DEFAULT NULL,
  `coverage_amount` decimal(10,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `status` enum('Active','Expired','Cancelled') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `insurance`
--

INSERT INTO `insurance` (`insurance_id`, `patient_id`, `provider`, `policy_number`, `coverage_type`, `coverage_amount`, `start_date`, `expiry_date`, `status`, `created_at`) VALUES
(1, 1, 'Green Life Insurance', 'GL-10001', 'Full', '500000.00', '2026-01-01', '2026-12-31', 'Active', '2026-08-15 01:40:40');

-- --------------------------------------------------------

--
-- Table structure for table `labtest`
--

CREATE TABLE `labtest` (
  `test_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `test_type` varchar(100) DEFAULT NULL,
  `test_date` date DEFAULT NULL,
  `results` text DEFAULT NULL,
  `status` enum('Pending','Completed','Cancelled') DEFAULT 'Pending',
  `cost` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `labtest`
--

INSERT INTO `labtest` (`test_id`, `patient_id`, `doctor_id`, `test_type`, `test_date`, `results`, `status`, `cost`, `created_at`) VALUES
(1, 1, 1, 'ECG', '2026-08-10', 'Normal ECG', 'Completed', '500.00', '2026-08-15 01:40:19');

-- --------------------------------------------------------

--
-- Table structure for table `medicalrecord`
--

CREATE TABLE `medicalrecord` (
  `record_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `diagnosis` text DEFAULT NULL,
  `treatment` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `follow_up_date` date DEFAULT NULL,
  `status` enum('Active','Closed') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medicalrecord`
--

INSERT INTO `medicalrecord` (`record_id`, `patient_id`, `doctor_id`, `diagnosis`, `treatment`, `notes`, `follow_up_date`, `status`, `created_at`) VALUES
(1, 1, 1, 'Mild cardiac problem', 'Medicine and regular exercise', 'Patient advised to avoid stress', '2026-09-01', 'Active', '2026-08-15 01:40:29');

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

CREATE TABLE `medicine` (
  `medicine_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  `batch_number` varchar(50) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `quantity` int(11) DEFAULT 0,
  `unit` varchar(20) DEFAULT NULL,
  `pharmacy_id` int(11) DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`medicine_id`, `name`, `category`, `manufacturer`, `batch_number`, `expiry_date`, `price`, `quantity`, `unit`, `pharmacy_id`, `supplier_name`, `created_at`) VALUES
(1, 'Aspirin', 'Tablet', 'Square Pharma', 'ASP001', '2027-12-31', '5.00', 500, 'Tablet', 1, 'Square Pharmaceuticals', '2026-08-15 01:41:36'),
(2, 'Paracetamol', 'Tablet', 'Beximco Pharma', 'PAR001', '2028-06-30', '2.00', 1000, 'Tablet', 1, 'Beximco Pharmaceuticals', '2026-08-15 01:41:36'),
(3, 'Omeprazole', 'Capsule', 'Renata', 'OME001', '2027-10-31', '4.00', 700, 'Capsule', 2, 'Renata Limited', '2026-08-15 01:41:36'),
(4, 'Amlodipine', 'Tablet', 'Incepta', 'AML001', '2028-01-31', '3.50', 600, 'Tablet', 3, 'Incepta Pharmaceuticals', '2026-08-15 01:41:36'),
(5, 'Napa', 'Tablet', 'Beximco Pharma', 'NAP001', '2028-05-31', '2.00', 900, 'Tablet', 1, 'Beximco Pharmaceuticals', '2026-08-15 01:41:36');

-- --------------------------------------------------------

--
-- Table structure for table `operation`
--

CREATE TABLE `operation` (
  `op_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `operation_date` date DEFAULT NULL,
  `operation_type` varchar(100) DEFAULT NULL,
  `room` varchar(20) DEFAULT NULL,
  `status` enum('Scheduled','Completed','Cancelled') DEFAULT 'Scheduled',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `operation`
--

INSERT INTO `operation` (`op_id`, `patient_id`, `doctor_id`, `operation_date`, `operation_type`, `room`, `status`, `notes`, `created_at`) VALUES
(6, 16, 5, '2026-08-17', 'Appendectomy', '101', 'Completed', 'Emergency operation', '2026-08-15 12:56:18');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `contact` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `blood_group` varchar(5) DEFAULT NULL,
  `medical_history` text DEFAULT NULL,
  `emergency_contact` varchar(15) DEFAULT NULL,
  `status` enum('Active','Inactive','Discharged') DEFAULT 'Active',
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `name`, `date_of_birth`, `gender`, `contact`, `email`, `address`, `blood_group`, `medical_history`, `emergency_contact`, `status`, `registration_date`) VALUES
(1, 'Mahin Rahman', '2026-08-13', 'Male', '01911111111', 'mahin@gmail.com', 'Dhaka, Bangladesh', 'A+', 'No major history', '01999911111', 'Active', '2026-08-15 01:38:55'),
(6, 'xyz', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2026-08-15 02:45:36'),
(16, 'Rahim Ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2026-08-15 12:45:05'),
(17, 's', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2026-08-15 12:52:12');

-- --------------------------------------------------------

--
-- Table structure for table `pharmacy`
--

CREATE TABLE `pharmacy` (
  `pharmacy_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `location` varchar(200) DEFAULT NULL,
  `contact` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `working_hours` varchar(100) DEFAULT NULL,
  `pharmacist_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pharmacy`
--

INSERT INTO `pharmacy` (`pharmacy_id`, `name`, `location`, `contact`, `email`, `working_hours`, `pharmacist_name`, `created_at`) VALUES
(1, 'City Hospital Pharmacy', 'Ground Floor', '01311111111', 'pharmacy1@hospital.com', '8 AM - 10 PM', 'Mr. Hasan', '2026-08-15 01:41:09'),
(2, 'Emergency Pharmacy', 'Emergency Floor', '01322222222', 'pharmacy2@hospital.com', '24 Hours', 'Ms. Rima', '2026-08-15 01:41:09'),
(3, 'Main Pharmacy', '1st Floor', '01333333333', 'pharmacy3@hospital.com', '8 AM - 10 PM', 'Mr. Karim', '2026-08-15 01:41:09');

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

CREATE TABLE `prescription` (
  `prescription_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `prescription_date` date DEFAULT NULL,
  `diagnosis` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('Active','Completed','Cancelled') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `prescription`
--

INSERT INTO `prescription` (`prescription_id`, `patient_id`, `doctor_id`, `appointment_id`, `prescription_date`, `diagnosis`, `notes`, `status`, `created_at`) VALUES
(1, 1, 1, 1, '2026-08-15', 'Heart problem', 'Take medicine after meal', 'Cancelled', '2026-08-15 01:41:19');

-- --------------------------------------------------------

--
-- Table structure for table `prescription_medicine`
--

CREATE TABLE `prescription_medicine` (
  `prescription_id` int(11) NOT NULL,
  `medicine_id` int(11) NOT NULL,
  `dosage` varchar(50) DEFAULT NULL,
  `frequency` varchar(50) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `instructions` text DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `prescription_medicine`
--

INSERT INTO `prescription_medicine` (`prescription_id`, `medicine_id`, `dosage`, `frequency`, `duration`, `instructions`, `quantity`) VALUES
(1, 1, '100 mg', 'Once daily', '30 days', 'Take after breakfast', 30),
(1, 4, '5 mg', 'Once daily', '30 days', 'Take after dinner', 30);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `contact` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `shift_time` varchar(50) DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `status` enum('Active','Inactive','On Leave') DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `name`, `role`, `dept_id`, `contact`, `email`, `shift_time`, `joining_date`, `salary`, `status`) VALUES
(1, 'Abdul Karim', 'Nurse', 1, '01611111111', 'abdul@hospital.com', 'Morning', '2021-01-10', '500.00', 'Active'),
(2, 'Rima Akter', 'Nurse', 2, '01622222222', 'rima@hospital.com', 'Evening', '2022-03-15', '500.00', 'Active'),
(3, 'Hasan Ali', 'Receptionist', 4, '01633333333', 'hasan@hospital.com', 'Morning', '2020-05-20', '25000.00', 'Active'),
(4, 'Mitu Rahman', 'Nurse', 3, '01644444444', 'mitu@hospital.com', 'Night', '2023-02-10', '1000.00', 'Inactive'),
(5, 'Jamal Uddin', 'Technician', 4, '01655555555', 'jamal@hospital.com', 'Morning', '2021-08-01', '28000.00', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `name`, `password`, `role`, `created_at`) VALUES
(2, 'mahi', 'mahi', '$2y$10$XC0ZYruBMTiKlHKujV8v2uDBhjBfmV5sbKQiIojbcf6qwFKiJCWLa', 'user', '2026-08-15 02:01:04'),
(3, 'A', 'A', '$2y$10$BgwbXDF.EG/kuiZ3h.zbe.q/C7YOuV9wlazdsgIhTMEwPzvabcGbm', 'user', '2026-08-15 02:02:28'),
(4, 'Mahin', 'Mahin', '$2y$10$M0Ab35A9j4pFsrxyw.HE9uAlCH9AdnoFyC07rBaxF82QCT/1GRxJO', 'user', '2026-08-16 17:08:29'),
(5, 'B', 'A', '$2y$10$lcMXvqgBq8UoP0mCmjWP7OUbPMGAgUsqInaWyOn/e.6FgA/RkkDxu', 'user', '2026-08-17 08:18:55'),
(6, 'D', 'D', '$2y$10$DcHFTWe6YG8aQ68WUJjfn.iZIfaDjFTyxaHe6SSrBIYFvVijCmCaa', 'user', '2026-08-17 14:24:48'),
(7, 'admin', 'admin', '$2y$10$gWj77HkcR/2VXtKh3LdkKOLYu9BesinvyCYycMhs7LenWl8EFuHHC', 'user', '2026-08-19 13:45:16');

-- --------------------------------------------------------

--
-- Table structure for table `ward`
--

CREATE TABLE `ward` (
  `ward_id` int(11) NOT NULL,
  `ward_number` varchar(20) DEFAULT NULL,
  `ward_type` enum('General','Private','ICU','Emergency') DEFAULT NULL,
  `floor` varchar(20) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `current_occupancy` int(11) DEFAULT 0,
  `status` enum('Available','Full','Maintenance') DEFAULT 'Available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ward`
--

INSERT INTO `ward` (`ward_id`, `ward_number`, `ward_type`, `floor`, `capacity`, `current_occupancy`, `status`, `created_at`) VALUES
(1, 'W-101', 'General', '1st Floor', 20, 5, 'Available', '2026-08-15 01:39:36'),
(2, 'W-201', 'Private', '2nd Floor', 10, 3, 'Available', '2026-08-15 01:39:36'),
(3, 'W-301', 'ICU', '3rd Floor', 8, 4, 'Full', '2026-08-15 01:39:36'),
(4, 'W-401', 'Emergency', 'Ground Floor', 15, 8, 'Available', '2026-08-15 01:39:36'),
(5, 'W-501', 'General', '5th Floor', 25, 25, 'Full', '2026-08-15 01:39:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ambulance`
--
ALTER TABLE `ambulance`
  ADD PRIMARY KEY (`ambulance_id`),
  ADD UNIQUE KEY `vehicle_number` (`vehicle_number`);

--
-- Indexes for table `ambulance_call`
--
ALTER TABLE `ambulance_call`
  ADD PRIMARY KEY (`call_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `ambulance_id` (`ambulance_id`);

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `bed`
--
ALTER TABLE `bed`
  ADD PRIMARY KEY (`bed_id`),
  ADD KEY `ward_id` (`ward_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`bill_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `appointment_id` (`appointment_id`),
  ADD KEY `insurance_claim_id` (`insurance_claim_id`);

--
-- Indexes for table `blood_donor`
--
ALTER TABLE `blood_donor`
  ADD PRIMARY KEY (`donor_id`);

--
-- Indexes for table `blood_request`
--
ALTER TABLE `blood_request`
  ADD PRIMARY KEY (`request_id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_id`),
  ADD KEY `fk_department_head_doctor` (`head_doctor`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`doctor_id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `insurance`
--
ALTER TABLE `insurance`
  ADD PRIMARY KEY (`insurance_id`),
  ADD UNIQUE KEY `policy_number` (`policy_number`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `labtest`
--
ALTER TABLE `labtest`
  ADD PRIMARY KEY (`test_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `medicalrecord`
--
ALTER TABLE `medicalrecord`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `medicine`
--
ALTER TABLE `medicine`
  ADD PRIMARY KEY (`medicine_id`),
  ADD KEY `pharmacy_id` (`pharmacy_id`);

--
-- Indexes for table `operation`
--
ALTER TABLE `operation`
  ADD PRIMARY KEY (`op_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `pharmacy`
--
ALTER TABLE `pharmacy`
  ADD PRIMARY KEY (`pharmacy_id`);

--
-- Indexes for table `prescription`
--
ALTER TABLE `prescription`
  ADD PRIMARY KEY (`prescription_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `appointment_id` (`appointment_id`);

--
-- Indexes for table `prescription_medicine`
--
ALTER TABLE `prescription_medicine`
  ADD PRIMARY KEY (`prescription_id`,`medicine_id`),
  ADD KEY `medicine_id` (`medicine_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `ward`
--
ALTER TABLE `ward`
  ADD PRIMARY KEY (`ward_id`),
  ADD UNIQUE KEY `ward_number` (`ward_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ambulance`
--
ALTER TABLE `ambulance`
  MODIFY `ambulance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ambulance_call`
--
ALTER TABLE `ambulance_call`
  MODIFY `call_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `bed`
--
ALTER TABLE `bed`
  MODIFY `bed_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `billing`
--
ALTER TABLE `billing`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `blood_donor`
--
ALTER TABLE `blood_donor`
  MODIFY `donor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `blood_request`
--
ALTER TABLE `blood_request`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `dept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `insurance`
--
ALTER TABLE `insurance`
  MODIFY `insurance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `labtest`
--
ALTER TABLE `labtest`
  MODIFY `test_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `medicalrecord`
--
ALTER TABLE `medicalrecord`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `medicine`
--
ALTER TABLE `medicine`
  MODIFY `medicine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `operation`
--
ALTER TABLE `operation`
  MODIFY `op_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `pharmacy`
--
ALTER TABLE `pharmacy`
  MODIFY `pharmacy_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `prescription`
--
ALTER TABLE `prescription`
  MODIFY `prescription_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `ward`
--
ALTER TABLE `ward`
  MODIFY `ward_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ambulance_call`
--
ALTER TABLE `ambulance_call`
  ADD CONSTRAINT `ambulance_call_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ambulance_call_ibfk_2` FOREIGN KEY (`ambulance_id`) REFERENCES `ambulance` (`ambulance_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bed`
--
ALTER TABLE `bed`
  ADD CONSTRAINT `bed_ibfk_1` FOREIGN KEY (`ward_id`) REFERENCES `ward` (`ward_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bed_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `billing`
--
ALTER TABLE `billing`
  ADD CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `billing_ibfk_2` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `billing_ibfk_3` FOREIGN KEY (`insurance_claim_id`) REFERENCES `insurance` (`insurance_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `fk_department_head_doctor` FOREIGN KEY (`head_doctor`) REFERENCES `doctor` (`doctor_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `doctor`
--
ALTER TABLE `doctor`
  ADD CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `insurance`
--
ALTER TABLE `insurance`
  ADD CONSTRAINT `insurance_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `labtest`
--
ALTER TABLE `labtest`
  ADD CONSTRAINT `labtest_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `labtest_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `medicalrecord`
--
ALTER TABLE `medicalrecord`
  ADD CONSTRAINT `medicalrecord_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `medicalrecord_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `medicine`
--
ALTER TABLE `medicine`
  ADD CONSTRAINT `medicine_ibfk_1` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacy` (`pharmacy_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `operation`
--
ALTER TABLE `operation`
  ADD CONSTRAINT `operation_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `operation_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prescription`
--
ALTER TABLE `prescription`
  ADD CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prescription_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prescription_ibfk_3` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `prescription_medicine`
--
ALTER TABLE `prescription_medicine`
  ADD CONSTRAINT `prescription_medicine_ibfk_1` FOREIGN KEY (`prescription_id`) REFERENCES `prescription` (`prescription_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prescription_medicine_ibfk_2` FOREIGN KEY (`medicine_id`) REFERENCES `medicine` (`medicine_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
