module Backend (backend) where

import Data.Pool (withResource)

import Database.Beam.Postgres (Connection, runBeamPostgres)

import Gargoyle.PostgreSQL.Connect (withDb)

import Common.Route
import Obelisk.Backend
import Backend.Mapper.Database (migration)

backend :: Backend BackendRoute FrontendRoute
backend = Backend
  { _backend_run = \serve -> do
    withDb "database" $ \pool -> withResource pool runMigrations
    serve $ const $ return ()
  , _backend_routeEncoder = fullRouteEncoder
  }

runMigrations :: Connection -> IO ()
runMigrations connection = 
  runBeamPostgres connection migration