module Main (main, spec) where

import Test.Hspec
import Test.Complex

import Complex.Show

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "TEST" $ do
    context "with valid one" $ do
      it "returns the first element of a list" $ do
        head [23 ..] `shouldBe` (23 :: Int)

  describe "SHOW" $ do
    context "with valid one" $ do
      it "returns the first element of a list" $ do
        head [23 ..] `shouldBe` (23 :: Int)

