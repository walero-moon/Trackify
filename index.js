const express = require("express");
const app = express();
const path = require("path");
const ejsLayouts = require("express-ejs-layouts");
const session = require("express-session")
require('dotenv').config();

app.use(express.static(path.join(__dirname, "public")));
app.use(express.urlencoded({ extended: true }));
app.use(ejsLayouts);
app.use(session({
  key: 'user_sid',
  secret: 'jennie',
  resave: false,
  saveUninitialized: false,
  cookie: {
      expires: 600000
  }
}));

app.set("views", path.join(__dirname, "/views"))
app.set("view engine", "ejs");

// Routes start here
app.get('/' ,(req, res) => { res.render("inventory") })
app.get('/about', (req, res) => { res.render("about") })
app.get('/contact', (req, res) => { res.render("contact") })

//Debugging console logs
app.use((req, res, next) => {
  console.log("User details are: ");
  console.log(req.inventory);
  console.log("Entire session object:");
  console.log(req.session);
  next();
});

app.listen(8000, function () {
  console.log(
    "Server running. Visit: http://localhost:8000 in your browser 🚀"
  );
});