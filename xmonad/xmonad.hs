-- -*- haskell -*-
import Control.Monad (liftM)
import XMonad
import XMonad.Core
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Layout.Tabbed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Grid
import XMonad.Layout.Magnifier
import XMonad.Layout.TabBarDecoration
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog hiding (shorten)
import XMonad.Actions.CycleWS
import XMonad.Hooks.ManageDocks
import XMonad.Actions.DwmPromote
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName
import XMonad.Util.Run (spawnPipe)
import System.IO 
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.WorkspaceCompare
import XMonad.Util.EZConfig
import XMonad.Actions.Warp
import Data.Ratio
 
myTerminal      = "terminator"
myScreenLock    = "/usr/bin/gnome-screensaver-command -l"
myBorderWidth   = 1
myModMask       = mod4Mask
myNumlockMask   = mod2Mask
myWorkspaces    = ["α", "β" ,"γ", "δ", "ε", "ζ", "η", "θ", "ι"] 
myNormalBorderColor  = "#111"
myFocusedBorderColor = "cadetblue3"
 
isVisible :: X (WindowSpace -> Bool)
isVisible = do
  vs <- gets (map (W.tag . W.workspace) . W.visible . windowset)
  return (\w -> (W.tag w) `elem` vs)
 
-- Config for Prompt
oxyXPConfig :: XPConfig
oxyXPConfig = defaultXPConfig { font              = "xft:Consolas-12"
                              , bgColor           = "#3F3F3F"
                              , fgColor           = "Aquamarine3"
                              , fgHLight          = "black"
                              , bgHLight          = "#333333"
                              , borderColor       = "black"
                              , promptBorderWidth = 1
                              , position          = Top
                              , height            = 16
                              , defaultText       = []
                              }
 
myLayout = avoidStrutsOn[U] $ tiled
           ||| tabs
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = ResizableTall nmaster delta ratio []
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 8 % 13
     -- Percent of screen to increment by when resizing panes
     delta   = 3 % 100
     -- tabbed layout
     tabs = tabbed shrinkText oxyDarkTheme
     -- magnification in grid
     magnify = magnifiercz (13%10)
 
-- Configuration for Tabbed
oxyTheme :: Theme
oxyTheme = defaultTheme { inactiveBorderColor = "#000"
                        , activeBorderColor = myFocusedBorderColor
                        , activeColor = "aquamarine3"
                        , inactiveColor = "DarkSlateGray4"
                        , inactiveTextColor = "#222"
                        , activeTextColor = "#222"
                        , fontName = "xft:Consolas-10:bold"
                        , decoHeight = 18
                        , urgentColor = "#000"
                        , urgentTextColor = "#63b8ff"
                        }
 
oxyDarkTheme :: Theme
oxyDarkTheme = defaultTheme { inactiveBorderColor = "#777"
                            , activeBorderColor = myFocusedBorderColor
                            , activeColor = "#000"
                            , inactiveColor = "#444"
                            , inactiveTextColor = "aquamarine4"
                            , activeTextColor = "aquamarine1"
                            , fontName = "xft:Dejavu Sans Mono-8"
                            , decoHeight = 15 
                            , urgentColor = "#000"
                            , urgentTextColor = "#63b8ff"
                        }
 
myManageHook = composeAll
 [ resource  =? "desktop_window"    --> doIgnore
 , className =? "ClockScreenlet.py" --> doIgnore
 , className =? "Deluge"            --> doF (W.shift "9")
 , title     =? "roottail"          --> doIgnore ]
    <+> manageDocks

-- Status bars and logging
myLogHook h = do
  dynamicLogWithPP $ oxyPP h 
  updatePointer (Relative (1/20) (1/20))
 
oxyPP :: Handle -> PP
oxyPP h = defaultPP  { ppCurrent = wrap "<fc=#333333,aquamarine3> " " </fc>" 
                     , ppSep     = ""
                     , ppWsSep = ""
                     , ppVisible = wrap "<fc=#333333,DarkSlateGray4> " " </fc>" 
                     , ppLayout = \x -> "<fc=aquamarine2,#3F3F3F>:: "
                                  ++ case x of
                                       "Mirror ResizableTall"   -> "MTiled"
                                       "ResizableTall"          -> "Tiled"
                                       "Tabbed Bottom Simplest" -> "Tabbed"
                                       "Tabbed Simplest"        -> "Tabbed"
                                       _                        -> x
                                  ++ "</fc> "
                     , ppTitle = \x -> case length x of
                                         0 -> ""
                                         _ -> "<fc=DarkSlateGray3,#3F3F3F>[" ++ shorten 33 x ++ "]</fc>"
                     , ppHiddenNoWindows = wrap "<fc=#aaa,#3F3F3F> " " </fc>"
                     , ppHidden = wrap "<fc=#aaa,#3F3F3F> " " </fc>"
                     , ppOutput = hPutStrLn h
                     }
 
