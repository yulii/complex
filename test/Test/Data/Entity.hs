{-# LANGUAGE TypeFamilies #-}
module Test.Data.Entity where

import Data.Word (Word32, Word64)
import Data.Text (Text, pack)
import Data.Time (UTCTime)

import Complex.Query

data User = User { userId        :: Word32
                 , userEmail     :: [Char]
                 , userPassword  :: [Char]
                 , userStatus    :: [Char]
                 , userCreatedAt :: UTCTime
                 , userUpdatedAt :: UTCTime
                 } deriving (Eq, Show)

instance Entity User where
  data Field User = UserId
                  | UserEmail
                  | UserPassword
                  | UserStatus
                  | UserCreatedAt
                  | UserUpdatedAt

  -- TODO: undefined にする事で弊害があるか？？
  newEntity = User { userId        = undefined
                   , userEmail     = undefined
                   , userPassword  = undefined
                   , userStatus    = "REG"
                   , userCreatedAt = undefined -- 現在時刻を指定するとIO型になるので、どうするか？？
                   , userUpdatedAt = undefined
                   }

  entityDef (User _ _ _ _ _ _) = SQLEntity { entityId = "user" }

  -- TODO: Entity の指定がコレで良いのか？
  fieldDef UserId        = SQLProjection { projectionEntity = newEntity ,projectionField = "id"         }
  fieldDef UserEmail     = SQLProjection { projectionEntity = newEntity ,projectionField = "email"      }
  fieldDef UserPassword  = SQLProjection { projectionEntity = newEntity ,projectionField = "password"   }
  fieldDef UserStatus    = SQLProjection { projectionEntity = newEntity ,projectionField = "status"     }
  fieldDef UserCreatedAt = SQLProjection { projectionEntity = newEntity ,projectionField = "created_at" }
  fieldDef UserUpdatedAt = SQLProjection { projectionEntity = newEntity ,projectionField = "updated_at" }

