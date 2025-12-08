-- Within each bank, turn on exactly two batteries. Can't rearrange batteries.
-- Find the largest possible joltage each bank can produce. Answer is sum of all banks largest possible joltage.
-- eg. 818181911112111, the largest joltage produced with this bank is 92.
-- 16812

local function getHighestBankJoltage(bank)
    local numBatteries = string.len(bank)
    local highestJoltage = 0

    for i = 1, numBatteries - 1, 1 do
        for j = i + 1, numBatteries, 1 do
            local tens = string.sub(bank, i, i)
            local ones = string.sub(bank, j, j)
            local testJoltage = tonumber(tens..ones)

            if (testJoltage > highestJoltage) then
                highestJoltage = testJoltage
            end
        end
    end

    return highestJoltage
end

local function main()
    local totalOutputJoltage = 0

    for bank in io.lines("./3/input.txt") do
        totalOutputJoltage = totalOutputJoltage + getHighestBankJoltage(bank)
    end

    print(totalOutputJoltage)
end

main()
