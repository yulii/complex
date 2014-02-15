module Complex.Connect
  ( module Database.HDBC
  , module Database.HDBC.MySQL
  , defaultConnectInfo
  ) where

import Database.HDBC
import Database.HDBC.MySQL

defaultConnectInfo :: MySQLConnectInfo
defaultConnectInfo = defaultMySQLConnectInfo
  { mysqlHost     = "localhost"
  , mysqlDatabase = "test"
  , mysqlUser     = "root"
  , mysqlPassword = ""
  , mysqlUnixSocket = "/tmp/mysql.sock" }

