const express = require("express");
const app = express();

app.get("/", (req, res) => {
  console.log("Hello world received a request.");
  console.log(req.headers.host);
  res.send(
    `The current time is ${Date().toLocaleString()}. 
    Serving request from ${req.headers.host}.
    Test2.`
  );
});

module.exports = app;
