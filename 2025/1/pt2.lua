-- Starting with dial at 50. The actual password is the number of times any click causes the dial
-- to point at 0, regardless of whether it happens during a rotation or at the end of one.
-- 6700

local currentDialNumber = 50
local numZeroes = 0

local function checkDial()
    if (currentDialNumber == 0) then
        numZeroes = numZeroes + 1;
    end
end

local function turnDial(direction, number)
    for _ = 1, number, 1 do
        if direction == 'L' then
            currentDialNumber = currentDialNumber - 1
        else
            currentDialNumber = currentDialNumber + 1
        end

        currentDialNumber = currentDialNumber % 100
        checkDial()
    end
end

for line in io.lines("./1/input.txt") do
    local direction = string.sub(line, 1, 1)
    local number = string.sub(line, 2)

    turnDial(direction, number)
end

print(numZeroes)
