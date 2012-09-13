import Data.List
import Data.Tuple

{-
  Multiset Comparison

  Write a function for comparing multisets. A multiset is [(Int, a)], while
  (i, k) means that k is repeater i-times in the set.

  M1 < M2 <=> M2 contains e which is not in M1 and it larger than any element
  that is in M1 and is missing from M2. This means that you do intersection,
  you drop this part from both multisets, and then the set containing larger
  element wins the game.
-}

type Multiset a = [(Int, a)]

cmpm :: Ord a => Multiset a -> Multiset a -> Ordering
cmpm m1 m2
  | m1 == m2 = EQ
  | otherwise =
    let m1f = filter (\e -> not $ elem e m2) m1
        m2f = filter (\e -> not $ elem e m1) m2
    in compare (swap $ last $ sort m1f) (swap $ last $ sort m2f)

{-
  Convert N-ary tree to binary tree

  Write a function that converts a N-ary tree, that is

      data NTree a = NTree a [NTree a]

  The output data structure is

      data BTree a = Void | BTree (BTree a) a (BTree a)
-}

data NTree a = NTree a [NTree a] deriving Show
data BTree a = Void | BTree (BTree a) a (BTree a) deriving Show

ntob :: NTree a -> BTree a
ntob (NTree v []) = BTree Void v Void
ntob (NTree v (c:cs)) =
  let l = ntob c
      r = ntob dummy
  in  BTree l v r
  where dummy = NTree v cs
