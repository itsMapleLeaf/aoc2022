import sequtils
import helpers
import strutils

const input = "src/day2.txt"

proc part1(): int =
  const rock = 'A'
  const paper = 'B'
  const scissors = 'C'

  const rockResponse = 'X'
  const paperResponse = 'Y'
  const scissorsResponse = 'Z'

  const roundScores = [
    rock: [rockResponse: 3, paperResponse: 6, scissorsResponse: 0],
    paper: [rockResponse: 0, paperResponse: 3, scissorsResponse: 6],
    scissors: [rockResponse: 6, paperResponse: 0, scissorsResponse: 3],
  ]

  const shapeScores = [
    rockResponse: 1,
    paperResponse: 2,
    scissorsResponse: 3,
  ]

  input.lines().toSeq()
    .filterIt(not it.isEmptyOrWhitespace())
    .mapIt((opponent: it[0], you: it[2]))
    .mapIt(roundScores[it.opponent][it.you] + shapeScores[it.you])
    .sum()

proc part2(): int =
  const rock = 'A'
  const paper = 'B'
  const scissors = 'C'

  const lose = 'X'
  const tie = 'Y'
  const win = 'Z'

  const shapeScores = [
    rock: 1,
    paper: 2,
    scissors: 3,
  ]

  const outcomeScores = [
    lose: 0,
    tie: 3,
    win: 6,
  ]

  const responses = [
    rock: [lose: scissors, tie: rock, win: paper],
    paper: [lose: rock, tie: paper, win: scissors],
    scissors: [lose: paper, tie: scissors, win: rock],
  ]

  input.lines().toSeq()
    .filterIt(not it.isEmptyOrWhitespace())
    .mapIt((opponent: it[0], outcome: it[2]))
    .mapIt(outcomeScores[it.outcome] + shapeScores[responses[it.opponent][it.outcome]])
    .sum()
    
when isMainModule:
  echo "Part 1: ", part1()
  echo "Part 2: ", part2()
