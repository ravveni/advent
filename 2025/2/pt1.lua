-- Invalid IDs are any ID which are made only of some sequence of digits repeated twice. Answer is sum of invalid IDs.
-- eg. 55 (5 twice), 6464 (64 twice), 123123 (123 twice)
-- 40055209690

local inputLine
for line in io.lines("./2/input.txt") do
    inputLine = line
end

local productIDRanges = {}
for productIDRange in string.gmatch(inputLine, "[^,]+") do
    table.insert(productIDRanges, productIDRange)
end

local invalidIDs = {}
local function evaluateRange(range)
    local hyphen = string.find(range, "-")
    local startOfRange = string.sub(range, 1, hyphen - 1)
    local endOfRange = string.sub(range, hyphen + 1)

    for currentID = startOfRange, endOfRange, 1 do
        local charLen = string.len(currentID)

        if (charLen % 2 == 0) then
            local splitIndex = charLen / 2
            local firstHalf = tonumber(string.sub(currentID, 1, splitIndex - 1))
            local secondHalf = tonumber(string.sub(currentID, splitIndex))

            if (firstHalf == secondHalf) then
                table.insert(invalidIDs, currentID)
            end
        end
    end
end

for _, productIDRange in pairs(productIDRanges) do
    evaluateRange(productIDRange)
end

local sumInvalidIDs = 0
for _, invalidID in pairs(invalidIDs) do
    sumInvalidIDs = sumInvalidIDs + invalidID
end

print(sumInvalidIDs)
