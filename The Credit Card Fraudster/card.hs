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

-- 5432,1000,0000,1234 divided by 123457 in N (ignoring the remainder) wields 43999935200
-- This is our lower bound
lower :: Int
lower = 43999935200 * prime

-- 5432,1100,0000,1234 divided by 123457 in N wields 44000016199
-- This is our upper bound
upper :: Int
upper = 44000016199 * prime

-- Between these two numbers there are little less than 10,000,000,000 numbers
-- Since our iterative step will be 123457, we reduced our bruteforce to only about 81000 cases
-- But we also filter them as they need to end with "1234" and start with "54321".
cases :: [Int]
cases =  fil2 $ fil1 $ helper lower
    where
        fil1 = filter (\x -> x `mod` 10^(4::Int) == 1234)
        fil2 = filter (\x -> x `div` 10^(11::Int) == 54321)
        helper n = if n > upper then []
            else n:helper (n+prime)

-- Taking "length cases" in ghci we can se that we're left with 8 cases.
-- That seems to be a reasonable number to work with

-- Lets write a function to convert them to lists of digits
toDigList :: Int -> [Int]
toDigList 0 = []
toDigList n = toDigList (n `div` 10) ++ [n `mod` 10]

-- And another to later get them back
toNum :: [Int] -> Int
toNum [] = 0
toNum ys = helper 0 (reverse ys)
    where
        helper :: Int -> [Int] -> Int
        helper _ [] = 0
        helper x (n:ns) = n*(10^x) + helper (x+1) ns

{- ANSWER -}


-- Now all we need to do is to map toDigList over cases and filter them with respect to Luhn algorithm
-- If everything goes right we should get only one result
result :: [Int]
result = (map toNum . filter luhn . map toDigList) cases 

-- AND AS A RESULT WE GET:
-- 5432103279251234
-- after putting it to the page, we see it is correct c: