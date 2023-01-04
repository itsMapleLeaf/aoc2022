import strformat
import strutils
import sequtils
import sugar
import pegs

const grammar = peg"""
monkeyIndex = "Monkey:" requiredWhiteSpace \d+ ":"
monkeyStartingItems = "Starting items:" requiredWhiteSpace \d+ ("," requiredWhiteSpace \d+)*

requiredWhiteSpace = \s+
"""


proc part1(inputPath: string): auto =
  type Monkey = object
    items: seq[int]
    operation: string
    divisibleByTest: int
    throwToWhenTrue: int
    throwToWhenFalse: int

  var monkeys = newSeq[Monkey]()
  var p = Parser(input: readFile(inputPath))

  while p.peekKeyword("Monkey"):
    p.skipKeyword("Monkey")
    p.skipWhitespace

    let monkeyId = p.consume(numbers).parseInt
    p.skipWhitespace

    p.consumeKeyword("Starting items:")
    p.skipWhitespace

    var items = newSeq[int]()
    while p.peek(numbers):
      items.add(p.consume(numbers).parseInt)
      discard p.consume(",")
      p.skipWhitespace

proc part2(inputPath: string): auto =
  0

when isMainModule:
  const inputPath = "day11/input.txt"
  const exampleInputPath = "day11/example.txt"
  echo "Part 1 (example): ", part1(exampleInputPath)
  echo "Part 1          : ", part1(inputPath)
  echo "Part 2 (example): ", part2(exampleInputPath)
  echo "Part 2          : ", part2(inputPath)
