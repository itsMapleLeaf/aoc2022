import sequtils

template sum*(nums: openArray[int]): int =
  nums.foldl(a + b)

proc last*[T](a: openArray[T]): T =
  a[a.high]

proc deleteLast*[T](items: var seq[T], count: Natural): seq[T] =
  if count == 0: return @[]

  let deletedRange = (items.high - count + 1) .. items.high
  let removed = items[deletedRange]
  items.delete deletedRange
  removed
