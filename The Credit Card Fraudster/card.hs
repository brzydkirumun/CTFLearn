{-# OPTIONS -Wall #-}

module Card where

-- Calculates sum of all digits of a number
sumdig :: Int -> Int
sumdig 0 = 0
sumdig n = n `seq` n `mod` 10 + sumdig (n `div` 10)

-- Verifies if credit card number satisfies Luhn algorithm
luhn :: [Int] -> Bool
luhn ys = summ ys `mod` 10 == 0
    where
        summ = foldr ((+) . (\(x,y) -> sumdig(x*y))) 0 . zip (go 1)
        go n = let n' = n `mod` 2 + 1 in n':go n'

