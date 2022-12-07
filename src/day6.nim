import helpers
import strutils
import sequtils
import sets
import sugar
import options

const input = "src/day6.txt"

let characters = input.readFile.strip

proc part1(): int =
  toSeq(3..characters.high)
    .findWhere(x => characters[x - 3 .. x].hasUniqueValues)
    .get() + 1

proc part2(): int =
  toSeq(13..characters.high)
    .findWhere(x => characters[x - 13 .. x].hasUniqueValues)
    .get() + 1

when isMainModule:
  echo "Part 1: ", part1()
  echo "Part 2: ", part2()
