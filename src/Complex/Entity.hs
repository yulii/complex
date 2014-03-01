{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}
module Complex.Entity
  ( EntityModel (..)
  , FieldModel  (..)
  , Entity      (..)
  , Field       (..)
  , Literal     (..)
  ) where

import Data.Int              (Int8, Int16, Int32, Int64)
import Data.Word             (Word, Word8, Word16, Word32, Word64)
import Data.ByteString.Char8 (ByteString)
import Data.Text             (Text, pack)
import Data.Text.Encoding    (decodeUtf8)

data EntityModel = EntityModel { entityId    :: ByteString
                               } deriving (Show, Eq)

data FieldModel  = FieldModel  { fieldId     :: ByteString
                               , fieldEntity :: EntityModel
                               } deriving (Show, Eq)

class Show e => Literal e where
  express :: e -> Text
  express = pack . show

instance (Show f, Field f) => Literal f where
  express = decodeUtf8 . fieldId . fieldDef

class Entity e where
  data Table e

  entityDef :: Table e -> EntityModel

class Field f where
  fieldDef :: f -> FieldModel


-- Define the literal of Number
instance Literal Integer
instance Literal Int
instance Literal Int8
instance Literal Int16
instance Literal Int32
instance Literal Int64
instance Literal Word
instance Literal Word8
instance Literal Word16
instance Literal Word32
instance Literal Word64
instance Literal Float
instance Literal Double

