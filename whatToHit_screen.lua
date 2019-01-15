-----------------------------------------------------------------------------------------
--
-- main.lua
-- Created by: Brody
-- Date: Month Day, Year
-- Description: This screen tells you witch coment to hit
-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------
-- Name the Scene
sceneName = "whatToHit_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )


local function Level1Transition( )
    composer.gotoScene( "level1_screen", {effect = "slideRight", time = 1000})
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Inserts the background image
    bkg_image = display.newImageRect("Images/Level1Screen (2).png", display.contentWidth, display.contentHeight)
    -- Assignes the background x and y coordinates
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    -- Assignes the background height and width
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight
    -- Inserts background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )
    
    avoidText = display.newText("Avoid the red comets", display.contentWidth*9/10, display.contentHeight*9/10, nil, 50 )
    sceneGroup:insert(avoidText)

    hitText = display.newText("Hit the purple comets", display.contentWidth*9/10, display.contentHeight*9/10, nil, 50 )
    sceneGroup:insert(hitText)

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

    timer.performWithDelay ( 3000, Level1Transition)
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        
    end
end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )
    audio.stop (level1SoundChannel)

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
      

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

      
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



-- Adds Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
