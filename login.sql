var mysql = require('mysql');

var con = mysql.createConnection({ --connects to server, change values to w/e server we're using
  host: "localhost",
  user: "yourusername",
  password: "yourpassword",
  database: "mydb"
});

var adr = 'Mountain 21';
var sql = 'SELECT userID FROM userinfo WHERE email = ' + mysql.escape(loginemail) + 'and password = ' + mysql.escape(loginpassword);
con.query(sql, function (err, result) {
  if (err) throw err;
  console.log(result);
});
       
