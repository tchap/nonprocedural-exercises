{-
  Construct a binary search tree from a list of nodes
  that represent the preorder traversal of the tree.
-}

data BST a = Void | Node (BST a) a (BST a) deriving Show

readBST :: Ord a => [a] -> BST a
readBST [] = Void
readBST (x:xs) = Node l x r
  where (smaller, larger) = span (<x) xs
        l = readBST smaller
	r = readBST larger
