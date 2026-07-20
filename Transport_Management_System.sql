CREATE DATABASE IF NOT EXISTS Transport_Management_System;
SHOW DATABASES;
USE Transport_Management_System;

-- Create a Customer Table
CREATE TABLE customer (
    customer_id         INT AUTO_INCREMENT PRIMARY KEY,
    name                VARCHAR(100) NOT NULL,
    birth_date          DATE NOT NULL,
    age                 INT,
    contact             VARCHAR(20) NOT NULL UNIQUE,                                 
    address_city        VARCHAR(50),
    address_street      VARCHAR(50),
    address_land_mark   VARCHAR(50)
);
DESC customer;

-- Create a Vehicle table
CREATE TABLE vehicle (
    vehicle_id  INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    category    VARCHAR(30) NOT NULL
);
DESC vehicle;

-- Create a Driver_data Table
CREATE TABLE driver_data (
    driver_id   INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    birth_date  DATE NOT NULL,
    age         INT,
    contact     VARCHAR(20) NOT NULL UNIQUE,                                
    address     VARCHAR(150)
);
DESC driver_data;

-- Create a Parking_area Table
CREATE TABLE parking_area (
    place_id        INT AUTO_INCREMENT PRIMARY KEY,
    parking_place   VARCHAR(100) NOT NULL
);
DESC parking_area;

-- Create a Service_type Table
CREATE TABLE service_type (
    type_id     INT AUTO_INCREMENT PRIMARY KEY,
    included    VARCHAR(200) NOT NULL
);
DESC service_type;

-- Create a Cost Table
CREATE TABLE cost (
    cost_id                 INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id              INT NOT NULL,
    start_location_city     VARCHAR(50),
    start_location_street   VARCHAR(50),
    start_location_land_mark VARCHAR(50),
    end_location_city       VARCHAR(50),
    end_location_street     VARCHAR(50),
    end_location_land_mark  VARCHAR(50),
    amount                  DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_cost_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicle(vehicle_id) ON DELETE CASCADE
);
DESC cost;

-- Create a Route Table
CREATE TABLE route (
    route_id    INT AUTO_INCREMENT PRIMARY KEY,
    cost_id     INT NOT NULL UNIQUE,
    distance_km DECIMAL(6,2),
    CONSTRAINT fk_route_cost FOREIGN KEY (cost_id)
        REFERENCES cost(cost_id) ON DELETE CASCADE
);
DESC route;

-- Create a Booking Table
CREATE TABLE booking (
    booking_id  INT AUTO_INCREMENT PRIMARY KEY,
    date        DATE NOT NULL,
    customer_id INT NOT NULL,
    vehicle_id  INT NOT NULL,
    CONSTRAINT fk_booking_customer FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_booking_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicle(vehicle_id) ON DELETE CASCADE
);
DESC booking;

-- Create a Trip Table
CREATE TABLE trip (
    trip_id     INT AUTO_INCREMENT PRIMARY KEY,
    booking_id  INT NOT NULL UNIQUE,
    vehicle_id  INT NOT NULL,
    driven_by   INT NOT NULL,
    parked_at   INT NULL,
    route_id    INT NULL,
    CONSTRAINT fk_trip_booking FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id) ON DELETE CASCADE,
    CONSTRAINT fk_trip_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicle(vehicle_id) ON DELETE CASCADE,
    CONSTRAINT fk_trip_driver FOREIGN KEY (driven_by)
        REFERENCES driver_data(driver_id) ON DELETE RESTRICT,
    CONSTRAINT fk_trip_parking FOREIGN KEY (parked_at)
        REFERENCES parking_area(place_id) ON DELETE SET NULL,
    CONSTRAINT fk_trip_route FOREIGN KEY (route_id)
        REFERENCES route(route_id) ON DELETE SET NULL
);
DESC trip;

-- Create a Vehicle_service Table
CREATE TABLE vehicle_service (
    service_id  INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id  INT NOT NULL,
    type_id     INT NOT NULL,
    date        DATE NOT NULL,
    CONSTRAINT fk_service_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicle(vehicle_id) ON DELETE CASCADE,
    CONSTRAINT fk_service_type FOREIGN KEY (type_id)
        REFERENCES service_type(type_id) ON DELETE RESTRICT
);
DESC vehicle_service;

