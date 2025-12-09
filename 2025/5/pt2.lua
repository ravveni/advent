-- Format: fresh ingredient ID ranges (inclusive), a blank line, list of ingredient IDs to check if fresh.
-- Count # fresh ingredientIDs. example.txt has 14 fresh ingredientIDs.
-- 367899984917516

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

local function getTotalUniqueFreshIngredientIDs(ranges)
    local splitRanges = {}

    for _, range in ipairs(ranges) do
        local lowerStr, upperStr = string.match(range, "(%d+)-(%d+)")
        local lower, upper = tonumber(lowerStr), tonumber(upperStr)

        table.insert(splitRanges, {lower, upper})
    end

    table.sort(splitRanges, function(a, b) return a[1] < b[1] end)

    local mergedSplitRanges = {}
    local rollingLower, rollingUpper = splitRanges[1][1], splitRanges[1][2]

    for _, range in ipairs(splitRanges) do
        local currentLower, currentUpper = range[1], range[2]

        if currentLower <= rollingUpper then
            rollingUpper = math.max(rollingUpper, currentUpper)
        else
            table.insert(mergedSplitRanges, {rollingLower, rollingUpper})
            rollingLower, rollingUpper = currentLower, currentUpper
        end
    end

    table.insert(mergedSplitRanges, {rollingLower, rollingUpper})

    local totalUniqueFreshIngredientIDs = 0

    for _, mergedSplitRange in ipairs(mergedSplitRanges) do
        totalUniqueFreshIngredientIDs = totalUniqueFreshIngredientIDs + (mergedSplitRange[2] - mergedSplitRange[1] + 1)
    end

    return totalUniqueFreshIngredientIDs
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

    local freshIDRanges, _ = splitData(rawData, separatorIndex)

    print(getTotalUniqueFreshIngredientIDs(freshIDRanges))
end

main()
