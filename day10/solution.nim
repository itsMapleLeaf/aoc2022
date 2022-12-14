import strutils
import sequtils

iterator runMachine(instructions: seq[string]): int =
  var value = 1
  for line in instructions:
    let lineParts = line.split(" ")
    case lineParts[0]
    of "noop":
      yield value
      # do nothing
    of "addx":
      yield value
      # wait a cycle

      yield value
      value += lineParts[1].parseInt # add x to register
    else:
      raise newException(ValueError, "Invalid instruction: " & line)

proc part1(inputPath: string): auto =
  var history = runMachine(inputPath.lines.toSeq).toSeq
  [20, 60, 100, 140, 180, 220]
    .mapIt(it * history[it - 1])
    .foldl(a + b)

proc part2(inputPath: string): auto =
  var screen: array[0..5, array[0..39, string]]
  for index, spriteCenter in runMachine(inputPath.lines.toSeq).toSeq.pairs:
    let row = index div 40
    let col = index mod 40
    screen[row][col] = if abs(spriteCenter - col) <= 1: "⬜" else: "⬛"

  "\n" & screen.mapIt(it.join("")).join("\n")

when isMainModule:
  const inputPath = "day10/input.txt"
  const exampleInputPath = "day10/example.txt"
  echo "Part 1 (example): ", part1(exampleInputPath)
  echo "Part 1          : ", part1(inputPath)
  echo "Part 2 (example): ", part2(exampleInputPath)
  echo "Part 2          : ", part2(inputPath)
