{-# LANGUAGE DeriveGeneric, StandaloneDeriving, FlexibleInstances, TypeFamilies, DeriveAnyClass #-}
module Backend.Mapper.Database.Map
  ( MapT
  , Map
  , MapId
  ) where

import GHC.Int       (Int32)
import Data.Text     (Text)

import Database.Beam (C, Generic, PrimaryKey, Nullable, Identity, Beamable, Table, primaryKey)

{-|
A Map table type.
The Map table contains visual maps to place interactive Regions on. 
NOTE: Width and Height? A cropping?
-}
data MapT f = Map
    { mapId :: C f Int32      -- ^ The Id of the map.
    , mapImage :: C f Text    -- ^ TODO: The data or path to the image to display for the map.
    } deriving (Generic, Beamable)

type Map = MapT Identity
deriving instance Show Map
deriving instance Eq Map

instance Table MapT where
    data PrimaryKey MapT f = MapId (C f Int32) deriving (Generic, Beamable)
    primaryKey = MapId . mapId


type MapId = PrimaryKey MapT Identity
deriving instance Show MapId
deriving instance Eq MapId

deriving instance Show (PrimaryKey MapT (Nullable Identity))
deriving instance Eq (PrimaryKey MapT (Nullable Identity))
