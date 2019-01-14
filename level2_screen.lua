-----------------------------------------------------------------------------------------
--
-- level2_screen.lua
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

-- load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------
--SOUNDS
-----------------------------------------------------------------------------------------

-- BACKGROUND MUSIC
local level2Sound = audio.loadStream("Sounds/bkgSound.mp3") 
-- COLLIDE SOUND
local collideSound = audio.loadSound("Sounds/comet.mp3")
local collideSoundChannel

---------------
-- SCENE NAME
---------------

-- Names the scene "level2_screen"
sceneName = "level2_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--------------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
--------------------------------------------------------------------------------------------

-- Makes variable "livesLevel2FS"
livesLevel2FS = 2

-- Global variable to hold the amount of correctly answered Questions
questionCorrect2FS = 0

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- CREATES THE LOCAL VARIABLES FOR THIS SCENE

-- Background image
local bkg_image

-- Comets/obstacles
local cometLoss
local cometQuestion

-- Full hearts/lives
local fullHeart1
local fullHeart2

-- Half hearts/lives
local halfHeart1
local halfHeart2

-- Character
local character

-- Motion speed
scrollSpeed1 = 7
scrollSpeed2 = 5
stop = 0

-- Variable for Correctquestions text object
local correctText

-- Boolean variable
local alreadyTouchedCharacter = false

--------------------------------------------------------------------------------------------
-- COLLISION FUNCTIONS
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

-- Sets boundries for the objects and detects if they collide
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
    -- Goes to "youLose_screen"
    composer.gotoScene( "youLose_screen", {effect = "zoomInOutFade", time = 900})
end

-- Transition to the third level
local function Level3Transition()

    -- Makes the character transparent
    character.isVisible = false
    -- Goes to "level3_screen"
    composer.gotoScene( "level3_screen", {effect = "zoomInOutFade", time = 900})
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

    -- Makes text "0/10" visible
    correctText.text = ("0/10")
    -- Makes all of the fullHearts visible
    fullHeart1.isVisible = true
    fullHeart2.isVisible = true
    halfHeart1.isVisible = false
    halfHeart2.isVisible = false
end

local function UpdateLives()

    -- How many hearts are visable when livesLevel2FS == 2
    if ( livesLevel2FS == 2 ) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = true
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false

    -- How many hearts are visable when livesLevel2FS == 1.5
    elseif ( livesLevel2FS == 1.5 ) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = true

    -- How many hearts are visable when livesLevel2FS == 1
    elseif ( livesLevel2FS == 1 ) then
        fullHeart1.isVisible = true
        fullHeart2.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false

    -- How many hearts are visable when livesLevel2FS == 0.5
    elseif ( livesLevel2FS == 0.5 ) then
        fullHeart1.isVisible = false
        fullHeart2.isVisible = false
        halfHeart1.isVisible = true
        halfHeart2.isVisible = false

    -- How many hearts are visable when livesLevel2FS == 0
    else --( livesLevel2FS == 0 ) then
        fullHeart1.isVisible = false
        fullHeart2.isVisible = false
        halfHeart1.isVisible = false
        halfHeart2.isVisible = false
        questionCorrect2FS = 0
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
            livesLevel2FS = livesLevel2FS - 0.5
            collideSoundChannel = audio.play(collideSound)
            -- resets the character x and y position
            character.x = display.contentWidth*50/100
            character.y = display.contentHeight*50/100
            -- Calls function to update the hearts/livesLevel2FS            
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
            composer.showOverlay( "level2_question", { isModal = true, effect = "fade", time = 100})
        end
    end

    if (touch.phase == "ended") then
        --
    end
end
-----------
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
            livesLevel2FS = livesLevel2FS - 0.5
            UpdateLives()
        end

        if (event.target.myName == "cometQuestion") then
            character.isVisible = false
            composer.showOverlay( "level2_question", { isModal = true, effect = "fade", time = 100})
        end

        if (event.target.myName == "Ship") then
            print ("***Hit character")
            character.isVisible = false
            composer.showOverlay( "level2_question", { isModal = true, effect = "fade", time = 100})
        end
    end
end

local function ReplaceCharacter()
    
    -- Associates the character with an image/png
    character = display.newImageRect("Images/Pilot1.png", display.contentWidth*12/100, display.contentHeight*36/100)
    -- Assignes the character's x and y position
    character.x = display.contentWidth*50/100
    character.y = display.contentHeight*50/100  
    -- Names the character
    character.myName = "Ship"
    -- Adds an EventListener
    character:addEventListener("touch", CharacterListener)
    character.collision = onCollision
    character:addEventListener("collision")
    -- add physics body
    physics.addBody( character, "static", { density=0, friction=0, bounce=0, rotation=0 } )
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

