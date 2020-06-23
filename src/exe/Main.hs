{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.Aeson

import           CovidData

main :: IO ()
main = do
  let testEntry =
        "{\"tested\":345251,\"testedO\":345260,\"confirmed\":12990,\"fatal\":262,\"hospitalized\":731,\"ventilator\":19,\"recovered\":11997,\"active\":731,\"caseP\":\"3.76\",\"fatalP\":\"2.02\",\"p0\":108,\"vs\":99,\"f0\":94}"
      covEntry = decode testEntry :: Maybe CovidEntry
  print covEntry
