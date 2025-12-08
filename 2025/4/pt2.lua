-- Forklifts can only access a roll of paper (@) if there are fewer than four rolls of paper in the eight adjacent positions.
-- Accessible rolls can be removed. Re-evaluate accessibility and remove rolls until no more rolls are accessible.
-- Count total # rolls removed. example.txt has 43 total rolls removed.
-- 8899

local Coord = {}

function Coord:new(y, x)
    local obj = {
        y = y or 0,
        x = x or 0
    }
    setmetatable(obj, { __index = self })
    return obj
end

local function isRollAccessible(map, row, col)
    local rollCount = 0

    local adjMod = {-1, 0, 1}
    for i = 1, #adjMod, 1 do
       for j = 1, #adjMod, 1 do
            if row + adjMod[i] <= 0 or row + adjMod[i] > #map
                or col + adjMod[j] <= 0 or col + adjMod[j] > #map[row]
                or (adjMod[i] == 0 and adjMod[j] == 0) then
                goto continue
            end

            if map[row + adjMod[i]][col + adjMod[j]] == '@' then
                rollCount = rollCount + 1
            end

            ::continue::
       end
    end

    if rollCount < 4 then
        return true
    end
end

local function markAccessibleRolls(map)
    local accessibleRolls = {}
    for rowIndex, _ in ipairs(map) do
        for colIndex, _ in ipairs(map[rowIndex]) do
            if map[rowIndex][colIndex] == '@' then
                if isRollAccessible(map, rowIndex, colIndex) then
                    table.insert(accessibleRolls, Coord:new(rowIndex, colIndex))
                end
            end
        end
    end
    return accessibleRolls
end

local function removeRollsAndGetCount(map, accessibleRolls)
    local numRollsRemoved = 0

    for _, coord in pairs(accessibleRolls) do
        map[coord.y][coord.x] = '.'
        numRollsRemoved = numRollsRemoved + 1
    end

    return numRollsRemoved
end

local function getTotalRollsRemovedFor(map)
    local totalRollsRemoved = 0
    ::continue::

    local accessibleRolls = markAccessibleRolls(map)
    local numRollsRemoved = removeRollsAndGetCount(map, accessibleRolls)

    if #accessibleRolls > 0 then
        totalRollsRemoved = totalRollsRemoved + numRollsRemoved
        goto continue
    end

    return totalRollsRemoved
end

local function main()
    local rollMap = {}

    for rowContent in io.lines("./4/input.txt") do
        local columnContent = {}
        for col = 1, string.len(rowContent), 1 do
            table.insert(columnContent, string.sub(rowContent, col, col))
        end
        table.insert(rollMap, columnContent)
    end

    print(getTotalRollsRemovedFor(rollMap))
end

main()
