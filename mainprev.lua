 push=require 'push' --for upscaling due to virtual width
 --==importing a module like
 
 Class=require "class"
 
 
 
 
 
WINDOW_WIDTH=700
WINDOW_HEIGHT=400

VIRTUAL_WIDTH=432
VIRTUAL_HEIGHT=243

PADDLE_SPEED=150





function love.load()
    --  love.graphics.setDefaultFilter("nearest","nearest")
    love.graphics.setDefaultFilter("linear", "linear") --for images only

    math.randomseed(os.time()) --for randomseed value for every random number as per unix epogh

    largeFont=love.graphics.newFont("font.ttf",20)
    smallFont=love.graphics.newFont("font.ttf",10)

  

    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
                        resizable=false,
                        vsync=true, --VSYNC TO AVOID TEARING DUE TO DIFFERENCE IN FRAME RATES OF GPU AND SCREEN 
                        fullscreen =false
                        })
    push.setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,{ upscale="normal"})

    player1Score=0
    player2Score=0

    player1Y=10 --initial ordinate for paddle1
    player2Y=VIRTUAL_HEIGHT-35

    ballX=VIRTUAL_WIDTH/2-2
    ballY=VIRTUAL_HEIGHT/2-2

    ballDX=math.random(2) ==1 and 100 or -100 --[[ternary in lua if return value=1 then 100 will be selected and 
                                                if 2 then -100]]
    --condition and A or B=LUA
    --condition ? A : B;=JAVA

    ballDY=math.random(-50,50)

    gameState="start"
end


function love.draw()
    push.start()
    love.graphics.clear(0/255,00/255,50/255,1)--bg col
    love.graphics.setFont(largeFont)

    love.graphics.print(tostring(player1Score),VIRTUAL_WIDTH/2-40,VIRTUAL_HEIGHT/2-90 )
    love.graphics.print(tostring(player2Score),VIRTUAL_WIDTH/2+30,VIRTUAL_HEIGHT/2-90 )

    --1st paddle
    love.graphics.rectangle("line",10,player1Y,5,25)

    --2nd paddle
    love.graphics.rectangle("line",VIRTUAL_WIDTH-15,player2Y,5,25)

    --ball
    love.graphics.rectangle("fill",ballX,ballY,4,4)

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

            ballX=VIRTUAL_WIDTH/2-2
            ballY=VIRTUAL_HEIGHT/2-2

            ballDX=math.random(2) ==1 and 100 or -100 
            ballDY=math.random(-50,50)
        end
    end
end

function love.update(dt)

    if love.keyboard.isDown("w") then
        player1Y=math.max(0,player1Y+ -PADDLE_SPEED*dt)
    elseif love.keyboard.isDown("s") then
        player1Y=math.min(VIRTUAL_HEIGHT-25,player1Y +PADDLE_SPEED*dt)
    end

    if love.keyboard.isDown("up") then
        player2Y=math.max(0,player2Y+ -PADDLE_SPEED*dt)
    elseif love.keyboard.isDown("down") then
        player2Y=math.min(VIRTUAL_HEIGHT-25,player2Y+ PADDLE_SPEED*dt)
    end

    if gameState=="play" then
        ballX=ballX+ballDX*dt
        ballY=ballY+ballDY*dt
    end
end
 