{-# LANGUAGE DeriveGeneric, FlexibleInstances, MultiParamTypeClasses #-}
module Backend.Mapper.Database 
  ( MapperDb(..)
  , mapperDb
  , migration
  ) where

import Backend.Mapper.Database.Map (MapT)
import Backend.Mapper.Database.Region (RegionT)

import Database.Beam (Generic, Database, TableEntity)

import Database.Beam.Migrate (CheckedDatabaseSettings, defaultMigratableDbSettings)
import Database.Beam.Migrate.Simple (autoMigrate)

import Database.Beam.Postgres (Postgres, Pg)
import Database.Beam.Postgres.Migrate (migrationBackend)

data MapperDb f = MapperDb
                { maps :: f (TableEntity MapT)
                , regions :: f (TableEntity RegionT)
                } deriving Generic

instance Database be MapperDb

mapperDb :: CheckedDatabaseSettings Postgres MapperDb
mapperDb = defaultMigratableDbSettings

migration :: Pg ()
migration = autoMigrate migrationBackend mapperDb
