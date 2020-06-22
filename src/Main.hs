{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import GHC.Generics

import Data.Aeson

data CovidEntry = CovidEntry {
    confirmed :: Int
  , fatal :: Int
  , hospitalized :: Int
  , ventilator :: Int
  , recovered :: Int
} deriving (Generic, Show)

instance ToJSON CovidEntry where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON CovidEntry

main :: IO ()
main = do
  let
    testEntry = "{\"tested\":345251,\"testedO\":345260,\"confirmed\":12990,\"fatal\":262,\"hospitalized\":731,\"ventilator\":19,\"recovered\":11997,\"active\":731,\"caseP\":\"3.76\",\"fatalP\":\"2.02\",\"p0\":108,\"vs\":99,\"f0\":94}"
    covEntry = decode testEntry :: Maybe CovidEntry
  putStrLn $ show covEntry
