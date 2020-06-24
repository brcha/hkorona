{-# LANGUAGE OverloadedStrings #-}

import           Test.QuickCheck.Arbitrary.Generic
import           Test.Tasty
import           Test.Tasty.Hspec
import           Test.Tasty.QuickCheck

import           CovidData

import           Data.Aeson

main :: IO ()
main = do
  ces <- testSpec "CovidEntryTotals" covidEntryTotalsSpec
  defaultMain (testGroup "Tests" [ces])

-- Enable QuickCheck for CovidEntryTotals
instance Arbitrary CovidEntryTotals where
  arbitrary = genericArbitrary
  shrink = genericShrink

covidEntryTotalsSpec :: Spec
covidEntryTotalsSpec =
  parallel $ do
    it "id == decode . encode" $
      property $ \entry ->
        ((decode $ encode entry) :: Maybe CovidEntryTotals) == Just entry
    it "Check if decode works as expected with a real example" $
      let testEntry =
            "{\"tested\":345251,\"testedO\":345260,\"confirmed\":12990,\"fatal\":262,\"hospitalized\":731,\"ventilator\":19,\"recovered\":11997,\"active\":731,\"caseP\":\"3.76\",\"fatalP\":\"2.02\",\"p0\":108,\"vs\":99,\"f0\":94}"
          decodedEntry = decode testEntry :: Maybe CovidEntryTotals
          expectedEntry =
            CovidEntryTotals
              { confirmed = 12990
              , fatal = 262
              , hospitalized = 731
              , ventilator = 19
              , recovered = 11997
              }
       in decodedEntry `shouldBe` Just expectedEntry
