#!/usr/bin/env cabal
{- cabal:
build-depends: base, split, containers
-}

import Debug.Trace (trace)

 

main :: IO ()
main = do
  content <- readFile "sample.txt"
  print $ lines content
 
 