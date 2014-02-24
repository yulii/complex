module Test.Complex.Query (specComplexQuery) where

import Test.Hspec

import Complex.Query

specComplexQuery :: Spec
specComplexQuery = do
  describe "SELECT" $ do
    context "with valid one" $ do
      it "returns the first element of a list" $ do
        "AA" `shouldBe` "SELECT"
        -- select' [ MTagId, MTagPids, MTagName, MTagDescription] `shouldBe` "SELECT"
        -- ++ from' MTagEntity -- TODO: データ型を作らずに指定できないか？
        -- ++ where' [ MTagId   .= "2"
        --          , MTagName .= "KEYWORD"
        --          ]

