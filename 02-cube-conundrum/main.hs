#!/usr/bin/env cabal
{- cabal:
build-depends: base, split, containers
-}

import Data.List (intercalate)
import Data.List.Split (splitOn)
import Debug.Trace
import qualified Data.Map as Map
import Debug.Trace (trace)


parseGameId str =
    let [_, id] = words str
    in (stringToInt id)


limit :: [(Int, String)]
limit = [(12, "red"), (13, "green"), (14, "blue")]

limitMap :: Map.Map String Int
limitMap = Map.fromList([("red", 12), ("green", 13), ("blue", 14)])

main :: IO ()
main = do
  content <- readFile "input.txt"
  let gameIdsAndRounds = (map getGameIdAndRound $ lines content)
  putStrLn "Game IDs and Rounds:"
  print gameIdsAndRounds
  print $ foldl (\ac (id, isPossible) ->
                    if isPossible == "True" then ac + id
                    else ac
    ) 0 gameIdsAndRounds
 


getGameIdAndRound :: [Char] -> (Int, [Char])
getGameIdAndRound s =
  let (gameId, _ : round) = break (== ':') s
   in (parseGameId gameId, processRound [round])

stringToInt :: String -> Int
stringToInt = read

processRound round =
  foldl
    buildColorsMap
    []
    round


checkIsPossible key value =
    case Map.lookup key limitMap of
        Just limitVal -> fromEnum value <= limitVal
        Nothing -> False


foldGamePart s = foldl (\a x ->
                        let [v, color] = words x
                        in if a == False then False
                        else case (checkIsPossible color (stringToInt v)) of
                            False -> False
                            True -> True
                    ) True (splitOn ", " s)

buildColorsMap acc curr =
    let e = splitOn "; " curr
        f = map foldGamePart e
        g = not $ foldl (\ac x ->
            ac || not x
            ) False f
    in show g


