DROP DATABASE IF EXISTS pizza;
CREATE DATABASE pizza;

\c pizza;

CREATE TABLE customer (
  ID SERIAL PRIMARY KEY,
  name VARCHAR,
  login VARCHAR,
  address INTEGER,
  pay_method VARCHAR
);

CREATE TABLE driver (
  ID SERIAL PRIMARY KEY,
  delivery_datetime DATETIME,
  money_collected DECIMAL(10,2)
  /* this table has two foreign keys. added after db creation */
);

CREATE TABLE customer_transaction (
  /* TODO: this table needs two foreign keys added after DB creation */
);

CREATE TABLE card_on_fine (
  /* TODO: this table needs two foreign keys added after db creation */
);

CREATE TABLE transaction_payment (
  /* TODO: this table needs two foreign keys added after db cretion */
);

CREATE TABLE credit (
  ID SERIAL PRIMARY KEY,
  credit_type INTEGER,
  card_number VARCHAR,
  expiration_date VARCHAR(4),
  csv INTEGER
  cardholder_name VARCHAR(100),
);

CREATE TABLE transaction (
  ID SERIAL PRIMARY KEY,
  price VARCHAR,
  pay_method VARCHAR,
  /* TODO: this table needs one foreign key added after db creation */
);

CREATE TABLE order (
  ID SERIAL PRIMARY KEY,
  price DECIMAL(10,2)
);

CREATE TABLE order_standard_pizza (
  /* TODO: this table needs two foreign keys added after db creation */
);

CREATE TABLE standard_pizza (
  ID SERIAL PRIMARY KEY,
  price DECIMAL(10,2),
  descripton TEXT(200)
);

CREATE TABLE order_custom_pizza (
  /* TODO: this table needs two foreign keys added after db creation */
);

CREATE TABLE custom_pizza (

)

INSERT INTO customer (name, login, address, pay_method)
  VALUES ('John Doe', 'jdoe', '111 First Street', 'cash');

ALTER TABLE driver
  ADD FOREIGN KEY (transation_id) REFERENCES transaction (transaction_id);
  ADD FOREIGN KEY (customer_id) REFERENCES customer (customer_id);
