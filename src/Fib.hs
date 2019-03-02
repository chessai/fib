{-# language BangPatterns #-}
{-# language DeriveFoldable #-}
{-# language DeriveFunctor #-}
{-# language DeriveTraversable #-}
{-# language DerivingStrategies #-}

module Fib
  ( Fib(..)
  ) where

data Fib a = Fib a a
  deriving stock (Show)
  deriving stock (Functor,Foldable,Traversable)

instance Semiring a => Semiring (Fib a) where
  zero = Fib zero zero
  Fib a b `plus` Fib c d = Fib (a `plus` c) (b `plus` d)
  one = Fib one zero
  Fib a b `times` Fib c d = Fib (a `times` (c `plus` d) `plus` b `times` c) (a `times` c `plus` b `times` d)
  {-# inline zero #-}
  {-# inline one #-}
  {-# inline plus #-}
  {-# inline times #-}

instance Ring a => Ring (Fib a) where
  negate (Fib a b) = Fib (negate a) (negate b)
  {-# inline negate #-}

instance Applicative Fib where
  pure x = Fib x x
  {-# inline pure #-} 
  Fib fa fb <*> Fib a b = Fib (fa a) (fb b)
  {-# inline (<*>) #-}

instance Monad Fib where
  Fib a b >>= f = Fib a' b' where
    Fib a' _ = f a
    Fib _ b' = f b
  {-# inline (>>=) #-}

phi :: Semiring a => Fib a
phi = one
{-# inline phi #-}

fib :: Ring a => Integer -> a
fib n
  | n >= 0 = case (phi ^ n) of (Fib a _) -> a
  | otherwise = case (Fib one (negate one) ^ negate n) of (Fib a _) -> a
{-# inlinable fib #-}
