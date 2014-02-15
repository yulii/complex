module Complex.Query where

import Data.Word (Word32, Word64)
import Data.Text (Text, pack)

-- Where 条件用
class Eq a => Field a where
  fieldName :: a -> String

--data MTagId          = MTagId          Word64 deriving (Show, Eq)
--data MTagPids        = MTagPids        Text   deriving (Show, Eq)
--data MTagName        = MTagName        Text   deriving (Show, Eq)
--data MTagDescription = MTagDescription Text   deriving (Show, Eq)
--
--instance Field MTagId where
--  fieldName _ = "id"
--
--instance Field MTagPids where
--  fieldName _ = "pids"
