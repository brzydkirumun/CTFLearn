{-# OPTIONS -Wall #-}

module Main where

main :: IO ()
main = do
    putStrLn "Give message:"
    mess <- getLine 
    putStrLn $ decode mess

decode :: String -> String
decode = map translate . lexer "" []
    where
        lexer :: String -> [String] -> String -> [String]
        lexer ns prev [] = prev ++ [ns]
        lexer ns prev (l:ls)
            | l == ' '  = lexer "" (prev ++ [ns]) ls
            | otherwise = lexer (ns++[l]) prev ls
        
        translate :: String -> Char
        translate ".-"      = 'A'
        translate "-..."    = 'B'
        translate "-.-."    = 'C'
        translate "-.."     = 'D'
        translate "."       = 'E'
        translate "..-."    = 'F'
        translate "--."     = 'G'
        translate "...."    = 'H'
        translate ".."      = 'I'
        translate ".---"    = 'J'
        translate "-.-"     = 'K'
        translate ".-.."    = 'L'
        translate "--"      = 'M'
        translate "-."      = 'N'
        translate "---"     = 'O'
        translate ".--."    = 'P'
        translate "--.-"    = 'Q'
        translate ".-."     = 'R'
        translate "..."     = 'S'
        translate "-"       = 'T'
        translate "..-"     = 'U'
        translate "...-"    = 'V'
        translate ".--"     = 'W'
        translate "-..-"    = 'X'
        translate "-.--"    = 'Y'
        translate "--.."    = 'Z'
        translate ".----"   = '1'
        translate "..---"   = '2'
        translate "...--"   = '3'
        translate "....-"   = '4'
        translate "....."   = '5'
        translate "-...."   = '6'
        translate "--..."   = '7'
        translate "---.."   = '8'
        translate "----."   = '9'
        translate "-----"   = '0'
        translate _         = undefined