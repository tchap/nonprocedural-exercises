import Data.List

{- 
   Isomorphic trees
   ----------------
   
   Write a function 
       
       iso :: Int -> (Bt a) -> [(Bt a)]

   which returns a list of all binary trees that are formed by
   swapping left and right subtree in exactly N nodes in the original tree.
-}

data Bt a = Void | Node (Bt a) a (Bt a) deriving Show

iso :: Int -> (Bt a) -> [(Bt a)]
iso _ Void = []
iso 0 t = [t]
iso n (Node l v r) =
  [ -- not swapping
    Node ls v rs |  m <- [0..n],
                   ls <- iso (n-m) l,
                   rs <- iso m r
  ]
  ++
  [ -- swapping
    Node rs v ls |  m <- [0..(n-1)],
                   ls <- iso (n-m-1) l,
                   rs <- iso m r
  ]

{-
   N-ary tree is given as

       data NTree a = NTree a [NTree a]
   
   In our case the type parameter is a pair of (k, v).

   So, write a function that visits all the nodes, sorting the list of children
   according to a compare function given. The signature is

       compare :: k -> k -> Bool

   Use it to compare keys (parameter k). It returns True when k1 < k2.
-}


data NTree a = NTree a [NTree a] deriving Show

sortNT :: (Eq k ) => (k -> k -> Bool) -> NTree (k, v) -> NTree (k, v)
sortNT cmpf (NTree (key, value) children) =
  NTree (key, value) schildren
  where
    mycmp (NTree (k1, _) _) (NTree (k2, _) _)
      | k1 == k2 = EQ
      | cmpf k1 k2 = LT
      | otherwise = GT
    chch = map (sortNT cmpf) children
    schildren = sortBy mycmp chch
