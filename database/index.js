const pgp = require( 'pg-promise' )()
const db = pgp({ database: 'pizza' })

const CREATE_CUSTOMER =
  'INSERT INTO customer( customer_name, login, phone, street_address, state, zip_code, jurisdiction_id ) VALUES( ${customer_name}, ${login}, ${phone}, ${street_address}, ${state}, ${zip_code}, ${jurisdiction_id} ) RETURNING customer_id'

const createCustomer = attributes => db.one( CREATE_CUSTOMER, attributes )

module.exports = { createCustomer }
