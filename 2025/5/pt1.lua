-- Format: fresh ingredient ID ranges (inclusive), a blank line, list of ingredient IDs to check if fresh.
-- Count # fresh ingredients. example.txt has 3 fresh ingredients.
-- 601

local function splitData(rawData, separatorIndex)
    local freshIDRanges = {}
    local ingredientIDs = {}

    for i = 1, #rawData do
        if i == separatorIndex then
        elseif i < separatorIndex then
            table.insert(freshIDRanges, rawData[i])
        else
            table.insert(ingredientIDs, rawData[i])
        end
    end

    return freshIDRanges, ingredientIDs
end

local function isNumInRange(range, num)
    local lowerStr, upperStr = string.match(range, "(%d+)-(%d+)")
    local lower, upper = tonumber(lowerStr), tonumber(upperStr)
    local testNum = tonumber(num)

    return (testNum >= lower and testNum <= upper)
end

local function main()
    local rawData = {}
    local separatorIndex = nil
    local index = 1

    for line in io.lines("./5/input.txt") do
        table.insert(rawData, line)

        if line == "" then
            separatorIndex = index
        end

        index = index + 1
    end

    local freshIDRanges, ingredientIDs = splitData(rawData, separatorIndex)
    local freshIngredientIDs = {}
    local freshCount = 0

    for _, freshIDRange in pairs(freshIDRanges) do
        for _, ingredientID in pairs(ingredientIDs) do
            if isNumInRange(freshIDRange, ingredientID) and not freshIngredientIDs[ingredientID] then
                freshIngredientIDs[ingredientID] = true
                freshCount = freshCount + 1
            end
        end
    end

    print(freshCount)
end

main()
