{-
  Give a data structure - Bag defined as

      data Bag a = Item a | Items [Bag a]

  , write a fold function defined as

      fold :: (a -> b) -> ([b] -> b) -> Bag a -> b

  that allows to fold the whole DS into a single value.
  Then use this function to get a list of all the values in a Bag.
-}

data Bag a = Item a | Items [Bag a]

fold :: (a -> b) -> ([b] -> b) -> Bag a -> b
fold mapf reducef (Item x) = mapf x
fold mapf reducef (Items xs) = reducef $ map (fold mapf reducef) xs

values :: Bag a -> [a]
values = fold toList concat

toList :: a -> [a]
toList x = [x]

{-
  Generate infinite sequence of lists of lenght n consisting of integers.
  They must be sorted - L1 < L2 <=> max L1 < max L2 ||
                                   (max L1 == max L2 => compare L1 L2 == LT)
  So you sort primarily according to the largest integer in the list,
  secondarily lexicographically.

  Example for n = 2: [1,1], [1,2], [2,1], [2,2], [1,3], ...
-}

seqn :: Int -> [[Int]]
seqn = seqWithMax 1

seqWithMax :: Int -> Int -> [[Int]]
seqWithMax k n = [s | s <- randSeq n k, k `elem` s] ++ seqWithMax (k+1) n

randSeq :: Int -> Int -> [[Int]]
randSeq 0 _ = [[]]
randSeq n k = [(x:xs) | x <- [1..k], xs <- randSeq (n-1) k]
