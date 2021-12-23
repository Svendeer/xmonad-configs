import XMonad
import Data.Monoid
import System.Exit
import System.IO

import XMonad.Hooks.DynamicLog --Los PP's
import XMonad.Util.Run--Para el autostart de xmobar
import XMonad.Util.SpawnOnce --Para el autostart de aplicaciones
import XMonad.Hooks.ManageDocks --Para que se vea la barra
import XMonad.Hooks.SetWMName
import XMonad.Util.NamedScratchpad
import XMonad.Util.EZConfig(additionalKeysP)

import XMonad.Prompt
import XMonad.Prompt.Shell --Para los scripts externos

--Layouts
import XMonad.Layout.GridVariants
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spiral
import XMonad.Layout.IndependentScreens

--Modificadores
import XMonad.Layout.Spacing --gaps
import XMonad.Layout.ResizableTile 
import XMonad.Layout.NoBorders
import XMonad.Layout.Magnifier
import XMonad.Layout.Circle
import XMonad.Layout.Tabbed

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Maybe

import XMonad.Actions.RotSlaves
import XMonad.Actions.GridSelect
import XMonad.Actions.TagWindows
import XMonad.Actions.WindowBringer (bringWindow)
import XMonad.Actions.WorkspaceNames

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal :: String
myTerminal = "xterm"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth :: Dimension
myBorderWidth = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask :: KeyMask
myModMask = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset
--
myWorkspaces    = ["\xf120","\xf2c6","\xf282","\xf121","\xf07c","\xf03d","\xf1c1","\xf03e","\xf074"]
--1. terminal
--2. Telegram
--3. Edge
--4. Code
--5. File manager
--6. Video
--7. PDF
--8. Wallpaper
--9. Other

myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

toggleFloat w = windows (\s -> if M.member w (W.floating s)
                            then W.sink w s
                            else (W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s))

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#8be9fd"
myFocusedBorderColor = "#ff79c6"

-- gsconfig1 = defaultGSConfig { gs_cellheight = 30, gs_cellwidth = 100 }
-- gsconfig2 colorizer = (buildDefaultGSConfig colorizer) { gs_cellheight = 30, gs_cellwidth = 100 }

-- gsconfig1 = defaultGSConfig { gs_cellheight = 30, gs_cellwidth = 100 }

colorSelected :: String
colorSelected = "FB7578"

colorNotSelected :: String
colorNotSelected = "545D7B"

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where
    conf = def { gs_navigate = navNSearch
               , gs_cellheight = 35
               , gs_cellwidth = 135
               , gs_cellpadding = 30
               , gs_rearranger = searchStringRearrangerGenerator id
               }    

-- spawnSelected'' lst = gridselect conf lst >>= flip whenJust spawn

-- Programas del grid select.
myGSConfig = [("Dolphin", "dolphin")
                        , ("Opera", "opera")
                        , ("GIMP", "gimp")
                        , ("WhatsApp", "whatsapp-nativefier")
                        , ("KDE Connect", "kdeconnect-app")
                        , ("GColor", "gcolor2")
                        , ("Yt Music", "youtube-music")
                        , ("Virtualbox", "virtualbox")
                        , ("Pavucontrol", "pavucontrol")
                        , ("Lollypop", "lollypop")
                        , ("Htop", "st -e htop")
                        , ("Cmus", "st -e cmus")
                        , ("Tmux", "st -e tmux -u")
                        , ("SR Recorder", "simplescreenrecorder")
                        , ("Firefox", "firefox")
                        , ("Stremio", "stremio")
                        , ("Spectacle", "spectacle")
                        , ("Genymotion", "genymotion")
                        , ("Google Earth", "google-earth-pro")
                        , ("Deluge", "deluge")
                        , ("Leafpad", "leafpad")
                        , ("Nitrogen", "nitrogen")
                        , ("LXAppearance", "lxappearance")
                        , ("Geogebra", "geogebra")
                        , ("Onlyoffice", "onlyoffice-desktopeditors")]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--

xmonadRestart :: String
xmonadRestart = "xmonad --recompile; xmonad --restart"

