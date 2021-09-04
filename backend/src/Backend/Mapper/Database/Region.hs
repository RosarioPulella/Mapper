{-# LANGUAGE DeriveGeneric, StandaloneDeriving, FlexibleInstances, TypeFamilies #-}
module Backend.Mapper.Database.Region
  ( RegionT(..)
  , Region
  , RegionId
  ) where

import Prelude hiding (id)

import Backend.Mapper.Database.Map (MapT)

import GHC.Int
import Data.Text     (Text)
import Database.Beam (C, Generic, PrimaryKey, Identity, Beamable, Table, primaryKey)
{-
Can be on a map.
NOTE: Think on how we want to store the vector graphical representation of a Region,
like do we have the location separately? or do we pull out other info from the path?
-}

data RegionT f = Region {
      on_map :: PrimaryKey MapT f -- ^ The map this region is on.
    , id :: C f Int32               -- ^ the id of the region on the map.
    , x :: C f Double             -- ^ The x position of the region.
    , y :: C f Double             -- ^ The y position of the region.
    , svg_path :: C f Text        -- ^ The svg path defining the shape of the region.
    } deriving Generic

instance Beamable RegionT

type Region = RegionT Identity
deriving instance Show Region
deriving instance Eq Region

type RegionId = PrimaryKey RegionT Identity
deriving instance Show RegionId
deriving instance Eq RegionId

{-|
RegionT is a Beam Table
Its primary key is on_map + id.
-}
instance Table RegionT where
  data PrimaryKey RegionT f = RegionId (PrimaryKey MapT f) (C f Int32) deriving Generic
  primaryKey = RegionId <$> on_map <*> id

instance Beamable (PrimaryKey RegionT)

