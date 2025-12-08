#!/bin/bash

directories=()

for d in *; do
    if [[ -d "$d" && $d =~ ^[0-9]+$ ]]; then
        directories+=("$d")
    fi
done

if [ ${#directories[@]} -eq 0 ]; then
    echo "No numeric directories found. Creating directory '1'."
    mkdir 1
    touch 1/pt1.lua
else
    numbers=()
    for d in "${directories[@]}"; do
        numbers+=("$d")
    done

    max_num=$(printf "%s\n" "${numbers[@]}" | sort -n | tail -1)

    new_dir=$((max_num + 1))
    echo "Creating directory '$new_dir'."
    mkdir "$new_dir"
    touch "$new_dir/input.txt"
    touch "$new_dir/pt1.lua"

lua_code="local function main()
    for _ in io.lines(\"./_/input.txt\") do
        -- do stuff
    end
end

main()"

    echo "$lua_code" > "$new_dir/pt1.lua"
fi
