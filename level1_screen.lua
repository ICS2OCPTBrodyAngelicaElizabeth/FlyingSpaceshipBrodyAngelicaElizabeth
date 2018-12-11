-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Angelica
-- Date: Month Day, Year
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

--SOUNDS
local level1Sound = audio.loadSound("Sounds/level1Sound.mp3") 
local level1SoundChannel

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
-- The local variables for this scene
-- Background image
local bkg_image

-- Comet/obstacles
local cometLoss
local cometQuestion

-- Full hearts/lives
local fullHeart1
local fullHeart2
local fullHeart3

-- Half hearts/lives
local halfHeart1
local halfHeart2
local halfHeart3

-- Lives
local lives = 3
-- Walls
local leftW
local rightW
local topW
local floor
-- Character
local character
-- Boolean variables
local alreadyTouchedCharacter = false

--------------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
--------------------------------------------------------------------------------------------

local function CharacterListener(touch)

    if (touch.phase == "began") then
        
    end

    if (touch.phase == "moved") then        
        character.x = touch.x
        character.y = touch.y
    end

    if (touch.phase == "ended") then

     --   if(character.x == cometLoss) then

--            lives = lives - 1
         --   UpdateLives()
       
    end
end

local function MakeHeartsVisible()

    fullHeart1.isVisible = true
    fullHeart2.isVisible = true
    fullHeart3.isVisible = true
    halfHeart1.isVisible = false
    halfHeart2.isVisible = false
    halfHeart3.isVisible = false
end

local function UpdateLives()

    if (lives == 3) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = true
        fullHeart3.isVisible = true
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false
        halfHeart3.isVisible = false

    elseif ( lives == 2.5) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = true
        fullHeart3.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false
        halfHeart3.isVisible = true

    elseif ( lives == 2 ) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = true
        fullHeart3.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false
        halfHeart3.isVisible = false

    elseif ( lives == 1.5 ) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = false
        fullHeart3.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = true
        halfHeart3.isVisible = false

    elseif ( lives == 1 ) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = false
        fullHeart3.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false
        halfHeart3.isVisible = false

    elseif ( lives == 0.5 ) then
        fullHeart1.isVisible = false
        fullHeart2.isVisible = false
        fullHeart3.isVisible = false
        halfHeart1.isVisible = true
        halfHeart2.isVisible = false
        halfHeart3.isVisible = false

    else --( lives == 0 ) then
        fullHeart1.isVisible = false
        fullHeart2.isVisible = false
        fullHeart3.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false
        halfHeart3.isVisible = false
    end
end

local function ReplaceCharacter()
    
    character = display.newImageRect("Images/FullCharacter.png", display.contentWidth*14/100, display.contentHeight*38/100)
    character.x = display.contentWidth*45/100
    character.y = display.contentHeight*75/100 
    character:rotate(-90)
    character.myName = "Spaceship"
    character:addEventListener("touch", CharacterListener)
end

local function onCollision( self, event)
    -- for testing purposes
    print( event.target.myName )        --the first object in the collision
    print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )


    if ( event.phase == "began" ) then

        if (event.target.myName == "cometLoss") then
            display.remove(character)
            lives = lives - 0.5
            UpdateLives()
        end

        if (event.target.myName == "cometQuestion") then
            character.isVisible = false
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})
        end

    end
end

local function AddCollisionListeners()

    cometLoss.collision = onCollision
    cometLoss:addEventListener("collision")

    cometQuestion.collision = onCollision
    cometQuestion:addEventListener("collision")
end

local function RemoveCollisionListeners()

    cometLoss:removeEventListener("collision")
    cometQuestion:removeEventListener("collision")
end

local function AddPhysicsBodies ()

    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(cometLoss, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(cometQuestion, "static",  {density=0, friction=0, bounce=0} )

end

local function RemovePhysicsBodies()

    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)
    physics.removeBody(floor)
    physics.removeBody(cometLoss)
    physics.removeBody(cometQuestion)

end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level1Screen (2).png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

        -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )  

    -- Full hearts
    -- Heart1
    fullHeart1 = display.newImageRect("Images/FullHeart.png", display.contentWidth*8/100, display.contentHeight*9/100)
    fullHeart1.x = display.contentWidth*95/100
    fullHeart1.y = display.contentHeight*9/100
    fullHeart1.isVisible = true
    sceneGroup:insert(fullHeart1)
    -- Heart2
    fullHeart2 = display.newImageRect("Images/FullHeart.png", display.contentWidth*8/100, display.contentHeight*9/100)
    fullHeart2.x = display.contentWidth*86/100
    fullHeart2.y = display.contentHeight*9/100
    fullHeart2.isVisible = true
    sceneGroup:insert(fullHeart2)
    -- Heart 3
    fullHeart3 = display.newImageRect("Images/FullHeart.png", display.contentWidth*8/100, display.contentHeight*9/100)
    fullHeart3.x = display.contentWidth*77/100
    fullHeart3.y = display.contentHeight*9/100
    fullHeart3.isVisible = true
    sceneGroup:insert(fullHeart3)

    -- Half hearts
    -- Halfheart 1
    halfHeart1 = display.newImageRect("Images/HalfHeart.png", display.contentWidth*4/100, display.contentHeight*8/100)
    halfHeart1.x = display.contentWidth*195/201
    halfHeart1.y = display.contentHeight*9/100
    halfHeart1.isVisible = true
    sceneGroup:insert(halfHeart1)
    -- Halfheart 2
    halfHeart2 = display.newImageRect("Images/HalfHeart.png", display.contentWidth*4/100, display.contentHeight*8/100)
    halfHeart2.x = display.contentWidth*177/201
    halfHeart2.y = display.contentHeight*9/100
    halfHeart2.isVisible = true
    sceneGroup:insert(halfHeart2)
    -- Halfheart 3
    halfHeart3 = display.newImageRect("Images/HalfHeart.png", display.contentWidth*4/100, display.contentHeight*8/100)
    halfHeart3.x = display.contentWidth*159/201
    halfHeart3.y = display.contentHeight*9/100
    halfHeart3.isVisible = true
    sceneGroup:insert(halfHeart3)


    -- Walls
    -- Left wall
    leftW = display.newLine( 0, 0, 0, display.contentHeight)
    leftW.isVisible = true
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( leftW )

    -- Right wall
    rightW = display.newLine( 0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rightW )

    -- Top wall
    topW = display.newLine( 0, 0, display.contentWidth, 0)
    topW.isVisible = true
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( topW )

    -- Comets
    -- Loss comet
    cometLoss = display.newImageRect("Images/Comet.png", display.contentWidth*12/100, display.contentHeight*22/100)
    cometLoss.x = display.contentWidth*77/100
    cometLoss.y = display.contentHeight*30/100
    cometLoss.isVisible = true
    cometLoss:rotate(-30)
    sceneGroup:insert(cometLoss)

    -- Question comet
    cometQuestion = display.newImageRect("Images/QuestionComet.png", display.contentWidth*12/100, display.contentHeight*22/100)
    cometQuestion.x = display.contentWidth*67/100
    cometQuestion.y = display.contentHeight*60/100
    cometQuestion.isVisible = true
    cometQuestion:rotate(-30)
    sceneGroup:insert(cometQuestion)




end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        physics.start()

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        
        --play level1 background sound
       
      --  AddPhysicsBodies()
        AddCollisionListeners()
        level1SoundChannel = audio.play(level1Sound)
        lives = 3
        MakeHeartsVisible()
        ReplaceCharacter()
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

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
        --RemoveCollisionListeners()
        --RemovePhysicsBodies()
        character:removeEventListener("touch", CharacterListener)
       

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
