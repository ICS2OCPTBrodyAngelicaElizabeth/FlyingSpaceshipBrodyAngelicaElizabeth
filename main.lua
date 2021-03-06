-----------------------------------------------------------------------------------------
--
-- main.lua
-- Created by: Brody, Angelica, Elizabeth
-- Date: Month Day, Year
-- Description: This calls the splash screen of the app to load itself.
-----------------------------------------------------------------------------------------

-- Hiding Status Bar
display.setStatusBar(display.HiddenStatusBar)

-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )


-----------------------------------------------------------------------------------------

-- Go to the intro screen (splash_screen2
composer.gotoScene( "splash_screen" )