{-# LANGUAGE OverloadedStrings #-}
module Test.Complex.Query (specComplexQuery) where

import Test.Hspec
import Test.Data.Entity

import Complex.Entity
import Complex.Query

specComplexQuery :: Spec
specComplexQuery = do
  describe "Entity Class" $ do
    context "with valid one" $ do
      it "returns the table name" $ do
        entityId (entityDef UserRef) `shouldBe` "user"

      it "returns the column name" $ do
        express UserId        `shouldBe` "id"
        express UserEmail     `shouldBe` "email"
        express UserPassword  `shouldBe` "password"
        express UserStatus    `shouldBe` "status"
        express UserCreatedAt `shouldBe` "created_at"
        express UserUpdatedAt `shouldBe` "updated_at"

      --it " list" $ do
      --  fields <- return [ UserId, UserEmail, UserPassword, UserStatus, UserCreatedAt, UserUpdatedAt ]
      --  select' fields `shouldBe` " SELECT id, email, password, status, created_at, updated_at"

      --it "express SQL" $ do
      --  join <- return []
      --  base <- return SQLBase { baseId = "t1", baseEntity = (entityDef UserEntity), baseJoin = join }
      --  ps   <- return [ SQLProjection { projectionId = "c1", projectionField = (fieldDef UserId)        }
      --                 , SQLProjection { projectionId = "c2", projectionField = (fieldDef UserEmail)     }
      --                 , SQLProjection { projectionId = "c3", projectionField = (fieldDef UserPassword)  }
      --                 , SQLProjection { projectionId = "c4", projectionField = (fieldDef UserStatus)    }
      --                 , SQLProjection { projectionId = "c5", projectionField = (fieldDef UserCreatedAt) }
      --                 , SQLProjection { projectionId = "c6", projectionField = (fieldDef UserUpdatedAt) }
      --                 ]
      --  cs   <- return []
      --  os   <- return []
      --  expressSQL base ps cs `shouldBe` " SELECT id, email, password, status, created_at, updated_at"

      --it " list" $ do
      --  f <- return SQLProjection { projectionId = "c4", projectionField = (fieldDef UserStatus)    }
      --  express SQLCondition { conditionField = f, conditionOperation = (.<), conditionValue = "AAA" } `shouldBe` "AA"
      --  UserEntity >:< [] `shouldBe` " FROM user"

