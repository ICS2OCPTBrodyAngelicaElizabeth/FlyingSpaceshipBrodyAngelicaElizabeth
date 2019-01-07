-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Angelica Lutkiewicz
-- Date: December 11, 2018
-- Description: This is one of the possible splash screens for the game.
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

----------
-- SOUND
----------
local SplashScreenSound = audio.loadSound("Sounds/DoorBellSound.mp3") 
local SplashScreenSoundChannel

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- Hides the status bar
display.setStatusBar(display.HiddenStatusBar)

-- The local variables for this scene
-- BANANA
local banana
-- TEXT IMAGE
local Jojo
-- SCROLL SPEEDS
local scrollSpeed = 6
local stop = 0
-- BACKGROUND IMAGE
local bkg 

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the beetleship across the screen
local function StopBanana()
    -- Stops the banana from moving by setting the scroll speed to "stop"(0)
    scrollSpeed = stop
end

-- This function moves the banana displayed
local function MoveBanana( event )

    -- Add the scroll speed to the banana so it moves up vertically
    banana.y = banana.y - scrollSpeed
    -- Calls function StopBanana after 1400 miliseconds
    timer.performWithDelay ( 1400, StopBanana )
end

-- This function fades the company logo from being trasparent to being opaque
local function FadeInName()

    -- Changes the alpha (transparency)
    Jojo.alpha = Jojo.alpha + 00.02
end

-- The function that will transition to the main menu screen (temporarily to splash_screen2) 
local function gotoMainMenu()
    -- Transitions to the main_menu screen (splash_screen2)
    composer.gotoScene( "main_menu" )
end

-- This function dictates when the audio sound effect plays
local function playAudio()
    -- Creates the audio sound channel for "SplashScreenSound"
    SplashScreenSoundChannel = audio.play(SplashScreenSound) 
    -- Calls function "gotpoMainMenu" after 800 miliseconds
    timer.performWithDelay(800,gotoMainMenu)
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    ---------------
    -- BACKGROUND
    ---------------
    -- Assigns an image to "bkg_image"
    bkg_image = display.newImage("Images/CompanyBackground.AngelicaCopy.png")
    -- Sets the x and y coordinates for "bkg_image"
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    -- Sets the width and height for "bkg_image"
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight
    -- Sends the background image to the back layer so all other objects can be on top
    bkg_image:toBack()
    -- Inserts object into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )

    -----------
    -- BANANA
    -----------
    -- Assigns an image/png to "banana"
    banana = display.newImageRect("Images/CompanyLogoAngelica.png",  display.contentWidth/5, display.contentHeight/5 + display.contentHeight/14)
    -- Sets x and y coordinates for "banana"
    banana.x = display.contentWidth *2/4
    banana.y = display.contentHeight *3/4
    -- Inserts object into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( banana )

    ---------------
    -- TEXT IMAGE
    ---------------
    -- Assigns image/png to "Jojo"
    Jojo = display.newImageRect("Images/CompanyLogoTextAngelicaCopy@2x.png",display.contentWidth*11/13,display.contentHeight/4+display.contentHeight/20)
    -- Sets the height and width of "Jojo"
    local JojoWidth = Jojo.width
    local JojoHeight = Jojo.height
    -- Sets x and y coordinates for "Jojo"
    Jojo.x = display.contentWidth/2
    Jojo.y = display.contentHeight*3/4
    -- Makes the image transparent
    Jojo.alpha = 0
    -- Inserts object into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( Jojo )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", MoveBanana)
        Runtime:addEventListener("enterFrame", FadeInName)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 1500, playAudio)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    
    -- Stops sound effect
    audio.stop (SplashScreenSoundChannel)

    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        

    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
