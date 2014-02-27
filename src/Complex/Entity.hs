{-# LANGUAGE TypeFamilies #-}
module Complex.Entity
  ( SQLEntity (..)
  , SQLField (..)
  , Entity (..)
  ) where

import Data.ByteString.Char8 (ByteString)

data SQLEntity = SQLEntity { entityId    :: ByteString
                           } deriving (Show, Eq)
data SQLField  = SQLField  { fieldId     :: ByteString
                           , fieldEntity :: SQLEntity -- TODO: この参照が必要か？？
                           } deriving (Show, Eq)

class Entity e where
  data Table e
  data Field e 

  -- Default 制約をインスタンスで定義する
  -- Default 定義がないフィールドは undefined で、参照時まで評価をされないようにする
  -- TODO: 実行時エラーになるのでコンパイラーでチェックできない！
  newEntity :: e

  entityDef :: Table e -> SQLEntity
  fieldDef  :: Field e -> SQLField

