-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: ...
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
local level3Sound = audio.loadSound("Sounds/bkgSound.mp3") 
local level3SoundChannel
local collideSound = audio.loadSound("Sounds/comet.mp3")
local collideSoundChannel

-- Naming Scene
sceneName = "level3_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--------------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
--------------------------------------------------------------------------------------------
-- Makes global variable "lives"
livesLevel3FS = 1

-- Global variable to hold the amount of correctly answered Questions
questionCorrect3FS = 0

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

-- Half hearts/lives
local halfHeart1

-- Character
local character

-- Boolean variable
local alreadyTouchedCharacter = false

--------------------------------------------------------------------------------------------
-- COLLISION FUNCTIONS
--------------------------------------------------------------------------------------------

-- This function detects if the boundries intersect/characters collide
local function hasCollided(obj1, obj2)

        -- Prints obj1's x and y coordinates
    print ("***obj1.x = " .. obj1.x)
    print ("***obj1.y = " .. obj1.y)
        -- Prints obj2's x and y coordinates
    print ("***obj2.x = " .. obj2.x)
    print ("***obj2.y = " .. obj2.y)
            

    if (obj1.x - obj1.width/2) > (obj2.x + obj2.width/2) then         
        return false 
    elseif (obj1.x + obj1.width/2) < (obj2.x - obj2.width/2) then 
        return false 
    elseif (obj1.y - obj1.height/2) > (obj2.y + obj2.height/2) then 
        return false 
    elseif (obj1.y + obj1.height/2) < (obj2.y - obj2.height/2) then 
        return false 
    else 
        return true 
    end
end

-- Collision Function for circular objects ( currently not used in the code)
local function hasCollidedCircle( obj1, obj2 )
 
    -- Makes sure the first object exists
    if ( obj1 == nil ) then
        return false
    end

    -- Makes sure the second object exists
    if ( obj2 == nil ) then
        return false
    end
 
    local dx = obj1.x - obj2.x
    local dy = obj1.y - obj2.y
 
    local distance = math.sqrt( dx*dx + dy*dy )
    local objectSize = (obj2.contentWidth/2) + (obj1.contentWidth/2)
 
    if ( distance < objectSize ) then
        return true
    end
    return false
end

-- Function to sense colklisions with the spaceship and comets
local function hasCollidedRect( obj1, obj2 )
 
      -- Makes sure the first object exists
    if ( obj1 == nil ) then
        return false
    end

    -- Make sure the other object exists
    if ( obj2 == nil ) then
        return false
    end

 -- sets bpoundries for the objects and detects if they collide
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
 
    return ( left or right ) and ( up or down )
end

--------------------------------------------------------------------------------------------
-- TRANSITIONS
--------------------------------------------------------------------------------------------

-- Transition to "YouLose_screen"
local function YouLoseTransition()

    character.isVisible = false

    -- Goes to "YouLose_screen"
     composer.gotoScene( "youLose_screen", {effect = "zoomInOutFade", time = 900})
end

-- Transition to "YouWin_screen"
local function YouWinTransition()

    character.isVisible = false

    -- Goes to "YouWin_screen"
     composer.gotoScene( "youWin_screen", {effect = "zoomInOutFade", time = 900})
end


--------------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
--------------------------------------------------------------------------------------------

-- This function makes all of the fullHearts visible
local function MakeHeartsVisible()

    -- Makes all of the fullHearts visible
    fullHeart1.isVisible = true
    halfHeart1.isVisible = false
end

local function UpdateLives()

    -- How many hearts are visable when lives == 1
    if ( livesLevel3FS == 1 ) then
        fullHeart1.isVisible = true
        halfHeart1.isVisible = false

    -- How many hearts are visable when lives == 0.5
    elseif ( livesLevel3FS == 0.5 ) then
        fullHeart1.isVisible = false
        halfHeart1.isVisible = true

    -- How many hearts are visable when lives == 0
    else --( lives == 0 ) then
        fullHeart1.isVisible = false
        halfHeart1.isVisible = false

        -- Performs the function after a delay of 1/10ths of a second/100 miliseconds
        timer.performWithDelay(100, YouLoseTransition)
    end
end

-- Character touch listener
local function CharacterListener(touch)


    if (touch.phase == "began") then
        --
    end

    if (touch.phase == "moved") then        

        -- Sets the character position to be the same as the courseur
        character.x = touch.x
        character.y = touch.y

        -- Verifies if the character has collided with cometLoss
        if (hasCollidedRect(character, cometLoss) == true) then
            -- Prints "character collided with cometLoss" on the console for testing purposes
            print ("character collided with cometLoss")
            -- loses 0.5 or half of a life/heart
            livesLevel3FS = livesLevel3FS - 0.5
            collideSoundChannel = audio.play(collideSound)
            -- resets the character x and y position
            character.x = display.contentWidth*50/100
            character.y = display.contentHeight*50/100
            -- Calls function to update the hearts/lives
            UpdateLives()
        end

        -- Verifies if the character has collided with cometQuestion
        if (hasCollidedRect(character, cometQuestion) == true) then
            -- Prints "character collided with cometQuestion" n the console for testing purposes
            print ("character collided with cometQuestion")
            -- Makes the character invisible
            character.isVisible = false
            -- Goes to the question screen/overlay
            composer.showOverlay( "level3_question", { isModal = true, effect = "fade", time = 100})
        end
        
    end

    if (touch.phase == "ended") then

    end
