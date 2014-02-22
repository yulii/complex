module Main (main, spec) where

import Test.Hspec
import Test.Complex

import Complex.Show
import Complex.Query

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "TEST" $ do
    context "with valid one" $ do
      it "returns the first element of a list" $ do
        head [23 ..] `shouldBe` (23 :: Int)

  describe "SELECT" $ do
    context "with valid one" $ do
      it "returns the first element of a list" $ do
        select' [ MTagId, MTagPids, MTagName, MTagDescription] `shouldBe` "SELECT"
        -- ++ from' MTagEntity -- TODO: データ型を作らずに指定できないか？
        -- ++ where' [ MTagId   .= "2"
        --          , MTagName .= "KEYWORD"
        --          ]

