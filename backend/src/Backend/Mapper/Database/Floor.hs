{-# LANGUAGE DeriveGeneric, StandaloneDeriving, FlexibleInstances, TypeFamilies, DeriveAnyClass #-}
module Backend.Mapper.Database.Floor
  ( FloorT
  , Floor
  , FloorId
  ) where

import GHC.Int

import Database.Beam (C, Generic, PrimaryKey, Identity, Nullable, Beamable, Table, primaryKey)

import Backend.Mapper.Database.Map (MapT)
import Backend.Mapper.Database.Building (BuildingT)

{-|
Floor
Is in a building.
Can have a map to show it.
-}
data FloorT f = Floor
    { floorInBuilding :: PrimaryKey BuildingT f -- ^ The the Building the floor is in.
    , floorNumber :: C f Int32                  -- ^ The floor number.
    , floorMap :: PrimaryKey MapT (Nullable f)  -- ^ Optional. The Map of the Floor.
    } deriving (Generic, Beamable)

type Floor = FloorT Identity
deriving instance Show Floor
deriving instance Eq Floor

instance Table FloorT where
    data PrimaryKey FloorT f = FloorId (PrimaryKey BuildingT f) (C f Int32) deriving (Generic, Beamable)
    primaryKey = FloorId <$> floorInBuilding <*> floorNumber

type FloorId = PrimaryKey FloorT Identity
deriving instance Show FloorId
deriving instance Eq FloorId