myFileManager :: String
myFileManager = "pcmanfm"

telegram :: String
telegram = "telegram-desktop"

mega :: String
mega = "megasync"

scrotFull :: String
scrotFull = "scrot -q 100 '%Y-%m-%d-%H-%M-%s_$wx$h.png' -e 'mv $f ~/Pictures/Screenshots'; dunstify 'Captura de pantalla guardada.' -i ~/.xmonad/screenshot-icon.png"

scrotSelect :: String
scrotSelect  ="scrot -s '%Y-%m-%d-%H-%M-%s_$wx$h.png' -e 'mv $f /home/svendeer/Pictures/Screenshots/'; dunstify 'Captura de pantalla guardada.'  -i ~/.xmonad/screenshot-icon.png"

rofi :: String
rofi = "rofi -show run -config /home/svendeer/.config/rofi/config.rasi"

flameshot :: String
flameshot = "flameshot gui"

atrilPDF :: String
atrilPDF = "atril"

edge :: String
edge = "com.microsoft.Edge"

kdevelop :: String
kdevelop = "kdevelop"

torBrowser :: String
torBrowser = "tor-browser"

picom :: String
picom = "picom"

killPicom :: String
killPicom = "killall picom"

vscode :: String
vscode = "code"

sublimeText :: String
sublimeText = "subl"

volumeUp :: String
volumeUp = "pactl set-sink-volume @DEFAULT_SINK@ +1%"

volumeDown :: String
volumeDown = "pactl set-sink-volume @DEFAULT_SINK@ -1%"

volumeMute :: String
volumeMute = "pactl set-sink-mute @DEFAULT_SINK@ toggle"

brightnessUp :: String
brightnessUp = "light -A 1"

brightnessDown :: String
brightnessDown = "light -U 1"

cmusPrev :: String
cmusPrev = "cmus-remote --prev"

cmusNext :: String
cmusNext = "cmus-remote --next"

cmusPlayPause :: String
cmusPlayPause = "cmus-remote --pause"

cmusStop :: String
cmusStop = "cmus-remote --stop"

