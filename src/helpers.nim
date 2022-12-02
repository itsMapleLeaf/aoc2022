template sum*(nums: openArray[int]): int =
  nums.foldl(a + b)
