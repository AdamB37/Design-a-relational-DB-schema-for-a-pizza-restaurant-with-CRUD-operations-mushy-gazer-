const express = require( 'express' )
const bodyParser = require( 'body-parser' )

const app = express()
app.use( bodyParser.json() )

const db = require( './database/' )

app.get( '/', (request, response) => {
  response.send( "Hello World!" )
})

app.post( '/customers', (request, response) => {
  db.createCustomer( request.body )
    .then( result => response.status( 201 ).json( result ))
    .catch( error => response.status( 500 ).json({ error }))
})

app.post( '/createorder', (request, response) => {
  db.createOrder( request.body )
    .then( result => response.status( 201 ).json( result ))
    .catch( error => response.status( 500 ).json({ error }))
})

app.post( '/orderstandardpizza', (request, response) => {
  db.orderStandardPizza( request.body )
    .then( result => response.status( 201 ).json( result ))
    .catch( error => response.status( 500 ).json({ error }))
})

app.listen( 3000, () => {
  console.log( 'Server started on port 3000' )
})