local function AddPhysicsBodies()

    physics.addBody( cometLoss, "static", { density=0, friction=0, bounce=0 } )
    physics.addBody( cometQuestion, "static", { density=0, friction=0, bounce=0 } )
end

local function RemovePhysicsBodies()
    physics.removeBody(cometLoss)
    physics.removeBody(cometQuestion)
end

--------------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
--------------------------------------------------------------------------------------------

function ResumeLevel2FS()
    
    -- Calls function "UpdateLives"
    UpdateLives()
    -- Makes the character visable
    character.isVisible = true
    -- Sets the characters x and y coordinates
    character.x = display.contentWidth*50/100
    character.y = display.contentHeight*50/100

    if (questionCorrect2FS == 0) then
        correctText.text = ("0/10")
    
    elseif (questionCorrect2FS == 1) then
        correctText.text = ("1/10")

    elseif (questionCorrect2FS == 2) then
        correctText.text = ("2/10")

    elseif (questionCorrect2FS == 3) then
        correctText.text = ("3/10")

    elseif (questionCorrect2FS == 4) then
        correctText.text = ("4/10")

    elseif (questionCorrect2FS == 5) then
        correctText.text = ("5/10")

    elseif (questionCorrect2FS == 6) then
        correctText.text = ("6/10")

    elseif (questionCorrect2FS == 7) then
        correctText.text = ("7/10")

    elseif (questionCorrect2FS == 8) then
        correctText.text = ("8/10")

     elseif (questionCorrect2FS == 9) then
        correctText.text = ("9/10")

    -- If 5 questions are answered, transitions to "level3_screen"
    elseif (questionCorrect2FS == 10) then
        correctText.text = ("10/10")
        questionCorrect2FS = 0
        Level3Transition()
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
    bkg_image = display.newImageRect("Images/Level2Screen.png", display.contentWidth, display.contentHeight)
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

    -- FULLHEART1 
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
    -- Inserts the "fullHeart" image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(halfHeart1)

    -- HALFHEART2
    -- Assignes "halfHeart2" to an image/png
    halfHeart2 = display.newImageRect("Images/HalfHeart.png", display.contentWidth*4/100, display.contentHeight*8/100)
    -- Assignes "halfHeart2" x and y coordinates
    halfHeart2.x = display.contentWidth*177/201
    halfHeart2.y = display.contentHeight*9/100
    -- Makes "halfHeart2" visible
    halfHeart2.isVisible = true
    -- Inserts the "fullHeart" image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(halfHeart2)

    -----------
    -- COMETS
    -----------

    -- LOSS COMET
    -- Assignes "cometLoss" to an image/png
    cometLoss = display.newImageRect("Images/Comet.png", display.contentWidth*12/100, display.contentHeight*22/100)
    -- Assignes "cometLoss" x and y coordinates
    cometLoss.x = math.random(display.contentWidth*1/5, display.contentWidth*4/5)
    cometLoss.y = display.contentHeight*80/100    
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

    ---------
    -- TEXT
    ---------

    correctText = display.newText("0/10", display.contentWidth*9/10, display.contentHeight*9/10, nil, 50 )
    correctText:setTextColor(0)
    sceneGroup:insert(correctText)

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
    -- Starts physics
    physics.start()

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        
        --play level2 background sound
        level2SoundChannel = audio.play(level2Sound)
        -- Sets variable "livesLevel2FS" to 3
        livesLevel2FS = 2
        -- Calls function "MakeHeartsVisible"
        MakeHeartsVisible()
        -- Calls function AddPhysicsBodies
        AddPhysicsBodies()
        -- Adds collision Listeners
        AddCollisionListeners()
        -- Adds Runtime eventListener
        Runtime:addEventListener("enterFrame", MoveComets)
        -- Calls function "ReplaceCharacter"
        ReplaceCharacter()
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )
    audio.stop (level2SoundChannel)

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
       audio.stop( level2SoundChannel )

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

        RemoveCollisionListeners()
        RemovePhysicsBodies()

        physics.stop()
        character:removeEventListener("touch", CharacterListener)
        Runtime:removeEventListener("enterFrame", MoveComets)
        display.remove(character)
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