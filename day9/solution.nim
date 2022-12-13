import algorithm
import strutils
import strformat
import sequtils
import ../math/vector
import ../helpers
import os
import sets

type RopeSim = object
  head: Vector
  segments: seq[Vector]
  visited: HashSet[Vector]

func tail(sim: RopeSim): Vector = sim.segments.last

func createRopeSim(segmentCount: Positive): RopeSim = RopeSim(
  head: (0, 0),
  segments: (0, 0).repeat(segmentCount),
  visited: [(0, 0)].toHashSet,
)

func parseDirection(direction: string): Vector =
  case direction
  of "R": right
  of "L": left
  # up is down, down is up
  of "U": down
  of "D": up
  else:
    raise newException(ValueError, &"Invalid direction \"{direction}\"")

func letter(direction: Vector): string =
  if direction == right: "R"
  elif direction == left: "L"
  elif direction == up: "D"
  elif direction == down: "U"
  else:
    raise newException(ValueError, &"Invalid direction vector \"{direction}\"")

func debugChar(sim: RopeSim, pos: Vector): string =
  if pos == sim.head: "H"
  elif pos in sim.segments: $(sim.segments.find(pos) + 1)
  elif pos in sim.visited: "#"
  else: "."

func debugStep(sim: RopeSim, direction: Vector, distance: int,
    step: int): string =
  let textGrid = toSeq(-15 .. 15)
    .map(proc (y: int): string =
      toSeq(-30 .. 30).map(proc (x: int): string = sim.debugChar((x, y))).join("")
    )
    .reversed
    .join("\n")

  (&"""
  direction: {direction.letter}, distance: {distance}, step: {step}
  {textGrid}
  """).unindent

proc step(sim: var RopeSim, direction: Vector) =
  sim.head += direction

  for index, follower in sim.segments:
    let leader = if index == 0: sim.head else: sim.segments[index - 1]
    let difference = follower - leader

    if difference.abs.x <= 1 and difference.abs.y <= 1:
      continue

    if difference.abs == (2, 2):
      sim.segments[index] = leader + (difference.x.sign, difference.y.sign)
    elif difference.x.abs > difference.y.abs:
      sim.segments[index] = leader + (difference.x.sign, 0)
    else:
      sim.segments[index] = leader + (0, difference.y.sign)

  sim.visited.incl sim.tail

proc runMotion(sim: var RopeSim, line: string, debug = false): auto =
  let parts = line.split(" ")
  let direction = parts[0].parseDirection
  let distance = parts[1].parseInt

  for step in 1..distance:
    sim.step direction
    if debug:
      echo debugStep(sim, direction, distance, step)
      discard stdin.readLine

proc part1(inputPath: string): auto =
  var sim = createRopeSim(1)
  for line in inputPath.lines:
    sim.runMotion(line, debug = commandLineParams().contains("--debug"))
  sim.visited.len

proc part2(inputPath: string): auto =
  var sim = createRopeSim(9)
  for line in inputPath.lines:
    sim.runMotion(line, debug = commandLineParams().contains("--debug"))
  sim.visited.len

when isMainModule:
  const inputPath = "day9/input.txt"
  const exampleInputPath = "day9/example.txt"
  echo "Part 1 (example): ", part1(exampleInputPath)
  echo "Part 1          : ", part1(inputPath)
  echo "Part 2 (example): ", part2(exampleInputPath)
  echo "Part 2          : ", part2(inputPath)

  assert part1(exampleInputPath) == 88
  assert part1(inputPath) == 6271
  assert part2(exampleInputPath) == 36
  assert part2(inputPath) == 2458
