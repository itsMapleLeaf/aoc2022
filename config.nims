import os
import strformat
import strutils

func solutionPath(day: string): string =
  &"day{day}/solution.nim"

task day, "Run the solution for a day":
  exec "nim c -r " & solutionPath(commandLineParams()[1])

task newDay, "Scaffold files for a day":
  let day = commandLineParams()[1]
  let inputPath = &"day{day}/input.txt"
  let exampleInputPath = &"day{day}/example.txt"

  let solutionTemplate = (&"""
    proc part1(inputPath: string): auto =
      0

    proc part2(inputPath: string): auto =
      0

    when isMainModule:
      const inputPath = "{inputPath}"
      const exampleInputPath = "{exampleInputPath}"
      echo "Part 1 (example): ", part1(exampleInputPath)
      echo "Part 1          : ", part1(inputPath)
      echo "Part 2 (example): ", part2(exampleInputPath)
      echo "Part 2          : ", part2(inputPath)
  """).dedent

  mkDir solutionPath(day).splitFile.dir
  writeFile solutionPath(day), solutionTemplate
  writeFile inputPath, ""
  writeFile exampleInputPath, ""
