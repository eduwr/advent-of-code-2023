import Data.Char qualified as Char
import Debug.Trace
import System.IO

main = do
  content <- readFile "data.txt"
  let result = sum $ map (castReversedStringToInt . getCalibrationValue) $ lines content
  print result

getCalibrationValue :: String -> String
getCalibrationValue =
  foldr
    handleString
    ""

handleString :: Char -> [Char] -> [Char]
handleString char acc
  | not $ Char.isDigit char = acc
  | length acc >= 2 =
      init acc ++ [char]
  | otherwise = char : [char]

castReversedStringToInt :: String -> Int
castReversedStringToInt s =
  read $ reverse s