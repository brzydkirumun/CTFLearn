# The credit card frauster

- Challenge: [The credit card frauster](https://ctflearn.com/challenge/970)
- Author: _ebouteillon_
- Category: _programming_
- Difficulty: _easy_

This challenge was probably one of the most enjoyable out of all that I've done yet. It mainly focuses on Luhn algorithm and a a bit on some basic number theory.
Our goal is to find credit card number knowing that it satisfies the _Luhn algorithm_, is divisible by _123457_, starts with _543210_ and ends with _1234_.

For this challenge I picked haskell as it seemed perfect for such problem due to its ellegance. I don't regret it. As always at one point I decided to make the code a little bit more general to cover some cases that we don't specifically need fot this problem but make it more interesting.

## Solution

### Luhn algorithm
Luhn algorithm is a relatively simple formula used in credit card validation. It consists of four steps:

1. Cut the number into digits and double every second one of them.
2. Sum digits of every result.
3. Sum the results.
4. If result ends with 0, then number is valid.

First we need some helper functions:
- `weights` - generating infinite list [2,1,2,1,...] for our weights.
- `sumdig` - summing all digits of a number
- `summ` - performing steps 1 to 3 of the algorithm
- `luhn` - checking if result of `summ` ends with a 0 (is a multiple of ten)

### Finding potential candidates
It is easy to look up, that _123457_ is a prime number. We will have to bruteforce this part, but we can still optimalize to make less steps.

First we want to find lower and upper bound for our search. We know that the number takes form _543210XXXXXX1234_ and hence it is:
1. greater or equal to _5432100000001234_
2. less than or equal to _5432109999991234_

But we also know that we're interested solely in numbers that are divisible by _123457_, hence we divide our bounds by the prime ignoring the reminder. We get _43999935200_ from the lower and _44000016199_ from the upper.

When we multiply these results by the prime again, we will get the actual, easy to work with, and divisible by _123457_ numbers, which in code are called `lower` and `upper` respectively.

We then write function `cases` which generates all cases that are interesing to us (i.e. satisfy the disivility condition, are within the bounds and have first 6 and last 4 digits same as the fraudster's credit card number). 

### Solution
Since for Luhn algorithm it was easier to work with list of digits and for second part actual numbers were more comfortable we need functions that can convert them one to the other. These are `toDigList` and `toNum` respectively.

Then we write function `result` that finds all results. It first calls `cases`, then maps `toDigList` on all of them so that they can be inputted to `luhn` function, which is a predicate for a filter. Hence, we're left only with solutions, that we then convert back to numbers.

We then just call `result` in ghci. Since this is a CTF problem we're lucily left only with one possible solution, that we can input as our answer.

## Neat c:
