module Paths_haskell_challenge (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/mario/.cabal/bin"
libdir     = "/home/mario/.cabal/lib/x86_64-linux-ghc-7.10.3/haskell-challenge-0.1.0.0-1I5UYvISgBcFGQLd4CAc0l"
datadir    = "/home/mario/.cabal/share/x86_64-linux-ghc-7.10.3/haskell-challenge-0.1.0.0"
libexecdir = "/home/mario/.cabal/libexec"
sysconfdir = "/home/mario/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "haskell_challenge_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "haskell_challenge_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "haskell_challenge_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "haskell_challenge_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "haskell_challenge_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
