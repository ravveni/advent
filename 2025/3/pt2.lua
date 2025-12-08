-- Within each bank, turn on exactly twelve batteries. Can't rearrange batteries.
-- Find the largest possible joltage each bank can produce. Answer is sum of all banks largest possible joltage.
-- eg. 234234234234278, the largest joltage produced with this bank is 434234234278.
-- 166345822896410

local function getHighestBankJoltage(bank, start, endMod, dynNum, size)
    if #dynNum == size then
        return tonumber(table.concat(dynNum))
    end

    local numBatteries = string.len(bank)
    local highestBankJoltage = 0
    local highestDigit = 0

    local rollingStartIndex = start
    for i = rollingStartIndex, numBatteries - endMod do
        local testDigit = tonumber(string.sub(bank, i, i))
        if testDigit > highestDigit then
            highestDigit = testDigit
            rollingStartIndex = i + 1
        end
    end

    table.insert(dynNum, highestDigit)
    local testBankJoltage = getHighestBankJoltage(bank, rollingStartIndex, endMod - 1, dynNum, size)
    highestBankJoltage = math.max(highestBankJoltage, testBankJoltage)
    table.remove(dynNum)

    return highestBankJoltage
end

local function main()
    local totalOutputJoltage = 0

    for bank in io.lines("./3/input.txt") do
        totalOutputJoltage = totalOutputJoltage + getHighestBankJoltage(bank, 1, 11, {}, 12)
    end

    print(totalOutputJoltage)
end

main()