-- Create a Rent_place Table
CREATE TABLE rent_place (
    rent_id     INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id  INT NOT NULL,
    contact     VARCHAR(20) NOT NULL,
    address     VARCHAR(150) NOT NULL,
    CONSTRAINT fk_rentplace_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicle(vehicle_id) ON DELETE CASCADE
);
DESC rent_place;

-- Insert Data

SHOW DATABASES;
USE Transport_Management_System;

INSERT INTO customer (name, birth_date, age, contact, address_city, address_street, address_land_mark) VALUES
('Kasun Perera',      '1990-04-12', '0771234567', 'Colombo',   'Galle Road',    'Near Town Hall'),
('Nimali Fernando',   '1985-09-23', '0772345678', 'Kandy',     'Peradeniya Rd', 'Opposite Lake'),
('Ruwan Silva',       '1995-01-05', '0773456789', 'Galle',     'Main Street',   'Near Fort'),
('Sanduni Jayasuriya', '1998-07-30', '0774567890', 'Matara',    'Beach Road',    'Near Bus Stand'),
('Dilshan Rathnayake', '1992-11-17', '0775678901', 'Jaffna',    'KKS Road',      'Near Market'),
('Tharushi Bandara',  '2000-03-08', '0776789012', 'Negombo',   'Lewis Place',   'Near Beach');
SELECT * FROM customer;

INSERT INTO vehicle (name, category) VALUES
('Toyota Hiace',   'Van'),
('Nissan Caravan', 'Van'),
('Toyota Corolla', 'Car'),
('Ashok Leyland',  'Bus'),
('Honda Civic',    'Car'),
('Tata Ace',       'Lorry');
SELECT * FROM vehicle;

INSERT INTO driver_data (name, birth_date, contact, address) VALUES
('Sunil Kumara',    '1980-05-14', '0711111111', 'Colombo, Sri Lanka'),
('Amal Perera',     '1978-08-22', '0712222222', 'Kandy, Sri Lanka'),
('Nuwan Chandrasiri','1988-02-19', '0713333333', 'Galle, Sri Lanka'),
('Kamal Weerasinghe','1983-12-01', '0714444444', 'Matara, Sri Lanka'),
('Sampath Kumara',  '1991-06-27', '0715555555', 'Jaffna, Sri Lanka'),
('Chaminda Silva',  '1986-10-09', '0716666666', 'Negombo, Sri Lanka');
SELECT * FROM driver_data;

INSERT INTO parking_area (parking_place) VALUES
('Colombo Fort Parking'),
('Kandy City Parking'),
('Galle Bus Stand Parking'),
('Matara Terminal Parking'),
('Jaffna Central Parking'),
('Negombo Beach Parking');
SELECT * FROM parking_area;

INSERT INTO service_type (included) VALUES
('Oil Change, Filter Replacement'),
('Full Service, Brake Check'),
('Tyre Replacement'),
('AC Service'),
('Engine Overhaul'),
('General Inspection');
SELECT * FROM service_type;

INSERT INTO cost (vehicle_id, start_location_city, start_location_street, start_location_land_mark,
                   end_location_city, end_location_street, end_location_land_mark, amount) VALUES
(1, 'Colombo', 'Galle Road',    'Town Hall',    'Kandy',   'Peradeniya Rd', 'Lake',        4500.00),
(2, 'Colombo', 'Baseline Rd',   'Race Course',  'Galle',   'Main Street',   'Fort',        6200.00),
(3, 'Kandy',   'Peradeniya Rd', 'Lake',         'Matara',  'Beach Road',    'Bus Stand',   8300.00),
(4, 'Galle',   'Main Street',   'Fort',         'Jaffna',  'KKS Road',      'Market',      15000.00),
(5, 'Matara',  'Beach Road',    'Bus Stand',    'Negombo', 'Lewis Place',   'Beach',       9700.00),
(6, 'Negombo', 'Lewis Place',   'Beach',        'Colombo', 'Galle Road',    'Town Hall',   3200.00);
SELECT * FROM cost;

INSERT INTO route (cost_id, distance_km) VALUES
(1, 115.50),
(2, 120.00),
(3, 160.30),
(4, 400.00),
(5, 180.75),
(6, 35.20);
SELECT * FROM route;

