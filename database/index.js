const pgp = require( 'pg-promise' )()
const db = pgp({ database: 'pizza' })

const CREATE_CUSTOMER =
  'INSERT INTO customer( customer_name, login, phone, street_address, state, zip_code, jurisdiction_id )\
   VALUES( ${customer_name}, ${login}, ${phone}, ${street_address}, ${state}, ${zip_code}, ${jurisdiction_id} )\
   RETURNING customer_id'

const CREATE_ORDER =
  'INSERT INTO customer_order( total_price, pay_method, delivery_time, driver_id, customer_id )\
  VALUES( ${total_price}, ${pay_method}, ${delivery_time},\
  (SELECT driver_id FROM driver WHERE driver_id = (SELECT MAX(driver_id) FROM driver)),\
  (SELECT customer_id FROM customer WHERE customer_id = (SELECT MAX(customer_id) FROM customer)))\
  RETURNING order_id'

const ORDER_STANDARD_PIZZA =
    'INSERT INTO order_standard_pizza( standard_pizza_id, crust_id, base_pizza_id, order_id )\
    VALUES ( ${standard_pizza_id}, ${crust_id}, ${base_pizza_id}, ${order_id} ) RETURNING order_id'

const createCustomer = attributes => db.one( CREATE_CUSTOMER, attributes )
const createOrder = attributes => db.one( CREATE_ORDER, attributes )
const orderStandardPizza = attributes => db.one( ORDER_STANDARD_PIZZA, attributes )
// const customPizza = attributes => db.one( CUSTOM_PIZZA, attributes )

module.exports = { createCustomer, createOrder, orderStandardPizza }
