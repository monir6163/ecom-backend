const express = require("express");
const dotenv = require("dotenv");
const bodyParser = require("body-parser");
const cors = require("cors");
const router = require("./utlis");
const app = express();
dotenv.config();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
if (process.env.mode === "production") {
  app.use(cors({ origin: "*" }));
} else {
  app.use(cors({ origin: "http://localhost:3000" }));
}
const port = process.env.Port || 5000;

// Routes for the app
app.use("/api", router);
app.get("/", (req, res) => {
  res.send("server is up and running!");
});

//error handling middleware function for all routes
app.use((err, req, res, next) => {
  console.log(err);
  const message = err.message ? err.message : "Server Error Occurred";
  const status = err.status ? err.status : 500;
  res.status(status).json({
    message,
  });
});

app.listen(port, () => {
  console.log(`Ecom app listening at http://localhost:${port}`);
});
