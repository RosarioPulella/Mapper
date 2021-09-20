{-# LANGUAGE DeriveGeneric, StandaloneDeriving, FlexibleInstances, TypeFamilies, DeriveAnyClass #-}
module Backend.Mapper.Database.Region
  ( RegionT
  , Region
  , RegionId
  ) where

import GHC.Int
import Data.Text     (Text)

import Database.Beam (C, Generic, PrimaryKey, Identity, Beamable, Table, primaryKey)

import Backend.Mapper.Database.Map (MapT)

{-
Can be on a Map.
NOTE: Think on how we want to store the vector graphical representation of a Region,
like do we have the location separately? or do we pull out other info from the path?
-}

data RegionT f = Region
    { regionOnMap :: PrimaryKey MapT f -- ^ The Map this Region is on.
    , regionId :: C f Int32            -- ^ the id of the Region on the Map.
    , regionX :: C f Double            -- ^ The x position of the Region.
    , regionY :: C f Double            -- ^ The y position of the Region.
    , regionSvgPath :: C f Text        -- ^ The svg path defining the shape of the Region.
    } deriving (Generic, Beamable)

type Region = RegionT Identity
deriving instance Show Region
deriving instance Eq Region

instance Table RegionT where
  data PrimaryKey RegionT f = RegionId (PrimaryKey MapT f) (C f Int32) deriving (Generic, Beamable)
  primaryKey = RegionId <$> regionOnMap <*> regionId

type RegionId = PrimaryKey RegionT Identity
deriving instance Show RegionId
deriving instance Eq RegionId
