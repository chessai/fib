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

instance Ring a => Ring (Fib a) where
  negate (Fib a b) = Fib (negate a) (negate b)

instance Applicative Fib where
  pure x = Fib x x
  Fib fa fb <*> Fib a b = Fib (fa a) (fb b)

instance Monad Fib where
  Fib a b >>= f = Fib a' b' where
    Fib a' _ = f a
    Fib _ b' = f b

phi :: Semiring a => Fib a
phi = one

fib :: Ring a => Integer -> a
fib n
  | n >= 0 = case (phi ^ n) of (Fib a _) -> a
  | otherwise = case (Fib one (negate one) ^ negate n) of (Fib a _) -> a
