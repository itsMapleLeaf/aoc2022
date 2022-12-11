import ../helpers
import strutils
import sequtils
import tables

let inputLines = "src/day7.txt".lines.toSeq

# let inputLines = """
# $ cd /
# $ ls
# dir a
# 14848514 b.txt
# 8504156 c.dat
# dir d
# $ cd a
# $ ls
# dir e
# 29116 f
# 2557 g
# 62596 h.lst
# $ cd e
# $ ls
# 584 i
# $ cd ..
# $ cd ..
# $ cd d
# $ ls
# 4060174 j
# 8033020 d.log
# 5626152 d.ext
# 7214296 k""".splitLines

var files = Table[string, int]()
var currentPath: seq[string] = @[]

for line in inputLines:
  if line.startsWith("$ cd "):
    let path = line[5..^1]
    case path
    of "/":
      currentPath = @[]
    of "..":
      currentPath = currentPath[0..^2]
    else:
      currentPath.add path

  elif line.startsWith("$ ls"):
    discard

  elif line.startsWith("dir"):
    discard

  else:
    let chunks = line.split(' ')
    let path = currentPath.concat(@[chunks[1]]).join("/")
    let size = chunks[0].parseInt
    files[path] = size

var folderSizes = Table[string, int]()
for path, size in files.pairs:
  let chunks = path.split('/')
  for i in 0 ..< chunks.len - 1:
    let folder = chunks[0..i].join("/")
    folderSizes[folder] = folderSizes.getOrDefault(folder, 0) + size

folderSizes["/"] = files.values.sum

proc part1basic: auto =
  folderSizes.values.toSeq
    .filterIt(it <= 100_000)
    .sum

proc part2: auto =
  const totalDiskSpace = 70000000
  const spaceRequired = 30000000
  let unusedSpace = totalDiskSpace - folderSizes["/"]
  let folderSizeToDelete = spaceRequired - unusedSpace

  folderSizes.values.toSeq
    .filterIt(it >= folderSizeToDelete)
    .min

when isMainModule:
  echo "Part 1: ", part1basic()
  echo "Part 2: ", part2()