shorten :: Int -> String -> String
shorten n xs | length xs < n = xs
             | otherwise     = (take (n - length end) xs) ++ end
 where
    end = "…"
 
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False
 
myKeys = \conf -> mkKeymap conf $
			[ ("M-S-<Return>", spawn $ XMonad.terminal conf)
			, ("C-S-<Esc>",    spawn $ myScreenLock)
			, ("M-C-<Esc>",    spawn $ "xkill")
			, ("M-<Space>",    sendMessage NextLayout)
			, ("M-S-<Space>",  setLayout $ XMonad.layoutHook conf)
			, ("M-r",          refresh)
			, ("M-S-c",        kill)
			, ("M-n",          windows W.focusDown)
			, ("M-e",          windows W.focusUp)
			, ("M-m",          windows W.focusMaster)
			, ("M-S-k",        windows W.swapDown)
			, ("M-S-j",        windows W.swapUp)
			, ("M-b",          sendMessage ToggleStruts)
			, ("M-h",          sendMessage Shrink)
			, ("M-l",          sendMessage Expand)
			, ("M-t",          withFocused $ windows . W.sink)
			, ("M-,",          sendMessage (IncMasterN 1))
			, ("M-.",          sendMessage (IncMasterN (-1)))
			, ("M-S-q",        io (exitWith ExitSuccess))
			, ("M-q",          restart "xmonad" True)
			, ("M-p",          shellPrompt oxyXPConfig)
			, ("M-S-<Right>",  shiftToNext >> nextWS)
			, ("M-S-<Left>",   shiftToPrev >> prevWS) 
			, ("M-<Down>",     nextScreen)
			, ("M-S-<Down>",   shiftNextScreen >> nextScreen)
			, ("M-<Left>",     prevNonEmptyWS )
			, ("M-C-k",        prevNonEmptyWS )
			, ("M-<Right>",    nextNonEmptyWS )
			, ("M-C-j",        nextNonEmptyWS )
			, ("M-s",          swapNextScreen)
			, ("M-<Up>",       swapNextScreen)
			, ("M-a",          sendMessage MirrorShrink)
			, ("M-y",          sendMessage MirrorExpand)
			, ("M-<Return>",   dwmpromote)
			, ("M-x M-c",      kill)
			, ("M-x c",        kill)
			, ("M-o",          nextScreen)
			, ("M-u M-x M-x",  swapNextScreen)
			, ("M-x e",        spawn "emacsclient -c -s emacs")
			, ("M-x s",        spawn "swiftfox")
			, ("M-x t",        spawn "tvbrowser")
			, ("M-x d",        spawn "deluge")
			, ("M-x <Return>", spawn $ XMonad.terminal conf)
			, ("M-i",          sendMessage MagnifyMore)
			, ("M-a",          sendMessage MagnifyLess)
			, ("M-<",          warpToWindow (1%10) (1%10)) -- Move pointer to currently focused window
			]
			++
			[ (m ++ i, windows $ f j) 
			    | (i, j) <- zip (map show [1..9]) (XMonad.workspaces conf)
			    , (m, f) <- [("M-", W.view), ("M-S-", W.shift)]
			]
	where 
		nextNonEmptyWS = moveTo Next (WSIs (liftM (not .) isVisible))
		prevNonEmptyWS = moveTo Prev (WSIs (liftM (not .) isVisible))

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
  pipe <- spawnPipe "xmobar"
  xmonad $ withUrgencyHook NoUrgencyHook $ defaults pipe
 
defaults pipe = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
      -- key bindings
        keys		   = myKeys,
      -- hooks, layouts
        startupHook        = setWMName "LG3D",
        layoutHook         = smartBorders (myLayout),
        manageHook         = myManageHook,
        logHook            = myLogHook pipe
    } 
