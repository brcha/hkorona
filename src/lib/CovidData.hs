{-# LANGUAGE DeriveGeneric #-}

module CovidData
  ( CovidEntry(..)
  ) where

import           GHC.Generics

import           Data.Aeson

data CovidEntry = CovidEntry
    { confirmed    :: Int
    , fatal        :: Int
    , hospitalized :: Int
    , ventilator   :: Int
    , recovered    :: Int
    }
    deriving (Generic, Show, Eq)

instance ToJSON CovidEntry where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON CovidEntry
