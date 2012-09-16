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

{-
  Given a relation defined by a list of pairs of elements, add pairs to this list
  so that the relation is equivalence (reflexive, transitive, symmetric).
-}

toEquiv :: Eq a => [(a, a)] -> [(a, a)]
toEquiv = closureT . closureRS
  where closureRS r = nub . concat $ map (\(a,b) -> [(a,a),(b,b),(a,b),(b,a)]) r
        closureT r
	  | length r == length closure = closure
	  | otherwise = closureT closure
	  where closure = nub $ [(a,d) | (a,b) <- r,
	                                 (c,d) <- r,
					 b == c
					 -- possible to add
					 -- not $ (a,d) `elem` r
					 -- instead of nub
				]
				++
				r
