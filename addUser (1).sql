var mysql = require('mysql');

var con = mysql.createConnection({ --connects to server, change values to w/e server we're using
  host: "localhost",
  user: "yourusername",
  password: "yourpassword",
  database: "mydb"
});

con.connect(function(err) { --add a user account
  if (err) throw err;
  var sql = "INSERT INTO userinfo(firstname,lastname,email,password) VALUES (Ufname,Ulname,Uemail,Upass)"; --the 4 values must be input by user, so we need box inputs accordingly
  con.query(sql, function (err, result) {
    if (err) throw err;
  });
});
            