INSERT INTO booking (date, customer_id, vehicle_id) VALUES
('2026-06-01', 1, 1),
('2026-06-03', 2, 2),
('2026-06-05', 3, 3),
('2026-06-08', 4, 4),
('2026-06-10', 5, 5),
('2026-06-12', 6, 6);
SELECT * FROM booking;

INSERT INTO trip (booking_id, vehicle_id, driven_by, parked_at, route_id) VALUES
(1, 1, 1, 1, 1),
(2, 2, 2, 2, 2),
(3, 3, 3, 3, 3),
(4, 4, 4, 4, 4),
(5, 5, 5, 5, 5),
(6, 6, 6, 6, 6);
SELECT * FROM trip;

INSERT INTO vehicle_service (vehicle_id, type_id, date) VALUES
(1, 1, '2026-05-01'),
(2, 2, '2026-05-05'),
(3, 3, '2026-05-10'),
(4, 4, '2026-05-15'),
(5, 5, '2026-05-20'),
(6, 6, '2026-05-25');
SELECT * FROM vehicle_service;

INSERT INTO rent_place (vehicle_id, contact, address) VALUES
(1, '0117001001', 'No. 12, Galle Road, Colombo'),
(2, '0117002002', 'No. 45, Kandy Road, Kandy'),
(3, '0117003003', 'No. 8, Fort Road, Galle'),
(4, '0117004004', 'No. 22, Beach Road, Matara'),
(5, '0117005005', 'No. 3, KKS Road, Jaffna'),
(6, '0117006006', 'No. 17, Lewis Place, Negombo');
SELECT * FROM rent_place;

-- Add age colomn in Customer Table
UPDATE customer
SET age=20
WHERE customer_id=1;

UPDATE customer
SET age=21
WHERE customer_id=2;

UPDATE customer
SET age=22
WHERE customer_id=3;

UPDATE customer
SET age=23
WHERE customer_id=4;

UPDATE customer
SET age=24
WHERE customer_id=5;

UPDATE customer
SET age=25
WHERE customer_id=6;
SELECT * FROM customer;

-- Add age column in Driver_data Table
UPDATE driver_data
SET age = 26
WHERE driver_id=1;

UPDATE driver_data
SET age = 27
WHERE driver_id=2;

UPDATE driver_data
SET age = 28
WHERE driver_id=3;

UPDATE driver_data
SET age = 29
WHERE driver_id=4;

UPDATE driver_data
SET age = 30
WHERE driver_id=5;

UPDATE driver_data
SET age = 31
WHERE driver_id=6;
SELECT age FROM driver_data;

-- Update customer table
UPDATE customer
SET contact = '0779998888'
WHERE customer_id = 1;
SELECT contact,customer_id FROM customer;

-- Update vehicle table
UPDATE vehicle
SET category = 'Mini Van'
WHERE vehicle_id = 2;
SELECT * FROM vehicle;

-- Delete row in rent_place table
DELETE FROM rent_place
WHERE rent_id = 6;

SELECT * FROM rent_place;

-- If we want car category
SELECT * FROM vehicle
WHERE category = 'Car';

-- If we want name and category in vehicle table
SELECT name, category
FROM vehicle;

-- customer table name column and vehicle table name column
SELECT customer.name, vehicle.name
FROM customer, vehicle;

-- Create view 
CREATE OR REPLACE VIEW view_vehicle_list AS
SELECT vehicle_id, name, category
FROM vehicle;
SELECT * FROM view_vehicle_list;

-- Vehicle name replace vehicle_name and category replace vehicle_category
SELECT name AS vehicle_name, category AS vehicle_category
FROM vehicle;

-- Take Average amount in cost table , and also amount replace average_trip_cost
SELECT AVG(amount) AS average_trip_cost
FROM cost;

-- We need names that start with the letter "k"
SELECT * FROM customer
WHERE name LIKE 'K%';

-- Combined customer table and driver_data table (name and role)
SELECT customer.name AS person_name, 'Customer' AS role
FROM customer
UNION
SELECT driver_data.name AS person_name, 'Driver' AS role
FROM driver_data;

