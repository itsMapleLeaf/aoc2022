import os

for file in walkFiles("src/*.nim"):
  let (dir, name, ext) = file.splitFile
  createDir name
  moveFile file, name / "solution.nim"
  moveFile (dir / name & ".txt"), name / "input.txt"
