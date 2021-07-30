{-# LANGUAGE DeriveGeneric, FlexibleInstances, MultiParamTypeClasses #-}
module Backend.Mapper.Database where

import Backend.Mapper.Database.Map
import Backend.Mapper.Database.Region

import Database.Beam (Generic, Database, TableEntity, DatabaseSettings, defaultDbSettings)

data MapperDb f = MapperDb
                { maps :: f (TableEntity MapT)
                , regions :: f (TableEntity RegionT)
                } deriving Generic

instance Database be MapperDb

mapperDb :: DatabaseSettings be MapperDb
mapperDb = defaultDbSettings