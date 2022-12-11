import sequtils
import strutils
import re
import algorithm
import ../helpers

const input = "day5/input.txt"

let (stacksInput, instructionsInput) = block:
  let chunks = input.readFile
    .strip(leading = false)
    .split("\n\n")
    .mapIt(it.splitLines)
  (chunks[0], chunks[1])

# the number of numbers on the last line of the stacks input
# is the number of stacks we have
let stackCount = stacksInput.last.splitWhitespace.len

proc getStacks(): seq[seq[char]] =
  (0..<stackCount).toSeq.map proc (index: int): seq[char] =
    let inputColumn: int = index * 4 + 1
    toSeq(0..<(stacksInput.len - 1))
      .mapIt(stacksInput[it][inputColumn])
      .filterIt(it.isUpperAscii)
      .reversed

type Instruction = tuple
  count: uint
  fromIndex: uint
  toIndex: uint

let instructions = instructionsInput.map proc (line: string): Instruction =
  var matches: array[3, string]
  discard line.match(re"move (\d+) from (\d+) to (\d+)", matches)
  (
    matches[0].parseUInt,
    matches[1].parseUInt - 1,
    matches[2].parseUInt - 1,
  )

proc part1(): string =
  var stacks = getStacks()

  for (count, fromIndex, toIndex) in instructions:
    for i in 1..count:
      if stacks[fromIndex].len > 0:
        stacks[toIndex].add stacks[fromIndex].pop

  stacks.mapIt(it.last).join("")

proc part2(): string =
  var stacks = getStacks()

  for (count, fromIndex, toIndex) in instructions:
    stacks[toIndex].add stacks[fromIndex].deleteLast count

  stacks.mapIt(it.last).join("")

when isMainModule:
  echo "Part 1: ", part1()
  echo "Part 2: ", part2()
