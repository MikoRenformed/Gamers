var mysql = require('mysql');

var con = mysql.createConnection({ --connects to server, change values to w/e server we're using
  host: "localhost",
  user: "yourusername",
  password: "yourpassword",
  database: "mydb"
});

con.connect(function(err) { --add a user account
  if (err) throw err;
  var sql = "INSERT INTO userinfo(firstname,lastname,email,password) VALUES (?,?,?,?)";
  con.query(sql,[Ufname,Ulname,Uemail,Upass], function (err, result) { --Ufname etc must be gathered by the user
    if (err) throw err;
  });
});
            
