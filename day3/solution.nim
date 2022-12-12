import sequtils
import sets
import sugar
import ../helpers

func intersection[T](sets: varargs[HashSet[T]]): HashSet[T] =
  result = sets[0]
  for set in sets[1 ..< sets.len]:
    result = result.intersection(set)

func itemPriority(item: char): int =
  case item
  of 'a' .. 'z': ord(item) - ord('a') + 1
  of 'A' .. 'Z': ord(item) - ord('A') + 27
  else: raise newException(ValueError, "Invalid item: " & $item)

proc part1(inputPath: string): auto =
  type Rucksack = tuple[first: string, second: string]

  func toRucksack(line: string): Rucksack =
    let first = line[0 .. int(line.len / 2) - 1]
    let second = line[int(line.len / 2) ..< line.len]
    (first, second)

  func sharedItem(rucksack: Rucksack): char =
    let firstSet = rucksack.first.toHashSet
    let secondSet = rucksack.second.toHashSet
    let shared = firstSet.intersection(secondSet)
    shared.toSeq[0]

  inputPath.lines.toSeq
    .mapIt(it.toRucksack.sharedItem.itemPriority)
    .sum

proc part2(inputPath: string): auto =
  let inputLines = inputPath.lines.toSeq
  inputLines
    .distribute(Positive(inputLines.len / 3))
    .map(group => intersection(group.mapIt(it.toHashSet)).toSeq[0].itemPriority)
    .sum

when isMainModule:
  const inputPath = "day3/input.txt"
  const exampleInputPath = "day3/example.txt"
  echo "Part 1 (example): ", part1(exampleInputPath)
  echo "Part 1          : ", part1(inputPath)
  echo "Part 2 (example): ", part2(exampleInputPath)
  echo "Part 2          : ", part2(inputPath)
