-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Angelica Lutkiewicz
-- Sounds: Elizabeth Acheng
-- Date: December 11, 2018
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
 
-- BACKGROUND MUSIC
local level1Sound = audio.loadStream("Sounds/bkgSound.mp3") 
-- COLLIDE SOUND
local collideSound = audio.loadSound("Sounds/comet.mp3")
local collideSoundChannel

-----------------------------------------------------------------------------------------
-- SCENE NAME
-----------------------------------------------------------------------------------------

-- Names the scene "level1_screen"
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--------------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
--------------------------------------------------------------------------------------------

-- Makes variable "livesLevel1FS"
livesLevel1FS = 3 

-- Global variable to hold the amount of correctly answered Questions in level 1
questionCorrect1FS = 0

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- CREATES THE LOCAL VARIABLES FOR THIS SCENE

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

-- Character
local character

-- Motion speed
scrollSpeed1 = 7
scrollSpeed2 = 5
stop = 0

-- Boolean variable
local alreadyTouchedCharacter = false

--------------------------------------------------------------------------------------------
-- COLLISION FUNCTION
--------------------------------------------------------------------------------------------

-- Function to sense collisions with the Ship and comets
local function hasCollidedRect( obj1, obj2 )
    local X_PADDING = 75
    local Y_PADDING = 55

      -- Makes sure the first object exists
    if ( obj1 == nil ) then
        return false
    end

    -- Make sure the other object exists
    if ( obj2 == nil ) then
        return false
    end



 -- sets bpoundries for the objects and detects if they collide

    local left = (obj1.contentBounds.xMin + X_PADDING <= obj2.contentBounds.xMin) and (obj1.contentBounds.xMax - X_PADDING >= obj2.contentBounds.xMin)
    local right = obj1.contentBounds.xMin + X_PADDING >= obj2.contentBounds.xMin and obj1.contentBounds.xMin + X_PADDING <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin + Y_PADDING <= obj2.contentBounds.yMin and obj1.contentBounds.yMax - Y_PADDING >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin + Y_PADDING >= obj2.contentBounds.yMin and obj1.contentBounds.yMin + Y_PADDING <= obj2.contentBounds.yMax
 
    return ( left or right ) and ( up or down )
end

--------------------------------------------------------------------------------------------
-- TRANSITIONS
--------------------------------------------------------------------------------------------

-- Transition to "YouLose_screen"
local function YouLoseTransition()

    -- Makes the character transparent
    character.isVisible = false

    -- Goes to "YouLose_screen"
     composer.gotoScene( "youLose_screen", {effect = "zoomInOutFade", time = 900})
end

-- Transition to "YouWin_screen"
local function Level2Transition()

    -- Makes the character transparent
    character.isVisible = false

    -- Goes to "level2_screen"
    composer.gotoScene( "level2_screen", {effect = "zoomInOutFade", time = 900})
end


--------------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
--------------------------------------------------------------------------------------------

-- creates a function that makes the comets invisible
local function Hide()
    -- Hides CometLoss 
    cometLoss.isVisible = false
    -- Hides CometQuestion
    cometQuestion.isVisible = false
end

-- makes a function that sets the comets in a downwards motion
local function MoveComets(event)
    if (cometLoss.y > display.contentHeight) then
        -- Assigns a random x coordinate for cometLoss
        cometLoss.x = math.random(0, display.contentWidth)
        cometLoss.y = 0
    else
        -- Lowers the y point of cometLoss steadily
        cometLoss.y = cometLoss.y + scrollSpeed1
    end
end

-- This function makes all of the fullHearts visible
local function MakeHeartsVisible()

    -- Makes all of the fullHearts visible
    fullHeart1.isVisible = true
    fullHeart2.isVisible = true
    fullHeart3.isVisible = true
    halfHeart1.isVisible = false
    halfHeart2.isVisible = false
    halfHeart3.isVisible = false
end

