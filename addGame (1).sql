var mysql = require('mysql');

var con = mysql.createConnection({ --connects to server, change values to w/e server we're using
  host: "localhost",
  user: "yourusername",
  password: "yourpassword",
  database: "mydb"
});
            
con.connect(function(err) { --add a game
  if (err) throw err;
  var sql = "INSERT INTO GameInfo(GameName,ConferenceShown,Genre,Developer,Publisher,ReleaseDate,MetacriticScore,Info) VALUES (Gname,Gconference,GGenre,Gdev,Gpub,Grelease,Gscore,Ginfo)";
  con.query(sql, function (err, result) { --again, get all values from some text box
    if (err) throw err;
  });
});