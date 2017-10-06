{-# LANGUAGE OverloadedStrings #-}

module Upload where

import Happstack.Lite
import Text.Blaze.Html5 (Html, (!), form, input, p, toHtml)
import Text.Blaze.Html5.Attributes (action, enctype, name, size, type_, value)
import qualified Text.Blaze.Html5.Attributes as A
import System.Directory (renameFile)

import Template


upload :: ServerPart Response 
upload = 
       msum [ uploadForm 
            , handleUpload 
            ] 
    where 
    -- Form to upload one file
    uploadForm :: ServerPart Response 
    uploadForm = 
        do method GET 
           ok $ template "upload form" $ do 
             form ! enctype "multipart/form-data" ! A.method "POST" ! action "/upload" $ do 
               input ! type_ "file" ! name "file_upload" ! size "40" 
               input ! type_ "submit" ! value "upload" 
 
    -- Perform the upload for a file
    handleUpload :: ServerPart Response 
    handleUpload = 
        do (tmpFile, uploadName, contentType) <- lookFile "file_upload" 
           ok $ template "file uploaded" $ do 
                p (toHtml $ "temporary file: " ++ tmpFile) 
                p (toHtml $ "uploaded name:  " ++ uploadName) 
                p (toHtml $ "content-type:   " ++ show contentType) 