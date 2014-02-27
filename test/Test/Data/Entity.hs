{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}
module Test.Data.Entity where

import Data.Word             (Word32, Word64)
import Data.Text             (Text, pack)
import Data.Time             (UTCTime)

import Complex

data User = User { userId        :: Word32
                 , userEmail     :: [Char]
                 , userPassword  :: [Char]
                 , userStatus    :: [Char]
                 , userCreatedAt :: UTCTime
                 , userUpdatedAt :: UTCTime
                 } deriving (Eq, Show)

instance Entity User where
  data Table User = UserEntity
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

  entityDef UserEntity = SQLEntity { entityId = "user" }

  fieldDef UserId        = SQLField { fieldEntity = (entityDef UserEntity) ,fieldId = "id"         }
  fieldDef UserEmail     = SQLField { fieldEntity = (entityDef UserEntity) ,fieldId = "email"      }
  fieldDef UserPassword  = SQLField { fieldEntity = (entityDef UserEntity) ,fieldId = "password"   }
  fieldDef UserStatus    = SQLField { fieldEntity = (entityDef UserEntity) ,fieldId = "status"     }
  fieldDef UserCreatedAt = SQLField { fieldEntity = (entityDef UserEntity) ,fieldId = "created_at" }
  fieldDef UserUpdatedAt = SQLField { fieldEntity = (entityDef UserEntity) ,fieldId = "updated_at" }

