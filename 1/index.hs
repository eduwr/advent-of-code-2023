
import System.IO

main = do
    content <- readFile "sample.txt"
    mapM_ putStrLn $ lines content


