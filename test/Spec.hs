module Main (main, spec) where

import Test.Hspec

import Complex.Entity

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "TEST" $ do
    context "with valid one" $ do
      it "returns the first element of a list" $ do
        head [23 ..] `shouldBe` (23 :: Int)
