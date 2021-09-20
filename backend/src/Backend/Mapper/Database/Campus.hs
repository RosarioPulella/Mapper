{-# LANGUAGE DeriveGeneric, StandaloneDeriving, FlexibleInstances, TypeFamilies, DeriveAnyClass #-}
module Backend.Mapper.Database.Campus
  ( CampusT
  , Campus
  , CampusId
  ) where

import GHC.Int
import Data.Text     (Text)

import Database.Beam (C, Generic, PrimaryKey, Identity, Nullable, Beamable, Table, primaryKey)

import Backend.Mapper.Database.Map (MapT)

{-|
Campus
Can have a map to show.
Can have a region on its map.
Note: This allows a Map with multiple Campuses on it.

Unrepresentable
FOREIGN KEY (on_map, region) REFERENCES Region (on_map, id)
-}
data CampusT f = Campus
    { campusId :: C f Int32                       -- ^ The Id of the Campus.
    , campusName :: C f Text                      -- ^ The name of the Campus.
    , campusOnMap :: PrimaryKey MapT (Nullable f) -- ^ Optional. Map the Campus is on.
    , campusRegion :: C f (Maybe Int32)           -- ^ Optional. onMap + region identify a Region on the Map for this Campus.
    } deriving (Generic, Beamable)

type Campus = CampusT Identity
deriving instance Show Campus
deriving instance Eq Campus

instance Table CampusT where
    data PrimaryKey CampusT f = CampusId (C f Int32) deriving (Generic, Beamable)
    primaryKey = CampusId . campusId

type CampusId = PrimaryKey CampusT Identity
deriving instance Show CampusId
deriving instance Eq CampusId

deriving instance Show (PrimaryKey CampusT (Nullable Identity))
deriving instance Eq (PrimaryKey CampusT (Nullable Identity))
