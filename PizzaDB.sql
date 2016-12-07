DROP DATABASE IF EXISTS pizza;
CREATE DATABASE pizza;

\c pizza;


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
  money_collected DECIMAL(10,2)
  /* this table has two foreign keys. added after db creation */
);

CREATE TABLE customer_transaction (
  transaction_id SERIAL REFERENCES transaction (transaction_id),
  customer_id SERIAL REFERENCES customer (customer_id)
  /* TODO: this table needs two foreign keys added after DB creation */
);

CREATE TABLE card_on_file (
  customer_id SERIAL REFERENCES customer (customer_id),
  credit_id SERIAL REFERENCES credit (credit_id)
  /* TODO: this table needs two foreign keys added after db creation */
);

CREATE TABLE transaction_payment (

  /* TODO: this table needs two foreign keys added after db cretion */
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
  /* TODO: this table needs one foreign key added after db creation */
  /*Can this import price or price paid,delivery address? Need to discuss */
);

CREATE TABLE customer_order (
  order_id SERIAL PRIMARY KEY,
  order_price DECIMAL(10,2)
);

CREATE TABLE order_standard_pizza (
  /* TODO: this table needs two foreign keys added after db creation */
);

CREATE TABLE standard_pizza (
  standard_pizza_id SERIAL PRIMARY KEY,
  standard_pizza_price DECIMAL(10,2),
  standard_pizza_desc TEXT(200)
);

CREATE TABLE order_custom_pizza (
  /* TODO: this table needs two foreign keys added after db creation */
);

CREATE TABLE custom_pizza (
  custpizza_id SERIAL PRIMARY KEY,
  custpizza_price DECIMAL(10,2),
  custpizza_desc TEXT(200)
);

CREATE TABLE order_topping (
  /* TODO: this table needs two foreign keys added after db creation */
);

CREATE TABLE topping (
  topping_id SERIAL PRIMARY KEY,
  topping_price DECIMAL(10,2),
  topping_name TEXT(45)
);

CREATE TABLE order_crust (
  /* TODO: this table needs two foreign keys added after db creation */
);

CREATE TABLE crust (
  crust_id SERIAL PRIMARY KEY,
  crust_price DECIMAL(10,2),
  crust_type TEXT(45)
);

CREATE TABLE order_drink (
  /* TODO: this table needs two foreign keys added after db creation */
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

ALTER TABLE driver
  ADD FOREIGN KEY (transaction_id) REFERENCES transaction (transaction_id);
  ADD FOREIGN KEY (customer_id) REFERENCES customer (customer_id);
  /*read documentation saying we can add foreign keys in creating tables*/
