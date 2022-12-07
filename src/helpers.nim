import sets
import options
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

proc findWhere*[T](s: seq[T], pred: proc(x: T): bool {.closure.}): Option[T] =
  for i, x in s:
    if pred(x): return some(x)
  none(T)

proc hasUniqueValues*[T](s: openArray[T]): bool =
  s.len == s.toHashSet.len
