{-# LANGUAGE TypeFamilies #-}
module Test.Data.Entity where

import Data.Word (Word64)
import Data.Text (Text, pack)

import Complex.Query

---- ストレージ上のモデルとマッピングするクラス
--class Entity e where
--  data Field e 
--
--  entityName :: e -> String
--  -- Default 制約をインスタンスで定義する
--  -- Default 定義がないフィールドは undefined で、参照時まで評価をされないようにする
--  newEntity :: e
--
--  fieldDef :: Field e -> String

data MTag = MTag { mTagId          :: Word64
                 , mTagPids        :: Maybe Text
                 , mTagName        :: Text
                 , mTagDescription :: Text
                 } deriving (Eq, Show)


instance Entity MTag where
  data Field MTag = MTagId | MTagPids | MTagName | MTagDescription

  -- TODO: undefined にする事で弊害があるか？？
  newEntity = MTag { mTagId   = undefined
                   , mTagPids = undefined
                   , mTagName = undefined
                   , mTagDescription = (pack "DEFAULT")
                   }

  entityDef (MTag _ _ _ _) = SQLEntity { entityId = "m_tag" }

  -- TODO: Entity の指定がコレで良いのか？
  fieldDef MTagId          = SQLProjection { projectionEntity = newEntity ,projectionField = "id"          }
  fieldDef MTagPids        = SQLProjection { projectionEntity = newEntity ,projectionField = "pids"        }
  fieldDef MTagName        = SQLProjection { projectionEntity = newEntity ,projectionField = "name"        }
  fieldDef MTagDescription = SQLProjection { projectionEntity = newEntity ,projectionField = "description" }

