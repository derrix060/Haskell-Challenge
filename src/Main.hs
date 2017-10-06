{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}

module Main where
 
import Control.Applicative ((<$>), optional)
import Data.Maybe (fromMaybe)
import Data.Text (Text)
import Data.Text.Lazy (unpack)
import Happstack.Lite
import Text.Blaze.Html5 (Html, (!), a, form, input, p, toHtml, label)
import Text.Blaze.Html5.Attributes (action, enctype, href, name, size, type_, value)
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Download
import Template

-- Start server
main :: IO ()
main = do
    putStrLn "Server running in http://localhost:8000/"
    serve Nothing myApp

-- Web routes
myApp :: ServerPart Response
myApp = msum
  , dir "upload"      $ upload
  [ dir "download"    $ downloadFile
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


echo :: ServerPart Response
echo =
    path $ \(msg :: String) ->
        ok $ template "echo" $ do
          p $ "echo says: " >>toHtml msg
          p "Change the url to echo something else."


queryParams :: ServerPart Response
queryParams =
    do mFoo <- optional $ lookText "foo"
       ok $ template "query params" $ do
         p $ "foo is set to: " >> toHtml (show mFoo)
         p $ "change the url to set it to something else."

formPage :: ServerPart Response
formPage = msum [ viewForm, processForm ]
  where
    viewForm :: ServerPart Response
    viewForm =
        do method GET
           ok $ template "form" $
              form ! action "/form" ! enctype "multipart/form-data" ! A.method "POST" $ do
                label ! A.for "msg" $ "Say something clever"
                input ! type_ "text" ! A.id "msg" ! name "msg"
                input ! type_ "submit" ! value "Say it!"

    processForm :: ServerPart Response
    processForm =
        do method POST
           msg <- lookText "msg"
           ok $ template "form" $ do
             H.p "You said:"
             H.p (toHtml msg)


fortune :: ServerPart Response
fortune = msum [ viewFortune, updateFortune ]
    where
      viewFortune :: ServerPart Response
      viewFortune =
          do method GET
             mMemory <- optional $ lookCookieValue "fortune"
             let memory = fromMaybe "Your future will be filled with web programming." mMemory
             ok $ template "fortune" $ do
                    H.p "The message in your (fortune) cookie says:"
                    H.p (toHtml memory)
                    form ! action "/fortune" ! enctype "multipart/form-data" ! A.method "POST" $ do
                    label ! A.for "fortune" $ "Change your fortune: "
                    input ! type_ "text" ! A.id "fortune" ! name "new_fortune"
                    input ! type_ "submit" ! value "Say it!"

      updateFortune :: ServerPart Response
      updateFortune =
          do method POST
             fortune <- lookText "new_fortune"
             addCookies [(Session, mkCookie "fortune" (unpack fortune))]
             seeOther ("/fortune" :: String) (toResponse ())




upload :: ServerPart Response
upload =
       msum [ uploadForm
            , handleUpload
            ]
    where
    uploadForm :: ServerPart Response
    uploadForm =
        do method GET
           ok $ template "upload form" $ do
             form ! enctype "multipart/form-data" ! A.method "POST" ! action "/upload" $ do
               input ! type_ "file" ! name "file_upload" ! size "40"
               input ! type_ "submit" ! value "upload"

    handleUpload :: ServerPart Response
    handleUpload =
        do (tmpFile, uploadName, contentType) <- lookFile "file_upload"
           ok $ template "file uploaded" $ do
                p (toHtml $ "temporary file: " ++ tmpFile)
                p (toHtml $ "uploaded name:  " ++ uploadName)
                p (toHtml $ "content-type:   " ++ show contentType)





