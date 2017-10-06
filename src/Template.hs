{-# LANGUAGE OverloadedStrings #-}

module Template where

import Data.Text (Text)
import Happstack.Lite
import Text.Blaze.Html5 (Html, (!), toHtml)
import qualified Text.Blaze.Html5 as H
    

-- Template for every webpage
template :: Text -> Html -> Response
template title body = toResponse $
  H.html $ do
    H.head $ do
      H.title (toHtml title)
    H.body $ do
      body