module Data.UUKaimyoSpec (spec) where

import qualified Data.UUID     as UUID
import           Data.UUKaimyo (Gender (Female, Male), genKaimyoFromUUID,
                                genUUIDAndKaimyo)
import           Test.Hspec    (Spec, describe, it, shouldBe, shouldReturn)

spec :: Spec
spec = do
  describe "genKaimyoFromUUID" $ do
    it "generates the kaimyo for male with the UUID of all zeros" $ do
      let kaimyo = genKaimyoFromUUID Male UUID.nil
      kaimyo `shouldBe` "亜院居士"

    it "generates the kaimyo for female with the UUID of all zeros" $ do
      let kaimyo = genKaimyoFromUUID Female UUID.nil
      kaimyo `shouldBe` "亜院大姉"

    it "generates a kaimyo for male" $ do
      let Just uuid = UUID.fromString "e2048802-ffee-4ed8-b577-a6eca4bac1c1"
      let kaimyo = genKaimyoFromUUID Male uuid
      kaimyo `shouldBe` "栄気院臆未狩浴丸蓄枚藩淡吹居士"

    it "generates a kaimyo for female" $ do
      let Just uuid = UUID.fromString "e2048802-ffee-4ed8-b577-a6eca4bac1c1"
      let kaimyo = genKaimyoFromUUID Female uuid
      kaimyo `shouldBe` "栄気院臆未狩浴丸蓄枚藩淡吹大姉"

  describe "genUUIDAndKaimyo" $ do
    it "generates a random uuid" $ do
      let isRandom = do
            (uuid, _) <- genUUIDAndKaimyo Male
            (uuid', _) <- genUUIDAndKaimyo Male
            return $ uuid /= uuid'
      isRandom `shouldReturn` True

    it "generates a random kaimyo" $ do
      let isRandom = do
            (_, kaimyo) <- genUUIDAndKaimyo Male
            (_, kaimyo') <- genUUIDAndKaimyo Male
            return $ kaimyo /= kaimyo'
      isRandom `shouldReturn` True

    it "generates a related pair" $ do
      let isRelated = do
            (st, kaimyo) <- genUUIDAndKaimyo Male
            let Just uuid = UUID.fromString st
            let kaimyo' = genKaimyoFromUUID Male uuid
            return $ kaimyo == kaimyo'
      isRelated `shouldReturn` True

