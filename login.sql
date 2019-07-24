var mysql = require('mysql');

var con = mysql.createConnection({ --connects to server, change values to w/e server we're using
  host: "localhost",
  user: "yourusername",
  password: "yourpassword",
  database: "mydb"
});


con.connect(function(err) { --login
  if (err) throw err;
  var sql = 'SELECT userID FROM userinfo WHERE email = ? and password = ?';
  con.query(sql,[loginEmail,loginPassword], function (err, result) {
  if (err) throw err;
  });
});



