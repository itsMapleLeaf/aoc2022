import strutils
import sequtils

func fullyContains(a: HSlice[int, int], b: HSlice[int, int]): bool =
  a.a <= b.a and b.b <= a.b

func overlaps(a: HSlice[int, int], b: HSlice[int, int]): bool =
  a.a <= b.a and b.a <= a.b or
  a.a <= b.b and b.b <= a.b or
  b.a <= a.a and a.a <= b.b or
  b.a <= a.b and a.b <= b.b

type AssignmentRange = HSlice[int, int]

func toAssignmentRange(input: string): AssignmentRange =
  let parts = input.split("-")
  (parts[0].parseInt .. parts[1].parseInt)

type AssignmentRangePair = tuple[a: AssignmentRange, b: AssignmentRange]

func toAssignmentRangePair(line: string): AssignmentRangePair =
  let parts = line.split(",")
  (parts[0].toAssignmentRange, parts[1].toAssignmentRange)

proc part1(inputPath: string): auto =
  inputPath.lines.toSeq
    .mapIt(it.toAssignmentRangePair)
    .countIt(it.a.fullyContains(it.b) or it.b.fullyContains(it.a))

proc part2(inputPath: string): auto =
  inputPath.lines.toSeq
    .mapIt(it.toAssignmentRangePair)
    .countIt(it.a.overlaps(it.b))

when isMainModule:
  const inputPath = "day4/input.txt"
  const exampleInputPath = "day4/example.txt"
  echo "Part 1 (example): ", part1(exampleInputPath)
  echo "Part 1          : ", part1(inputPath)
  echo "Part 2 (example): ", part2(exampleInputPath)
  echo "Part 2          : ", part2(inputPath)
