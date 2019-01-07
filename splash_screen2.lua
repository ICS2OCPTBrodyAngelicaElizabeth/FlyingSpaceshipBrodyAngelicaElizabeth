-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Elizabeth
-- Date: November 12th, 2018
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen2"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- Sounds
-----------------------------------------------------------------------------------------
local backgroundSound = audio.loadSound("Sounds/clearday.mp3")
local backgroundSoundChannel

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local scrollSpeedBanana = 3
local gameTitleSpeed = 4
local backgroundImage
local gameTitle
local banana


--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

--Function: MoveBanana
--Input: this function accepts an event listener
--Output: none
--Description: This function adds the scroll speed to the x-value of the banana
local function MoveBanana()
    --add the scroll speed to the x-value of the banana
    banana.x = banana.x + scrollSpeedBanana
    banana.y = banana.y + scrollSpeedBanana
    --banana.y = banana.y - scrollSpeedBanana

    --change the transparency of the banana every time it so fast that it fades out
    banana.alpha = banana.alpha - 0.000000001
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

local function HideTitle()
    gameTitle.isVisible = false
    MoveBanana()
end

local function MoveTitle()
    --add the scroll speed to the x-value of the ship
    gameTitle.x = gameTitle.x + gameTitleSpeed

    --change the transparency of the ship every time it so fast that it fades out
    gameTitle.alpha = gameTitle.alpha - 0.00001
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event ) 

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view






    -- set the background to be black
    backgroundImage = display.newImageRect("Images/background.png", 2048, 1536)

    -- Insert the beetleship image
    banana = display.newImageRect("Images/CompanyLogoElizabeth@2x copy.png", 200, 200)

    -- set the initial x and y position of the banana
    banana.x = 200
    banana.y = 200

    --set the image to be transparent
    banana.alpha = 1

    --display the game title
    gameTitle = display.newText("The Jojo's", 0, 300, native.systemFontBold, 70)
    gameTitle:setTextColor(102/255, 234/255, 255/255)
    gameTitle.isVisible = true
    

    -- set the initial x and y position of the beetleship
    gameTitle.x = 0
    gameTitle.y = 300
    
    --set the image to be transparent
    gameTitle.alpha = 1

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( backgroundImage )
    sceneGroup:insert( banana )
    sceneGroup:insert( gameTitle )

end --function scene:create( event )
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
        -- start the splash screen music
        backgroundSoundChannel = audio.play(backgroundSound)

        -- Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", MoveBanana)
        Runtime:addEventListener("enterFrame", MoveTitle)

        timer.performWithDelay(2000, HideTitle)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
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
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(backgroundSoundChannel)
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
