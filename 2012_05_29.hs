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
