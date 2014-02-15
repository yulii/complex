module Complex.Show where

import Data.ByteString (ByteString)
import Data.Text.Encoding (decodeUtf8)

import Complex.Connect
import Complex.Text

showTables :: IO [Text]
showTables = do
  _connect <- connectMySQL defaultConnectInfo
  _result  <- quickQuery _connect "SHOW TABLES" []
  return $ map (toCamelCase . decodeUtf8 . table) _result
  where
    table :: [SqlValue] -> ByteString
    table = fromSql . head


showColumns table = do
  _connect <- connectMySQL defaultConnectInfo
  _result  <- quickQuery _connect ("SHOW COLUMNS FROM " ++ table) []
  return _result


