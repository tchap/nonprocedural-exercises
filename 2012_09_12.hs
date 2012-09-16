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
