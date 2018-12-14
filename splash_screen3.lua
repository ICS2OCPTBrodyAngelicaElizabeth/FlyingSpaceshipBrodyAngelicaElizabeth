--------------------------------------------------------------------------------------------
-- splash screen
-- Made by: Brody Lawson
-- Course: ICS2O

-- hide status bar
display.setStatusBar(display.HiddenStatusBar)

local banana
local Jojo
local scrollSpeed = 6
local stop = 0

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
    timer.performWithDelay ( 1800, StopBanana )
end

-- This function fades the company logo from being trasparent to being opaque
local function FadeInName()

    -- Changes the alpha
    Jojo.alpha = Jojo.alpha + 00.5
end

local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end


-- set the background
display.setDefault("background", 0, 255/255, 255/255)

------------------------------------------------------------------------------------------------------
--Global secen functions
------------------------------------------------------------------------------------------------------

function scene:create( event )

	-- Creating a group that associates objects with the scene
    local sceneGroup = self.view
	
	-- Insert the banana image
	banana = display.newImageRect("Images/CompanyLogoBrody@2x.png",  display.contentWidth/5, display.contentHeight/5 + display.contentHeight/14)
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

    
    sceneGroup:insert( banana )
    sceneGroup:insert( Jojo )	
end

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
        Runtime:addEventListener("enterFrame", MoveBanana)
    	Runtime:addEventListener("enterFrame", FadeInName)
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