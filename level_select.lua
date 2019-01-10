-----------------------------------------------------------------------------------------
--
-- level select
-- Created by: Brody
-- Date: January 9, 2019
-- Description: Chosis the level you want
-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-- Use Widget Library
local widget = require( "widget" )

-- Name the Scene
sceneName = "level_select"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------

local level1Button
local level2Button
local level3Button

local bkg

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "zoomInOutFade", time = 900})
end    

-----------------------------------------------------------------------------------------

-- Creating Transition to Level2 Screen
local function Level2ScreenTransition( )
    composer.gotoScene( "level2_screen", {effect = "zoomOutInFade", time = 900})
end    

-----------------------------------------------------------------------------------------

-- Creating Transition to Level2 Screen
local function Level3ScreenTransition( )
    composer.gotoScene( "level3_screen", {effect = "zoomOutInFade", time = 900})
end    

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
	

	-----------------------------------------------------------------------------------------
    -- BUTTONS WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    level1Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/4,
            y = display.contentHeight/2,
            width = display.contentWidth/5,
            height = display.contentHeight/4,

            -- Insert the images here
            defaultFile = "Images/Level1ButtonPressed@2x.png",
            overFile = "Images/Level1ButtonUnpressed@2x.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    level2Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight/2,
            width = display.contentWidth/5,
            height = display.contentHeight/4,


            -- Insert the images here
            defaultFile = "Images/Level2ButtonPressed@2x.png",
            overFile = "Images/Level2ButtonUnpressed@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = Level2ScreenTransition 
        } ) 
    
    -- ADD INSTRUCTIONS BUTTON WIDGET

    -----------------------------------------------------------------------------------------

 -- Creating Credits Button
    level3Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*3/4,
            y = display.contentHeight/2,
            width = display.contentWidth/5,
            height = display.contentHeight/4,


            -- Insert the images here
            defaultFile = "Images/Level3ButtonPressed@2x.png",
            overFile = "Images/Level3ButtonUnpressed@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = Level3ScreenTransition
        } ) 
    

    ---------------
    -- BACKGROUND
    ---------------
    -- Assigns an image to "bkg_image"
    bkg_image = display.newImage("Images/LevelSelectScreenBrody@2x.png")
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

    -- Associating button widgets with this scene
    sceneGroup:insert( level1Button )
    sceneGroup:insert( level2Button )
    sceneGroup:insert( level3Button )


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
