{-# OPTIONS -Wall #-}

-- https://ctflearn.com/challenge/970

module Card where

-- Because 0 is the neutral element of addition in N and
-- for every x in N: [x * 0 = 0] i substituted 0s in place
-- of the stars. We'll use it in ghci for testing.
cardNeutral :: [Int]
cardNeutral = [5,4,3,2,1,0,0,0,0,0,0,0,1,2,3,4]


{- LUHN ALGORITHM PART -}


-- Calculates sum of all digits of a number
sumdig :: Int -> Int
sumdig 0 = 0
sumdig n = n `seq` n `mod` 10 + sumdig (n `div` 10)

-- Summation for Luhn algorithm
summ :: [Int] -> Int
summ = foldr ((+) . (\(x,y) -> sumdig (x*y))) 0 . zip (weights 1)

-- Generating infinite list [2, 1, 2, 1, 2, 1, ...]
weights :: Int -> [Int]
weights n = let n' = n `mod` 2 + 1 in n':weights n'

-- Verifies if credit card number satisfies Luhn algorithm
luhn :: [Int] -> Bool
luhn ys = summ ys `mod` 10 == 0


{- DIVISIBILITY PART -}


prime :: Int
prime = 123457

lower :: Int
lower = 43999935200 * prime

upper :: Int
upper = 43999943300 * prime

cases :: [Int]
cases =  fil2 $ fil1 $ helper lower
    where
        fil1 = filter (\x -> x `mod` 10^(4::Int) == 1234)
        fil2 = filter (\x -> x `div` 10^(10::Int) == 543210)
        helper n = if n > upper then []
            else n:helper (n+prime)

toDigList :: Int -> [Int]
toDigList 0 = []
toDigList n = toDigList (n `div` 10) ++ [n `mod` 10]

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