-- Intersect
SELECT b.vehicle_id AS vehicle_id
FROM booking AS b
INTERSECT
SELECT vs.vehicle_id AS vehicle_id
FROM vehicle_service AS vs;

-- Division
SELECT DISTINCT b1.customer_id AS customer_id
FROM booking AS b1
WHERE NOT EXISTS (
SELECT v.category AS category
FROM vehicle AS v
WHERE NOT EXISTS (
SELECT 1
FROM booking AS b2
JOIN vehicle AS v2 ON b2.vehicle_id = v2.vehicle_id
WHERE b2.customer_id = b1.customer_id
AND v2.category = v.category
    )
);

-- Both booking and vehicle service vehicle_id AS ID
SELECT booking.vehicle_id AS ID 
FROM booking
INNER JOIN vehicle_service
ON booking.vehicle_id = vehicle_service.vehicle_id;

INSERT INTO vehicle (name,category) VALUES('Nissan GTR','Car');

-- The result is 0 records from left side
SELECT vehicle.vehicle_id AS vehicle_id
FROM vehicle
RIGHT OUTER JOIN vehicle_service
ON vehicle.vehicle_id = vehicle_service.vehicle_id ;

-- Retrive vehicles that exist in the vehicle table but do not exist in the vehicle_service table (NOT IN)
SELECT v.vehicle_id
FROM vehicle AS v
WHERE v.vehicle_id 
NOT IN (
		SELECT vs.vehicle_id
		FROM vehicle_service AS vs
);

-- Retrive vehicles that exist in the vehicle table but do not exist in the vehicle_service table (NOT EXISTS)
SELECT vehicle.vehicle_id
FROM vehicle
WHERE NOT EXISTS (
    SELECT 1
    FROM vehicle_service
    WHERE vehicle_service.vehicle_id = vehicle.vehicle_id
);

-- Create a New table AS view_trip_inner ( data collect - booking,trip,customer,vehicle tables)
CREATE OR REPLACE VIEW view_trip_inner AS 
SELECT trip.trip_id AS trip_id,customer.name AS customer_name, vehicle.name AS vehicle_name, booking.date AS booking_date
FROM trip
INNER JOIN booking 
ON trip.booking_id = booking.booking_id
INNER JOIN customer 
ON booking.customer_id = customer.customer_id
INNER JOIN vehicle 
ON trip.vehicle_id  = vehicle.vehicle_id;

SELECT * FROM view_trip_inner;

-- Retrieves all columns from the joined tables
CREATE OR REPLACE VIEW view_service_natural AS
SELECT *
FROM vehicle_service
NATURAL JOIN service_type;

SELECT * FROM view_service_natural;

-- Create  a table view_customer_left ( Even if a customer does not have a booking,it will show up in the results)
CREATE OR REPLACE VIEW view_customer_left AS
SELECT customer.customer_id AS customer_id, customer.name AS customer_name, booking.booking_id AS booking_id
FROM customer
LEFT JOIN booking
ON customer.customer_id = booking.customer_id;

SELECT * FROM view_customer_left;

-- combined selected column and 2 table using right and left join AS a new table
CREATE OR REPLACE VIEW view_customer_vehicle_full AS
SELECT c.customer_id AS customer_id, c.name AS customer_name, b.booking_id AS booking_id
FROM customer AS c
LEFT JOIN booking AS b 
ON c.customer_id = b.customer_id
UNION
SELECT c.customer_id AS customer_id, c.name AS customer_name, b.booking_id AS booking_id
FROM booking AS b
RIGHT JOIN customer AS c 
ON c.customer_id = b.customer_id;

SELECT * FROM view_customer_vehicle_full;

-- Combined selected columns in customer and driver_data tables As a new table 
CREATE OR REPLACE VIEW view_person_outer_union AS
SELECT c.customer_id AS person_id, c.name AS person_name, c.contact AS contact,
       'Customer' AS role, c.address_city AS city, NULL AS driver_address
FROM customer AS c
UNION
SELECT d.driver_id AS person_id, d.name AS person_name, d.contact AS contact,
       'Driver' AS role, NULL AS city, d.address AS driver_address
FROM driver_data AS d;

SELECT * FROM view_person_outer_union;

