{-# LANGUAGE DeriveGeneric, FlexibleInstances, MultiParamTypeClasses #-}
module Backend.Mapper.Database where

import Backend.Mapper.Database.Map

import Database.Beam (Generic, Database, TableEntity, DatabaseSettings, defaultDbSettings)

data MapperDb f = MapperDb
                { maps :: f (TableEntity MapT)
                } deriving Generic

instance Database be MapperDb

mapperDb :: DatabaseSettings be MapperDb
mapperDb = defaultDbSettings