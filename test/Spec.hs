module Main (main) where

import Test.Hspec
import Test.Complex.Query

main :: IO ()
main = do
  hspec specComplexQuery

