{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
module Test.Data.Entity where

import Data.Word             (Word32)
import Data.Time             (UTCTime)
import Data.Text             (Text)

import Complex

data User = User { userId        :: Word32
                 , userEmail     :: Text
                 , userPassword  :: Text
                 , userStatus    :: Text
                 , userCreatedAt :: UTCTime
                 , userUpdatedAt :: UTCTime
                 } deriving (Eq, Show)

instance Entity User where
  data Table User = UserRef

  entityDef UserRef = EntityModel { entityId = "user" }


-- TODO: 外部キーで関連定義したときに、同じフィールドの型が複数出来てしまう。-> type で別名複製？？？
data UserId        = UserId        deriving (Eq, Show)
data UserEmail     = UserEmail     deriving (Eq, Show)
data UserPassword  = UserPassword  deriving (Eq, Show) 
data UserStatus    = UserStatus    deriving (Eq, Show) 
data UserCreatedAt = UserCreatedAt deriving (Eq, Show)
data UserUpdatedAt = UserUpdatedAt deriving (Eq, Show)

instance Field UserId        where fieldDef UserId        = FieldModel { fieldEntity = (entityDef UserRef) ,fieldId = "id"         }
instance Field UserEmail     where fieldDef UserEmail     = FieldModel { fieldEntity = (entityDef UserRef) ,fieldId = "email"      }
instance Field UserPassword  where fieldDef UserPassword  = FieldModel { fieldEntity = (entityDef UserRef) ,fieldId = "password"   }
instance Field UserStatus    where fieldDef UserStatus    = FieldModel { fieldEntity = (entityDef UserRef) ,fieldId = "status"     }
instance Field UserCreatedAt where fieldDef UserCreatedAt = FieldModel { fieldEntity = (entityDef UserRef) ,fieldId = "created_at" }
instance Field UserUpdatedAt where fieldDef UserUpdatedAt = FieldModel { fieldEntity = (entityDef UserRef) ,fieldId = "updated_at" }




