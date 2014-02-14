module Complex.Text
  (T.Text
  ,toCamelCase
  ,capitalize
  ) where

import qualified Data.Text as T

toCamelCase :: T.Text -> T.Text
toCamelCase = T.concat . (map capitalize) . (T.split (=='_'))

capitalize :: T.Text -> T.Text
capitalize t = T.append (head' t) (tail' t)
  where
    head' = T.toUpper . T.singleton . T.head
    tail' = T.toLower . T.tail


