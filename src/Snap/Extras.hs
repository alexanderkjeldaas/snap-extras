{-# LANGUAGE OverloadedStrings #-}

module Snap.Extras
    ( module Snap.Extras.CoreUtils
    , module Snap.Extras.TextUtils
    , module Snap.Extras.JSON
    , module Snap.Extras.FlashNotice
    , module Snap.Extras.FormUtils
    , module Snap.Extras.Tabs
    , initExtras
    ) where

-------------------------------------------------------------------------------
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import           Snap.Snaplet.Session
import           System.FilePath.Posix
-------------------------------------------------------------------------------
import           Snap.Extras.CoreUtils
import           Snap.Extras.FlashNotice
import           Snap.Extras.FormUtils
import           Snap.Extras.JSON
import qualified Snap.Extras.SpliceUtils.Interpreted as I
import           Snap.Extras.Tabs
import           Snap.Extras.TextUtils
-------------------------------------------------------------------------------
import Paths_snap_extras
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- | Initialize all the 'Snap.Extras' functionality in your Snap app.
-- Currently, we don't need to keep any state and simply return ().
initExtras :: HasHeist b
           => Snaplet (Heist b)
           -> SnapletLens b SessionManager
           -> SnapletInit b ()
initExtras heistSnaplet session = 
  makeSnaplet 
    "Snap Extras" 
    "Collection of utilities for web applications" 
    (Just getDataDir) $ do
      addTemplatesAt heistSnaplet "" . (</> "resources/templates") =<< getSnapletFilePath
      initFlashNotice session
      I.addUtilSplices
      initTabs
