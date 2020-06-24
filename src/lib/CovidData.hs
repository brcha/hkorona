{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

-- This module models the JSON data from https://github.com/urosevic/covid19/
module CovidData
  ( CovidEntryTotals(..)
  , CovidEntry(..)
  ) where

import           GHC.Generics

import           Data.Aeson

import           Control.Applicative
import           Data.Time

-- Totals for a single entry in the covid json file
data CovidEntryTotals = CovidEntryTotals
    { confirmed    :: Int
    , fatal        :: Int
    , hospitalized :: Int
    , ventilator   :: Int
    , recovered    :: Int
    }
    deriving (Generic, Show, Eq)

instance ToJSON CovidEntryTotals where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON CovidEntryTotals

-- Actual entry in the JSON file
data CovidEntry = CovidEntry
    { date   :: Day
    , totals :: CovidEntryTotals
    }
    deriving (Generic, Show, Eq)

instance ToJSON CovidEntry where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON CovidEntry where
  parseJSON (Object v) = do
    date' <- v .: "date"
    totals' <- v .: "totals"
    let (day, rest) = span (/= '/') date'
        (month, rest') = span (/= '/') $ tail rest
        (year, _) = span (/= ' ') $ tail rest'
        fixedDate = fromGregorian (read year) (read month) (read day)
    return (CovidEntry {date = fixedDate, totals = totals'})
  parseJSON _ = empty

data CovidData = CovidData
    { updated :: UTCTime
    }