cmusRepeat :: String
cmusRepeat = "cmus-remote --repeat"

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ 
        ((modm,               xK_Return), spawn $ XMonad.terminal conf) -- launch terminal
    ,   ((modm,               xK_x     ), kill) -- close focused window
    ,   ((modm,               xK_space ), sendMessage NextLayout) -- Rotate through the available layout algorithms
    ,   ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) --  Reset the layouts on the current workspace to default
    ,   ((modm,               xK_n     ), refresh) -- Resize viewed windows to the correct size
    ,   ((modm,               xK_Tab   ), windows W.focusDown) -- Move focus to the next window
    ,   ((modm,               xK_j     ), windows W.focusDown) -- Move focus to the next window
    ,   ((modm,               xK_k     ), windows W.focusUp  ) -- Move focus to the previous window
    ,   ((modm,               xK_m     ), windows W.focusMaster  ) -- Move focus to the master window
    ,   ((modm .|. shiftMask, xK_Return), windows W.swapMaster) -- Swap the focused window and the master window
    ,   ((modm .|. shiftMask, xK_j     ), windows W.swapDown  ) -- Swap the focused window with the next window
    ,   ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )  -- Swap the focused window with the previous window
    ,   ((modm,               xK_h     ), sendMessage Shrink) -- Shrink the master area
    ,   ((modm,               xK_l     ), sendMessage Expand) -- Expand the master area
    ,   ((modm,               xK_t     ), withFocused $ windows . W.sink) -- Push window back into tiling
    ,   ((modm              , xK_comma ), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
    ,   ((modm              , xK_period), sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area
    ,   ((modm .|. shiftMask, xK_r      ), renameWorkspace def) 
    -- Increase/decrease spacing (gaps)
    , ((modm .|. controlMask, xK_r), decWindowSpacing 4)         -- Decrease window spacing
    , ((modm .|. controlMask, xK_d), incWindowSpacing 4)         -- Increase window spacing
    , ((modm .|. controlMask, xK_u), decScreenSpacing 4)         -- Decrease screen spacing
    , ((modm .|. controlMask, xK_i), incScreenSpacing 4)         -- Increase screen spacing


    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- Quit xmonad
    , ((modm              , xK_q     ), spawn (xmonadRestart)) -- Restart xmonad
    --More useful tiled layout that allows you to change a width/height of window.
    , ((modm,               xK_a), sendMessage MirrorShrink)
    , ((modm,               xK_z), sendMessage MirrorExpand)
    , ((modm .|. shiftMask, xK_Tab   ), rotSlavesUp)
    , ((modm,               xK_p     ), spawn (rofi)) -- launch rofi
    --
    --Custom keys begin
    --

    --mod shift mask
    , ((modm .|. shiftMask, xK_p     ), spawn (myFileManager)) -- launch file manager
    , ((modm .|. shiftMask, xK_t ), safeSpawn (telegram) []) --telegram desktop
    , ((modm .|. shiftMask, xK_m ), safeSpawn (mega) []) --megasync
    , ((modm .|. shiftMask, xK_c ), spawn (scrotFull)) --take a screenshot
    , ((modm .|. shiftMask, xK_f ), spawn (scrotSelect)) --select area to take screenshot
--    , ((modm .|. controlMask, xK_f ), spawn (flameshot)) --select area to take screenshot
    , ((modm .|. shiftMask, xK_a ), safeSpawn (atrilPDF) []) --atril pdf reader

    --mod controlmask
    , ((modm .|. controlMask, xK_e ), safeSpawn (edge) [])
    , ((modm .|. controlMask, xK_t ), safeSpawn (torBrowser) [])
    , ((modm .|. controlMask, xK_p ), safeSpawn (picom) [])
    , ((modm .|. controlMask, xK_l ), spawn (killPicom))
    , ((modm .|. controlMask, xK_c ), safeSpawn (vscode) [])
    , ((modm .|. controlMask, xK_s ), safeSpawn (sublimeText) []) --sublime text
    , ((modm .|. controlMask, xK_Return), safeSpawn "st" [])

    --Brightness. Use cat /usr/include/X11/XF86keysym.h | rg Audio to get this codes
    , ((0            , 0x1008ff13), spawn (volumeUp)) --up 1%
    , ((0            , 0x1008ff11), spawn (volumeDown)) --down 1%
    , ((0            , 0x1008ff12), spawn (volumeMute)) --mute

    --Brightness. Use cat //usr/include/X11/XF86keysym.h | rg Brightness to get this codes
    , ((0            , 0x1008FF02), spawn (brightnessUp)) --up 1%
    , ((0            , 0x1008FF03), spawn (brightnessDown)) --down 1%
    , ((modm .|. controlMask              , xK_plus ), sendMessage MagnifyMore)
    , ((modm .|. controlMask              , xK_minus), sendMessage MagnifyLess)
    , ((modm .|. controlMask              , xK_o    ), sendMessage ToggleOff  )
    , ((modm .|. controlMask .|. shiftMask, xK_o    ), sendMessage ToggleOn   )
    , ((modm .|. controlMask              , xK_m    ), sendMessage Toggle     )
    , ((modm, xK_g), goToSelected defaultGSConfig)
    , ((modm, xK_s), spawnSelected' (myGSConfig))
    -- somewhere inside additionalKeysP style keybinding definition
    , ((modm .|. controlMask, xK_b), withFocused toggleFloat) --make a window floating

    --cmus commands
    , ((0            , 0x1008FF16), spawn (cmusPrev)) --cmus previous song
    , ((0            , 0x1008FF17), spawn (cmusNext)) --cmus next song
    , ((0            , 0x1008FF14), spawn (cmusPlayPause)) --cmus pause current song
    , ((0            , 0x1008FF15), spawn (cmusStop)) --cmus stop current song
    , ((modm .|. controlMask .|. shiftMask, xK_r), spawn (cmusRepeat)) --cmus repeat current song

    ]
    ++
    --Custom keys end
    --

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --

    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster)) -- mod-button2, Raise the window to the top of the stack

    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w -- mod-button3, Set the window to floating mode and resize by dragging
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

