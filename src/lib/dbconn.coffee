mysql = require("mysql")
config = require '../config'



conn = mysql.createConnection {
    host: config.DB_HOST
    user: config.DB_USER,
    password: config.DB_PASSWORD,
    database: config.DB_NAME,
    port: 3306
}



module.exports = conn

