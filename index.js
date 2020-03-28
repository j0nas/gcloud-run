const express = require('express');
const app = express();

app.get('/', (req, res) => {
  console.log('Hello world received a request.');

  res.send(`The current time is ${Date().toLocaleString()}.
  Adding this string to see if CD works.`);
});

const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log('Listening on port', port);
});
