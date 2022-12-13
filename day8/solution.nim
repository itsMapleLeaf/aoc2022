import strutils
import sequtils
import ../math/vector
import ../math/rect

func parseInt(c: char): int =
  if c in '0'..'9':
    c.ord - '0'.ord
  else:
    raise newException(ValueError, "Failed to parse int: " & $c)

# a tree map is a 2d grid of integers, where each int represents the tree's height
type TreeMap = seq[seq[int]]

func toTreeMap(lines: openArray[string]): TreeMap =
  lines.mapIt(it.map(parseInt))

func treeAt(map: TreeMap, pos: Vector): int =
  map[pos.y][pos.x]

func rect(map: TreeMap): Rect =
  rect(x = 0, y = 0, width = map[0].len, height = map.len)

func isVisibleFromEdge(map: TreeMap, pos: Vector): bool =
  # a tree is visible from the edge if all other trees between it and an edge are shorter
  # this is true if the tree is on an edge, or if there are no trees between it and an edge

  if map.rect.isAtEdge(pos):
    return true

  let thisTree = map.treeAt(pos)
  func allTreesShorterInDirection(dir: Vector): bool =
    map.rect
      .raycastToEdge(pos, dir)
      .toSeq[1..^1]
      .allIt(map.treeAt(it) < thisTree)

  return cardinals.any(allTreesShorterInDirection)

func scenicScoreAt(map: TreeMap, pos: Vector): int =
  result = 1

  let thisTree = map.treeAt(pos)

  for dir in cardinals:
    var directionScore = 0

    for pos in map.rect.raycastToEdge(pos, dir).toSeq[1..^1]:
      directionScore += 1
      if map.treeAt(pos) >= thisTree: break

    result *= directionScore

proc part1(inputPath: string): auto =
  let treeMap = inputPath.lines.toSeq.toTreeMap
  treeMap.rect.points.countIt(treeMap.isVisibleFromEdge(it))

proc part2(inputPath: string): auto =
  let treeMap = inputPath.lines.toSeq.toTreeMap
  treeMap.rect.points.toSeq.mapIt(treeMap.scenicScoreAt(it)).max

when isMainModule:
  const inputPath = "day8/input.txt"
  const exampleInputPath = "day8/example.txt"

  echo "Part 1 (example) | ", part1(exampleInputPath)
  echo "Part 1           | ", part1(inputPath)
  echo "Part 2 (example) | ", part2(exampleInputPath)
  echo "Part 2           | ", part2(inputPath)

  doAssert part1(exampleInputPath) == 21
  doAssert part1(inputPath) == 1801
  doAssert part2(exampleInputPath) == 8
  doAssert part2(inputPath) == 209880
