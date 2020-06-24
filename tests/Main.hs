{-# LANGUAGE OverloadedStrings #-}

import           Test.Tasty
import           Test.Tasty.Hspec

import           CovidData

import           Data.Aeson

import           Data.Time

main :: IO ()
main = do
  cets <- testSpec "CovidEntryTotals" covidEntryTotalsSpec
  ces <- testSpec "CovidEntry" covidEntrySpec
  defaultMain (testGroup "Tests" [cets, ces])

covidEntryTotalsSpec :: Spec
covidEntryTotalsSpec =
  parallel $ do
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

covidEntrySpec :: Spec
covidEntrySpec =
  parallel $ do
    it "Check if reading date works correctly" $
      let entryTotalsData =
            CovidEntryTotals
              { confirmed = 13235
              , fatal = 263
              , hospitalized = 861
              , ventilator = 21
              , recovered = 12111
              }
          entryData =
            CovidEntry
              {date = fromGregorian 2020 6 24, totals = entryTotalsData}
          testEntry =
            "{\"date\":\"24/06/2020 15:00\",\"dateTime\":{\"date\":\"24.06.2020\",\"time\":\"15:00\"},\"totals\":{\"tested\":359060,\"testedO\":359069,\"confirmed\":13235,\"fatal\":263,\"hospitalized\":861,\"ventilator\":21,\"recovered\":12111,\"active\":861,\"caseP\":\"3.69\",\"fatalP\":\"1.99\",\"p0\":110,\"vs\":101,\"f0\":96},\"details\":{\"positive\":143,\"hospital\":143,\"personal\":0,\"negative\":7641,\"totalTested\":7784,\"fatalM\":0,\"fatalF\":0,\"fatal\":0,\"recovered\":57,\"caseP\":\"1.84\"},\"info\":{\"refs\":[\"https://www.zdravlje.gov.rs/vest/348407/informacija-o-novom-korona-virusu-na-dan-24-jun-2020-godine-u-15-casova.php\"],\"note\":\"\"}}"
          decodedEntry = decode testEntry :: Maybe CovidEntry
       in decodedEntry `shouldBe` Just entryData
