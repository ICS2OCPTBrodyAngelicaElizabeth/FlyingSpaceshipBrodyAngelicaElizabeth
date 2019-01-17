----------------------------------------------------------------------------------------
--
-- level2_screen.lua
-- Created by: Elizabeth
-- Date: December 20
-- Description: This is the level 1 screen of the game. the charater can be dragged to move
--If character goes off a certain araea they go back to the start. When a user interactes
--with piant a trivia question will come up. they will have a limided time to click on the answer
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")

---------------
-- SCENE NAME
---------------

sceneName = "level2_question"

--SOUNDS
--Correct sound
local correctSound = audio.loadSound("Sounds/correctSound.mp3")
local correctSoundChannel

--Incorrect sound
local incorrectSound = audio.loadSound("Sounds/incorrectSound.mp3")
local incorrectSoundChannel
-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- CREATES THE LOCAL VARIABLES FOR THIS SCENE

-- The local variables for this scene
local questionText

-- Creates variables for the random numbers that add up to "answer"
local firstNumber
local secondNumber

-- Creates the variables for the wrong and tight answeres to be stored
local answer
local wrongAnswer1
local wrongAnswer2
local wrongAnswer3

-- Text for the wrong abd right answers
local answerText 
local wrongAnswerText1
local wrongAnswerText2
local wrongAnswerText3

-- Creates a variable to hold the random x and y position for the answer
local answerPosition = 1

-- Background
local bkg

-- A rectangle cover to have the background fully bolcked where the question is
local cover

-- Right and wrong answer positions
local X1 = display.contentWidth*2/7
local X2 = display.contentWidth*4/7
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5.5/7

-- Variable to hold the user's answer
local userAnswer

-- Variable that contains if the text has been touched or not
local textTouched = false

-- Variables for the timer
local countDownTimer
local clockText
-- Variable for how many seconds are left
local secondsLeft = 15
-- Variable for total seconds
local totalSeconds = 15
-- Variables for "Incorrect!" and "Correct!" text objects
local CorrectText
local IncorrectText

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-----------------
-- RESUME LEVEL
-----------------

--making transition to next scene
local function BackToLevel2() 
    -- Uses the "crossFade" effect for 400 miliseconds
    composer.hideOverlay("crossFade", 400 )
    -- Calls function "ResumeLevel2FS"
    ResumeLevel2FS()
end 

----------
-- TIMER
----------

-- Function that updates the timer
local function UpdateTime()
    -- Decrement the number of seconds
    secondsLeft = secondsLeft - 1
    --Display the number of seconds left in the clock object
    clockText.text = "Time: " .. secondsLeft

    if (secondsLeft == 0 ) then
        -- Reset the number of seconds left
        secondsLeft = totalSeconds
        -- Subtracts a life
        livesLevel2FS = livesLevel2FS - 1
        -- Calls function BackToLevel2
        BackToLevel2()
    end
end

-- Function that starts the timer
local function StartTimer()
    -- Create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

--------------------------
-- QUESTIONS AND ANSWERS
--------------------------

-- Checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerAnswer(touch)
    userAnswer = answerText.text
    
    if (touch.phase == "ended") then

        -- Adds 1 to questionCorrect for level 2
        questionCorrect2FS = questionCorrect2FS + 1
        -- Makes CorrectText visible
        CorrectText.isVisible = true
        correctSoundChannel = audio.play(correctSound)
        -- Adds a delay before going to Level 2
        timer.performWithDelay(1000,BackToLevel2)
    end 
end

-- Checking to see if the user pressed the right answer and bring them back to level 2
local function TouchListenerWrongAnswer(touch)
    userAnswer = wrongText1.text
    
    if (touch.phase == "ended") then

        -- Subtracts a life from Level 2
        livesLevel2FS = livesLevel2FS - 1
        -- Makes IncorrectText visible
        IncorrectText.isVisible = true
        incorrectSoundChannel = audio.play(incorrectSound)
        -- Adds delay before going to level
        timer.performWithDelay(1000,BackToLevel2)        
    end 
end

-- Checking to see if the user pressed the right answer and bring them back to level 2
local function TouchListenerWrongAnswer2(touch)
    userAnswer = wrongText2.text
    
    if (touch.phase == "ended") then
        
        -- Subtracts a life from Level 2
        livesLevel2FS = livesLevel2FS - 1
        -- Makes IncorrectText visible
        IncorrectText.isVisible = true
        incorrectSoundChannel = audio.play(incorrectSound)
        -- Adds delay before going to level
        timer.performWithDelay(1000,BackToLevel2)        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 2
local function TouchListenerWrongAnswer3(touch)
    userAnswer = wrongText3.text
    
    if (touch.phase == "ended") then
        
        -- Subtracts a life from Level 2
        livesLevel2FS = livesLevel2FS - 1
        -- Makes IncorrectText visible
        IncorrectText.isVisible = true
        incorrectSoundChannel = audio.play(incorrectSound)
        -- Adds delay before going to level
        timer.performWithDelay(1000,BackToLevel2)        
    end 
end

-- Adding the event listeners 
local function AddTextListeners ( )
    answerText:addEventListener( "touch", TouchListenerAnswer )
    wrongText1:addEventListener( "touch", TouchListenerWrongAnswer)
    wrongText2:addEventListener( "touch", TouchListenerWrongAnswer2)
    wrongText3:addEventListener( "touch", TouchListenerWrongAnswer3)
