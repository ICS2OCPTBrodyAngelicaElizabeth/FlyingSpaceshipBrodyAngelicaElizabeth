-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 display.setStatusBar(display.HiddenStatusBar)

-- The local variables for this scene
local banana
local Jojo
local scrollSpeed = 6
local stop = 0
local bkg 

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the beetleship across the screen
local function StopBanana()
    -- Styops the banana from moving
    scrollSpeed = stop
end

-- This function moves the banana displayed
local function MoveBanana( event )

    -- Add the scroll speed to the banana so it moves vertically
    banana.y = banana.y - scrollSpeed
    -- Calls function StopBanana
    timer.performWithDelay ( 1400, StopBanana )
end

-- This function fades the company logo from being trasparent to being opaque
local function FadeInName()

    -- Changes the alpha
    Jojo.alpha = Jojo.alpha + 00.02
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    bkg_image = display.newImage("Images/CompanyBackground.AngelicaCopy.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()


    -- Insert the banana image
    banana = display.newImageRect("Images/CompanyLogoAngelica.png",  display.contentWidth/5, display.contentHeight/5 + display.contentHeight/14)
    -- Inserts the image of the App name
    Jojo = display.newImageRect("Images/CompanyLogoTextAngelicaCopy@2x.png",display.contentWidth*11/13,display.contentHeight/4+display.contentHeight/20)

    -- set the initial x and y position of the banana
    banana.x = display.contentWidth *2/4
    banana.y = display.contentHeight *3/4

    -- Sets the heighht and width of the company name
    local JojoWidth = Jojo.width
    local JojoHeight = Jojo.height
    -- x and y values of the Company name
    Jojo.x = display.contentWidth/2
    Jojo.y = display.contentHeight*3/4
    -- sets the transparency
    Jojo.alpha = 0

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( banana )
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
        timer.performWithDelay ( 2300, gotoMainMenu)          
        
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