myTabConfig = def { inactiveBorderColor = "#4F5275"
                  , activeTextColor = "#4F5275"}

myLayoutHook = avoidStruts $ spacingRaw True (Border 5 5 5 5) True (Border 3 3 3 3) True $ tiled
 ||| ResizableTall 5 (3/100) (1/2) []  
 ||| Grid (8/10)
 ||| ThreeCol 5 (3/100) (1/2) 
 ||| ThreeColMid 5 (3/100) (1/2)
 ||| Circle
 ||| tabbed shrinkText myTabConfig 
  where

    -- default tiling algorithm partitions the screen into two panes
    tiled  = spacing 5 $ ResizableTall nmaster delta ratio []

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"            --> doFloat
    , className =? "Gimp"               --> doFloat
    , className =? "Telegram Desktop"   --> doFloat
    , resource  =? "desktop_window"     --> doIgnore
    , resource  =? "kdesktop"           --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "/home/svendeer/arandr-dual-monitor.sh &"
    spawnOnce "/home/svendeer/.xmonad/NotifyCaps.sh &"
--    spawnOnce "setxkbmap dvorak es &"
    -- spawnOnce "/home/svendeer/.xmonad/runTrayer.sh &"
    spawnOnce "xsetroot -cursor_name left_ptr &"
    setWMName "haskellWM"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    xmproc0 <- spawnPipe "xmobar -x 0 /home/svendeer/.config/xmobar/xmobarrc0"
    xmproc1 <- spawnPipe "xmobar -x 1 /home/svendeer/.config/xmobar/xmobarrc1"
    -- xmproc2 <- spawnPipe "xmobar -x 2 /home/svendeer/.config/xmobar/xmobarrc2cmus"
    h <- spawnPipe "xmobar -d"
    xmonad $ docks $def {
                terminal           = myTerminal,
                focusFollowsMouse  = myFocusFollowsMouse,
                clickJustFocuses   = myClickJustFocuses,
                borderWidth        = myBorderWidth,
                modMask            = myModMask,
                workspaces         = myWorkspaces,
                normalBorderColor  = myNormalBorderColor,
                focusedBorderColor = myFocusedBorderColor,
        
              -- key bindings
                keys               = myKeys,
                mouseBindings      = myMouseBindings,
        
              -- hooks, layouts
                layoutHook         = myLayoutHook,
                manageHook         = myManageHook,
                handleEventHook    = myEventHook,
                logHook            = dynamicLogWithPP $ namedScratchpadFilterOutWorkspacePP $ xmobarPP 
                    { ppOutput = \x -> hPutStrLn xmproc0 x                          -- xmobar on monitor 1
                                >> hPutStrLn xmproc1 x 
                                -- >> hPutStrLn xmproc2 x 
                    , ppCurrent = xmobarColor "#50fa7b,#282a36" "" . wrap " " " " . clickable          -- Current workspace
                    , ppVisible = xmobarColor "#8be9fd,#282a36" "" . wrap " " " " . clickable           -- Visible but not current workspace
                    , ppHidden  = xmobarColor "#8be9fd,#282a36" "" . wrap " " " " . clickable           -- Hidden workspaces
                    -- , ppHiddenNoWindows = xmobarColor "#e5e9f0,#BE616B" "" . wrap " " " " . clickable   -- Hidden workspaces (no windows)
                    -- , ppTitle = xmobarColor "#e5e9f0,#2E3440" "" . wrap " " " " . shorten 100  -- Title of active window
                    -- ppSep =  "<fc=#323C4B> <fn=1>|</fn> </fc>"                   -- Separator character
                    -- , ppUrgent = xmobarColor "#000000,#BF616A" "" . wrap "!" "!" . clickable           -- Urgent workspace
                    -- ppExtras  = [windowCount]                                    -- # of windows current workspace
                    , ppOrder  = \(ws:l:t:ex) -> [ws]
                    , ppWsSep = ""
                    , ppSep = ""
                    },
                startupHook        = myStartupHook
            }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--

help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
