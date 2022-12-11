import os
import strformat
import strutils
import sequtils
import algorithm
include "aoc2022.nimble"

task newDay, "Scaffold files for a day":
  let day = commandLineParams()[1]

  let solutionPath = &"src/day{day}.nim"
  let inputPath = &"src/day{day}.input.txt"
  let exampleInputPath = &"src/day{day}.example.txt"

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

  const nimbleFilePath = "aoc2022.nimble"
  let newNimbleContent = nimbleFilePath.readFile.splitLines.toSeq
    .map(proc (line: string): string =
      if not line.startsWith("bin"):
        return line

      let openBracketIndex = line.find("@[")
      if openBracketIndex == -1:
        raise newException(ValueError, "Could not find @[ in line: " & line)

      let prefix = line[0 ..< openBracketIndex]
      let newBinSequence = bin.concat(@[&"day{day}"]).sorted
      prefix & $newBinSequence
    )
    .join("\n")

  writeFile solutionPath, solutionTemplate
  writeFile inputPath, ""
  writeFile exampleInputPath, ""
  writeFile nimbleFilePath, newNimbleContent

  # echo nimbleFilePath.open.read.replace(
  #   re"^(bin\s*=\s*).*$",
  #   $(bin.concat(@[&"day{day}"]).sorted)
  # )
