-- 1. Write a query to fetch all the vehicle model name whose production started in 2022.
-- Query:-
SELECT model_name 
FROM Model 
WHERE first_production_year = 2022;


-- 2. Write a query to fetch all the brand names for Germany.
-- query:-
SELECT make_name 
FROM Make 
WHERE Country = 'Germany';

-- 3. Write a query to find out which country has more than 2 brands.
-- query:-
SELECT Country, COUNT(make_id) AS NumberOfBrands
FROM Make
GROUP BY Country
HAVING COUNT(make_id) > 2;


-- 4. Write a query to find out the total price of all the vehicles which are white in color.
-- query:-
SELECT SUM(Inventory.Price) AS TotalPriceOfWhiteVehicles
FROM Inventory
JOIN Vehicle ON Inventory.fk_vehicle_id = Vehicle.vehicle_id
JOIN Color ON Inventory.fk_color_id = Color.color_id
WHERE Color.Name = 'White';


-- 5. Write a query to find the highest price of a vehicle.
-- query:-
SELECT MAX(Price) AS HighestVehiclePrice
FROM Inventory;


-- 6. Write a query to find the distinct types of Incentives.
-- query:-
SELECT DISTINCT Type
FROM Incentive;


-- 7. Write a query to idenify the model that has an incentive valid till 2027.
-- query:-
SELECT DISTINCT Model.model_name
FROM Model
JOIN Vehicle ON Model.model_id = Vehicle.fk_model_id
JOIN Vehicle_Incentive ON Vehicle.vehicle_id = Vehicle_Incentive.fk_vehicle_id
WHERE YEAR(Vehicle_Incentive.valid_till) = 2027;


-- 8. Write a query to find the price of each model.
-- query:-
Average Price for Each Model
SELECT Model.model_name, AVG(Inventory.Price) AS AveragePrice
FROM Model
JOIN Vehicle ON Model.model_id = Vehicle.fk_model_id
JOIN Inventory ON Vehicle.vehicle_id = Inventory.fk_vehicle_id
GROUP BY Model.model_name;

Minimum Price for Each Model
SELECT Model.model_name, MIN(Inventory.Price) AS MinimumPrice
FROM Model
JOIN Vehicle ON Model.model_id = Vehicle.fk_model_id
JOIN Inventory ON Vehicle.vehicle_id = Inventory.fk_vehicle_id
GROUP BY Model.model_name;

Maximum Price for Each Model
SELECT Model.model_name, MAX(Inventory.Price) AS MaximumPrice
FROM Model
JOIN Vehicle ON Model.model_id = Vehicle.fk_model_id
JOIN Inventory ON Vehicle.vehicle_id = Inventory.fk_vehicle_id
GROUP BY Model.model_name;


-- 9. Write a query to find out all the brands, their country, and their incentives irrespective if they have incentives or not.
-- query:-
SELECT Make.make_name, Make.Country, Incentive.Type AS IncentiveType
FROM Make
LEFT JOIN Vehicle ON Make.make_id = Vehicle.fk_make_id
LEFT JOIN Vehicle_Incentive ON Vehicle.vehicle_id = Vehicle_Incentive.fk_vehicle_id
LEFT JOIN Incentive ON Vehicle_Incentive.fk_incentive_id = Incentive.Incentive_id
ORDER BY Make.make_name, Incentive.Type;


-- 10. Write a query to identify which color doesn’t have any inventory yet.
-- query:-
SELECT Color.Name AS ColorName
FROM Color
LEFT JOIN Inventory ON Color.color_id = Inventory.fk_color_id
WHERE Inventory.fk_color_id IS NULL;


-- 11. Write a query to select each country and the number of models they have.
-- query:-
SELECT Make.Country, COUNT(DISTINCT Model.model_id) AS NumberOfModels
FROM Make
LEFT JOIN Vehicle ON Make.make_id = Vehicle.fk_make_id
LEFT JOIN Model ON Vehicle.fk_model_id = Model.model_id
GROUP BY Make.Country;


-- 12. Write a query to find which vehicle has the highest price.
-- query:-
SELECT Vehicle.vehicle_id, Inventory.Price AS HighestPrice
FROM Vehicle
JOIN Inventory ON Vehicle.vehicle_id = Inventory.fk_vehicle_id
WHERE Inventory.Price = (SELECT MAX(Price) FROM Inventory);


-- 13. Write a query to indentify which incentive type has the lowest incentive amount.
-- query:-
SELECT Incentive.Type AS LowestIncentiveType, Incentive.Amount AS LowestAmount
FROM Incentive
WHERE Incentive.Amount = (SELECT MIN(Amount) FROM Incentive);


-- 14. Write a query to find which year and number of models were launched showcasing the year having max models at the top.
-- query:-
SELECT first_production_year AS Year, COUNT(model_id) AS NumberOfModels
FROM Model
GROUP BY first_production_year
ORDER BY COUNT(model_id) DESC, first_production_year;


-- 15. Write a stored procedure named sp_color to select the model and color of each model.
-- query:-
DELIMITER //
CREATE PROCEDURE sp_color()
BEGIN
    SELECT Model.model_name AS ModelName, Color.Name AS ColorName
    FROM Model
    JOIN Vehicle ON Model.model_id = Vehicle.fk_model_id
    JOIN Inventory ON Vehicle.vehicle_id = Inventory.fk_vehicle_id
    JOIN Color ON Inventory.fk_color_id = Color.color_id;
END;
//
DELIMITER ;


-- 16. Write a query to execute the sp_color stored procedure.
-- query:-
CALL sp_color();