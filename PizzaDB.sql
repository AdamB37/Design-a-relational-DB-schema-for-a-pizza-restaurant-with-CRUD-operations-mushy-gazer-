DROP DATABASE IF EXISTS pizza;
CREATE DATABASE pizza;

\c pizza;

CREATE TABLE tax_jurisdiction (
  jurisdiction_id SERIAL PRIMARY KEY,
  jurisdiction_name VARCHAR (100),
  tax_rate INTEGER
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
  delivery_name VARCHAR(100)
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

CREATE TABLE standard_pizza (
  standard_pizza_id SERIAL PRIMARY KEY,
  standard_pizza_price DECIMAL(10,2),
  standard_pizza_desc VARCHAR(200)
);

CREATE TABLE custom_pizza (
  custom_pizza_id SERIAL PRIMARY KEY,
  custom_pizza_price DECIMAL(10,2),
  custom_pizza_desc VARCHAR(200)
);

CREATE TABLE topping (
  topping_id SERIAL PRIMARY KEY,
  topping_price DECIMAL(10,2),
  topping_name VARCHAR
);

CREATE TABLE crust (
  crust_id SERIAL PRIMARY KEY,
  crust_price DECIMAL(10,2),
  crust_type VARCHAR
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
  order_id SERIAL REFERENCES customer_order (order_id)
);

CREATE TABLE order_custom_pizza (
  custom_pizza_id SERIAL REFERENCES custom_pizza (custom_pizza_id),
  order_id SERIAL REFERENCES customer_order (order_id)
);

CREATE TABLE pizza_topping (
  custom_pizza_id SERIAL REFERENCES custom_pizza (custom_pizza_id),
  topping_id SERIAL REFERENCES topping (topping_id)
);

CREATE TABLE order_crust (
  crust_id SERIAL REFERENCES crust (crust_id),
  custom_pizza_id SERIAL REFERENCES custom_pizza (custom_pizza_id)
);

CREATE TABLE order_drink (
  order_id SERIAL REFERENCES customer_order (order_id),
  drink_id SERIAL REFERENCES drink (drink_id)
);
INSERT INTO tax_jurisdiction(jurisdiction_name, tax_rate)
  VALUES ('Colorado', 2.9),(),(),();

INSERT INTO customer(customer_name, login, phone, street_address, state, zip_code, jurisdiction_id)
  VALUES ('John Doe', 'jdoe', '8675309', '111 First Street', 'ca', '55555', 1);

INSERT INTO credit(credit_type, card_number, expiration_date, csv, cardholder_name)
  VALUES ('visa', '123456780987', 1120, 111, 'John Doe')