-- If we want cost table ,vehicle_id (amount > Overall average amount in cost table)
SELECT v.vehicle_id AS vehicle_id, v.name AS vehicle_name
FROM vehicle AS v
WHERE v.vehicle_id IN (
						SELECT c.vehicle_id AS vehicle_id
						FROM cost AS c
						WHERE c.amount > (SELECT AVG(amount) AS avg_amount FROM cost)
);

-- Booking table and customer table same customer_id rows
SELECT c.customer_id AS customer_id, c.name AS customer_name
FROM customer AS c
WHERE EXISTS (
			SELECT 1
			FROM booking AS b
			WHERE b.customer_id = c.customer_id
);

-- number of trips per vehicle
SELECT v.vehicle_id AS vehicle_id, v.name AS vehicle_name, t.trip_count AS trip_count
FROM vehicle AS v
JOIN (
    SELECT vehicle_id AS vehicle_id, COUNT(*) AS trip_count
    FROM trip
    GROUP BY vehicle_id
	 ) AS t 
ON v.vehicle_id = t.vehicle_id;

-- filter on vehicle(category)
EXPLAIN SELECT * FROM vehicle WHERE category = 'Car'; 
CREATE INDEX idx_vehicle_category ON vehicle(category);
EXPLAIN SELECT * FROM vehicle WHERE category = 'Car';

-- LIKE search on customer(name)
EXPLAIN SELECT * FROM customer WHERE name LIKE 'K%';
CREATE INDEX idx_customer_name ON customer(name);
EXPLAIN SELECT * FROM customer WHERE name LIKE 'K%'; 

-- Filter bookings(customer_id)
EXPLAIN SELECT * FROM booking WHERE customer_id = 3;
CREATE INDEX idx_booking_customer ON booking(customer_id);
EXPLAIN SELECT * FROM booking WHERE customer_id = 3;

-- Filter trips(driver)
EXPLAIN SELECT * FROM trip WHERE driven_by = 2;
CREATE INDEX idx_trip_driver ON trip(driven_by);
EXPLAIN SELECT * FROM trip WHERE driven_by = 2;

-- Join cost to vehicle on vehicle_id
EXPLAIN 
SELECT cost.cost_id, vehicle.name, cost.amount
FROM cost
JOIN vehicle ON cost.vehicle_id = vehicle.vehicle_id
WHERE cost.amount > 5000;

CREATE INDEX idx_cost_amount ON cost(amount);

EXPLAIN 
SELECT cost.cost_id, vehicle.name, cost.amount
FROM cost
JOIN vehicle ON cost.vehicle_id = vehicle.vehicle_id
WHERE cost.amount > 5000;

-- Sort bookings(date)
EXPLAIN SELECT * FROM booking ORDER BY date DESC;
CREATE INDEX idx_booking_date ON booking(date);
EXPLAIN SELECT * FROM booking ORDER BY date DESC;

--  Range query on route distance
EXPLAIN SELECT * FROM route 
WHERE distance_km BETWEEN 100 AND 200;
CREATE INDEX idx_route_distance ON route(distance_km);
EXPLAIN SELECT * FROM route 
WHERE distance_km BETWEEN 100 AND 200;

-- Group vehicle_service by service date range
EXPLAIN 
SELECT vehicle_id, COUNT(*) 
FROM vehicle_service 
WHERE date >= '2026-05-01' 
GROUP BY vehicle_id;

CREATE INDEX idx_service_date ON vehicle_service(date);

EXPLAIN 
SELECT vehicle_id, COUNT(*) 
FROM vehicle_service 
WHERE date >= '2026-05-01' 
GROUP BY vehicle_id;

-- Composite index for a two-column filter
EXPLAIN SELECT * FROM vehicle_service WHERE vehicle_id = 4 AND type_id = 4;
CREATE INDEX idx_service_vehicle_type ON vehicle_service(vehicle_id, type_id);
EXPLAIN SELECT * FROM vehicle_service WHERE vehicle_id = 4 AND type_id = 4;

--  Driver lookup by contact
EXPLAIN SELECT * FROM driver_data WHERE contact = '0712222222';
CREATE INDEX idx_driver_contact ON driver_data(contact);
EXPLAIN SELECT * FROM driver_data WHERE contact = '0712222222';







      
 
             
















