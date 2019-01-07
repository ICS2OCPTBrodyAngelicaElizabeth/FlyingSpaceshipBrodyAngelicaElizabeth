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

-- Go to the intro screen
composer.gotoScene( "splash_screen" )

		if (randomNumber1 < randomNumber2) then
	 		temp = randomNumber1
	 		randomNumber1 = randomNumber2
	 		randomNumber2 = temp
	 		correctAnswer = randomNumber1 - randomNumber2
	 	end