-- Each problem's numbers are arranged vertically; at the bottom of the problem is the symbol (+ or *) for the operation that needs to be performed.
-- Sum of problem totals. example.txt problem sum is 4277556
-- 4648618073226

local function main()
    local rawData = {}

    for line in io.lines("./6/input.txt") do
        table.insert(rawData, line)
    end

    local mathData = {}
    local numRows = #rawData
    local numColumns = nil

    for rowIndex, row in ipairs(rawData) do
        mathData[rowIndex] = {}
        numColumns = 0

        for match in string.gmatch(row, "[^%s]+") do
            numColumns = numColumns + 1
            table.insert(mathData[rowIndex], match)
        end
    end

    local total = 0

    for col = 1, numColumns, 1 do
        local colTotal = 1

        if mathData[numRows][col] == "+" then
            colTotal = 0
        end

        for row = 1, numRows - 1, 1 do
            if mathData[numRows][col] == "+" then
                colTotal = colTotal + tonumber(mathData[row][col])
            else
                colTotal = colTotal * tonumber(mathData[row][col])
            end
        end

        total = total + colTotal
    end

    print(total)
end

main()
