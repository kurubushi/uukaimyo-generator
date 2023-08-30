module Data.UUKaimyoSpec (spec) where

import Test.Hspec (Spec, describe, it, shouldBe)

spec :: Spec
spec = describe "True" $ do
  it "must be True" $ do
    True `shouldBe` True
