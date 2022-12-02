import strutils
import sequtils
import algorithm
import helpers
import sugar

const input = "src/day1.txt"

proc part1(): int =
  input.readFile().strip()
    .split("\n\n")
    .map(nums => nums.split("\n").map(parseInt).sum())
    .max()

proc part2(): int =
  input.readFile().strip()
    .split("\n\n")
    .map(nums => nums.split("\n").map(parseInt).sum())
    .sorted(Descending)[0 .. 2]
    .sum()
    
when isMainModule:
  echo "Part 1: ", part1()
  echo "Part 2: ", part2()
