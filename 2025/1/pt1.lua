-- Starting with dial at 50. The password is the number of times the dial is left pointing at 0 after any rotation in the sequence
-- 1071

local currentDialNumber = 50
local numZeroes = 0

local function turnDial(direction, number)
    if direction == 'L' then
        currentDialNumber = currentDialNumber - number
    else
        currentDialNumber = currentDialNumber + number
    end
    currentDialNumber = currentDialNumber % 100
end

for line in io.lines("./1/input.txt") do
    local direction = string.sub(line, 1, 1)
    local number = string.sub(line, 2)

    turnDial(direction, number)

    if (currentDialNumber == 0) then
        numZeroes = numZeroes + 1;
    end
end

print(numZeroes)
