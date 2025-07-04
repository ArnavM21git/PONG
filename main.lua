 push=require 'push' --for upscaling due to virtual width
 --==importing a module like
 
 Class=require "class"

require "Paddle"
 Ball=require "Ball"--[[write "=" when it returns
                        as here it returns Ball at end ]]
 
 
 
 
 
WINDOW_WIDTH=700
WINDOW_HEIGHT=400

VIRTUAL_WIDTH=432
VIRTUAL_HEIGHT=243

PADDLE_SPEED=150





function love.load()
    love.graphics.setDefaultFilter("nearest","nearest")
    --love.graphics.setDefaultFilter("linear", "linear") --for images only

    math.randomseed(os.time()) --for randomseed value for every random number as per unix epogh

    largeFont=love.graphics.newFont("font.ttf",15)
    smallFont=love.graphics.newFont("font.ttf",10)
    scoreFont=love.graphics.newFont("font.ttf",35)

  

    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
                        resizable=false,
                        vsync=true, --VSYNC TO AVOID TEARING DUE TO DIFFERENCE IN FRAME RATES OF GPU AND SCREEN 
                        fullscreen =false
                        })
    push.setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,{ upscale="normal"})
    
    love.window.setTitle("Pong")
    
    player1=Paddle(10,20,5,25)
    player2=Paddle(VIRTUAL_WIDTH-15,VIRTUAL_HEIGHT-45,5,25)

    player1Score=0
    player2Score=0

    ball=Ball(VIRTUAL_WIDTH/2-2,VIRTUAL_HEIGHT/2-2,4,4)



    gameState="start"
end


function love.draw()
    push.start()
    love.graphics.clear(0/255,00/255,50/255,1)--bg col
    love.graphics.setFont(largeFont)

    if gameState=="start" then
        love.graphics.printf(" Start state!",0,20,VIRTUAL_WIDTH,"center")
    else
        love.graphics.printf("  Play state!",0,20,VIRTUAL_WIDTH,"center")
    end


    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score),VIRTUAL_WIDTH/2-40,VIRTUAL_HEIGHT/2-70 )
    love.graphics.print(tostring(player2Score),VIRTUAL_WIDTH/2+30,VIRTUAL_HEIGHT/2-70 )
    
    
    --1st paddle
    player1:render()

    --2nd paddle
    player2:render()

    --ball
    ball:render()

    displayFPS()

    push.finish()
end


function love.keypressed(key)
    if key =='escape' then
        love.event.quit()
   
    elseif key=='enter' or key=="return" then
        if gameState=="start" then
            gameState="play"
        else
            gameState="start"
            ball:reset()
        end
    end
end

function love.update(dt)

    if gameState=="play" then
        if ball:collides(player1) then

            ball.dx=-ball.dx*1.03
            ball.x=player1.x+5  --5 as its the width of paddle
            
            if ball.dy<0 then
                ball.dy=-math.random (0,100)--just randomisation
            else
                ball.dy=math.random(0,100)--just randomisation
            end

        end

        if ball:collides(player2) then

            ball.dx=-ball.dx*1.03
            ball.x=player2.x-5

            if ball.dy<0 then--same as above
                ball.dy=-math.random (0,100)--just randomisation
            else
                ball.dy=math.random(0,100)--just randomisation
            end

        end

        --screen boundary
        --top
        if ball.y<=0 then
            ball.y=0
            ball.dy=-ball.dy
        end
        --bottom
        if ball.y>=VIRTUAL_HEIGHT-4 then
            ball.y=VIRTUAL_HEIGHT-4
            ball.dy=-ball.dy
        end
    end
    
    
    if love.keyboard.isDown("w") then
        player1.dy=-PADDLE_SPEED
    elseif love.keyboard.isDown("s") then
        player1.dy= PADDLE_SPEED
    else
        player1.dy=0
    end

    player1:update(dt)

    if love.keyboard.isDown("up") then
        player2.dy=-PADDLE_SPEED
    elseif love.keyboard.isDown("down") then
        player2.dy=PADDLE_SPEED
    else 
        player2.dy=0
    end

    player2:update(dt)

    if gameState=="play" then
        ball:update(dt)
    end
    
end


function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(1,0,0,1)
    love.graphics.print("FPS:" .. tostring(love.timer.getFPS()),10,10)
    love.graphics.setColor(1,1,1,1)
end
 