local function UpdateLives()

    -- How many hearts are visable when livesLevel1FS == 3
    if (livesLevel1FS == 3) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = true
        fullHeart3.isVisible = true
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false
        halfHeart3.isVisible = false

    -- How many hearts are visable when livesLevel1FS == 2.5
    elseif ( livesLevel1FS == 2.5) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = true
        fullHeart3.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false
        halfHeart3.isVisible = true

    -- How many hearts are visable when livesLevel1FS == 2
    elseif ( livesLevel1FS == 2 ) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = true
        fullHeart3.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false
        halfHeart3.isVisible = false

    -- How many hearts are visable when livesLevel1FS == 1.5
    elseif ( livesLevel1FS == 1.5 ) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = false
        fullHeart3.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = true
        halfHeart3.isVisible = false

    -- How many hearts are visable when livesLevel1FS == 1
    elseif ( livesLevel1FS == 1 ) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = false
        fullHeart3.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false
        halfHeart3.isVisible = false

    -- How many hearts are visable when livesLevel1FS == 0.5
    elseif ( livesLevel1FS == 0.5 ) then
        fullHeart1.isVisible = false
        fullHeart2.isVisible = false
        fullHeart3.isVisible = false
        halfHeart1.isVisible = true
        halfHeart2.isVisible = false
        halfHeart3.isVisible = false

    -- How many hearts are visable when livesLevel1FS == 0
    else --( livesLevel1FS == 0 ) then
        fullHeart1.isVisible = false
        fullHeart2.isVisible = false
        fullHeart3.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false
        halfHeart3.isVisible = false
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
            livesLevel1FS = livesLevel1FS - 0.5
            collideSoundChannel = audio.play(collideSound)
            -- resets the character x and y position
            character.x = display.contentWidth*50/100
            character.y = display.contentHeight*50/100
            -- Calls function to update the hearts/livesLevel1FS            
            UpdateLives()
            cometLoss.x = math.random(0, display.contentWidth)
            cometLoss.y = 0            
        end

        -- Verifies if the character has collided with cometQuestion
        if (hasCollidedRect(character, cometQuestion) == true) then
            -- Prints "character collided with cometQuestion" n the console for testing purposes
            print ("character collided with cometQuestion")
            -- Makes the character invisible
            character.isVisible = false
            -- Goes to the question screen/overlay
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})
        end
        
    end

    if (touch.phase == "ended") then
            
    end
end


--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local function onCollision( self, event)
    -- for testing purposes
    print( event.target.myName )        --the first object in the collision
    print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )

    print ("onCollision called")

    if ( event.phase == "began" ) then

        if (event.target.myName == "cometLoss") then
            print ("***Hit cometLoss")
            display.remove(character)
        end

        if (event.target.myName == "cometQuestion") then
            character.isVisible = false
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})
        end

        if (event.target.myName == "Ship") then
            print ("***Hit character")
            character.isVisible = false
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})
        end

    end
end


local function ReplaceCharacter()
    
    -- associates the character with an image/png
    character = display.newImageRect("Images/Pilot1.png", display.contentWidth*14/100, display.contentHeight*38/100)

    -- Assignes the character's x and y position
    character.x = display.contentWidth*50/100
    character.y = display.contentHeight*50/100  

    -- Names the character
    character.myName = "Ship"
    -- Addsa the EventListener
    character:addEventListener("touch", CharacterListener)

    character.collision = onCollision
    character:addEventListener("collision")
    

end



-- This function adds EventListeners
local function AddCollisionListeners()

    print ("****Called AddCollisionListeners")

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



--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--------------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
--------------------------------------------------------------------------------------------

