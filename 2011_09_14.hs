import Data.List
import Data.Maybe

{-
  Given a permutation, return its position sorting permutations lexicographically.
-}

indexOf :: Ord a => [a] -> Int
indexOf perm = fromJust (elemIndex perm $ genPerms (sort perm))

genPerms :: Eq a => [a] -> [[a]]
genPerms [] = [[]]
genPerms sorted = [(x:xs) | x <- sorted, xs <- genPerms (delete x sorted)]
