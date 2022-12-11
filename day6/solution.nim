import ../helpers
import strutils
import sequtils
import sets
import sugar
import options

const input = "day6/input.txt"

let characters = input.readFile.strip

proc firstIndexOfUniqueCharacters(groupSize: int): int =
  toSeq((groupSize - 1)..characters.high)
    .findWhere(x => characters[x - (groupSize - 1) .. x].hasUniqueValues)
    .get() + 1

proc part1: int =
  firstIndexOfUniqueCharacters(4)

proc part2: int =
  firstIndexOfUniqueCharacters(14)

when isMainModule:
  echo "Part 1: ", part1()
  echo "Part 2: ", part2()