end

local function ReplaceCharacter()
    
    -- associates the character with an image/png
    character = display.newImageRect("Images/Pilot3.png", display.contentWidth*14/100, display.contentHeight*38/100)
    -- Assignes the character's x and y position
    character.x = display.contentWidth*50/100
    character.y = display.contentHeight*50/100  
    -- Names the character
    character.myName = "Spaceship"
    -- Addsa the EventListener
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
            print ("***Hit cometLoss")
            display.remove(character)
        end

        if (event.target.myName == "cometQuestion") then
            character.isVisible = false
            composer.showOverlay( "level3_question", { isModal = true, effect = "fade", time = 100})
        end

    end
end

-- This function adds EventListeners
local function AddCollisionListeners()

    -- Adds the Eventlistener for cometLoss
    cometLoss.collision = onCollision
    cometLoss:addEventListener("collision")

    -- Adds the EventListener for cometQuestion
    cometQuestion.collision = onCollision
    cometQuestion:addEventListener("collision")
end

-- this function removes EventListeners
local function RemoveCollisionListeners()

    -- Removes EventListeners
    cometLoss:removeEventListener("collision")
    cometQuestion:removeEventListener("collision")
end

--------------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
--------------------------------------------------------------------------------------------

function ResumeLevel3FS()
    -- body
    UpdateLives()
    character.isVisible = true
    character.x = display.contentWidth*50/100
    character.y = display.contentHeight*50/100

    -- If 15 questions are answered, transitions to the "YouWin_screen"
    if (questionCorrect3FS == 5) then
        YouWinTransition()
    end

end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Inserts the background image
    bkg_image = display.newImageRect("Images/Level3Screen.png", display.contentWidth, display.contentHeight)
    -- Assignes the background x and y coordinates
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    -- Assignes the background height and width
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight
    -- Inserts background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )  
    ---------
    -- Full hearts
    ---------

    -- Heart1 
    -- Assignes "fullHeart1" to an image/png
    fullHeart1 = display.newImageRect("Images/FullHeart.png", display.contentWidth*8/100, display.contentHeight*9/100)
    -- Assignes "fullHeart1" x and y coordinates
    fullHeart1.x = display.contentWidth*95/100
    fullHeart1.y = display.contentHeight*9/100
    -- Makes "fullHeart1" visible
    fullHeart1.isVisible = true
    -- Inserts the "fullHeart1" image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(fullHeart1)

    ---------
    -- Half hearts
    ---------

    -- Halfheart 1
    -- Assignes "halfHeart1" to an image/png
    halfHeart1 = display.newImageRect("Images/HalfHeart.png", display.contentWidth*4/100, display.contentHeight*8/100)
    -- Assignes "halfHeart1" x and y coordinates
    halfHeart1.x = display.contentWidth*195/201
    halfHeart1.y = display.contentHeight*9/100
    -- Makes "halfHeart1" visible
    halfHeart1.isVisible = true
    -- Inserts the "fullHeart3" image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(halfHeart1)

    ---------
    -- Comets
    ---------

    -- Loss comet
    -- Assignes "cometLoss" to an image/png
    cometLoss = display.newImageRect("Images/Comet.png", display.contentWidth*12/100, display.contentHeight*22/100)
    -- Assignes "cometLoss" x and y coordinates
    cometLoss.x = display.contentWidth*85/100
    cometLoss.y = display.contentHeight*80/100
    -- Makes "cometLoss" visible
    cometLoss.isVisible = true
    -- Names the object
    cometLoss.myName = "cometLoss"
    -- Rotates image
    cometLoss:rotate(-30)
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(cometLoss)

    -- Question comet
    -- Assignes "cometQuestion" to an image/png
    cometQuestion = display.newImageRect("Images/QuestionComet.png", display.contentWidth*12/100, display.contentHeight*22/100)
    -- Assignes "cometQuestion" x and y coordinates
    cometQuestion.x = display.contentWidth*15/100
    cometQuestion.y = display.contentHeight*20/100
    -- Makes "cometQuestion" visible
    cometQuestion.isVisible = true
    -- Names the object
    cometQuestion.myName = "cometQuestion"
    -- Rotates Image
    cometQuestion:rotate(-30)
    -- Insert objects into the scene group in order to ONLY be associated with this scene
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
        level3SoundChannel = audio.play(level3Sound)
        -- Adds collision Listeners
        AddCollisionListeners()
        livesLevel3FS = 1
        -- Calls function "MakeHeartsVisible"
        MakeHeartsVisible()
        -- Calls function "ReplaceCharacter"
        ReplaceCharacter()
        
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
       audio.stop( level1SoundChannel )

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

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

-- Adds Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
