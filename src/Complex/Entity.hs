module Complex.Entity where

import Data.Word (Word32, Word64)
import Data.Text (Text, pack)

-- ストレージ上のモデルとマッピングするクラス
class Eq a => Entity a where
  entityName :: a -> String
  -- Default 制約をインスタンスで定義する
  -- Default 定義がないフィールドは undefined で、参照時まで評価をされないようにする
  newEntity :: a


-- テスト用モデル
--data MTag = MTag { mTagId          :: Word64
--                 , mTagPids        :: Maybe Text
--                 , mTagName        :: Text
--                 , mTagDescription :: Text
--                 } deriving (Eq, Show)
--
--instance Entity MTag where
--  entityName _ = "m_tag"
--  newEntity = MTag { mTagId   = undefined
--                   , mTagPids = undefined
--                   , mTagName = undefined
--                   , mTagDescription = (pack "DEFAULT")
--                   }

