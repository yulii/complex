module Test.Data.Entity where

import Data.Word (Word64)
import Data.Text (Text, pack)

import Complex.Entity

data MTag = MTag { mTagId          :: Word64
                 , mTagPids        :: Maybe Text
                 , mTagName        :: Text
                 , mTagDescription :: Text
                 } deriving (Eq, Show)

instance Entity MTag where
  entityName _ = "m_tag"
  newEntity = MTag { mTagId   = undefined
                   , mTagPids = undefined
                   , mTagName = undefined
                   , mTagDescription = (pack "DEFAULT")
                   }

