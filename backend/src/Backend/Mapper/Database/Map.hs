{-# LANGUAGE DeriveGeneric, StandaloneDeriving, FlexibleInstances, TypeFamilies #-}
module Backend.Mapper.Database.Map
  ( MapT(..)
  , Map
  , MapId
  ) where

import Prelude hiding (id)

import Data.Text     (Text)
import Database.Beam (C, Generic, PrimaryKey, Identity, Beamable, Table, primaryKey)
{-|
A Map table type.
The Map table contains visual maps to place interactive Regions on. 
NOTE: Width and Height might not be needed?
-}
data MapT f = Map
    { id :: C f Int        -- ^ The Id of the map.
    , image :: C f Text    -- ^ TODO: The data or path to the image to display for the map.
    , width :: C f Double  -- ^ The width of the image.
    , height :: C f Double -- ^ The height of the image.
    } deriving Generic

instance Beamable MapT

type Map = MapT Identity
deriving instance Show Map
deriving instance Eq Map

type MapId = PrimaryKey MapT Identity
deriving instance Show MapId
deriving instance Eq MapId

{-|
MapT is a Beam Table
Its primary key is just id.
-}
instance Table MapT where
    data PrimaryKey MapT f = MapId (C f Int) deriving Generic
    primaryKey = MapId . id

instance Beamable (PrimaryKey MapT)