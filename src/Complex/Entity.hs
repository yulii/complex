{-# LANGUAGE TypeFamilies #-}
module Complex.Entity where

import Data.Word (Word32, Word64)
import Data.Text (Text, pack)

data FieldType = Word32 | Word64 | Text

-- ストレージ上のモデルとマッピングするクラス
class Entity e where
  data Field e 

  entityName :: e -> String
  -- Default 制約をインスタンスで定義する
  -- Default 定義がないフィールドは undefined で、参照時まで評価をされないようにする
  newEntity :: e

  fieldDef :: Field e -> String

data MTag = MTag { mTagId          :: Word64
                 , mTagPids        :: Maybe Text
                 , mTagName        :: Text
                 , mTagDescription :: Text
                 } deriving (Eq, Show)


instance Entity MTag where
  data Field MTag = MTagId | MTagPids

--  data Field MTag typ where
--    MTagId           :: Field MTag Word64
--    MTagPids         :: Field MTag (Maybe Text)
--    MTagName         :: Field MTag Text
--    MTagDescription  :: Field MTag Text

  entityName _ = "m_tag"
  newEntity = MTag { mTagId   = undefined
                   , mTagPids = undefined
                   , mTagName = undefined
                   , mTagDescription = (pack "DEFAULT")
                   }
  fieldDef MTagId = "id"

--data Field = Field Entity Word64
--
--data Field MTag FieldType where
--  MTagId :: Field MTag Word64
--type MTagPids = Field MTag (Maybe Text)
