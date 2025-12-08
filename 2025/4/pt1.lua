-- Forklifts can only access a roll of paper (@) if there are fewer than four rolls of paper in the eight adjacent positions.
-- Count # rolls of paper accessible by forklift. example.txt has 13 rolls accessible.
-- 1480

local function isRollAccessible(map, row, col)
    local isAccessible = false
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
        isAccessible = true
    end

    return isAccessible
end

local function getNumAccessibleRollsFor(map)
    local numAccessibleRolls = 0
    for rowIndex, _ in ipairs(map) do
        for colIndex, _ in ipairs(map[rowIndex]) do
            if map[rowIndex][colIndex] == '@' then
                if isRollAccessible(map, rowIndex, colIndex) then
                    numAccessibleRolls = numAccessibleRolls + 1
                end
            end
        end
    end

    return numAccessibleRolls
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

    print(getNumAccessibleRollsFor(rollMap))
end

main()
