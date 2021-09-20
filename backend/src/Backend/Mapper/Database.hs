{-# LANGUAGE DeriveGeneric, FlexibleInstances, MultiParamTypeClasses, DeriveAnyClass #-}
module Backend.Mapper.Database 
  ( MapperDb(..)
  , mapperDb
  , migration
  ) where

import Backend.Mapper.Database.Map (MapT)
import Backend.Mapper.Database.Region (RegionT)
import Backend.Mapper.Database.Campus (CampusT)
import Backend.Mapper.Database.Building (BuildingT)
import Backend.Mapper.Database.Floor (FloorT)
import Backend.Mapper.Database.Room (RoomT)

import Database.Beam (Generic, Database, TableEntity)

import Database.Beam.Migrate (CheckedDatabaseSettings, defaultMigratableDbSettings)
import Database.Beam.Migrate.Simple (autoMigrate)

import Database.Beam.Postgres (Postgres, Pg)
import Database.Beam.Postgres.Migrate (migrationBackend)

{-
Beam Database type.

The app gets driven off of the Campus.
So this will probably be the start of some important queries like,

When we load a list of campuses or the default campus,
we look here first and find the Map for it and display it.
-}
data MapperDb f = MapperDb
                { mapperMaps :: f (TableEntity MapT)
                , mapperRegions :: f (TableEntity RegionT)
                , mapperCampus :: f (TableEntity CampusT)
                , mapperBuilding :: f (TableEntity BuildingT)
                , mapperFloor :: f (TableEntity FloorT)
                , mapperRoom :: f (TableEntity RoomT)
                } deriving (Generic, Database be)

mapperDb :: CheckedDatabaseSettings Postgres MapperDb
mapperDb = defaultMigratableDbSettings

migration :: Pg ()
migration = autoMigrate migrationBackend mapperDb