function ResumeLevel1FS()
    -- Calls function "UpdateLives"
    UpdateLives()
    -- Makes the character visable
    character.isVisible = true
    -- Sets the characters x and y coordinates
    character.x = display.contentWidth*50/100
    character.y = display.contentHeight*50/100

    -- If 5 questions are answered, transitions to "level2_screen"
    if (questionCorrect1FS == 5) then
        Level2Transition()
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

    ---------------
    -- BACKGROUND
    ---------------

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

    ----------------
    -- FULL HEARTS
    ----------------

    -- FULLHEART3 
    -- Assignes "fullHeart1" to an image/png
    fullHeart1 = display.newImageRect("Images/FullHeart.png", display.contentWidth*8/100, display.contentHeight*9/100)
    -- Assignes "fullHeart1" x and y coordinates
    fullHeart1.x = display.contentWidth*95/100
    fullHeart1.y = display.contentHeight*9/100
    -- Makes "fullHeart1" visible
    fullHeart1.isVisible = true
    -- Inserts the "fullHeart1" image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(fullHeart1)

    -- FULLHEART2
    -- Assignes "fullHeart2" to an image/png
    fullHeart2 = display.newImageRect("Images/FullHeart.png", display.contentWidth*8/100, display.contentHeight*9/100)
    -- Assignes "fullHeart2" x and y coordinates
    fullHeart2.x = display.contentWidth*86/100
    fullHeart2.y = display.contentHeight*9/100
    -- Makes "fullHeart2" visible
    fullHeart2.isVisible = true
    -- Inserts the "fullHeart2" image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(fullHeart2)

    -- FULLHEART3
    -- Assignes "fullHeart3" to an image/png
    fullHeart3 = display.newImageRect("Images/FullHeart.png", display.contentWidth*8/100, display.contentHeight*9/100)
    -- Assignes "fullHeart3" x and y coordinates
    fullHeart3.x = display.contentWidth*77/100
    fullHeart3.y = display.contentHeight*9/100
    -- Makes "fullHeart3" visible
    fullHeart3.isVisible = true
    -- Inserts the "fullHeart3" image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(fullHeart3)

    ----------------
    -- HALF HEARTS
    ----------------

    -- HALFHEART1
    -- Assignes "halfHeart1" to an image/png
    halfHeart1 = display.newImageRect("Images/HalfHeart.png", display.contentWidth*4/100, display.contentHeight*8/100)
    -- Assignes "halfHeart1" x and y coordinates
    halfHeart1.x = display.contentWidth*195/201
    halfHeart1.y = display.contentHeight*9/100
    -- Makes "halfHeart1" visible
    halfHeart1.isVisible = true
    -- Inserts the "fullHeart3" image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(halfHeart1)

    -- HALFHEART2
    -- Assignes "halfHeart2" to an image/png
    halfHeart2 = display.newImageRect("Images/HalfHeart.png", display.contentWidth*4/100, display.contentHeight*8/100)
    -- Assignes "halfHeart2" x and y coordinates
    halfHeart2.x = display.contentWidth*177/201
    halfHeart2.y = display.contentHeight*9/100
    -- Makes "halfHeart2" visible
    halfHeart2.isVisible = true
    -- Inserts the "fullHeart3" image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(halfHeart2)

    -- HALFHEART3
    -- Assignes "halfHeart3" to an image/png
    halfHeart3 = display.newImageRect("Images/HalfHeart.png", display.contentWidth*4/100, display.contentHeight*8/100)
    -- Assignes "halfHeart3" x and y coordinates
    halfHeart3.x = display.contentWidth*159/201
    halfHeart3.y = display.contentHeight*9/100
    -- Makes "halfHeart3" visible
    halfHeart3.isVisible = true
    -- Inserts the "fullHeart3" image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(halfHeart3)

    -----------
    -- COMETS
    -----------

    -- LOSS COMET
    -- Assignes "cometLoss" to an image/png
    cometLoss = display.newImageRect("Images/Comet.png", display.contentWidth*12/100, display.contentHeight*22/100)
    -- Assignes "cometLoss" x and y coordinates
    cometLoss.x = math.random(display.contentWidth*1/5, display.contentWidth*4/5)
    cometLoss.y = display.contentHeight*80/100
    print ("***cometLoss.contentBounds.xMin = " .. cometLoss.contentBounds.xMin)
    print ("***cometLoss.contentBounds.xMax = " .. cometLoss.contentBounds.xMax)
    print ("***cometLoss.contentBounds.yMin = " .. cometLoss.contentBounds.yMin)
    print ("***cometLoss.contentBounds.yMax = " .. cometLoss.contentBounds.yMax)
    print ("***cometLoss.x = " .. cometLoss.x)
    print ("***cometLoss.y = " .. cometLoss.y)
    
    -- Makes "cometLoss" visible
    cometLoss.isVisible = true
    -- Names the object
    cometLoss.myName = "cometLoss"
    -- Rotates image
    cometLoss:rotate(-30)
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(cometLoss)

    -- QUESTION COMET
    -- Assignes "cometQuestion" to an image/png
    cometQuestion = display.newImageRect("Images/QuestionComet.png", display.contentWidth*12/100, display.contentHeight*22/100)
    -- Assignes "cometQuestion" x and y coordinates
    cometQuestion.x = math.random(display.contentWidth*1/5, display.contentWidth*4/5)
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
        
        --plays level1 background sound
        level1SoundChannel = audio.play(level1Sound)
        
        -- Sets variable "livesLevel1FS" to 3
        livesLevel1FS = 3
        -- Calls function "MakeHeartsVisible"
        MakeHeartsVisible()

        Runtime:addEventListener("enterFrame", MoveComets)
        -- Calls function "ReplaceCharacter"
        ReplaceCharacter()

        -- Adds collision Listeners
        AddCollisionListeners()

        
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
        Runtime:removeEventListener("enterFrame", MoveComets)
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