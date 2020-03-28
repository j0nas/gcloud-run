const express = require('express');
const app = express();

app.get('/', (req, res) => {
  console.log('Hello world received a request.');
  res.send(`The current time is ${Date().toLocaleString()}.`);
});

module.exports = app;