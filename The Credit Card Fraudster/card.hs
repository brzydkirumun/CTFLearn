{-# OPTIONS -Wall #-}

-- https://ctflearn.com/challenge/970

module Card where

-- Because 0 is the neutral element of addition in N and
-- for every x in N: [x * 0 = 0] i substituted 0s in place
-- of the stars.
cardNeutral :: [Int]
cardNeutral = [5,4,3,2,1,0,0,0,0,0,0,0,1,2,3,4]

-- Calculates sum of all digits of a number
sumdig :: Int -> Int
sumdig 0 = 0
sumdig n = n `seq` n `mod` 10 + sumdig (n `div` 10)

-- Summation for Luhn algorithm
summ :: [Int] -> Int
summ = foldr ((+) . (\(x,y) -> sumdig(x*y))) 0 . zip (go 1)

-- Generating infinite list [2, 1, 2, 1, 2, 1, ...]
go :: Int -> [Int]
go n = let n' = n `mod` 2 + 1 in n':go n'

-- Verifies if credit card number satisfies Luhn algorithm
luhn :: [Int] -> Bool
luhn ys = summ ys `mod` 10 == 0
