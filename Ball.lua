
Ball=Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dx = math.random(2)==1 and 100 or -100
    self.dy = math.random(-100,100)
end

function Ball:collides(paddle)
    if paddle.x+paddle.width<=self.x or paddle.x>=self.x+self.width then
        return false
    end
    if paddle.y+paddle.height<=self.y or self.y+self.height<=paddle.y then
        return false
    end
    return true
end

function Ball:reset()
    self.x=VIRTUAL_WIDTH/2-2--[[x,y,width,height that are like 
                                data members of Ball class
                                 ]]
    self.y=VIRTUAL_HEIGHT/2-2
    self.dx=math.random(2)==1 and 100 or -100
    self.dy=math.random(-100,100)
end

function Ball:update(dt)
    self.x=self.x+self.dx*dt
    self.y=self.y+self.dy*dt
end

function Ball:render()
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
end

return Ball