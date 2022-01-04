{-# OPTIONS -Wall #-}

-- https://ctflearn.com/challenge/970

module Card where

-- Because 0 is the neutral element of addition in N and
-- for every x in N: [x * 0 = 0] i substituted 0s in place
-- of the stars.
cardNeutral :: [Int]
cardNeutral = [5,4,3,2,1,0,0,0,0,0,0,0,1,2,3,4]


{- LUHN ALGORITHM PART -}


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


{- DIVISIBILITY PART -}


-- Since 123457 is prime, we have to brute force
-- nevertheless we still can limit number of computations
prime :: Int
prime = 123457

-- 5432,1000,0000,1234 divided by 123457 wields 43999935200
-- This is our lower bound
lower :: Int
lower = 43999935200 * prime

-- 5432,2000,0000,1234 divided by 123457 wields 44000745198
-- This is our upper bound
upper :: Int
upper = 44000745198 * prime

-- Between these two numbers there are little less than 100000000000 numbers
-- Since our iterative step will be 123457, we reduced our bruteforce to only about 810000 cases
-- But we also filter them as they need to end with "1234".
cases :: [Int]
cases = filter (\x -> x `mod` 10000 == 1234) $ helper lower
    where
        helper n = if n > upper then []
            else n:helper (n+prime)

-- Taking "length cases" in ghci we can se that we're left with 81 cases.
-- That seems reasonable number to work with

-- Lets write a function to convert them to lists of digits (reversed)
toDigList :: Int -> [Int]
toDigList 0 = []
toDigList n = toDigList (n `div` 10) ++ [n `mod` 10]

