DROP DATABASE IF EXISTS pizza;
CREATE DATABASE pizza;

\c pizza;

CREATE TABLE tax_jurisdiction (
  jurisdiction_id SERIAL PRIMARY KEY,
  jurisdiction_name VARCHAR (100),
  tax_rate DECIMAL(10,2)
);

CREATE TABLE customer (
  customer_id SERIAL PRIMARY KEY,
  customer_name VARCHAR(100),
  login VARCHAR(100),
  phone VARCHAR(25),
  street_address VARCHAR(100),
  state VARCHAR(2),
  zip_code INTEGER,
  jurisdiction_id SERIAL REFERENCES tax_jurisdiction (jurisdiction_id)
);

CREATE TABLE credit (
  credit_id SERIAL PRIMARY KEY,
  credit_type VARCHAR,
  card_number VARCHAR,
  expiration_date VARCHAR(4),
  csv INTEGER,
  cardholder_name VARCHAR(100)
);

CREATE TABLE driver (
  driver_id SERIAL PRIMARY KEY,
  driver_name VARCHAR(100)
);

CREATE TABLE customer_order (
  order_id SERIAL PRIMARY KEY,
  total_price DECIMAL(10,2),
  pay_method VARCHAR(45),
  delivery_time TIMESTAMP,
  driver_id SERIAL REFERENCES driver (driver_id),
  customer_id SERIAL REFERENCES customer (customer_id)
);

CREATE TABLE card_on_file (
  customer_id SERIAL REFERENCES customer (customer_id),
  credit_id SERIAL REFERENCES credit (credit_id)
);

CREATE TABLE transaction_payment (
  credit_id SERIAL REFERENCES credit (credit_id),
  order_id SERIAL REFERENCES customer_order (order_id)
);

CREATE TABLE base_pizza (
  base_pizza_id SERIAL PRIMARY KEY,
  pizza_size VARCHAR(100),
  base_price DECIMAL(10,2)
);

CREATE TABLE topping (
  topping_id SERIAL PRIMARY KEY,
  price DECIMAL(10,2),
  topping_name VARCHAR(200)
);

CREATE TABLE crust (
  crust_id SERIAL PRIMARY KEY,
  crust_type VARCHAR
);

CREATE TABLE standard_pizza (
  standard_pizza_id SERIAL PRIMARY KEY,
  st_pizza_name VARCHAR(200),
  price DECIMAL(10,2)
);

CREATE TABLE custom_pizza (
  custom_pizza_id SERIAL PRIMARY KEY,
  custom_pizza_price DECIMAL(10,2)
);

CREATE TABLE drink (
  drink_id SERIAL PRIMARY KEY,
  drink_name VARCHAR(45),
  manufacturer VARCHAR(100),
  supplier VARCHAR(100),
  price DECIMAL(10,2)
);

CREATE TABLE order_standard_pizza (
  standard_pizza_id SERIAL REFERENCES standard_pizza (standard_pizza_id),
  crust_id SERIAL REFERENCES crust (crust_id),
  base_pizza_id SERIAL REFERENCES base_pizza (base_pizza_id),
  order_id SERIAL REFERENCES customer_order (order_id)
);

CREATE TABLE order_custom_pizza (
  custom_pizza_id SERIAL REFERENCES custom_pizza (custom_pizza_id),
  crust_id SERIAL REFERENCES crust (crust_id),
  base_pizza_id SERIAL REFERENCES base_pizza (base_pizza_id),
  order_id SERIAL REFERENCES customer_order (order_id)
);

CREATE TABLE order_drink (
  order_id SERIAL REFERENCES customer_order (order_id),
  drink_id SERIAL REFERENCES drink (drink_id)
);

CREATE TABLE pizza_topping (
  custom_pizza_id SERIAL REFERENCES custom_pizza (custom_pizza_id),
  topping_id SERIAL REFERENCES topping (topping_id)
);

INSERT INTO tax_jurisdiction(jurisdiction_name, tax_rate)
  VALUES ('Colorado', 2.9),('Arizona', 5.6),('New Mexico', 5.13),('Utah', 5.0);

INSERT INTO customer(customer_name, login, phone, street_address, state, zip_code, jurisdiction_id)
  VALUES ('John Doe', 'jdoe', '8675309', '111 First Street', 'ca', '55555', 1);

INSERT INTO credit(credit_type, card_number, expiration_date, csv, cardholder_name)
  VALUES ('visa', '123456780987', 1120, 111, 'John Doe');

INSERT INTO driver(driver_name)
  VALUES ('Jane Doe');

INSERT INTO topping(topping_name, price)
  VALUES ('pepperoni', 1.25),('sausage', 1.25),('ham', 1.25),('chicken', 1.25),('bacon', 1.25),
  ('anchovies', 1.25),('extra cheese', 1.00),('onion', 0.75), ('pineapple', 0.75),('mushroom', 0.75),
  ('olive', 0.75), ('spinach', 0.75),('arugula', 0.75),('roma tomato', 0.75),('bell pepper', 0.75);

INSERT INTO crust(crust_type)
  VALUES ('thin'),('thick');

INSERT INTO base_pizza(pizza_size, base_price)
  VALUES ('small', 8.75),('medium', 10.50),('large', 13.00),('extra large', 16.00);

/* Note: Prices shown in standard pizza table is the "additional" price.
price of the base (cheese only) pizza + standard "add on" price = total price of a standard pizza
ex: medium base pizza (10.50) + BBQ Chicken (add 5.00) = a med BBQ Chicken pizza costs $15.50 */

INSERT INTO standard_pizza(st_pizza_name, price)
  VALUES ('BBQ Chicken Supreme', 5.00),('Vegan Deluxe', 4.00),('The Kitchen Sink', 10.00),
  ('Double Pepperoni', 2.50),('Cheeze Pizza', 0.00);

INSERT INTO drink (drink_name, manufacturer, supplier, price)
  VALUES ('Pepsi 20 oz', 'PepsiCo', 'Drink Distro Inc', 1.25),('Pepsi 2 ltr', 'PepsiCo', 'Drink Distro Inc', 2.00),
  ('Diet Pepsi 20 oz', 'PepsiCo', 'Drink Distro Inc', 1.25),('Diet Pepsi 2 ltr', 'PepsiCo', 'Drink Distro Inc', 2.00),
  ('Mug Root Beer 20 oz', 'PepsiCo', 'Drink Distro Inc', 1.25),('Mug Root Beer 2 ltr', 'PepsiCo', 'Drink Distro Inc', 2.00),
  ('Mtn Dew 20 oz', 'PepsiCo', 'Drink Distro Inc', 1.25),('Mtn Dew 2 ltr', 'PepsiCo', 'Drink Distro Inc', 2.00);
