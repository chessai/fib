module Prelude
  ( module P
  ) where

import GHC.Show as P (Show)
import Data.Eq as P (Eq(..))
import Data.Functor as P (Functor(..))
import Data.Foldable as P (Foldable(..))
import Data.Traversable as P (Traversable(..))
import Data.Semiring as P (Semiring(..),Ring(..),(+),(*),(-),(^))
import Control.Applicative as P (Applicative(..))
import Control.Monad as P (Monad(..))
import GHC.Integer as P (Integer)
import Data.Ord as P (Ord(..))
import Data.Bool as P (otherwise,Bool)
