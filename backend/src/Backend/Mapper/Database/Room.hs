{-# LANGUAGE DeriveGeneric, StandaloneDeriving, FlexibleInstances, TypeFamilies, DeriveAnyClass #-}
module Backend.Mapper.Database.Room
  ( RoomT
  , Room
  , RoomId
  ) where

import GHC.Int

import Database.Beam (C, Generic, PrimaryKey, Identity, Nullable, Beamable, Table, primaryKey)

import Backend.Mapper.Database.Map (MapT)
import Backend.Mapper.Database.Building (BuildingT)

{-|
Room
Is in a Building.
Can be on a floor.
Can have a region on a map.

Unrepresentable
FOREIGN KEY (in_building, on_floor) REFERENCES Floor (in_building, floor),
FOREIGN KEY (on_map, region) REFERENCES Region (on_map, id)
-}
data RoomT f = Room
    { roomInBuilding :: PrimaryKey BuildingT f  -- ^ The Building the Room is in.
    , roomNumber :: C f Int32                   -- ^ The Room number.
    , roomOnFloor :: C f (Maybe Int32)          -- ^ Optional. The Floor the Room is on.
    , roomOnMap :: PrimaryKey MapT (Nullable f) -- ^ Optional. The Map the Room is on.
    , roomRegion :: C f (Maybe Int32)           -- ^ Optional. onMap + region identify a Region on the Map for this Room.
    } deriving (Generic, Beamable)

type Room = RoomT Identity
deriving instance Show Room
deriving instance Eq Room

instance Table RoomT where
    data PrimaryKey RoomT f = RoomId (PrimaryKey BuildingT f) (C f Int32) deriving (Generic, Beamable)
    primaryKey = RoomId <$> roomInBuilding <*> roomNumber

type RoomId = PrimaryKey RoomT Identity
deriving instance Show RoomId
deriving instance Eq RoomId
