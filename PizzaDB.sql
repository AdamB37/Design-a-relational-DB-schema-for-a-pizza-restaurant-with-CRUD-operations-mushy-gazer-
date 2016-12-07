DROP DATABASE IF EXISTS pizza;
CREATE DATABASE pizza;

\c pizza;

/* working on naming convention. for example: name is a reserved word
  therefore name can not be a colum name. datetime is also reserved. */

CREATE TABLE customer (
  customer_id SERIAL PRIMARY KEY,
  name VARCHAR,
  login VARCHAR,
  address INTEGER,
  pay_method VARCHAR
);

CREATE TABLE driver (
  driver_id SERIAL PRIMARY KEY,
  delivery_datetime DATETIME,
  money_collected DECIMAL(10,2),
  transaction_id SERIAL REFERENCES transaction (transaction_id),
  customer_id SERIAL REFERENCES customer (customer_id)
);

CREATE TABLE customer_transaction (
  transaction_id SERIAL REFERENCES transaction (transaction_id),
  customer_id SERIAL REFERENCES customer (customer_id)
);

CREATE TABLE card_on_file (
  customer_id SERIAL REFERENCES customer (customer_id),
  credit_id SERIAL REFERENCES credit (credit_id)
);

CREATE TABLE transaction_payment (
  credit_id SERIAL REFERENCES credit (credit_id),
  transaction_id SERIAL REFERENCES transaction (transaction_id)
);

CREATE TABLE credit (
  credit_id SERIAL PRIMARY KEY,
  credit_type INTEGER,
  card_number VARCHAR,
  expiration_date VARCHAR(4),
  csv INTEGER
  cardholder_name VARCHAR(100),
);

CREATE TABLE transaction (
  transaction_id SERIAL PRIMARY KEY,
  price DECIMAL(10,2),
  delivery_date DATE
);

CREATE TABLE customer_order (
  order_id SERIAL PRIMARY KEY,
  order_price DECIMAL(10,2)
);

CREATE TABLE order_standard_pizza (
  standard_pizza_id SERIAL REFERENCES standard_pizza (standard_pizza_id),
  order_id SERIAL REFERENCES customer_order (order_id)
);

CREATE TABLE standard_pizza (
  standard_pizza_id SERIAL PRIMARY KEY,
  standard_pizza_price DECIMAL(10,2),
  standard_pizza_desc TEXT(200)
);

CREATE TABLE order_custom_pizza (
  custom_pizza_id SERIAL REFERENCES custom_pizza (custom_pizza_id),
  order_id SERIAL REFERENCES customer_order (order_id)
);

CREATE TABLE custom_pizza (
  custpizza_id SERIAL PRIMARY KEY,
  custpizza_price DECIMAL(10,2),
  custpizza_desc TEXT(200)
);

CREATE TABLE order_topping (
  custom_pizza_id SERIAL REFERENCES custom_pizza (custom_pizza_id),
  topping_id SERIAL REFERENCES topping (topping_id)
);

CREATE TABLE topping (
  topping_id SERIAL PRIMARY KEY,
  topping_price DECIMAL(10,2),
  topping_name TEXT(45)
);

CREATE TABLE order_crust (
  crust_id SERIAL REFERENCES crust (crust_id),
  custom_pizza_id SERIAL REFERENCES custom_pizza (custom_pizza_id)
);

CREATE TABLE crust (
  crust_id SERIAL PRIMARY KEY,
  crust_price DECIMAL(10,2),
  crust_type TEXT(45)
);

CREATE TABLE order_drink (
  order_id SERIAL REFERENCES customer_order (order_id),
  drink_id SERIAL REFERENCES drink (drink_id)
);

CREATE TABLE drink (
  drink_id SERIAL PRIMARY KEY,
  drink_name VARCHAR(45),
  manufacturer VARCHAR(100),
  supplier VARCHAR(100),
  price DECIMAL(10,2)
);

INSERT INTO customer (name, login, address, pay_method)
  VALUES ('John Doe', 'jdoe', '111 First Street', 'cash');
