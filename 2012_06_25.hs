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
