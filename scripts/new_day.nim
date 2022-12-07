import os
import strformat
import re

let day = commandLineParams()[0]

# create src/dayX.nim
writeFile(&"src/day{day}.nim", &"""
const input = "src/day{day}.txt"

proc part1: int =
  0

proc part2: int =
  0

when isMainModule:
  echo "Part 1: ", part1()
  echo "Part 2: ", part2()
""")

# create src/dayX.txt
writeFile(fmt"src/day{day}.txt", "")

# update the bin list in the nimble file
let nimbleFilePath = "aoc2022.nimble"

writeFile(
  nimbleFilePath,
  readFile(nimbleFilePath)
    .replacef(
      re"(bin\s*=\s*@\[[^\]]*)\]",
      &"$1, \"day{day}\"]"
    )
)
