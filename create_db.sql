-- File: create_db.sql
\c cars

CREATE TABLE cars (
    id SERIAL PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    color VARCHAR(20) NOT NULL,
    motor VARCHAR(50) NOT NULL,
    year INT NOT NULL
);

INSERT INTO cars (model, color, motor, year) VALUES
    ('Toyota Corolla', 'Red', '1.8L I4', 2021),
    ('Ford Mustang', 'Blue', '5.0L V8', 2022),
    ('Honda Civic', 'Black', '2.0L I4', 2020),
    ('Tesla Model 3', 'White', 'Electric', 2023),
    ('Chevrolet Camaro', 'Yellow', '6.2L V8', 2019),
    ('Volkswagen Golf', 'Gray', '1.4L I4', 2021),
    ('BMW M3', 'Green', '3.0L I6 Twin-Turbo', 2022),
    ('Audi A4', 'Silver', '2.0L I4', 2020),
    ('Mercedes-Benz C-Class', 'Black', '2.0L I4 Turbo', 2023),
    ('Nissan Altima', 'White', '2.5L I4', 2021);

SELECT * FROM cars;