end

-- Removing the event listeners
local function RemoveTextListeners()
    answerText:removeEventListener( "touch", TouchListenerAnswer )
    wrongText1:removeEventListener( "touch", TouchListenerWrongAnswer)
    wrongText2:removeEventListener( "touch", TouchListenerWrongAnswer2)
    wrongText3:removeEventListener( "touch", TouchListenerWrongAnswer3)
end

local function DisplayQuestion()
    -- Creating random numbers
    firstNumber = math.random (13,20)
    secondNumber = math.random (2,10)

    -- calculate answer
    answer = firstNumber - secondNumber
    -- calculate wrong answers
    wrongAnswer1 = answer - math.random(1, 3)
    wrongAnswer2 = answer + math.random(4, 6)
    wrongAnswer3 = answer + math.random(7, 9)
    -- Creating the question depending on the selcetion number
    questionText.text = firstNumber .. " - " .. secondNumber .. " = "
    -- Creating answer text from list it corispondes with the animals list
    answerText.text = answer
    -- Creating wrong answers
    wrongText1.text = wrongAnswer1
    wrongText2.text = wrongAnswer2
    wrongText3.text = wrongAnswer3
end

local function PositionAnswers()

    -- Creating random start position in a cretain area
    answerPosition = math.random(1,4)

    if (answerPosition == 1) then
        -- AnswerText
        answerText.x = X1
        answerText.y = Y1
        -- WrongText1
        wrongText1.x = X2
        wrongText1.y = Y1
        -- WrongText2
        wrongText2.x = X1
        wrongText2.y = Y2
        -- WrongText3
        wrongText3.x = X2
        wrongText3.y = Y2
        
    elseif (answerPosition == 2) then
        -- AnswerText
        answerText.x = X1
        answerText.y = Y2
        -- WrongText1
        wrongText1.x = X1
        wrongText1.y = Y1
        -- WrongText2
        wrongText2.x = X2
        wrongText2.y = Y1
        -- WrongText3
        wrongText3.x = X2
        wrongText3.y = Y2


    elseif (answerPosition == 3) then
        -- AnswerText
        answerText.x = X2
        answerText.y = Y1
        -- WrongText1
        wrongText1.x = X1
        wrongText1.y = Y2
        -- WrongText2
        wrongText2.x = X1
        wrongText2.y = Y1
        -- WrongText3
        wrongText3.x = X2
        wrongText3.y = Y2

    elseif (answerPosition == 4) then
        -- AnswerText
        answerText.x = X2
        answerText.y = Y2
        -- WrongText1
        wrongText1.x = X2
        wrongText1.y = Y1
        -- WrongText2
        wrongText2.x = X1
        wrongText2.y = Y1
        -- WrongText3
        wrongText3.x = X1
        wrongText3.y = Y2       
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
    -- Covering the other scene with a rectangle so it looks faded and stops touch from going through
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0,0.5)

    -----------------------------------------------------------------------------------------
    -- Making a cover rectangle to have the background fully bolcked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.95, 50 )
    --setting its colour
    cover:setFillColor(96/255, 96/255, 96/255)
    -- create the question text object
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)

    -- create the answer text object & wrong answer text objects
    answerText = display.newText("", X1, Y2, Arial, 75)
    answerText.anchorX = 0
    wrongText1 = display.newText("", X2, Y2, Arial, 75)
    wrongText1.anchorX = 0
    wrongText2 = display.newText("", X1, Y1, Arial, 75)
    wrongText2.anchorX = 0
    wrongText3 = display.newText("", X2, Y1, Arial, 75)
    wrongText3.anchorX = 0

    -- Create the text object that will say "Correct!", set the colour and then hide it
    CorrectText = display.newText("Correct!", display.contentWidth*2/5, display.contentHeight*1/3, nil, 50)
    -- Sets the text colour to be green
    CorrectText:setTextColor(0, 1, 0)
    -- Makes CorrectText transparent
    CorrectText.isVisible = false

    -- Create the text object that will say "Incorrect!", set the colour and then hide it
    IncorrectText = display.newText("Incorrect!", display.contentWidth*2/5, display.contentHeight*1/3, nil, 50)
    -- Sets the text colour to be red
    IncorrectText:setTextColor(1, 0, 0)
    -- Makes IncorrectText transparent
    IncorrectText.isVisible = false

    -----------------------------------------------------------------------------------------
   
    clockText = display.newText("Time: 15", display.contentWidth *3/12, display.contentHeight *1/12, nil, 50)
    clockText:setTextColor(1)

    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    sceneGroup:insert(questionText)
    sceneGroup:insert(answerText)
    sceneGroup:insert(wrongText1)
    sceneGroup:insert(wrongText2)
    sceneGroup:insert(wrongText3)
    sceneGroup:insert(clockText)
    sceneGroup:insert(CorrectText)
    sceneGroup:insert(IncorrectText)


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
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        
        -- Calls function DisplayQuestion
        DisplayQuestion()
        -- Calls function PositionAnswers
        PositionAnswers()
        -- Calls function StartTimer
        StartTimer()
        -- Calls function AddTextListeners
        AddTextListeners()
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
        --parent:resumeGame()

        -- stops the timer
        timer.cancel(countDownTimer)
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called immediately after scene goes off screen.
        RemoveTextListeners()
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