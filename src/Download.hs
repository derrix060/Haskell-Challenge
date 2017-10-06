{-# LANGUAGE OverloadedStrings #-}

module Download where

import Data.Text.Lazy (unpack)
import Happstack.Lite
import Text.Blaze.Html5 (Html, (!), form, input, label)
import Text.Blaze.Html5.Attributes (action, enctype, name, type_, value)
import qualified Text.Blaze.Html5.Attributes as A

import Template

downloadFile :: ServerPart Response 
downloadFile = msum [ downloadForm, handleDownload ] 
  where 
    -- Form to download one file if GET request 
    downloadForm :: ServerPart Response 
    downloadForm = 
        do method GET 
           ok $ template "Download Form" $ 
            form ! action "/download" ! enctype "multipart/form-data" ! A.method "POST" $ do 
              label ! A.for "file" $ "Enter the file name: " 
              input ! type_ "text" ! A.id "file" ! name "file" 
              input ! type_ "submit" ! value "Download it!" 
 
    -- Download the file if POST request 
    handleDownload :: ServerPart Response 
    handleDownload = 
        do method POST 
           mFile <- lookText "file" 
           serveDirectory DisableBrowsing ["index.html"] ("./files/" ++ unpack mFile) 
