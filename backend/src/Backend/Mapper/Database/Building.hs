{-# LANGUAGE DeriveGeneric, StandaloneDeriving, FlexibleInstances, TypeFamilies, DeriveAnyClass #-}
module Backend.Mapper.Database.Building
  ( BuildingT
  , Building
  , BuildingId
  ) where

import GHC.Int
import Data.Text     (Text)

import Database.Beam (C, Generic, PrimaryKey, Identity, Nullable, Beamable, Table, primaryKey)

import Backend.Mapper.Database.Map (MapT)
import Backend.Mapper.Database.Campus (CampusT)

{-|
Building
Can be on a campus.
Can have a region on a map.

Unrepresentable
FOREIGN KEY (on_map, region) REFERENCES Region (on_map, id)
-}
data BuildingT f = Building
    { buildingId :: C f Int32                             -- ^ The Id of the Building.
    , buildingName :: C f Text                            -- ^ The name of the Building.
    , buildingOnCampus :: PrimaryKey CampusT (Nullable f) -- ^ Optional. Campus the Building is on.
    , buildingOnMap :: PrimaryKey MapT (Nullable f)       -- ^ Optional. Map the Building is on.
    , buildingRegion :: C f (Maybe Int32)                 -- ^ Optional. onMap + region identify a Region on the Map for this Building.
    } deriving (Generic, Beamable)

type Building = BuildingT Identity
deriving instance Show Building
deriving instance Eq Building

instance Table BuildingT where
    data PrimaryKey BuildingT f = BuildingId (C f Int32) deriving (Generic, Beamable)
    primaryKey = BuildingId . buildingId

type BuildingId = PrimaryKey BuildingT Identity
deriving instance Show BuildingId
deriving instance Eq BuildingId
