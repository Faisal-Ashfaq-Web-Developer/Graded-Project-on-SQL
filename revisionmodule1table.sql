-- Create Model table
CREATE TABLE Model (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    model_name VARCHAR(255),
    first_production_year INT
);

-- Create Make table
CREATE TABLE Make (
    make_id INT PRIMARY KEY AUTO_INCREMENT,
    make_name VARCHAR(255),
    Country VARCHAR(255)
);

-- Create Color table
CREATE TABLE Color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    Code VARCHAR(10)
);

-- Create Vehicle table
CREATE TABLE Vehicle (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    fk_make_id INT,
    fk_model_id INT,
    FOREIGN KEY (fk_make_id) REFERENCES Make(make_id),
    FOREIGN KEY (fk_model_id) REFERENCES Model(model_id)
);

-- Create Inventory table
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    fk_vehicle_id INT,
    fk_color_id INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (fk_vehicle_id) REFERENCES Vehicle(vehicle_id),
    FOREIGN KEY (fk_color_id) REFERENCES Color(color_id)
);

-- Create Incentive table
CREATE TABLE Incentive (
    Incentive_id INT PRIMARY KEY AUTO_INCREMENT,
    Type VARCHAR(255),
    Amount DECIMAL(10, 2),
    Conditions TEXT
);

-- Create Vehicle_Incentive table
CREATE TABLE Vehicle_Incentive (
    fk_vehicle_id INT,
    fk_incentive_id INT,
    valid_till DATE,
    PRIMARY KEY (fk_vehicle_id, fk_incentive_id),
    FOREIGN KEY (fk_vehicle_id) REFERENCES Vehicle(vehicle_id),
    FOREIGN KEY (fk_incentive_id) REFERENCES Incentive(Incentive_id)
);