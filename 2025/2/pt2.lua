-- Invalid IDs are any ID which are made only of some sequence of digits repeated **at least twice**. Answer is sum of invalid IDs.
-- eg. 12341234 (1234 two times), 123123123 (123 three times), 1212121212 (12 five times), 1111111 (1 seven times)
-- 50857215650

local invalidIDs = {}

local function isGroupRepeated(numGroups)
    local firstGroup = numGroups[1]
    for _, numGroup in pairs(numGroups) do
        if (firstGroup ~= numGroup) then
            return false
        end
    end
    return true
end

local function isIDInvalid(id)
    local lenID = string.len(id)
    local splitIndex = math.floor(lenID / 2)

    for i = 1, splitIndex, 1 do
        if (lenID % i == 0) then
            local numDivisions = tonumber(lenID / i)
            local splitNumGroups = {}
            local rollingStartIndex = 1
            local jump = tonumber(lenID / numDivisions)

            for j = 1, numDivisions, 1 do
                table.insert(splitNumGroups, string.sub(id, rollingStartIndex, j * jump))
                rollingStartIndex = (j * jump) + 1
            end

            local isInvalid = isGroupRepeated(splitNumGroups)
            if (isInvalid) then
                return true
            end
        end
    end

    return false
end

local function evaluateRange(range)
    local hyphen = string.find(range, "-")
    local startOfRange = string.sub(range, 1, hyphen - 1)
    local endOfRange = string.sub(range, hyphen + 1)

    for currentID = startOfRange, endOfRange, 1 do
        local strippedID = string.format("%.0f", currentID)
        local isInvalid = isIDInvalid(strippedID)

        if (isInvalid) then
            table.insert(invalidIDs, currentID)
        end
    end
end

local function main()
    local inputLine
    for line in io.lines("./2/input.txt") do
        inputLine = line
    end

    local productIDRanges = {}
    for productIDRange in string.gmatch(inputLine, "[^,]+") do
        table.insert(productIDRanges, productIDRange)
    end

    for _, productIDRange in pairs(productIDRanges) do
        evaluateRange(productIDRange)
    end

    local sumInvalidIDs = 0
    for _, invalidID in pairs(invalidIDs) do
        sumInvalidIDs = sumInvalidIDs + invalidID
    end

    print(sumInvalidIDs)
end

main()
