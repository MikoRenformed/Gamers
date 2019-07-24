var mysql = require('mysql');

var con = mysql.createConnection({ --connects to server, change values to w/e server we're using
  host: "localhost",
  user: "yourusername",
  password: "yourpassword",
  database: "mydb"
});
            
con.connect(function(err) { --add a game
  if (err) throw err;
  var sql = "INSERT INTO GameInfo(GameName,ConferenceShown,Genre,Developer,Publisher,ReleaseDate,MetacriticScore,Info) VALUES (?,?,?,?,?,?,?,?)";
  con.query(sql,[Gname,Gconference,GGenre,Gdev,Gpub,Grelease,Gscore,Ginfo], function (err, result) { 
    if (err) throw err;
  });
});
