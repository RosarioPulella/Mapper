{-# LANGUAGE DeriveGeneric, StandaloneDeriving, FlexibleInstances #-}
module Backend.Mapper.Database.Map
  ( MapT(..)
  , Map
  , MapId
  ) where

import Prelude hiding (id)

import Data.Text     (Text)
import Database.Beam (C, Generic, PrimaryKey, Identity)
{-
NOTE: Width and Height might not be needed?

CREATE TABLE Map (
    id INT,
    image DATA NOT NULL,
    width REAL NOT NULL,
    height REAL NOT NULL,
    PRIMARY KEY (id),
)
-}
data MapT f = Map
    { id :: C f Int
    , image :: C f Text
    , width :: C f Double
    , height :: C f Double
    } deriving Generic

type Map = MapT Identity
type MapId = PrimaryKey MapT Identity

deriving instance Show Map
deriving instance Eq Map
