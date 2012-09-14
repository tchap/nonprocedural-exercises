{-
  Given an alphabet (sorted array of characters), a word from that alphabet and
  N, generate all the words from the same alphabet that differ in max N letters.
  The list of works returned shall be alphabetically sorted.
-}

differByMax :: Int -> String -> [String]
differByMax 0 word = [word]
differByMax _ ""   = [""]
differByMax n (c:suffix) =
  [
    (ac:gensuffix) | ac <- alphabet, 
                     let i = if ac == c then 0 else 1,
		     gensuffix <- differByMax (n-i) suffix
  ]
  where alphabet = "abcdefghijklmnopqrstuvwxyz"
