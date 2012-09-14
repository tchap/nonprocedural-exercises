{-
  Given an alphabet (sorted array of characters), a word from that alphabet and
  N, generate all the words from the same alphabet that differ in max N letters.
  The list of works returned shall be alphabetically sorted.
-}

differInMax :: Int -> String -> [String]
differInMax 0 word = [word]
differInMax _ ""   = [""]
differInMax n (c:suffix) =
  [
    (ac:gensuffix) | ac <- alphabet, 
                     let i = if ac == c then 0 else 1,
		     gensuffix <- differInMax (n-i) suffix
  ]
  where alphabet = "abcdefghijklmnopqrstuvwxyz"

{-
  Generate all factors of the number given. 
-}

factors n = factors' n 2 [] 

factors' n k acc
  | n == 1 = reverse acc
  | n `mod` k == 0 = factors' (n `div` k) 2 (k:acc)
  | otherwise = factors' n (k+1) acc
