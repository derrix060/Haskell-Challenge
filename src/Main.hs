{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}

module Main where
 
import Happstack.Lite
import Text.Blaze.Html5 (Html, (!), a, p)
import Text.Blaze.Html5.Attributes (href)
import qualified Text.Blaze.Html5 as H

import Download
import Template
import Upload

-- Start server
main :: IO ()
main = do
    putStrLn "Server running in http://localhost:8000/"
    serve Nothing myApp

-- Web routes
myApp :: ServerPart Response
myApp = msum
  [ dir "download"    $ downloadFile
  --, dir "upload"      $ uploadFile
  , homePage
  ]



-- Main Page
homePage :: ServerPart Response
homePage =
    ok $ template "home page" $ do
           H.h1 "Hello!"
           H.p "This is a API to upload and download files"
           H.p $ a ! href "/download"         $ "Download one file"
           H.p $ a ! href "/upload"        $ "Upload one file"
