import Data.List

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

{-
  A graph is represented either as a list of edges, that is [(a, a, Int)]
  or as a list of pairs (vertex, [edges]), that is [(a, [(a, Int)])].
  Your task is to write a function that convert the former representation
  into the latter one.
-}

type EdgGraph a = [(a, a, Int)]
type AdjGraph a = [(a, [(a, Int)])]

edg2adj :: Eq a => EdgGraph a -> AdjGraph a
edg2adj g = map transf grps
  where grps = groupBy (\(x, _, _) (y, _, _) -> x == y) g
        transf grp@((v, _, _):_) = (v, es)
	  where es = map (\(_, t, w) -> (t, w)) grp
