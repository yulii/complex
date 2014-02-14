module Complex.Show where

import Database.HDBC
import Database.HDBC.MySQL

import Data.ByteString (ByteString)
import Data.Text.Encoding (decodeUtf8)

import Complex.Text

defaultConnectInfo :: MySQLConnectInfo
defaultConnectInfo = defaultMySQLConnectInfo
  { mysqlHost     = "localhost"
  , mysqlDatabase = "test"
  , mysqlUser     = "root"
  , mysqlPassword = ""
  , mysqlUnixSocket = "/tmp/mysql.sock" }

showTables :: IO [Text]
showTables = do
  _connect <- connectMySQL defaultConnectInfo
  _result  <- quickQuery _connect "SHOW TABLES" []
  return $ map (toCamelCase . decodeUtf8 . table) _result
  where
    table :: [SqlValue] -> ByteString
    table = fromSql . head


showColumns = do
  _connect <- connectMySQL defaultConnectInfo
  _result  <- quickQuery _connect "SHOW COLUMNS FROM t_user" []
  return _result

