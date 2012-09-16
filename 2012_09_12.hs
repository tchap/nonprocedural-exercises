import Data.List

{-
  Given a list and a list of pairs representing order or elements,
  generate all permutations of the first list fulfilling all the constraints
  on order of elements given in the second argument.

  (1, 2) means that 1 must be before 2 in the permutation.

  Example:
    perm [1,2,3] [(2,1)]
      -> [[2,1,3],[2,3,1],[3,2,1]]
    perm [1,2,3] [(2,1), (1,2)]
      -> []
-}
perm :: Eq a => [a] -> [(a,a)] -> [[a]]
perm list constr = filter ff (allPerms list)
  where ff p = all (\(x, y) -> (elemIndex x p) < (elemIndex y p)) constr

allPerms :: Eq a => [a] -> [[a]]
allPerms [] = [[]]
allPerms list = [(p:ps) | p <- list, ps <- allPerms $ delete p list]

{-
  Write fold function for binary trees. The types are
  
      data BTree = Void | Node (BTree a) a (BTree a)
      fold :: (b -> a -> b -> b) -> b -> BTree a -> b

  Use that fold function to get the height of the tree and
  count the number of leaves in the tree.
-}

data BTree = Void | Node (BTree a) a (BTree a)

fold :: (b -> a -> b -> b) -> b -> BTree a -> b
fold f acc Void = acc
fold f acc (Node l v r) = f (fold f acc l) v (fold f acc r)

height :: BTree a -> Int
height = fold (\l _ r -> (+) 1 $ max l r) 0

leaveCount :: BTree a -> [a]
leaveCount = fold (\l _ r -> if (max l r) == 0 then 1 else l + r) 0
