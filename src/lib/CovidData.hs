{-# LANGUAGE DeriveGeneric #-}

-- This module models the JSON data from https://github.com/urosevic/covid19/
module CovidData
  ( CovidEntryTotals(..)
  ) where

import           GHC.Generics

import           Data.Aeson

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

data CovidData = CovidData
    { updated :: UTCTime
    }
